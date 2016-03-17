name "pypi"

build do
  command "curl -kL https://bootstrap.pypa.io/get-pip.py | #{install_dir}/embedded/bin/python"
  command "ln -fs #{install_dir}/embedded/bin/pip #{install_dir}/bin/pip"
end
