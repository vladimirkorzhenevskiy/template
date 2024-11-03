
.PHONY: docker-build
docker-build:
	docker build -t scheduler-api:dev -f ./build/dev/Dockerfile .

.PHONY: generate
generate:
	go run github.com/ogen-go/ogen/cmd/ogen@latest --target api --clean openapi.yaml

.PHONY: migration
migration:
	GOOSE_DRIVER=postgres
	GOOSE_DBSTRING=postgresql://postgres:postgres@localhost:5432/postgres?sslmode=disable
	goose -dir migrations create ${table} ${format}

.PHONY: migrate-up
migrate-up:
	goose -dir migrations up

.PHONY: migrate-down
migrate-down:
	goose -dir migrations down
