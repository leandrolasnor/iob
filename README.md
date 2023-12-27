# Desafio para Fullstack - IOB

Este documento descreve o passo a passo para rodar a aplicação referente ao desafio da vaga de Fullstack da IOB

[Enunciado do problema](https://drive.google.com/file/d/1ibXBWxRVvqlIs1NQSrmO7kUnfrSopz2z/view?usp=drive_link)


## Considerações sobre o ambiente

```
# docker-compose.yml
version: '2.22'
services:
  frontend:
    image: leandrolasnor/ruby:iob
    container_name: iob.react
    stdin_open: true
    tty: true
    command: sh
    ports:
      - 3001:3001
    depends_on:
      - backend

  backend:
    image: leandrolasnor/ruby:iob
    container_name: iob.rails
    stdin_open: true
    tty: true
    command: sh
    ports:
      - 3000:3000
```

* Uma image docker foi publicada no [Docker Hub](https://hub.docker.com/layers/leandrolasnor/ruby/iob/images/sha256-d4c7c030705579ac269b442b4eac0972fca77c0d10c5b7abc2f5b6176a37a764?context=repo)

## Considerações sobre a aplicação
#### Conceitos e ferramentas utilizadas na resolução do problema
* Princípio de Inversão de Dependência
* Princípio da Segregação da Interface
* Princípio da responsabilidade única
* Princípio da substituição de Liskov
* Princípio Aberto-Fechado
* Domain Driven Design
* Código Limpo
* Rubocop
* Bullet
* Dry-rb
* RSpec
* RSwag
* SSE

```
all: prepare run

prepare:
	docker compose up backend -d
	docker compose exec backend bundle exec rake db:migrate:reset
	docker compose exec backend bundle exec rake db:seed

run:
	docker compose exec backend foreman start
```
## Passo a Passo de como executar a solução

* Faça o clone deste repositório ou copie os arquivos `makefile` e `docker-compose.yaml` para uma pasta local

* Use o comando `make prepare` para baixar a imagem e subir o container _backend_

* _Nessa etapa as `migrations` foram executadas e o banco de dados se encontra populado com alguns dados_

_presumo que nesse momento seu ambiente esteja devidamente configurado e o banco de dados criado e populado_

* Use o comando `make run` para rodar o frontend e o backend.

## Documentação

* Acesse o [`Swagger`](http://localhost:3000/api-docs)
* Verifique o campo `defaultHost` na interface do [`Swagger`](http://localhost:3000/api-docs) e avalie se a url esta correta (_127.0.0.1:3000_ ou _localhost:3000_)

* Nessa interface você poderá validar a documentação dos endpoints e testá-los, enviando algumas requisições http
* É necessário estar logado para interagir com a api - utilize o endpoint **POST** `/auth` (_create user_) para criar um usuário. Informe email, password e confirme o password
* No `response` copie o `header` **authorization** - seu valor será como este: *Bearer eyJhY2Nlc3MtdG9rZW4iOiJyNzV4Wi1KM1psbnQ0R2FVSGFzTUxnIiwidG9rZW4tdHlwZSI6IkJlYXJlciIsImNsaWVudCI6IlhxMEpHSWs5ZkV5RzhURXZhNWxpUXciLCJleHBpcnkiOiIxNjk3NDQyODUwIiwidWlkIjoic3RyaW5nQHRlc3QuY29tIn0=*
* Copie o `token` e clique no botão **Authorize** no canto superior direito da interface do [`Swagger`](http://localhost:3000/api-docs)
* Cole e conteúdo, clique em **Authorize** e depois em **Close**
* Agora será possível integarir com a api pela interface do [`Swagger`](http://localhost:3000/api-docs)
