local version="0.9.8.4.1"
local type="tar.gz"
local URL="http://bpipe.googlecode.com/files/bpipe-${version}.${type}"
local tb_file=`basename $URL`
local tar_name="bpipe-v${version}"
local seed_name="bpipe-${version}"
local install_files=(bin/bpipe)


do_install()
{
  cd $TB_DIR
  download $URL $tb_file
  decompress_tool $tb_file $type
  mv $TB_DIR/$seed_name $STAGE_DIR/$seed_name
}

do_activate()
{
  link_from_stage $seed_name ${install_files[@]}
}

do_remove()
{
  remove_recipe $seed_name
  remove_from_stage $seed_name ${install_files[@]}
}

source "$MAIN_DIR/lib/case.sh"
