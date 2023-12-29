#!/bin/sh
set -eu

IMAGES="
base-ubuntu-20.04
base-ubuntu-22.04
base-jre-17
base-jdk-17
base-nodejs-10
base-nodejs-14
"

DOCKER_TAG="${DOCKER_TAG:-master}"

docker pull ubuntu:focal
docker pull ubuntu:jammy

# Build images.
for image in $IMAGES; do
	echo "Building jbonjean/$image"
	docker build "$image" --tag "jbonjean/$image:$DOCKER_TAG" --build-arg DOCKER_TAG="$DOCKER_TAG"
	docker tag "jbonjean/$image:$DOCKER_TAG" "jbonjean/$image:latest"
done

echo "Build success"

if [ "${CI:-}" != "true" ]; then
	echo "Not in CI environment, stopping here"
	exit 0
fi

# Push images, with the new tag.
for image in $IMAGES; do
	echo "Pushing jbonjean/$image:$DOCKER_TAG"
	docker push "jbonjean/$image:$DOCKER_TAG"
done

# Update latest tag.
for image in $IMAGES; do
	echo "Pushing jbonjean/$image:latest"
	docker push "jbonjean/$image:latest"
done

echo "Done"
