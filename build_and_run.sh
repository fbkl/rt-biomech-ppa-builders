set -e
docker build -t debian-builder .
export simbodyversion=3.7-1
export catch2version=3.11.0-1
export opensim_coreversion=4.5.2-1
export spdlogversion=1.15.3-1

somevols() {
	local dep=$1
	local var="${dep}version"
	local ver=${!var}
	printf -- "-v %s/src/%s:/src/%s-%s -v %s/debian_folders/%s:/src/%s-%s/debian" \
		"$(pwd)" "$dep" "$dep" "$ver" \
		"$(pwd)" "$dep" "$dep" "$ver"
}

docker run -it \
  -v $HOME/.ssh:/home/builder/.ssh:ro \
  -v $HOME/.gnupg:/home/builder/.gnupg:rw \
  $(somevols simbody) \
  $(somevols catch2) \
  $(somevols opensim_core) \
  $(somevols spdlog) \
  debian-builder

