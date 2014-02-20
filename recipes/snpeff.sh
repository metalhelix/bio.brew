
# wget http://sourceforge.net/projects/snpeff/files/snpEff_latest_core.zip

local version="3_3h"
local type="zip"
local tb_file="snpEff_v${version}_core.${type}"
#local URL="http://sourceforge.net/projects/snpeff/files/${tb_file}"
local tb_dir=`basename $tb_file .$type`
local seed_name="snpEff_${version}"
local deps=(java)

local databases=(WS220.66)

do_install()
{
  cd $TB_DIR
#  download $URL $tb_file
#  wget -O $tb_file http://sourceforge.net/projects/snpeff/files/snpEff_latest_core.zip
  decompress_tool $tb_file $type
  mv snpEff $STAGE_DIR/$seed_name
  # mv $tb_dir $seed_name
  #mv $seed_name $STAGE_DIR
  cd $STAGE_DIR/$seed_name
  perl -i -pe 's!data_dir = ~/snpEff/data/!data_dir = /n/local/stage/snpeff/data/$version/!' snpEff.config
  # TODO: make this into an array and iterate
  # stop being so lazy
}

do_activate()
{
  ln -s $STAGE_DIR/$seed_name $STAGE_DIR/current
#  java -jar ./snpEff.jar download WS220.66
#  java -jar ./snpEff.jar download Zv9.66
  for_env "export SNPEFF='$STAGE_DIR/current'"
}

do_remove()
{
  remove_recipe $seed_name
}

source "$MAIN_DIR/lib/case.sh"
