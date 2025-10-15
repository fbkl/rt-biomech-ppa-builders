set -e
docker build -t debian-builder .
export simbodyversion=3.7-1
export catch2version=3.11.0-1
export opensimversion=4.5.2-1
export spdlogversion=1.15.3-1
docker run -it \
  -v $HOME/.ssh:/home/builder/.ssh:ro \
  -v $HOME/.gnupg:/home/builder/.gnupg:rw \
  -v "$(pwd)/src/simbody":/src/simbody-${simbodyversion} \
  -v "$(pwd)/src/catch2":/src/catch2-${catch2version} \
  -v "$(pwd)/src/opensim-core":/src/opensim-${opensimversion} \
  -v "$(pwd)/src/spdlog":/src/spdlog-${spdlogversion} \
  debian-builder

