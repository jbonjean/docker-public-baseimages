#!/bin/sh
set -eu

IMAGES="
base-ubuntu-24.04
base-jre-25
base-jdk-25
base-nodejs-14
"

DOCKER_TAG="${DOCKER_TAG:-master}"

docker pull ubuntu:noble

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
