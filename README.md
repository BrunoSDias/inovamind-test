## Dependencias do Sistema
* Ruby versão 2.3.7.
* Rails versão 5.1.7.
* MongoDB 4.0.x
## Instruções de uso
* `/authorize`- A rota `/authorize` gera o token de acesso para testar a aplicação.
* `/load`- A rota `/load` crawlea a página `http://quotes.toscrape.com/` e carrega a base de dados com as citações do site.
* `/quotes/:tag_name`- A rota `/quotes/:tag_name` busca as citações relacionadas a tag enviada como parametro `:tag_name` na url.
* `/quotes`- A rota `/quotes` traz todas as citações registradas na coleção.

Para a implementação dessa solução a gem `httparty` foi utilizada para realizar o request a página `http://quotes.toscrape.com/` e a gem `nokogiri` para parsear o conteúdo da página. Através dessa mesma gem foi realizado o filtro das informações por meio de classes css e atribuido o valor de cada bloco a devida propriedade da collection `quotes`.\
Para realizar um request à API é necessário um token de acesso, esse token de acesso é requisitado todas as vezes que uma rota é requerida, fora a rota `/authorize`, pois essa gera o token de acesso ao usuário (como esse solução é apenas um teste não foi criado um processo de autorização para realizar o request a esse token), ao obter esse token ele deve ser enviado no header `Authorization` junto do request para acessar ao conteúdo da rota
