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
      sudo virt-install "${START_ARGS[@]}" --name "mcn-${PREFIX}" --import --disk "${DISKFOLDER}/${PREFIX}.qcow2"
      ;;
    "start")
      sudo virsh start "mcn-${PREFIX}"
      ;;
    "stop")
      sudo virsh destroy "mcn-${PREFIX}"
      ;;
    "kill" | "rm" | "remove")
      sudo virsh undefine "mcn-${PREFIX}"
      ;;
    "console" | "shell")
      sudo virsh console "mcn-${PREFIX}"
      ;;
    "switch")
      sudo bootc switch $(mcnini --get images.${PREFIX})
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
    if [[ $input == *\[*\]* ]]; then
        base_url="${input%\[*}"
        range="${input##*\[}"
        range="${range%\]*}"
        start_part="${range%-*}"
        end_part="${range#*-}"
        
        if [[ -z "$start_part" || -z "$end_part" ]]; then
            echo "Invalid range start or end"
            return 1
        fi
        
        # Remove any existing final output file to avoid appending to old data
        rm -f "$final_output_file"

        for i in $(seq $start_part $end_part); do
            part_url="${base_url}${i}"
            echo "Downloading $part_url and appending to $final_output_file..."
            curl -s -L "$part_url" -o - >> "$final_output_file"
            if [[ $? -ne 0 ]]; then
                echo "Error downloading $part_url. Exiting."
                return 1
            fi
        done
        echo "Download completed and concatenated into $final_output_file."
    else

    echo "nope"

        # Direct download
        url=$input
        echo "Downloading $url to $final_output_file..."
        curl -s -L $url -o $final_output_file
        if [[ $? -ne 0 ]]; then
            echo "Error downloading $url. Exiting."
            return 1
        fi
        echo "Download completed: $final_output_file."
    fi
}
