FROM golang:alpine as builder
RUN mkdir /build
ADD . /build/
WORKDIR /build
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o go-srv .
FROM scratch
COPY --from=builder /build/go-srv /app/
WORKDIR /app
EXPOSE 8080
CMD ["./go-srv"]

