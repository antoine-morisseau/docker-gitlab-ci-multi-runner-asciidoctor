# Docker image with gitlab-ci-multi-runner to run builds with Asciidoctor and pandoc and wkhtmltopdf

Docker image with gitlab-ci-multi-runner, which can run asciidoctor, pandoc and wkhtmltopdf.

## How to use

Example of [Docker Compose](https://docs.docker.com/compose/) file (`docker-compose.yml`)

```
vrunner:
  image: busybox
    volumes:
        - /home/gitlab-runner/data
runner:
    image: amorisseau/gitlab-ci-multi-runner-asciidoctor:latest
    volumes_from:
        - vrunner
    environment:
        - CI_SERVER_URL=https://gitlabci.example.com/ci
        - REGISTRATION_TOKEN=YOUR_TOKEN_FROM_GITLABCI
    restart: always
```

Replace `CI_SERVER_URL` and `REGISTRATION_TOKEN`.

Run it

```
docker-compose up -d
```

Or using docker command line

```
docker run -d --env "CI_SERVER_URL=https://gitlabci.example.com/ci" \
              --env "REGISTRATION_TOKEN=YOUR_TOKEN_FROM_GITLABCI" \
              --restart="always" \
              --name=ruby_runner \
              amorisseau/gitlab-ci-multi-runner-asciidoctor:latest
```

## More information

* Read about [gitlab-runner](https://docs.gitlab.com/runner/) to learn how integration works with GitLab CI.
* all the command about `gitlab-runner register` are available [here](gitlab-runner-register-commands.md)
