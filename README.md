# Sistema de Oficina Mecânica

Sistema desktop em Delphi para gerenciar oficinas mecânicas com clientes, serviços e financeiro.

## O que faz?

- **Cadastro de Clientes** e seus veículos
- **Ordens de Serviço** completas
- **Controle Financeiro** (receitas e contas a pagar)
- **Relatórios** de vendas e finanças
- **Estoque** de peças
- **Gestão de Funcionários** e fornecedores

## Perfis de Usuário

- **Administrador:** acesso a tudo
- **Gerente:** gestão operacional e financeira
- **Atendente:** atendimento ao cliente
- **Mecânico:** apenas consulta de serviços

## Tecnologias

- **Delphi** (Object Pascal)
- **PostgreSQL** (banco de dados)
- **FireDAC** (conexão com banco)
- **FastReport** (relatórios)

## Como usar

1. Tenha o **Delphi 20.1+** instalado
2. Instale o **PostgreSQL**
3. Abra o arquivo `ProjetoFinalDelphi.dproj`
4. Compile (Ctrl+F9) e execute (F9)

## Estrutura do Projeto

```
src/
├── Model/          # Classes (Usuario, Cliente, etc.)
├── View/           # Telas do sistema
├── Controller/     # Lógica das telas
├── Services/       # Regras de negócio
├── Repository/     # Acesso ao banco
└── session/        # Login do usuário
```

## Segurança

- Senhas criptografadas com **bcrypt**
- Login por usuário e senha
- Controle de acesso por perfil

---

Feito para facilitar o dia a dia de oficinas mecânicas!