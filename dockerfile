FROM node as front
COPY /client/package.json .
COPY /client/package-lock.json .
RUN npm i 
COPY /client .
RUN npm build

FROM golang:bullseye as back
WORKDIR /app
COPY . .
RUN go build go-server/main.go


FROM alpine:latest

RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/* && \
  mkdir -p /src/web/build

COPY --from=front /build /src/front/build
COPY --from=back /go-server/main /src

WORKDIR /src

EXPOSE 3000
EXPOSE 8080

CMD [ "./main" ]