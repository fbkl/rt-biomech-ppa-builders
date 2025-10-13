docker build -t debian-builder .
docker run -it \
  -v $HOME/.ssh:/home/builder/.ssh:ro \
  -v $HOME/.gnupg:/home/builder/.gnupg:ro \
  -v "$(pwd)/src":/src debian-builder

