docker build -t debian-builder-small -f simple_dockerfile .
docker run -it \
  -v $HOME/.ssh:/home/builder/.ssh:ro \
  -v $HOME/.gnupg:/home/builder/.gnupg:rw \
  -v "$(pwd)/src":/src debian-builder-small

