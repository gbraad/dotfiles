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

  # Check if the correct number of arguments are provided
  if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <file>"
    return 0
  fi

  # Get the argument
  vimcrypt_file="$1"

  vimcrypt_password=$(read_password "Enter the password for the file")
  decrypted_text=$(vim_decrypt_file "$vimcrypt_file" "$vimcrypt_password")

  echo "$decrypted_text"
}

set_secret_variable() {
  local secret_name="$1"
  local secret_file="${_secretspath}/secrets/${secret_name}"
  local env_var_name=$(echo "$secret_name" | tr '[:lower:]' '[:upper:]')
    
  # Check if file exists
  if [ ! -f "$secret_file" ]; then
    printf "Error: Secret file '%s' does not exist\n" "$secret_file" >&2
    return 1
  fi
    
  # Decrypt and store the content
  local secret_content
  secret_content=$(get_secret "$secret_file")
    
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

