.PHONY: build run test fmt lint tidy

build:
	go build -o bin/api ./cmd/api

run:
	go run ./cmd/api

test:
	go test ./...

fmt:
	gofmt -l -w .

lint:
	golangci-lint run

tidy:
	go mod tidy
