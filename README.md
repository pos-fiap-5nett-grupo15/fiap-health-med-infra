


## Como Rodar o Banco de Dados

[readme database](./sql-server/README.md)

## Como rodar o banco de dados usando compose


A primeira coisa a ser feita é realizar o build da imagem localmente, para evitar usar um repositório.

```shell
    cd ./sql-server
    docker build -t mssql-hack .
```

Em seguida basta apenas rodar o comando:

```shell
    docker compose up -d
```

Para encerrar basta rodar o comando

```shell
    docker compose down -v
```


## Rodar o Rabbit MQ

Para rodar o rabbit mq, basta usar os mesmos comandos de compose do banco, com exceção do build.


## Repositório do Wait For It

https://github.com/vishnubob/wait-for-it