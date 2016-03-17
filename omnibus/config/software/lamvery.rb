name "lamvery"

build do
  command "#{install_dir}/embedded/bin/pip install lamvery==#{version}"
  command "ln -fs #{install_dir}/embedded/bin/lamvery #{install_dir}/bin/lamvery"
end
