[Vindi - Recorrênica](https://blog.vindi.com.br/wp-content/uploads/2018/08/logo-vindi.png)

#### Vindi - Magento Recorrente

[![Licença do Software][badge-license]](LICENSE)
[![Última Versão no GitHub][badge-versionGitHub]][link-GitHub-release]
[![GitHub commits desde a última Versão][badge-versionGitHub-commits]][link-GitHub-release]

### Descrição
A integração do módulo da Vindi permite criação e gestão de planos e assinaturas através do Magento de forma transparente.

### Iniciar uma instância do Vindi - Magento Recorrente

# É necessário criar uma rede com o nome webproxy

```
docker network create webproxy
```

# docker-compose.yml:

```
version: '3.3'
services:
    selenium:
        image: selenium/hub
        container_name: selenium
        ports:
        - "4444"
    chrome:
        image: selenium/node-chrome-debug
        container_name: chrome
        depends_on:
        - selenium
        links:
        - selenium:hub
        ports:
        - "5900:5900"
        environment:
        - HUB_HOST=selenium
        - HUB_PORT=4444
    magento1db:
        image: vindi/mysql-magento1-ci
        container_name: magento1_db
        ports:
        - "3306"
    magento1web:
        image: vindi/apache-magento1-ci
        container_name: vindi.local
        depends_on:
        - magento1db
        - chrome
        ports:
        - "443:443"
        links:
        - magento1db:mysql
        - chrome
networks:
    default:
        external:
            name: webproxy
```


# Rodar os testes

```
composer test
```

# Créditos
- [Vindi](https://github.com/vindi)
- [Todos os Contribuidores](https://github.com/vindi/vindi-magento/contributors)

# Licença
GNU GPLv3. Por favor, veja o [Arquivo de Licença](LICENSE) para mais informações.

[badge-license]: https://img.shields.io/badge/license-GPLv3-blue.svg
[badge-versionGitHub]: https://img.shields.io/github/release/vindi/vindi-magento.svg
[badge-versionGitHub-commits]:  https://img.shields.io/github/commits-since/vindi/vindi-magento/latest.svg


[link-GitHub-release]: https://github.com/vindi/vindi-magento/releases