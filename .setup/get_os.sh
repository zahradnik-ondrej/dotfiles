get_os() {

  if grep -qi "manjaro" /etc/os-release; then
    echo "manjaro"
  else
    echo "unknown"
  fi

}
