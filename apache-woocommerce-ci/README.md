![Vindi - Recorrênica](https://vindi-blog.s3.amazonaws.com/wp-content/uploads/2017/10/logo-vindi-1.png)

#### Vindi - WooCommerce Subscriptions

[![Licença do Software][badge-license]](LICENSE)
[![Última Versão no WordPress][badge-version]][link-version]
[![Avaliação do Plugin][badge-rates]][link-rates]
[![Downloads no Total][badge-downloads]][link-downloads]

### Descrição
A integração do módulo da Vindi permite criação e gestão de planos e assinaturas através do Magento de forma transparente.

### Iniciar uma instância do Vindi - WooCommerce Subscriptions

# É necessário criar uma rede com o nome webproxy

```
docker network create webproxy
```

# docker-compose.yml:

```
version: '3.3'
services:
    selenium:
        image: selenium/standalone-chrome-debug
        container_name: selenium
        ports:
        - "5900:5900"
    db:
        image: vindi/mysql-woocommerce-ci
        container_name: wordpress_db
        ports:
        - "3306"
    web:
        image: vindi/apache-woocommerce-ci
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

# Dúvidas
Caso necessite de informações sobre a plataforma ou API por favor siga através do canal [Atendimento Vindi](http://atendimento.vindi.com.br/hc/pt-br)

# Créditos
- [Vindi](https://github.com/vindi)
- [Todos os Contribuidores](https://github.com/vindi/vindi-magento/contributors)

# Licença
GNU GPLv3. Por favor, veja o [Arquivo de Licença](LICENSE) para mais informações.

[badge-license]: https://img.shields.io/badge/license-GPLv3-blue.svg
[badge-version]: https://img.shields.io/wordpress/plugin/v/vindi-woocommerce-subscriptions.svg
[badge-rates]: https://img.shields.io/wordpress/plugin/r/vindi-woocommerce-subscriptions.svg
[badge-downloads]: https://img.shields.io/wordpress/plugin/dt/vindi-woocommerce-subscriptions.svg

[link-version]: https://wordpress.org/plugins/vindi-woocommerce-subscriptions/
[link-rates]: https://wordpress.org/support/view/plugin-reviews/vindi-woocommerce-subscriptions
[link-downloads]: https://wordpress.org/plugins/vindi-woocommerce-subscriptions/stats/
