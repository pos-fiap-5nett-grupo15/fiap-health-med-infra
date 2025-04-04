


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