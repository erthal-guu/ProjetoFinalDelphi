# Sistema de Oficina Mecânica

Sistema desktop em Delphi para gerenciar oficinas mecânicas com clientes, serviços e financeiro.

## O que faz?

### 👥 Cadastros
- **👤 Clientes:** dados pessoais, contato, histórico de serviços
- **🚗 Veículos:** placa, modelo, ano, vinculado ao cliente
- **👷 Funcionários:** dados, acesso ao sistema, permissões
- **🏪 Fornecedores:** peças e serviços fornecidos
- **🔧 Peças:** controle de estoque, valores, vinculação com fornecedores
- **🛠️ Serviços:** catálogo de serviços oferecidos
- **👨‍💼 Usuários:** login, senha criptografada, grupo de acesso

### 🔧 Operações
- **📋 Ordens de Serviço:** criação, edição, acompanhamento
- **🔩 Peças Usadas:** vincula peças às ordens de serviço
- **📦 Pedidos:** solicitação de peças aos fornecedores
- **📊 Status:** aberto, em andamento, concluído, cancelado
- **📚 Histórico:** serviços realizados por cliente/veículo

### 💰 Financeiro
- **💵 Receitas:** pagamentos dos clientes por ordens de serviço
- **💸 Contas a Pagar:** pendências com fornecedores
- **📈 Status Financeiro:** pendente, concluído, cancelado
- **💰 Valores:** total, recebido, pendente, comissões

### 📊 Relatórios
- **✅ Receitas Concluídas:** por cliente, totais, tickets médios
- **❌ Receitas Canceladas:** valores perdidos, percentuais
- **⏳ Receitas Pendentes:** valores a receber, vencidos
- **🧾 Contas a Pagar:** por fornecedor, prazos, vencidos
- **📈 Análises:** totais gerais, médias, percentuais

### 🔐 Segurança
- **🔑 Login:** usuário e senha com bcrypt
- **👤 Perfis:** administrador, gerente, atendente, mecânico
- **🚪 Controle de Acesso:** cada perfil vê só o que pode
- **📝 Logs:** registro de atividades do sistema

## Perfis de Usuário

- **Administrador:** acesso a tudo
- **Gerente:** gestão operacional e financeira
- **Atendente:** atendimento ao cliente
- **Mecânico:** apenas consulta de serviços

## 🛠️ Tecnologias

- **💻 Delphi** (Object Pascal)
- **🗄️ PostgreSQL** (banco de dados)
- **🔗 FireDAC** (conexão com banco)
- **📄 FastReport** (relatórios)

## 🚀 Como usar

1. 💻 Tenha o **Delphi 20.1+** instalado
2. 🗄️ Instale o **PostgreSQL**
3. 📂 Abra o arquivo `ProjetoFinalDelphi.dproj`
4. ⚡ Compile (Ctrl+F9) e execute (F9)

## 📁 Estrutura do Projeto

```
src/
├── Model/          # 🏗️ Classes (Usuario, Cliente, etc.)
├── View/           # 🖼️ Telas do sistema
├── Controller/     # 🎮 Lógica das telas
├── Services/       # ⚙️ Regras de negócio
├── Repository/     # 💾 Acesso ao banco
└── session/        # 🔐 Login do usuário
```

## 🔐 Segurança

- 🔒 Senhas criptografadas com **bcrypt**
- 👤 Login por usuário e senha
- 🚪 Controle de acesso por perfil

---

🏎️ Feito para facilitar o dia a dia de oficinas mecânicas! 🛠️