FROM golang AS builder

WORKDIR /go/src/github.com/mikloslorinczi/bit_test/
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o bit_test .

FROM alpine:latest

RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /go/src/github.com/mikloslorinczi/bit_test/bit_test .

CMD ["./bit_test"]