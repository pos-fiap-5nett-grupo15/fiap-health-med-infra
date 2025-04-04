Criação e configuração de uma banco de dados SQL Sever local para uso pessoal.


[Imagem base](https://hub.docker.com/r/microsoft/mssql-server)
[Configuração de Entrypoint](https://github.com/microsoft/mssql-docker/tree/master/linux/preview/examples/mssql-customize)

MSSQL_PID=Developer
ACCEPT_EULA=Y


## Passo a Passo para Criar o Banco usando Docker Compose

1. Como rodar o banco localmente usando docker

No folder do Dockerfile
```shell
docker build -t mssql-hack .
docker run -e 'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD=Q1w2e3r4' -e 'SVC_PASS=Q1w2e3r4' -p 1433:1433 --name sql1 -d mssql-hack
```

Para matar o container:
```shell
docker container kill sql1

docker container rm sql1
```

Para visualizar os logs do container:

```shell
docker logs sql1
```