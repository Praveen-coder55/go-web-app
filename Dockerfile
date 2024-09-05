FROM golang:1.22.5-alpine AS Build

WORKDIR /app

COPY go.mod .

RUN go mod download

COPY . .

RUN go build -o main .

FROM gcr.io/distroless/base

COPY --from=Build /app/main .

COPY --from=Build /app/static /static

EXPOSE 8080

CMD [ "./main" ]