# Stage 1: Build
FROM golang:1.24 AS build
WORKDIR /src

# Copy Go module files first (for caching)
COPY go.mod go.sum ./
RUN go mod tidy

COPY . .
RUN go build -o processor

# Stage 2 : Runtime
FROM gcr.io/distroless/base-debian12
WORKDIR /app

COPY --from=build /src/processor .
EXPOSE 9090

ENTRYPOINT [ "/app/processor" ]