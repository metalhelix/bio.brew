bb_unlock()
{
  local recipe=$1
  local bb_action="unlock"
  log "Removing lock for recipe: $recipe"
  check_recipe ${recipe}.sh
  log "recipe script found"  
  source "$RECIPE_DIR/${recipe}.sh"
}

do_unlock()
{
  local seed_name=$1
  local lock_file="$LOG_DIR/$recipe_name.lock"
  local install_flag="$LOG_DIR/$recipe_name.installed"
  log "removing $lock_file"
  rm -f $lock_file
  log "removing $install_flag"
  rm -f $install_flag
}
