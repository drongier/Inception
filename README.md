## Inception

### 1. How Docker and docker-compose work

**Docker** is a tool that allows us to create, deploy and run containers. A container is a lightweight, portable, and isolated environment that includes everything needed to run an application.

**Docker Compose** is a tool that allows us to define and run multi-container applications with a single YAML file (`docker-compose.yml`). It simplifies complex setups involving multiple services like WordPress, NGINX, and MariaDB.

**Summary:**

* Docker: runs individual containers.
* Docker Compose: manages multiple containers together with one command.

---

### 2. Difference between a Docker image used with and without docker-compose

| Without Docker Compose        | With Docker Compose                     |
| ----------------------------- | --------------------------------------- |
| Use `docker run` manually     | Use `docker-compose up` automatically   |
| Manual linking and networking | Networks are declared in the YAML file  |
| Harder to scale/configure     | Easy orchestration of multiple services |

**Conclusion:** Docker Compose simplifies and automates container management for multi-service applications.

---

### 3. Benefits of Docker compared to VMs

| Docker                   | Virtual Machines                   |
| ------------------------ | ---------------------------------- |
| Shares host OS kernel    | Each VM has its own OS             |
| Lightweight and fast     | Heavy and slow to start            |
| Easy to version and ship | Harder to distribute and replicate |
| Ideal for microservices  | Better for full system emulation   |

**Conclusion:** Docker is faster, more efficient, and better suited for modern development.

---

### 4. Pertinence of the directory structure

Having a well-organized project structure helps maintainability, clarity, and scalability. Each service is isolated in its own folder with its own Dockerfile and configurations.

**Example:**

```
inception/
├── docker-compose.yml
├── srcs/
│   ├── wordpress/
│   │   ├── Dockerfile
│   │   └── tools/setup.sh
│   ├── nginx/
│   │   ├── Dockerfile
│   │   └── conf/default.conf
│   └── mariadb/
│       ├── Dockerfile
│       └── conf/my.cnf
```

**Benefits:**

* Separation of concerns
* Easier debugging
* Better project readability
* Modular and extendable (e.g., adding Redis, Adminer, etc.)


**Commands:**

nobody:nobody
docker exec -it wordpress sh
ls -la /var/www/html

*check PID 1

docker exec nginx ps aux
docker exec wordpress ps aux
docker exec mariadb ps aux

*clean volume et dockers

docker compose down -v --rmi all
docker system prune -af --volumes

*Login

https://drongier.42.fr/wp-login.php


**Questions:**

Utiliser la derniere version d'alpine 3.22 ? 
Ok si pas de folder secret ?

