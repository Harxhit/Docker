# Docker – Learning Notes

## Overview

This repository documents my first hands-on learning experience with Docker.  
I built a simple Ubuntu-based image, installed some packages, and ran a container interactively to understand how Docker images and containers work.

---

## Containers

### 1. **Dockerfile Basics**

- A `Dockerfile` is a text file that contains instructions to build a Docker image.
- My Dockerfile:
  ```dockerfile
  FROM ubuntu:25.10
  RUN apt update && apt install iputils-ping -y
  ```
- `FROM` sets the base image (Ubuntu 25.10 in this case).
- `RUN` executes commands inside the image during the build (like installing packages).

---

### 2. **Building an Image**

- Command used:
  ```bash
  docker build -t my-ubuntu-image .
  ```
- The `.` means “build from the Dockerfile in the current directory.”
- `-t my-ubuntu-image` assigns a tag (name) to the image.

---

### 3. **Running a Container**

- A container is a **running instance** of an image.
- Command to start and enter the shell:
  ```bash
  docker run -it my-ubuntu-image
  ```
- `-i` keeps STDIN open (interactive mode).
- `-t` allocates a terminal.

---

### 4. **Difference Between Image and Container**

- **Image** → a _blueprint_ or template (like a class).
- **Container** → a _running instance_ of that blueprint (like an object).

---

### 5. **Common Issues Faced**

- Docker couldn’t find the Dockerfile because it was named `DockerFile` (wrong case).  
  → Fixed by renaming it to `Dockerfile`.
- Running `docker run` without `-it` exited immediately since there was no terminal attached.

---

## Key Takeaways

- Docker simplifies environment setup using images and containers.
- Building and running images helped me understand how applications can be isolated and portable.
- I now know how to:
  - Write a basic `Dockerfile`
  - Build an image
  - Run and enter a container shell interactively


