automação TXT para Markdown (Recursiva)
Este projeto consiste em um script Bash integrado ao systemd para monitorar e converter automaticamente arquivos .txt em .md (Markdown) de forma recursiva. Desenvolvido para otimizar fluxos de trabalho no Linux, garantindo que qualquer nota salva seja instantaneamente transformada e o arquivo original removido.

Cenário e Problemas Resolvidos
Durante o desenvolvimento no Debian 13 (Trixie), identifiquei que o monitoramento simples de pastas não atendia a todas as necessidades. Este projeto resolve:

Recursividade: Monitora não apenas a pasta raiz, mas todos os subdiretórios criados.

Confiabilidade de Eventos: Utiliza os eventos close_write e moved_to do kernel para garantir que a conversão só ocorra após o arquivo ser totalmente gravado no disco.

Persistência: Transforma o script em um serviço de usuário do systemd, rodando silenciosamente em segundo plano desde o login.

Limpeza Automática: Remove o arquivo .txt original após o sucesso da cópia para manter o diretório organizado.

Tecnologias Utilizadas
Sistema Operacional: Debian 13 (Trixie).

Linguagem: Bash Script.

Ferramentas: inotify-tools (para monitoramento de eventos do sistema de arquivos).

Gerenciador de Serviços: Systemd (User mode).

Como Instalar
1. Pré-requisitos
Certifique-se de ter o inotify-tools instalado:

Bash
sudo apt update && sudo apt install inotify-tools -y
2. Configuração do Script
Salve o script converter.sh em sua pasta de preferência e conceda permissão de execução:

Bash
chmod +x ~/converter.sh
3. Configuração do Serviço (Systemd)
Para que o script rode automaticamente no seu usuário:

Crie o diretório de serviços caso não exista: mkdir -p ~/.config/systemd/user/

Mova o arquivo txt-to-md.service para esta pasta.

Ative o serviço:

Bash
systemctl --user daemon-reload
systemctl --user enable txt-to-md.service
systemctl --user start txt-to-md.service

Demonstração de Uso
Ao salvar qualquer arquivo em /caminho/da/sua/pasta/nota.txt, o serviço detecta a alteração e:

Gera um arquivo nota.md com o mesmo conteúdo.

Exclui o arquivo nota.txt original.

Registra a operação nos logs do sistema.

Autor
Gabriel William

Estudante de Big Data para Negócios (Fatec Ipiranga) e Gestão Financeira (UniFatecie).
Foco em Análise de Dados, Ciência de Dados e Automação.

=======
# Automação Recursiva: TXT para Markdown 

Este projeto automatiza a conversão de arquivos `.txt` para `.md` em sistemas Linux, utilizando **Bash Scripting** e monitoramento de eventos do kernel via **inotify-tools**. A solução foi desenhada para ser leve, persistente e recursiva.

##  Problemas Resolvidos
* **Monitoramento Ativo**: Identifica novos arquivos via eventos `close_write` e `moved_to`.
* **Recursividade**: Atua na pasta principal e em todos os seus subdiretórios.
* **Automação de Limpeza**: Remove o arquivo original após a conversão bem-sucedida.
* **Persistência**: Executa como um serviço de usuário do `systemd`, garantindo que o processo rode em segundo plano desde o login.

##  Tecnologias e Ambiente
* **OS**: Debian 13 (Trixie)
* **Hardware**: Intel Core i5-7500T | 16GB RAM
* **Ferramentas**: Bash, inotify-tools, Systemd

##  Instalação e Uso

1. **Instale as dependências:**
   ```bash
   sudo apt update && sudo apt install inotify-tools -y
>>>>>>> a381b24 (Inital Commit: Automação recursiva de conversão txt para md)
