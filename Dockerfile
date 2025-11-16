
FROM golang:1.21-alpine AS builder

WORKDIR /app

COPY backend/go.mod backend/go.sum ./

RUN go mod download

COPY backend/ .

RUN CGO_ENABLED=0 GOOS=linux go build -o server main.go

FROM alpine:3.18

WORKDIR /app

COPY --from=builder /app/server .

EXPOSE 8080

CMD ["./server"]
