.PHONY: help format lint typecheck check test install pre-commit-install pre-commit-run clean run scheduler \
		docker-build docker-up docker-down docker-test docker-scheduler docker-shell docker-logs

help:
	@echo "Доступные команды:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

install:
	poetry install

run:
	poetry run python run.py

scheduler:
	poetry run python run.py --scheduler

test:
	poetry run pytest

test-verbose:
	poetry run pytest -vv

test-coverage:
	poetry run pytest --cov=src --cov-report=term-missing --cov-report=html

format:
	poetry run ruff format .
	poetry run ruff check --fix .

lint:
	poetry run ruff check .

typecheck:
	poetry run mypy .

check: lint typecheck

pre-commit-install:
	poetry run pre-commit install

pre-commit-run:
	poetry run pre-commit run --all-files

clean:
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name ".pytest_cache" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name ".mypy_cache" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name ".ruff_cache" -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.pyc" -delete 2>/dev/null || true

docker-build:
	docker-compose build

docker-up:
	docker-compose up -d

docker-down:
	docker-compose down

docker-restart:
	docker-compose restart

docker-test:
	docker exec salesbrush-app poetry run pytest -v

docker-test-coverage:
	docker exec salesbrush-app poetry run pytest --cov=src --cov-report=term-missing --cov-report=html

docker-scheduler:
	docker exec -it salesbrush-app poetry run python run.py --scheduler

docker-run:
	docker exec salesbrush-app poetry run python run.py

docker-shell:
	docker exec -it salesbrush-app /bin/bash

docker-logs:
	docker logs -f salesbrush-app

docker-clean:
	docker-compose down -v

docker-db-shell:
	docker exec -it salesbrush-postgres psql -U postgres -d salesbrush_test
