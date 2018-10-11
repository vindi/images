![Vindi - Recorrênica](https://blog.vindi.com.br/wp-content/uploads/2018/08/logo-vindi.png)

# Vindi 


### Descrição
Imagens utilizadas para testes funcionais e unitários no ambiente de Integração Contínua no **Semaphore CI**


### É necessário criar uma rede com o nome webproxy

```
docker network create webproxy
```

### Instalar VNC viewer para debug

```
wget https://www.realvnc.com/download/file/viewer.files/VNC-Viewer-6.18.907-Linux-x64.deb
sudo dpkg -i VNC-Viewer-6.18.907-Linux-x64.deb
```


### docker-compose.yml:

```
version: '3.3'
services:
    chrome:
        image: selenium/standalone-chrome-debug
        container_name: chrome
        ports:
        - "5900:5900"
    db:
        image: vindi/mysql- <plugin-vindi> -ci
        container_name: db
        ports:
        - "3306"
    web:
        image: vindi/apache- <plugin-vindi> -ci
        container_name: vindi.local
        depends_on:
        - db
        ports:
        - "443:443"
        links:
        - db:mysql
networks:
    default:
        external:
            name: webproxy
```

## Créditos
- [Vindi](https://github.com/vindi)
- [Todos os Contribuidores](https://github.com/vindi/vindi-magento/contributors)

## Licença
GNU GPLv3. Por favor, veja o [Arquivo de Licença](LICENSE) para mais informações.
