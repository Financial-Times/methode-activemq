errorAndExit() {
  echo -e "\e[31m$(date '+%x %X') ERROR: $1\e[0m"
  exit $2
}

info() {
  echo -e "\e[34m$(date '+%x %X') INFO: ${1}\e[0m"
}

processCliArgs() {
  #  Reads arguments into associative array ARGS[]
  #  Key-Value argument such as --myarg="argvalue" adds an element ARGS[--myarg]="argvalue"
  #
  #  USAGE: processCliArgs $*
  for each in $*; do
    if [[ "$(echo ${each} | grep '=' >/dev/null ; echo $?)" == "0" ]]; then
      key=$(echo ${each} | cut -d '=' -f 1)
      value=$(echo ${each} | cut -d '=' -f 2)
      if [[ "${ARGS[--debug]}" ]]; then
        if [[ "${key}" =~ "key" ]]; then
          info "Processing Key-Value argument ${key}=${value:0:4}********************"
        else
          info "Processing Key-Value argument ${key}=${value}"
        fi
      fi
      ARGS[${key}]="${value}"
    else
      errorAndExit "Argument must contain = character as in --key=value"
    fi
  done
}
