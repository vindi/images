![Vindi - Recorrênica](https://blog.vindi.com.br/wp-content/uploads/2018/08/logo-vindi.png)

# Vindi 


### Descrição
Imagens utilizadas para desenvolvimento e criação de testes funcionais e unitários 


### É necessário criar uma rede com o nome webproxy se já não foi criada

```
docker network create webproxy
```


### Instalar VNC viewer para debug

```
wget https://www.realvnc.com/download/file/viewer.files/VNC-Viewer-6.18.907-Linux-x64.deb
sudo dpkg -i VNC-Viewer-6.18.907-Linux-x64.deb
```


### É necessario substituir a chave API no arquivo **.env**

```
API_KEY=digite aqui sua chave API
```


### Instalar o modgit

```
curl https://raw.githubusercontent.com/jreinke/modgit/master/modgit > modgit
chmod +x modgit
sudo mv modgit /usr/local/bin
```


### docker-compose.yml:

```
version: '3.3'
services:
  selenium:
    image: selenium/standalone-chrome-debug
    container_name: selenium
    ports:
    - "4444:4444"
    - "5900:5900"
    volumes:
    - /dev/shm:/dev/shm
  mariadb:
    image: vindi/mysql-magento1-ci
    container_name: magento1_db
    ports:
    - "3306"
  web:
    image: vindi/apache-magento1-dev
    container_name: vindi.local
    env_file:
      - .env
    depends_on:
    - mariadb
    ports:
    - "443:443"
    links:
    - mariadb:mysql
    volumes:
    - ./html:/var/www/html
    - ./html/app/code/community/Vindi/Subscription/tests:/var/www/html/app/code/community/Vindi/Subscription/tests
    working_dir: /var/www/html/app/code/community/Vindi/Subscription/tests
networks:
  default:
    external:
      name: webproxy
```

### Executar o docker compose na pasta onde esta o docker-compose.yml

```
docker-compose up -d
```

### Instalar o magento na pasta html criada
```
cd html
tar -xzvf magento.tar.gz
rm magento.tar.gz

```


### Instalar o Vindi magento na pasta raiz do magento que será html

```
modgit init
modgit -b homolog add vindi https://github.com/vindi/vindi-magento.git
```


### Inspecionar o container do apache para saber qual é o IP

```
docker inspect vindi.local
```

### Com o IP do container agora é possível executar o VNC viewer colocando o IP e depois a senha "secret"


## Créditos
- [Vindi](https://github.com/vindi)
- [Todos os Contribuidores](https://github.com/vindi/vindi-magento/contributors)

## Licença
GNU GPLv3. Por favor, veja o [Arquivo de Licença](LICENSE) para mais informações.
