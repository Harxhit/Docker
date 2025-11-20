.PHONY:build
build: 
	echo 'From scratch' > Dockerfile
	docker build . --tag my-scratch-image
	-rm Dockerfile

.PHONY:push-dockerhub
push-dockerhub:
	docker tag my-scratch-image harxhitttt/my-scratch-image
	docker push harxhitttt/my-scratch-image


.PHONY:push-github-packages
push-github-packages:
	docker tag my-scratch-image ghcr.io/harxhit/my-scratch-image:latest
	docker push ghcr.io/harxhit/my-scratch-image:latest