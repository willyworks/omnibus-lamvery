name "virtualenv"

build do
  command "#{install_dir}/embedded/bin/pip install virtualenv"
  command "ln -fs #{install_dir}/embedded/bin/virtualenv #{install_dir}/bin/virtualenv"
end
