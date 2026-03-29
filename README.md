<div align="center">
  <img src="assets/images/logo.png" alt="Zen Reiki Logo" width="200">
</div>

# 🧘‍♂️ Zen Reiki App

> Um timer minimalista e funcional para praticantes de Reiki, desenvolvido com foco em personalização e tranquilidade.

O **Zen Reiki App** foi criado para auxiliar praticantes de Reiki durante suas sessões, permitindo o controle preciso do tempo de cada posição, com alertas sonoros suaves e uma interface intuitiva que não interfere na meditação.

-----

## ✨ Funcionalidades

  * **⏱️ Timer Personalizável:** Configure o tempo por posição (ex: 3 min) e o número de repetições (ex: 15 posições).
  * **🔔 Alertas Sonoros:** Escolha sons de sinos suaves para marcar a transição entre as posições.
  * **🎵 Background Music:** Suporte para música de fundo relaxante (músicas locais ou integradas).
  * **⏳ Prelúdio:** Tempo de preparação configurável antes do início da sessão.
  * **📱 Interface Minimalista:** Foco total no player principal para evitar distrações.

## 🛠️ Tecnologias Utilizadas

O projeto utiliza as melhores práticas de desenvolvimento mobile:

  * **Flutter:** Framework UI.
  * **Dart:** Linguagem de programação.
  * **Flutter Modular:** Para uma estrutura de pastas organizada, injeção de dependências e gerenciamento de rotas.
  * **Triple (Segmented State Management):** Para um gerenciamento de estado limpo e reativo.

-----

## 🚀 Como Rodar o Projeto

Para rodar o **Zen Reiki App** localmente, você precisará ter o ambiente Flutter configurado em sua máquina.

### 1\. Pré-requisitos

  * [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado (versão estável).
  * Um emulador (Android ou iOS) ou um dispositivo físico conectado.
  * Git instalado.

### 2\. Instalação

Clone o repositório para o seu computador:

```bash
git clone https://github.com/soniamarasa/zen_reiki_app.git
```

Entre na pasta do projeto:

```bash
cd zen_reiki_app
```

### 3\. Configuração de Dependências

Baixe todos os pacotes necessários utilizando o comando:

```bash
flutter pub get
```

### 4\. Executando o App

Para rodar o projeto em modo de debug:

```bash
flutter run
```

-----

## 📂 Estrutura de Pastas

O projeto segue a estrutura padrão do **Flutter Modular**:

  * `lib/app/modules/home`: Contém a lógica do Player e interface principal.
  * `lib/app/modules/config`: Telas e lógica de personalização do timer.
  * `lib/app/shared`: Componentes, modelos e utilitários compartilhados.

-----

*Desenvolvido com 💜 por Sônia Mara de Sá*
