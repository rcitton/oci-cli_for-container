# -------------------------------------------------------------------------------
# Author: Ruggero Citton
# Date: September 18 , 2023
# Purpose: Oracle Cloud Infrastructure CLI
#
#
# Licensed under The MIT License (MIT).
# See included LICENSE file or the notice below.
#
# Copyright (c) 2023 Ruggero Citton
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# ----------------------------------------------------------------------------

##########################
## Environment Variable ##
include ./env.mk
###########################

IDU        := $(shell id -u)
IDG        := $(shell id -g)
USER       := $(shell id -un)
BUILD_DATE := $(shell date +"%Y-%m-%d_%H-%M-%S")


###########################
## Colors definition     ##
###########################
COLOUR_GREEN=\033[0;32m
COLOUR_RED=\033[0;31m
COLOUR_YELLOW=\033[0;33m
COLOUR_BLUE=\033[0;34m
COLOUR_END=\033[0m

###########################
## Help Setup            ##
###########################
.DEFAULT_GOAL := help
.PHONY: help
help:
	@echo "$(COLOUR_GREEN)-------------------------$(COLOUR_END)"
	@echo "$(COLOUR_GREEN)Make Commands for oci-cli$(COLOUR_END)"
	@echo "$(COLOUR_GREEN)-------------------------$(COLOUR_END)"
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sed -n 's/^\(.*\): \(.*\)##\(.*\)/\1\3/p' \
	| column -t  -s ' '

###############################################################################
#                                Main SECTION                                 #
###############################################################################
# ----------------------------------------------------------------


oci: ## 🏗️ Setup oci-cli
	@echo "Create oci-cli container..."
    ifeq ($(RUNTIMECT), /usr/bin/docker)
		-$(RUNTIMECT) rmi oci:latest
    else
		-$(RUNTIMECT) rmi localhost/oci:latest
    endif
	$(RUNTIMECT) build --force-rm=true  \
	--build-arg USER_NAME=$(USER) \
	--build-arg USER_ID=$(IDU) \
	--build-arg GROUP_ID=$(IDG) \
	--build-arg BUILD_DATE=$(BUILD_DATE) \
	--build-arg VERSION=$(VERSION) \
	--build-arg REVISION=$(REVISION) \
	--no-cache=true -t oci -f oci-cli_dockerfile . 

oci-proxy: ## 🌐 Setup oci-cli-by-proxy
	@echo "Create oci-cli container..."
    ifeq ($(RUNTIMECT), /usr/bin/docker)
		-$(RUNTIMECT) rmi oci:latest
    else
		-$(RUNTIMECT) rmi localhost/oci:latest
    endif
	$(RUNTIMECT) build --force-rm=true  \
	--build-arg HTTP_PROXY=$(HTTP_PROXY) \
	--build-arg USER_NAME=$(USER) \
	--build-arg USER_ID=$(IDU) \
	--build-arg GROUP_ID=$(IDG) \
	--build-arg BUILD_DATE=$(BUILD_DATE) \
	--build-arg VERSION=$(VERSION) \
	--build-arg REVISION=$(REVISION) \
	--no-cache=true -t oci -f oci-cli_dockerfile . 

oci-cleanup: ## 🧹 Cleanup oci-cli
	@echo "Cleanup oci-cli container image..."
    ifeq ($(RUNTIMECT), /usr/bin/docker)
		-$(RUNTIMECT) rmi oci:latest
    else
		-$(RUNTIMECT) rmi localhost/oci:latest
    endif


# --------------
# EndOfFile
# --------------
