docker build -t debian-builder .
docker run -it \
  -v $HOME/.ssh:/home/builder/.ssh:ro \
  -v $HOME/.gnupg:/home/builder/.gnupg:rw \
  -v "$(pwd)/src":/src debian-builder

