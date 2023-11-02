# Build stage
FROM golang:1.21-alpine3.18 AS builder
# To declare the current working directory inside the image.
WORKDIR /app 
# The first dot means that copy everything from current folder.
# The second dot is the current working directory inside the image.
COPY . .
# Build app to a single binary executable file.
# -o stands for output. then the name of the output binary file
# and pass in the main entrypoint file of our application main.go
RUN go build -o main main.go
RUN apk add curl
RUN curl -L https://github.com/golang-migrate/migrate/releases/download/v4.12.2/migrate.linux-amd64.tar.gz | tar xvz
    
FROM alpine:3.18
WORKDIR /app
COPY --from=builder /app/main .
COPY --from=builder /app/migrate.linux-amd64 ./migrate
COPY app.env .
COPY start.sh .
COPY wait-for.sh .
RUN chmod +x wait-for.sh
RUN chmod +x start.sh
COPY db/migration  ./migration


EXPOSE 8080
# Instruction is used together with ENTRYPOINT It will act as just the addtional parameters
# That will be passed into the entry point script.
# ["/app/start.sh", "/app/main"]
CMD ["/app/main"]
ENTRYPOINT [ "/app/start.sh" ]