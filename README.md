# Automação Recursiva: TXT para Markdown

Este projeto consiste em um script Bash integrado ao `systemd` para monitorar e converter automaticamente arquivos `.txt` em `.md` (Markdown) de forma recursiva.

---

## O Projeto sob a Metodologia STAR

### Situation (Situação)

No desenvolvimento de fluxos de trabalho locais utilizando o sistema operacional **Debian 13 (Trixie)**, havia a necessidade de centralizar e padronizar notas e registros textuais no formato Markdown (`.md`). Ferramentas tradicionais de monitoramento simples de pastas eram limitadas: elas falhavam em processar estruturas complexas de diretórios (subpastas) e frequentemente tentavam ler arquivos que ainda estavam sendo gravados em disco, gerando corrupção de dados ou falhas de sincronização automática.

### Task (Tarefa)

O desafio consistia em projetar e implementar uma solução de background que cumprisse as seguintes premissas:

* **Monitoramento Completo:** Rastrear não apenas o diretório raiz, mas qualquer subpasta criada dinamicamente (recursividade).


* **Integridade dos Dados:** Garantir que a conversão só ocorresse após o encerramento completo da escrita do arquivo.


* **Persistência:** O processo deveria rodar silenciosamente em segundo plano, iniciando automaticamente junto com o login do usuário, sem necessidade de intervenção manual no terminal.


* **Organização Automática:** Eliminar resíduos removendo o arquivo `.txt` original após o sucesso da cópia para manter o ambiente limpo.



### Action (Ação)

Para solucionar o problema, foram adotadas as seguintes estratégias técnicas:

1. **Garantia de Eventos com o Kernel:** Utilização da biblioteca `inotify-tools` para escutar especificamente os eventos `close_write` (arquivo fechado após escrita) e `moved_to` (arquivo movido para o diretório) do kernel do Linux, mitigando erros de leitura precoce.


2. **Modularização em Bash:** Desenvolvimento de um script Bash robusto estruturado com loops lógicos para varredura e tratamento de caminhos com espaços ou caracteres especiais.


3. **Sustentação via Systemd:** Criação e configuração de uma unidade de serviço de usuário (`systemd --user`), transformando o script em um daemon persistente atrelado à sessão do usuário.



### Result (Resultado)

A implementação resultou em um ecossistema de automação local altamente confiável e invisível para o usuário:

* **Conversão em Tempo Real:** Arquivos `.txt` salvos em qualquer nível da árvore de diretórios especificada geram instantaneamente sua contraparte `.md` correspondente.


* **Eficiência de Armazenamento:** A limpeza pós-conversão eliminou com 100% de eficácia a duplicidade de arquivos.


* **Confiabilidade:** O consumo de recursos de hardware (testado em CPU Intel i5-7500T e 15 GB RAM) manteve-se insignificante, operando com estabilidade ininterrupta desde o boot do sistema.

---

## Tecnologias e Ambiente

* **Sistema Operacional:** Debian 13 (Trixie).


* **Especificações de Hardware Testadas:** Intel Core i5-7500T (Quad Core, 3.1 GHz) | 15 GB RAM | Intel HD Graphics 630.
* **Linguagem:** Bash Script.


* **Ferramentas Chave:** inotify-tools (inotifywait) & Systemd (User mode).



---

## Instalação e Configuração

### 1. Instalar Pré-requisitos

Certifique-se de possuir o `inotify-tools` instalado em seu sistema:

```bash
sudo apt update && sudo apt install inotify-tools -y

```

### 2. Configurar o Script

Salve o script `converter.sh` em sua pasta de preferência e conceda a permissão necessária para execução:

```bash
chmod +x ~/converter.sh

```

### 3. Configuração do Serviço (Systemd)

Para habilitar a persistência do script em sua conta de usuário:

1. Crie o diretório de serviços do usuário, caso ele não exista:
```bash
mkdir -p ~/.config/systemd/user/

```



```
2. Mova o arquivo `txt-to-md.service` para a pasta criada acima.
3. Recarregue os daemons do systemd e inicialize o serviço:
   ```bash
   systemctl --user daemon-reload
   systemctl --user enable txt-to-md.service
   systemctl --user start txt-to-md.service

```

---

## Demonstração de Uso

Ao salvar ou mover qualquer arquivo de texto para a pasta monitorada:

```text
/seu-diretorio-monitorado/
└── nota.txt  (Criado ou modificado)

```

O serviço intercepta o gatilho do kernel instantaneamente e altera o cenário para:

```text
/seu-diretorio-monitorado/
└── nota.md   (Conteúdo preservado e convertido)

```

*O arquivo `nota.txt` original é deletado e a ação é documentada nos registros de logs do sistema.*
