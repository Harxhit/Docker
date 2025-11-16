## Container Registry

A repository or container of repositories used to store or access container images.
There are many types of container registries some of example are given below :

- Dockerhub
- Github container registry(ghcr.io)
- Google container registry(gcr.io)
- Amazon elastic container registry (ECR)
- Azure container registry(ACR)
- Nexus
- Harbour

### Authenticating Container registry

We can have public or private container registry . For a public registry we dont need to authenticate to pull but for push we need to authenticate for that container registry . In private container registry we need to authenticate for both push and pull.

### Code
Below are the codes for how to push into docker hub repo and github repo


#### Docker Hub
```powershell
docker build . --tag my-scratch-image
-rm Dockerfile
#I need to login first before pushing  below is how to login
#docker login
docker tag my-scratch-image harxhitttt/my-scratch-image
docker push harxhitttt/my-scratch-image
```
#### Github
```powershell
docker build . --tag my-scratch-image
-rm Dockerfile
#I need to login first before pushing below is how to login
# export CD_PAT=token given by github
# echo $CD_PAT | docker login ghcr.io -u MY_USERNAME --password-stdin
docker tag my-scratch-image harxhitttt/my-scratch-image
docker push harxhitttt/my-scratch-image
```