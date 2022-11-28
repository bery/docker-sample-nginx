docker-build-nocache:
	docker buildx build --nocache --platform=linux/amd64,linux/arm/v8 . -t dsrcaapp.azurecr.io/nginx-demo
docker-build:
	docker buildx build --platform=linux/amd64,linux/arm/v8 . -t dsrcaapp.azurecr.io/nginx-demo

docker-run: docker-build
	docker run --rm -p 8080:80 dsrcaapp.azurecr.io/nginx-demo

docker-push: login docker-build
	docker buildx build --push --platform=linux/amd64,linux/arm/v8 . -t dsrcaapp.azurecr.io/nginx-demo

dive: docker-build
	docker run --rm -it \
    -v /var/run/docker.sock:/var/run/docker.sock \
    wagoodman/dive:latest dsrcaapp.azurecr.io/nginx-demo

login:
	az acr login --name dsrcaapp