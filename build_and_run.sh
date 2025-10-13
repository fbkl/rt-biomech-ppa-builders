docker build -t debian-builder .
docker run -it -v "$(pwd)":/src debian-builder

