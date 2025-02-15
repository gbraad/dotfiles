#!/usr/bin/zsh

CONFIG="${HOME}/.secrets"
alias secretsini="git config -f ${CONFIG}"

_secretspath=$(secretsini --get secrets.path || echo "${HOME}/.dotsecrets/secrets")
eval _secretspath=$(echo ${_secretspath})

_secretsexists() {
    if [ -d "${_secretspath}" ]; then
        return 0  # File exists, return true (0)
    else
        return 1  # File does not exist, return false (1)
    fi
}

vim_decrypt_file() {
  local file="$1"
  local password="$2"

  # Use vim in ex mode to decrypt the file
  printf "%s\n" "$password" | vim -n -E -s "$file" \
    -c 'set nomore' \
    -c '%print' \
    -c 'q!' 2>/dev/null
}

vim_encrypt_file() {
  local file="$1"
  local password="$2"
  local content="$3"

  # Create a temporary file with the content
  local temp_file=$(mktemp)
  printf "%s" "$content" > "$temp_file"

  # Use vim in ex mode to encrypt the file
  # Double password entry: first for setting, second for verification
  printf "%s\n%s\n" "$password" "$password" | vim -n -E -s "$temp_file" \
    -c 'set cm=blowfish2' \
    -c 'X' \
    -c 'w! '"$file" \
    -c 'q!' 2>/dev/null

  # Clean up the temporary file
  rm -f "$temp_file"

  # Verify the file exists and is not empty
  if [ ! -s "$file" ]; then
    echo "Error: Failed to encrypt file"
    return 1
  fi
}

add_secret() {
  if ! _secretsexists; then
    _clonesecrets
  fi

  # Get the password for encryption
  local vimcrypt_password=$(read_password "Enter password for encryption")

  # Read the secret content
  echo "Enter the secret content (press Enter, then Ctrl+D to finish):"
  local content
  content=$(cat)

  # Prompt for the secret name if not provided
  local secret_name
  if [ "$#" -eq 1 ]; then
    secret_name="$1"
  else
    echo "Enter the secret name: "
    read secret_name
  fi

  # Ensure we have a name
  if [ -z "$secret_name" ]; then
    echo "Error: Secret name is required"
    return 1
  fi

  local secret_file="${_secretspath}/secrets/${secret_name}"

  # Ensure the secrets directory exists
  mkdir -p "${_secretspath}/secrets"

  # Encrypt and save the content
  if ! vim_encrypt_file "$secret_file" "$vimcrypt_password" "$content"; then
    echo "Failed to encrypt secret"
    return 1
  fi

  echo "Secret has been encrypted and saved to $secret_file"

  # If we're in a git repository, stage the new file
  if [ -d "${_secretspath}/.git" ]; then
    (cd "${_secretspath}" && git add "secrets/${secret_name}")
    echo "The secret file has been staged in git. Don't forget to commit and push your changes."
  fi
}

read_password() {
  local old_tty=$(stty -g </dev/tty)
  
  stty -echo </dev/tty
    
  local password=""
  if [ -n "$1" ]; then
    printf "%s: " "$1" >&2
  else
    printf "Password: " >&2
  fi
    
  read password </dev/tty
  printf "\n" >&2

  stty "$old_tty" </dev/tty
    
  printf "%s" "$password"
}

_clonesecrets() {
  local repo=$(secretsini --get secrets.repository)
  git clone ${repo} ${_secretspath}
}

get_secret() {
  if ! _secretsexists; then
    _clonesecrets
  fi

  local vimcrypt_file
  if [ -z "$1" ]; then
    secret_name=$(cd "${_secretspath}/secrets" && find . -type f -not -path '*/\.*' | sed 's|^\./||' | fzf)
    if [ -z "${secret_name}" ]; then
      echo "Empty selection"
      return 1
    fi
    vimcrypt_file="${_secretspath}/secrets/${secret_name}"
  else
    vimcrypt_file="${_secretspath}/secrets/$1"
  fi

  vimcrypt_password=$(read_password "Enter the password for the secret")
  decrypted_text=$(vim_decrypt_file "$vimcrypt_file" "$vimcrypt_password")

  echo "$decrypted_text"
}

var_secret() {
  local secret_name="$1"
  if [ -z "$1" ]; then
    secret_name=$(cd "${_secretspath}/secrets" && find . -type f -not -path '*/\.*' | sed 's|^\./||' | fzf)
    if [ -z "${secret_name}" ]; then
      echo "Empty selection"
      return 1
    fi
  else
    secret_name="$1"
  fi

  local env_var_name=$(echo "$secret_name" | tr '[:lower:]' '[:upper:]')
        
  # Decrypt and store the content
  local secret_content
  secret_content=$(get_secret "$secret_name")
    
  # Check if decryption was successful
  if [ -z "$secret_content" ]; then
    printf "Error: Failed to decrypt secret '%s'\n" "$secret_name" >&2
    return 1
  fi
    
  # Export to environment variable
  export "$env_var_name=$secret_content"
    
  # Optionally notify that the secret was loaded (to stderr to avoid affecting pipes)
  printf "Loaded secret '%s' into environment variable '%s'\n" "$secret_name" "$env_var_name" >&2
}

_updatesecrets() {
  cd ${_secretspath}
  git pull

  cd - > /dev/null
}

secrets() {
  if [ $# -lt 1 ]; then
    echo "Usage: $0 <command> [args...]"
    return 1
  fi

  local COMMAND=$1
  shift

  case "$COMMAND" in
    "up" | "update")
      _updatesecrets
      ;;
    "in" | "install")
      _clonesecrets
      ;;
    "get" | "show")
      get_secret $@
      ;;
    "set" | "add")
      add_secret $@
      ;;
    "var")
      var_secret $@
      ;;      
    *)
      echo "Unknown command: $0 $COMMAND"
      ;;
  esac
}
