# Orulo Test - Implementação
## Configuração

Clone o projeto

```sh
$ git clone https://github.com/pedrohcrisanto/orulo.git
```

Instale as dependências
```sh
$ cd /orulo/
$ sudo docker-compose run --rm app bundle install
```

Crie o banco, migre as tabelas
```sh
$ sudo docker-compose run --rm app bundle exec rails db:create db:migrate 
```

Rode a aplicação em um terminal
```sh
$ sudo docker-compose up
```

Para rodar os Testes
```sh
$ sudo docker-compose run --rm app bundle exec rspec
```
