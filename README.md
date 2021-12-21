# autoui-project-generator

Generate a UI based on a OData OpenAPI JSON file

## Configuration

After cloning the repo: 

    $ cd autoui-project-generator

## Generate project

ARGUMENTS:
```
title: Project Title
openapi: openApi JSON file path
logo: Project logo path
apihost: Api host
```

RUN: 

    $ bash start.sh --title="AutoUI Demo" --openapi=<PATH_TO_LOCAL_FOLDER>/open-api.json --logo=<PATH_TO_LOCAL_FOLDER>/logo.svg --apihost=https://api.balena-staging.com/v6/

### NOTES:

1) The Logo must be in svg format and must have the following name `logo.svg`
2) Both files (logo, open-api.json) must be reachable from the machine that launches the command, the script will not make any http requests to get these files.

### ATTENTION:

**Once the folder has been created we strongly recommend that you move it out of the project in order to prevent it from being deleted by any future command.**



