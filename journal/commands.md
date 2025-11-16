## Docker Command's I used

### -d

By using -d command with docker run it gives me the container id.

```powershell
docker run -d ubuntu:latest sleep 5
```

Output: Gives container id

[!Terminal screenshot of running -d command](/assets/-d.png)

### --entrypoint

The default entrypoint for docker run is bash we can specify it by using below command

```powershell
docker run --entrypoint echo ubuntu hello
```

Output

```powershell
Hello
```

[!Docker entry point command terminal image](/assets/--entrypoint.png)

#### -e OR --env OR --env-file

Sets up enviorment variable

```powershell
docker run --env MY_ENV=hello printenv
docker run -e MY_ENV=hello printenv
docker run --env-file MY_ENV printenv
```

Here **printenv** : sPrints the env

Output

```powershell
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
HOSTNAME=0a3c97493ff6
MY_ENV=hello
HOME=/root
```

[!Terminal screen shot for above all three commands](/assets/--env.png)

#### --init

It generates starter Docker configuration files for your project.\
It is helpfull when your application have sub-process.

It scans your project and auto-creates:

- Dockerfile
- .dockerignore
- Optional compose.yaml

It asks a few questions about your app (language, how to run, ports, etc.).

It outputs a clean, optimized setup so you don’t write everything manually.

It does not build or run containers; it only scaffolds config files.

```powershell
docker --init
```

[!Terminal screenshot of --init command](/assets/init1.png)

For below commands below it adds a lightweight init process (PID 1) inside the container. s

This init process:

- Reaps zombie processes.
- Handles signal forwarding correctly.

Useful for long-running apps that spawn child processes.

```powershell
docker run ubuntu ps
```

Output

```powershell
  PID TTY          TIME CMD
    1 ?        00:00:00 ps
```

```powershell
docker run --init ubuntu ps
```

Output

```powershell
  PID TTY          TIME CMD
    1 ?        00:00:00 docker-init
    7 ?        00:00:00 ps
```

What **ps** command do ?

- The command executed inside the container.
- It lists the process running inside the container.

[!Terminal screenshot for --init command](/assets/--init.png)

#### --interactive OR -I OR --tty OR -t

When I run

```powershell
docker run ubuntu
```

It creates the container and exits.

```powershell
docker run --interactive ubuntu
```

It does the same thing above.

But when I run

```powershell
docker run --interactive --tty ubuntu
```

It creates the shell inside the container.We can also the above command same as below:

```powershell
docker run -it ubuntu
```

[!Terminal screen shot for all the commands](/assets/ShellOpen.png)

### --mount OR --volume OR -v

**--volume** Always needs two parts

```powershell
--volume <source>:<target>
```

Where:

```bash
<source> = host path or named volume
```

```bash
<target> = path inside the container
```

Whole command will look like below:

```powershell
docker create --volume my_volume:/data ubuntu
```

If I only need to create a volume locally

```powershell
docker volume create my_volume
```

The difference between both of those commands is -

```powershell
docker volume create my_volume
```

This one is to create a volume locally then I need to use mount to mount this with my container.

```powershell
docker volume create my_volume
```

This one creates the volume inside the container

```powershell
docker create --volume my_volume:/data ubuntu
```

We can also write it as like below:

```powershell
docker create -v my_volume:/data ubuntu
```

This is how we mount the my_volume locally to the container

```powershell
docker run --mount source=my_volume,target=/data -it ubuntu
```

[!Terminal screenshot for all the commands](/assets//mount.png)

### --name

Name the container whatever you want.

```powershell
docker run -d --name my_container ubuntu sleep 99
```

Output:

```powershell
CONTAINER ID   IMAGE     COMMAND      CREATED         STATUS         PORTS     NAMES
c68368a77d0c   ubuntu    "sleep 99"   4 seconds ago   Up 3 seconds             my-container
```

[!Terminal screenshot for the above command](/assets/name.png)

### --network OR --net

It creates the network and the network you want can switch to desire network you want.

```powershell
docker network ls
```

Lists the available network

```powershell
docker network create my-network
```

Creates a docker new network

```powershell
 docker run -d --network my-network ubuntu sleep 99
```

Runs the container on my network

```powershell
 docker run -d --net my-network ubuntu sleep 99
```

This command can also be written by below command

```powershell
docker run -d --net my-network ubuntu sleep 99
```

[!Terminal screenshot of networks all commands](/assets/network.png)

### --platform

This allows to in which platform architecture we want to run our image.

```powershell
docker run --platform/linux/amd64/v8 dpkg --print-architecture
```

This is the command executed inside the container.

**_dpkg --print-architecture_** prints the CPU architecture inside the running Ubuntu container, for example:

```bash
arm64
```

Useful for:

- testing multi-arch
- images running ARM containers on an x86 system (Docker uses emulation via QEMU)

[!Terminal screenshot for above commands](/assets/platform.png)

### --restart

Decides what Docker should do if your container stops

This is the default command.

```powershell
docker run --restart no ubuntu
```

If the container stops, Docker does nothing.

On-failure

```powershell
docker run --restart on-failure ubuntu
```

Docker restarts the container only if it exits with a non-zero error code.
Good for apps that should restart only when they crash.

unless-stopped

```powershell
docker run --restart unless-stopped ubuntu
```

Docker automatically restarts the container if it stops for any reason,
except when you manually stop it.
.

### --rm

Removes the container.

### docker ps

It shows the running container.

```powershell
docker run -d ubuntu:latest sleep 15
docker ps
```

Output :

```powershell
CONTAINER ID   IMAGE     COMMAND      CREATED         STATUS         PORTS     NAMES
138b91cb0654   ubuntu    "sleep 15"   3 seconds ago   Up 2 seconds             sharp_wilson
```

[!D command image](/assets//-d%20command.png)

## start -ai

Here -a = attach \

- It attaches your terminal to the container’s STDOUT/STDERR.
- You will see the container’s logs/output.

Here -i = interactive \

- It keeps STDIN open so you can type commands if the container was created with a shell (-it or an entrypoint like /bin/bash).

```powershell
docker start -ai <container_id>
```

This will start the container .
