projectbuilder
==============

Installation
------------

Check out this project somewhere:

```
git clone https://github.com/brimstone/projectbuilder.git ~/projectbuilder
```

Export the path as PROJECTBUILDER:

```
user@host:project$ export PROJECTBUILDER=$HOME/projectbuilder
```

If this is the first use in a project, call:

```
user@host:project$ ${PROJECTBUILDER}/make
```

This sets up a super simple `Makefile`. This can also be setup manually:

```
include ${PROJECTBUILDER}/Makefile
```


Usage
-----

Once installed, simply type `make` when used locally. This runs through the `precheck`, `check`, `binary`, and `test` steps.

Lifecycle
---------

Available top level targets:

### setup

This sets up the local system to build and package your project. Overriding this is possible with the `CHECK` variable, but is not recommended.

### precheck

This is for projectbuilder to do any top level checks. Mainly for setting up the local `Makefile`. Overriding this is possible with the `PRECHECK` variable, but is not recommended. If required, at least append to `PRECHECK`.

### check

This is for checking source code before the build. This performs any language specific formatting, vetting, linting, unit testing or otherwise. 

### binary

This is for the actual complication step to result in a binary file. Overriding this is possible with the `BINARY` variable.

If `BINARY` is set to a target, that target is called.

If `BINARY` is set to anything else, it's assumed it's a file on disk. The default value is `app`

Supported languages:

- Go

### package

This is for packaging the binary. Overriding this is possible with the `PACKAGE` variable.

Supported packaging formats:

- Docker container image

### test

This is for testing the packaged binary. Overriding this is possible with the `TEST` variable.

Supported test runners:

- Prove

### publish

This is for publishing the packaged binary. Overriding this is possible with the `PUBLISH` variable.

Supported endpoints:

- Docker registries


Supported languages and package formats
---------------------------------------

### Go

No extra variables.

### Docker

`DOCKER_TAG`

### Prove

No extra variables.
