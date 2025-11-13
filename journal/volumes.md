## Volume

```powershell
Step 1: Run a basic docker container
docker run -it --rm ubuntu:25.10
Step 2 : Create a folder and file inside the container
mkdir my-data
echo 'Hello from container' > my-data/hello.txt
cat /my-data/hello.txt

Output :
Hello from a container

Then we exit the container
exit

Step 3: Run another container
docker run -it ubuntu:25.10
cat my-data/hello.txt

Output :
cat: my-data/hello.txt: No such file or directory

```

[!Creating a container](/assets/Creating%20a%20container.png)

Explanation :
Each conatiner is isolated , so the previous container is gone.

```
Step 4 : Create a volume
docker volume create my-volume

This creates the persistent storage outside the container

Step 5 : Attach the volume to a new container
docker run -it --rm --mount source=my-volume,destination=/my-data/hello.txt

Now my data is linked to persistent storage

Inside this container:
echo 'Hello from new container' > my-data/hello.txt

Step 6 : Reopen the another container with same volume

docker run -it --rm --mount source=my-volume,destination=/my-data ubuntu
ls -la
cat /my-data/hello.txt

Output:
Hello from new container
```

[!Volume](/assets/Volume.png)

### Conclusion

- Without volumes → Data is deleted after container exit.
- With volumes → Data persists across containers.
- Volumes act like shared, permanent storage between containers.

## Bind Mount

```powershell
Step 1 : Run a conatiner using bind method
docker run -it --rm --mount type=bind,source="${PWD}/my-data",destination=/my-data
This will open a container with a shell
cd my-data
ls my-data
Output : Nothing because there is no file inside the my-data
echo 'What is love' > hello.txt
cat hello.txt
Output :
What is love
exit
This made me exit the conatiner
```

Now I will run below comamnds to make changes locally in the hello.txt file the changes I made will be shown in conatiner to.

```powershell
cd my-data
ls my-data
code hello.txt
I will add What is love please dont heart me
I will save it now I will open a new container mounted with the same
docker run -it --rm --mount type=bind,source="${PWD}/my-data",destination=/my-data
cd my-data
cat hello.txt
I will see the changes I made locally
```

[!Bind method](/assets/Bind%20method.png)
[!Bind method](/assets/Bind%20method%202.png)

## Key Takeaways

- Bind mounts allow direct access to host files from inside a container.
- Changes are synchronized in real-time between host and container.
- This is different from Docker volumes, which are managed by Docker and hidden from the host.
- Ideal for development workflows, where you want to edit code locally and see it inside the container immediately.
