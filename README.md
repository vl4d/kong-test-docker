# KongTestDocker

This docker image was created in order to install dependencies needed to run kong tests.
We would copy our custom plugins over and then run tests.

### Running tests (in theory - tested with out own requirements)
Steps taken
- Clone kong's repo eg: ```$ git clone https://github.com/Mashape/kong.git --branch <tag> --single-branch ```
- Goto the <kong-repo> and run: ```$ luarocks make && make dev ```
- Then mount or copy your tests and run them using ```$ <kong-repo>/bin/busted <path-to>/<tests-to-run> ```
 
