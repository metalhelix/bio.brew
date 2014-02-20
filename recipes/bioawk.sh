local version="10-17-2013"
local URL="git://github.com/lh3/bioawk.git"
local seed_name="bioawk-${version}"
local install_files=(bioawk)

do_install()
{
  cd $STAGE_DIR
  download_git $URL $seed_name
  cd $seed_name
  make_tool $seed_name $make_j
}

do_activate()
{
  link_from_stage $seed_name ${install_files[@]}
}

do_test()
{
	log "test"	
}

do_remove()
{
  remove_recipe $seed_name
  remove_from_stage $seed_name ${install_files[@]}
}

source "$MAIN_DIR/lib/case.sh"
