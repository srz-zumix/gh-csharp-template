GH_EXTENSION_NAME=GhCSharpExtension
EXTENSION_NAME=$(shell echo ${GH_EXTENSION_NAME} | sed 's/^gh-//')
DOTNET_VERSION=netDotNetVersion

help: ## Display this help screen
	@grep -E '^[a-zA-Z][a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sed -e 's/^GNUmakefile://' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

install: ## install gh extention for development
	gh extension remove "${EXTENSION_NAME}" || :
	gh extension install .

install-released: ## install gh extention for released
	gh extension remove "${EXTENSION_NAME}" || :
	gh extension install "GitHubOrganizationName/${GH_EXTENSION_NAME}"

build: ${GH_EXTENSION_NAME} ## build extension

clean:
	dotnet clean
	rm -rf dist temp

${GH_EXTENSION_NAME}: ${GH_EXTENSION_NAME}.Command/bin/Debug/${DOTNET_VERSION}/${GH_EXTENSION_NAME}

SRCS=$(wildcard ${GH_EXTENSION_NAME}.Command/*.cs)

${GH_EXTENSION_NAME}.Command/bin/Debug/${DOTNET_VERSION}/${GH_EXTENSION_NAME}: $(SRCS)
	dotnet build -c Debug
