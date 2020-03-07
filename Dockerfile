# Primeira etapa
# Usa a imagem do golang para buildar o programa
FROM golang:1.13.8-alpine3.11 as builder

COPY ./src/ /go/src
WORKDIR /go/src/
# -ldflags "-w" remove informações de debug do executável
RUN go build -ldflags "-w" main.go

# Segunda etapa
# Cria uma imagem mínima copiando o executável gerado na primeira etapa
FROM scratch

COPY --from=builder /go/src/main /go/src/main
ENTRYPOINT [ "/go/src/main" ]
