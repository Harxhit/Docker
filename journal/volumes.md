## Volume

Step 1: Run a basic docker container

```powershell
docker run -it --rm ubuntu:25.10
```

Step 2 : Create a folder and file inside the container

```powershell
mkdir my-data
echo 'Hello from container' > my-data/hello.txt
cat /my-data/hello.txt
```

Output :

```powershell
Hello from a container
```

Then we exit the container

```powershell
exit
```

Step 3: Run another container

```powershell
docker run -it ubuntu:25.10
cat my-data/hello.txt
```

Output :

```powershell
cat: my-data/hello.txt: No such file or directory
```

[!Terminal image of how to create a container](/assets/CreatingAContainer.png)

Explanation :
Each conatiner is isolated , so the previous container is gone.

Step 4 : Create a volume

```powershell
docker volume create my-volume
```

This creates the persistent storage outside the container.

Step 5 : Attach the volume to a new container

```powershell
docker run -it --rm --mount source=my-volume,destination=/my-data/hello.txt
```

Now my data is linked to persistent storage

Inside this container:

```powershell
echo 'Hello from new container' > my-data/hello.txt
```

Step 6 : Reopen the another container with same volume

```powershell
docker run -it --rm --mount source=my-volume,destination=/my-data ubuntu
ls -la
cat /my-data/hello.txt
```

Output:

```powershell
Hello from new container
```

[!Volume terminal screenshot](/assets/Volume.png)

### Conclusion

- Without volumes → Data is deleted after container exit.
- With volumes → Data persists across containers.
- Volumes act like shared, permanent storage between containers.

## Bind Mount

Step 1 : Run a conatiner using bind method

```powershell
docker run -it --rm --mount type=bind,source="${PWD}/my-data",destination=/my-data
```

This will open a container with a shell

```powershell
cd my-data
ls my-data
```

Output : Nothing because there is no file inside the my-data .

```powershell
echo 'What is love' > hello.txt
cat hello.txt
```

Output :

```powershell
What is love
```

```powershell
exit
```

This made me exit the conatiner

Now I will run below comamnds to make changes locally in the **hello.txt** file the changes I made will be shown in conatiner to.

```powershell
cd my-data
ls my-data
code hello.txt
```

**I will add What is love please dont heart me**.
I will save it now I will open a new container mounted with same docker container.

```powershell
docker run -it --rm --mount type=bind,source="${PWD}/my-data",destination=/my-data
cd my-data
cat hello.txt
```

I will see the changes I made locally

[!Terminal image 1 of bind methods](/assets/BindMethod.png)
[!Terminal image 2 of bind methods](/assets/BindMethod2.png)

## Key Takeaways

- Bind mounts allow direct access to host files from inside a container.
- Changes are synchronized in real-time between host and container.
- This is different from Docker volumes, which are managed by Docker and hidden from the host.
- Ideal for development workflows, where you want to edit code locally and see it inside the container immediately.
