.DEFAULT_GOAL := help

.PHONY: help
help:  ## Show this help.
	@grep -E '^\S+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "%-30s %s\n", $$1, $$2}'

.PHONY: add-package
add-package:
	docker compose run --rm --no-deps lift uv add $(package)
	make build

.PHONY: build
build: ## Build the chatcommands Docker image
	docker compose build

.PHONY: test
test: ## Run tests
	docker compose run --rm lift uv run pytest ./test -ra

.PHONY: test-coverage
test-coverage:
	docker compose run --rm lift uv run coverage run --branch -m pytest test
	docker compose run --rm lift uv run coverage html
	@open "${PWD}/htmlcov/index.html"