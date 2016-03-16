FROM marcy/omnibus-ubuntu-14

RUN . /root/load-omnibus-toolchain.sh && bundle install --binstubs --without development

ENTRYPOINT ["bin/omnibus", "build"]
