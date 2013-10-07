#===============================================
# case.sh
# Should be sourced as final line for every recipe.
# Provides functionality for bb actions (install, 
# remove, etc).
#   
#===============================================
case $bb_action in
  "install") 
    if [ $(check_if_installed $seed_name) == "0" ]
    then
      check_deps ${deps[@]}
      check_external_deps ${external_deps[@]}
      before_install $seed_name
      do_install
      after_install $seed_name
    else
      log "recipe already installed, skipping."
    fi
    ;;
  "remove")
    if [ $(check_if_installed $seed_name) == "1" ]
    then
      before_remove $seed_name
      do_remove
      after_remove $seed_name
    else
      log "recipe not installed."
    fi
    ;;
  "activate")
    if [ $(check_if_installed $seed_name) == "1" ]
    then
      if [ $(check_if_active $seed_name) == "0" ]
      then
        before_activate $seed_name
        do_activate
        after_activate $seed_name
      else
        log "seed already active: $seed_name"
      fi
    else
      log "recipe not installed."
    fi
    ;;
  "test")
    if [ $(check_if_installed $seed_name) == "1" ]
    then
      do_test
    else
      log "recipe not installed."
    fi
    ;;
  "fake")
    if [ $(check_if_installed $seed_name) == "0" ]
    then
      fake_install $seed_name
    else
      log "recipe already installed, skipping."
    fi
    ;;
  "clean")
      do_clean $seed_name
    ;;
  "unlock")
      do_unlock $seed_name
    ;;
  "list")
    ;;
  *)
    log "Incorrect action. Bailing out."; exit 1
    ;;
esac
