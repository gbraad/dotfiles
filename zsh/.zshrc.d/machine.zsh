#!/bin/zsh

CONFIG="${HOME}/.machine"
alias mcnini="git config -f $CONFIG"

mcn() {
  if [ $# -lt 2 ]; then
    echo "Usage: mcn <prefix> <command> [args...]"
    return 1
  fi

  local PREFIX=$1
  local COMMAND=$2
  shift 2

  local START_ARGS=(
    "--cpu=host"
    "--vcpus=$(mcnini --get machine.vcpus)"
    "--memory=$(mcnini --get machine.memory)"
    "--graphics=none"
    "--noreboot"
    "--os-variant=fedora-eln"
  )
  local DISKFOLDER=$(mcnini --get machine.diskfolder)
  DISKFOLDER="${DISKFOLDER/#\~/$HOME}"

  case "$COMMAND" in
    "download")
      download "$(mcnini --get disks.${PREFIX})" "${DISKFOLDER}/${PREFIX}.qcow2"
      ;;
    "system" | "create")
      ;;
    "start")
      ;;
    "stop")
      ;;
    "kill" | "rm" | "remove")
      ;;
    "console" | "shell")
      ;;
    "switch")
      ;;
    *)
      echo "Unknown command: dev $PREFIX $COMMAND"
      ;;
  esac
}

download() {
    input=$1
    final_output_file=$2

    # Check if the input contains a range pattern
    if [[ $input =~ \[([0-9]+)-([0-9]+)\] ]]; then
        # Extract the base URL and the range
        base_url="${input%%_part*}"
        start_part=${BASH_REMATCH[1]}
        end_part=${BASH_REMATCH[2]}
        
        # Remove any existing final output file to avoid appending to old data
        rm -f "$final_output_file"

        # Loop through the range and download each part, appending to the final file
        for i in $(seq $start_part $end_part); do
            part_url="${base_url}_part${i}"
            echo "Downloading $part_url and appending to $final_output_file..."
            curl -s -L "$part_url" -o - >> $final_output_file
            if [[ $? -ne 0 ]]; then
                echo "Error downloading $part_url. Exiting."
                return 1
            fi
        done
        echo "Download completed and concatenated into $final_output_file."
    else
        # Direct download
        url=$input
        echo "Downloading $url to $final_output_file..."
        curl -L $url -o $final_output_file
        if [[ $? -ne 0 ]]; then
            echo "Error downloading $url. Exiting."
            return 1
        fi
        echo "Download completed: $final_output_file."
    fi
}
