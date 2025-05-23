# Copiar Imagem do Docker Hub para o ACR



Para subir a imagem local `rabbitmq:3-management` para o seu Azure Container Registry (ACR) chamado `fiapacrhackathon.azurecr.io`, você pode seguir os passos abaixo:

### Passo 1: Fazer Login no ACR

Primeiro, faça login no seu Azure Container Registry usando a Azure CLI:

```bash
az acr login --name fiapacrhackathon
```

### Passo 2: Marcar a Imagem Local

Depois de fazer login, você precisa marcar a imagem local `rabbitmq:3-management` com o nome do seu ACR. Use o seguinte comando:

```bash
docker tag rabbitmq:3-management fiapacrhackathon.azurecr.io/rabbitmq:3-management
```

### Passo 3: Fazer o Push da Imagem para o ACR

Agora que a imagem está marcada corretamente, você pode fazer o push da imagem para o ACR:

```bash
docker push fiapacrhackathon.azurecr.io/rabbitmq:3-management
```

### Passo 4: Verificar a Imagem no ACR

Após o push, você pode verificar se a imagem foi enviada corretamente para o ACR. Use os seguintes comandos:

1. Para listar os repositórios no ACR:

   ```bash
   az acr repository list --name fiapacrhackathon --output table
   ```

2. Para ver as tags da imagem específica:

   ```bash
   az acr repository show-tags --name fiapacrhackathon --repository rabbitmq --output table
   ```

### Resumo dos Comandos

1. **Login no ACR**:
   ```bash
   az acr login --name fiapacrhackathon
   ```

2. **Marcar a Imagem**:
   ```bash
   docker tag rabbitmq:3-management fiapacrhackathon.azurecr.io/rabbitmq:3-management
   ```

3. **Fazer o Push da Imagem**:
   ```bash
   docker push fiapacrhackathon.azurecr.io/rabbitmq:3-management
   ```

4. **Verificar a Imagem no ACR**:
   ```bash
   az acr repository list --name fiapacrhackathon --output table
   az acr repository show-tags --name fiapacrhackathon --repository rabbitmq --output table
   ```

### Observações

- Certifique-se de que a Azure CLI e o Docker estão instalados e configurados corretamente em sua máquina.
- Se você encontrar algum erro durante o processo, verifique se você tem as permissões necessárias para fazer push para o ACR.

Se você tiver mais perguntas ou precisar de mais assistência, sinta-se à vontade para perguntar!



## Acessar Rabbit MQ Management

Para acessar a página de gerenciamento, basta fazer um port foward para o pod do rabbit mq. Isto pode ser feito com o seguinte comando:

```shell
   kubectl port-forward service/rabbitmq-service-management 15672:80 -n hk
```