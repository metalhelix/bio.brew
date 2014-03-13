local version="0.64"
local tool_version="0.16-2"
local seed_name="circos-$version"
local tut_seed_name="circos-tutorials-$version"
local tool_seed_name="circos-tools-$tool_version"
local type="tgz"
local URL="http://circos.ca/distribution/circos-${version}.${type}"
local tut_URL="http://circos.ca/distribution/circos-tutorials-${version}.${type}"
local tool_URL="http://circos.ca/distribution/circos-tools-${tool_version}.${type}"
local tb_file=`basename $URL`
local tut_tb_file=`basename $tut_URL`
local tool_tb_file=`basename $tool_URL`
local deps=()
local install_files=(bin/circos)

do_install()
{
  cd $TB_DIR
  download $URL $tb_file
  download $tut_URL $tut_tb_file
  download $tool_URL $tool_tb_file
  decompress_tool $tb_file $type
  decompress_tool $tut_tb_file $type
  decompress_tool $tool_tb_file $type
  mv $TB_DIR/$seed_name $STAGE_DIR/$seed_name
  mv $TB_DIR/$tut_seed_name $STAGE_DIR/$tut_seed_name
  mv $TB_DIR/$tool_seed_name $STAGE_DIR/$tool_seed_name
  cd $STAGE_DIR/$seed_name
}

do_test()
{
	$STAGE_DIR/$seed_name/bin/circos -conf $STAGE_DIR/$seed_name/example/etc/circos.conf
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
