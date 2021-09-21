FROM golang:bullseye

WORKDIR /app

COPY . .


EXPOSE 8080

RUN go build main.go

CMD [ "./main" ]