FROM golang:1.14-alpine as builder

WORKDIR /go/src/github.com/sjentzsch/default-backend
COPY main.go .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags '-w -s' -o main github.com/sjentzsch/default-backend

FROM scratch

COPY --from=builder /go/src/github.com/sjentzsch/default-backend/main /
COPY assets/404.html /assets/

CMD ["/main"]
