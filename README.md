# LPR-Doc
LPR Doc Serviço de armazenamento de placas identificadas através o 

**Serviços desenvolvidos neste projeto**

 - 👍 Serviço do Linux usando o systemd 
 - 👍 Armazenamento do log de passagem no banco de dados PostgreSQL 
 - 👍 Envio Websocket
 - Pesquisa de veículos na base de dados
 - 👍 GUI para visualização em tempo real das passagens veiculares


Dependências

 - [Craos Smart Framework](https://github.com/Craos/smart.git)
 
 Diretórios
  - install: Utilizado para scripts de instalação do rastreador no equipamento que irá fazer a captura das informações
  - report: Módulo GUI para pesquisa de informações
  - stogare: Local para armazenamento das imagens 
  - trace: Módulo rastreador de dados. Contém o submódulo view capaz apresentar em tempo real as capturas
  - transfer: Módulo de importação das unidades. Contém o submodulo import gerenciador de importação