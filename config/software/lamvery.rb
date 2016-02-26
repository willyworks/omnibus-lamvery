name "lamvery"

build do
  command "#{install_dir}/embedded/bin/pip install lamvery", :env => env
  command "ln -fs #{install_dir}/embedded/bin/lamvery #{install_dir}/bin/lamvery", :env => env
end
