name "pypi"

dependency "curl"

build do
  command "curl -kL https://raw.github.com/pypa/pip/master/contrib/get-pip.py | #{install_dir}/embedded/bin/python"
  command "ln -fs #{install_dir}/embedded/bin/pip #{install_dir}/bin/pip"
end
