local URL="http://cran.stat.ucla.edu/src/base/R-2/R-2.12.0.tar.gz"
local tb_file=`basename $URL`
local type="tar.gz"
local seed_name=$(extract_tool_name $tb_file $type)
local install_files=(bin/R bin/Rscript)

do_install()
{
  before_install $seed_name
  cd $TB_DIR
  download $URL $tb_file
  decompress_tool $tb_file $type
  cd $seed_name
  configure_tool $seed_name "--with-x=no"
  make_tool $seed_name $make_j
  install_tool $seed_name
  link_from_stage $seed_name ${install_files[@]}
  after_install $seed_name
}

do_remove()
{
  before_remove $seed_name
  remove_recipe $seed_name
  remove_from_stage $seed_name ${install_files[@]}
  after_remove $seed_name
}

source "$MAIN_DIR/lib/case.sh"
