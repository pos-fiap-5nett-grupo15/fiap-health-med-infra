
# Hackaton - Fiap.Health.Med.Infra

Projeto criado pelo **Grupo 15** do curso de **Arquitetura de Sistemas .NET com Azure** da Fiap para atender o Hackaton.

> O projeto de infra tem como função manter todas as configurações dos recursos do ambiente, visando facilitar a criação da infraestrutura com todos os recursos necessários e preparados para o funcionamento das aplicações


## Autores

- Grupo 15

|Integrantes
|--|
| Caio Vinícius Moura Santos Maia |
| Evandro Prates Silva |
| Guilherme Castro Batista Pereira |
| Luis Gustavo Gonçalves Reimberg |


## Stack utilizada

|Tecnologia utilizada|
|--|
|RabbitMQ|
|SQL Server|
|Terraform|
|Docker|


## Funcionalidades

- Configurações de fila
- Configurações do banco de dados
- Configurações de infraestrutura como código(IaC)


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

## Local
Para rodar o rabbit mq, basta usar os mesmos comandos de compose do banco, com exceção do build.


## Repositório do Wait For It

https://github.com/vishnubob/wait-for-it



## Como Subir o Sql Server no Minikube

### Criação das Secrets

Uma vez com o minikube configurado como cluster padrão, siga os passo desta seção.

Para verificar qual o cluster configurado, execute o seguinte comnando:

```shell
kubectl config get-contexts
```

Verifique se a secret do docker registry já foi criada. Para fazer isto basta usar o seguinte comando:

```shell
kubectl get secrets -n hk
```

Caso a secret de acesso ao docker registry não tenha sido criada, basta utilizar o seguite comando, substituindo a chave de acesso.

```shell
kubectl create secret docker-registry acr-secret \
  --docker-server=fiapacrhackathon.azurecr.io \
  --docker-username=minikubetoken \
  --docker-password=35f9dK12/AkF4tatneYQTLEU4sFDiXcac/xfy4x8U/+ACRDYVWyJ \
  --namespace=hk
```

Para cirar o token de acesso na Azure basta ir até ao ACR, repository permissions, tokens, para criar um.

Para criar a secret de acesso ao banco basta utilizar o seguinte comando:
```shell
     kubectl apply -f ./sql-server/k8s-minikube/secrets.yaml
```


Para criar a configmap de configuração do banco, basta rodar o comando:

```shell
     kubectl apply -f ./sql-server/k8s-minikube/configmap.yaml
```

O próximo passo é criar o volume para o banco de dados. Para isto basta executar o seguinte comnado:

```shell
    kubectl apply -f ./sql-server/k8s-minikube/volume.yaml
```


agora basta aplicar o deployment do sql server usando o seguinte comando:

```shell
    kubectl apply -f ./sql-server/k8s-minikube/k8s.yaml
```

para acessar o banco, basta pegar o ip do cluster e colocar a porta configurada no serviço do tipo nodePort.

```shell
minikube ip
```

Casos esteja usando o WSL pode usar o seguinte comnado para pegar o endereço Windows do pod, como pode ser visto na documentação do minikube. https://minikube.sigs.k8s.io/docs/handbook/accessing/

```shell
minikube service sql-server-service -n hk --url
```
