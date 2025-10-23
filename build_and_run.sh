#!/usr/bin/env bash
set -e

echo "Choose your distro:"
select BASE_DISTRO_NAME in focal jammy noble; do
    [ -n "$BASE_DISTRO_NAME" ] && break
    echo "Invalid choice"
done
echo "Selected distro: $BASE_DISTRO_NAME"
case "$BASE_DISTRO_NAME" in
	focal)
		BASE_IMAGE=ubuntu:20.04
		;;
	jammy)
		BASE_IMAGE=ubuntu:22.04
		;;
	noble)
		BASE_IMAGE=ubuntu:24.04
		;;
esac

echo "What do you want to do?"
select ACTION in build-base build-deps skip-base skip-deps; do
    [ -n "$ACTION" ] && break
    echo "Invalid choice"
done
echo "Selected action: $ACTION"

build_cmd() {
	local TARGET_NAME=$1
	docker build --build-arg BASE_IMAGE=${BASE_IMAGE} \
		--build-arg BASE_DISTRO_NAME=${BASE_DISTRO_NAME} \
		--target ${TARGET_NAME} \
		-t ${BASE_DISTRO_NAME}-${TARGET_NAME}-builder . -f dockerfile
}
#BASE_IMAGE=$1
#BASE_DISTRO_NAME=$2
#TARGET_NAME=$3
export simbodyversion=3.7-1
export catch2version=3.11.0-1
export opensim_coreversion=4.5.2-1
export spdlogversion=1.15.3-1

somevols() {
	local dep=$1
	local var="${dep}version"
	local ver=${!var}
	local distro_dir=tmp/${BASE_DISTRO_NAME}/$dep
	if [ ! -d "$distro_dir" ]; then
		mkdir -p tmp/${BASE_DISTRO_NAME}/$dep
		cp -R debian_folders/$dep/ tmp/${BASE_DISTRO_NAME}/

	fi
	printf -- "-v %s/src/%s:/src/%s-%s -v %s/%s:/src/%s-%s/debian" \
		"$(pwd)" "$dep" "$dep" "$ver" \
		"$(pwd)" "$distro_dir" "$dep" "$ver"
}

run_cmd() {
	IMAGE_TAG=$1
xhost +
docker run -it \
  -v $HOME/.ssh:/home/${BASE_DISTRO_NAME}builder/.ssh:ro \
  -v $HOME/.gnupg:/home/${BASE_DISTRO_NAME}builder/.gnupg:rw \
  -v $(pwd)/src/test_simbody_install:/src/test_simbody \
  -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
  $(somevols simbody) \
  $(somevols catch2) \
  $(somevols opensim_core) \
  $(somevols spdlog) \
  $IMAGE_TAG
}

case "$ACTION" in
    build-base)
        build_cmd base
        run_cmd	${BASE_DISTRO_NAME}-base-builder
	;;
    build-deps)
        build_cmd deps
        run_cmd	${BASE_DISTRO_NAME}-deps-builder
	;;
    skip-base)
        echo "Skipping build, running base"
        run_cmd	${BASE_DISTRO_NAME}-base-builder
        ;;
    skip-deps)
        echo "Skipping build, running deps"
        run_cmd	${BASE_DISTRO_NAME}-deps-builder
        ;;
esac

