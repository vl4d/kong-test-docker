# KongTestDocker
See [Mashape/Kong tests](https://github.com/Mashape/kong/blob/master/README.md#tests)

Docker Image for KongTestDocker [here](https://hub.docker.com/r/vl4d/test_kong)

This docker image was created in order to install dependencies needed to run kong tests.
We would copy our custom plugins over and then run tests.

### Running tests (in theory - tested with out own requirements)
Steps taken
- Clone kong's repo eg: ```$ git clone https://github.com/Mashape/kong.git --branch <tag> --single-branch ```
- Goto the <kong-repo> and run: ```$ luarocks make && make dev ```
- Then mount or copy your tests and run them using ```$ <kong-repo>/bin/busted <path-to>/<tests-to-run> ```
 
