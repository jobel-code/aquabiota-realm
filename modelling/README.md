# Using the rocker/rstudio container

## Quickstart

    docker run -d -p 8787:8787 aquabiota/realm-modelling

Visit `localhost:8787` in your browser and log in with username:password as `rstudio:rstudio`.

## Notes:
- Based on the  `rocker/rstudio` stack,
  see: <https://github.com/rocker-org/rocker/wiki>.

## Common configuration options:

Note: all commands documented here work in just the same way with any container derived from `aquabiota/realm-rstudio`,
such as `aquabiota/realm-modelling`.  


#### Use a custom password by specifying the `PASSWORD` environmental variable


    docker run -d -p 8787:8787 -e PASSWORD=yourpasswordhere aquabiota/realm-modelling


#### Give the user root permissions (add to sudoers)

    docker run -d -p 8787:8787 -e ROOT=TRUE aquabiota/realm-modelling

Link a local volume (in this example, the current working directory, `$(pwd)`) to the rstudio container:

    docker run -d -p 8787:8787 -v $(pwd):/home/rstudio aquabiota/realm-modelling


#### Add shiny server on start up with `e ADD=shiny`

    docker run -d -p 3838:3838 -p 8787:8787 -e ADD=shiny aquabiota/realm-modelling

shiny server is now running on `localhost:3838` and RStudio on `localhost:8787`.  


Note: this triggers shiny install at runtime, which may require a few minutes to execute before services come up.
If you are building your own Dockerfiles on top of this stack, you should simply include the RUN command:

    RUN export ADD=shiny && bash /etc/cont-init.d/add

Then omit the `-e ADD=shiny` when running your image and shiny should be installed and waiting on port 3838.


#### Access a root shell for a running `rstudio` container instance

First, determine the name or id of your container (unless you provided a `--name` to `docker run`) using `docker ps`.  You need just enough of the hash id to be unique, e.g. the first 3 letters/numbers.  Then exec into the container for an interactive session:

    docker exec -ti <CONTAINER_ID> bash

You can now perform maintenance operations requiring root behavior such as `apt-get`, adding/removing users, etc.  


## Additional configuration options

- Custom user name: `-e USER=<CUSTOM_NAME>`
- Custom user id, group id, UMASK: `-e USERID=<UID>`, `-e GROUPID=<GID>`, `e UMASK=022`


Custom uid/gid etc is usually only needed when sharing a local volume for a user/group whose id does not match the default (`1000`:`1000`).  Failing to do this could make files change permissions on the linked volume when accessed from RStudio.


Adding additional users:  From a root bash shell (see above), the usual debian linux commands can be used to create new users and passwords, e.g.


## Developers / Dockerfile authors

The RStudio images use the `s6-init` system to run multiple/persistant jobs.  While init systems like supervisord are better known, `s6` is powerful, lightweight, easy to use, and plays nicely with docker (e.g. avoiding the pid 1 / zombie problem).  See [s6-overlay](https://github.com/just-containers/s6-overlay) for details if you need to add additional services (such as an sshd server) or custom start-up, shut down, or logging scripts.  
