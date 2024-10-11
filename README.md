# Motivation

At [easybill](https://easybill.de), we maintain this public Tech Radar to help our engineering teams align on technology
choices. It is based on the pioneering work by [ThoughtWorks](https://www.thoughtworks.com/radar)
and [Zalando](https://zalando.github.io/tech-radar).

## Local Development

1. Install dependencies: `yarn install`
2. Start local development server: `yarn start`
3. Your default browser should automatically open the url `http://localhost:3000`
4. Local changes to the page should automatically reflect on the opened web page

## Docker Build

The Docker image can be build and run locally:

1. Build the container: `docker build -t easybill-tech-radar:latest .`
2. Run the container, exposing the Tech Radar on port 8080: `docker run -p 8080:8080 easybill-tech-radar:latest`

The steps for publishing the docker image to Dockerhub are automated using a GitHub action which must be triggered
manually. Note that the docker image also exposes metrics about the nginx process on port 9113, and a health endpoint
at `/health` which just returns a `200 - OK` response without a body when called.

## Structure

1. Data is provided by 4 configurations (`docs/config_{1-4}.js`) which are not following any special separation.
2. Variables, such as the rings indexes, are provided by `docs/vars.js`. These variables must be used over hardcoded
   indexes where applicable.
3. The visualization is done by the `docs/radar.js` script, called from `index.html`
4. The radar version is taken from the package.json during the docker build process
