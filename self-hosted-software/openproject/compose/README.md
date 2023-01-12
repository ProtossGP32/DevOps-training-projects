# OpenProject installation with Docker Compose

This Docker Compose deployment is based on the ones available in the official Docker NextCloud repository:
- [Examples with secrets](https://github.com/docker-library/docs/blob/master/nextcloud/README.md#docker-secrets)
- [Additional examples](https://github.com/nextcloud/docker/tree/master/.examples)

## Custom docker-compose parameters
TODO: Docker Compose doesn't seem to be applying the overridden parameters, so for now launch it with:

```bash
OPENPROJECT_HTTPS="false" OPENPROJECT_HOST__NAME="<server-ip>:8080" docker compose up -
```

Any additional parameter that should be configured or overridden from the base `docker-compose.yml` file can be defined inside the `docker-compose.override.yml` file; when launching `docker-compose up -d` docker will find it and apply the changes over the base config.


## Install

Clone this repository:

```bash
git clone https://github.com/opf/openproject-deploy --depth=1 --branch=stable/12 openproject
```

Go to the compose folder: 

```bash
cd openproject/compose
```

Make sure you are using the latest version of the Docker images:

```bash
docker-compose pull
```

Launch the containers:

```bash
docker-compose up -d
```

After a while, OpenProject should be up and running on <http://localhost:8080>.

**HTTPS/SSL**

By default OpenProject starts with the HTTPS option **enabled**, but it **does not** handle SSL termination itself.
This is usually done separately via a [reverse proxy setup](https://www.openproject.org/docs/installation-and-operations/installation/docker/#apache-reverse-proxy-setup).
Without this you will run into an `ERR_SSL_PROTOCOL_ERROR` when accessing OpenProject.

See below how to disable HTTPS.

**PORT**

By default the port is bound to `0.0.0.0` means access to OpenProject will be public.
See below how to change that.

## Configuration

Environment variables can be added to `docker-compose.yml` under `x-op-app -> environment` to change
OpenProject's configuration. Some are already defined and can be changed via the environment.

You can pass those variables directly when starting the stack as follows.

```bash
VARIABLE=value docker-compose up -d
```

You can also put those variables into an `.env` file in your current working
directory, and Docker Compose will pick it up automatically. See `.env.example`
for details.

## HTTPS

You can disable OpenProject's HTTPS option via:

```bash
OPENPROJECT_HTTPS=false
```

## PORT

If you want to specify a different port, you can do so with:

```bash
PORT=4000
```

If you don't want OpenProject to bind to `0.0.0.0` you can bind it to localhost only like this:

```bash
PORT=127.0.0.1:8080
```

## TAG

If you want to specify a custom tag for the OpenProject docker image, you can do so with:

```bash
TAG=my-docker-tag
```

## Upgrade

Go to the compose folder:

```bash
cd openproject/compose
```

Retrieve any changes from the `openproject-deploy` repository:

```bash
git pull origin stable/12
```

Make sure you are using the latest version of the Docker images:

```bash
docker-compose pull
```

Relaunch the containers:

```bash
docker-compose up -d
```

## Uninstall

You can remove the stack with:

```bash
docker-compose down
```

## Troubleshooting

You can look at the logs with:

```bash
docker-compose logs -n 1000
```

For the complete documentation, please refer to https://docs.openproject.org/installation-and-operations/.

### Network issues

If you're running into weird network issues and timeouts such as the one described in [OP#42802](https://community.openproject.org/work_packages/42802), you might have success in remove the two separate frontend and backend networks. This might be connected to using podman for orchestration, although we haven't been able to confirm this.


### SMTP setup fails: Network is unreachable.

Make sure your container has DNS resolution to access external SMTP server when set up as described in [OP#44515](https://community.openproject.org/work_packages/44515).

```yml
worker:
   dns:    
     - "Your DNS IP" # OR add a public DNS resolver like 8.8.8.8
 ```
