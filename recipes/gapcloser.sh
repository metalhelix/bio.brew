local version="1.12-r6"
local short_version="r6"
local seed_name="gapcloser_$version"
local type="tgz"
local URL="http://downloads.sourceforge.net/project/soapdenovo2/GapCloser/bin/${short_version}/GapCloser-bin-v${version}.${type}"
local tb_file=`basename $URL`
local extract_name=`basename $URL .$type`
local deps=()
local external_deps=()
local tb_files=(GapCloser GapCloser_Manual.pdf)
local install_files=(GapCloser)

do_install()
{
  cd $TB_DIR
  download $URL $tb_file
  decompress_tool $tb_file $type
  mkdir $STAGE_DIR/$seed_name
  for file in ${tb_files[@]}
  do
    echo $file
    mv $TB_DIR/$file $STAGE_DIR/$seed_name
  done
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
