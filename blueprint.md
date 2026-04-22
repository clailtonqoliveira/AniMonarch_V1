# Blueprint do Projeto: Animonarch

## Visão Geral

Animonarch é um aplicativo Flutter moderno e responsivo, projetado para explorar o mundo dos animes. Utilizando a API Jikan, o aplicativo oferece uma interface de usuário elegante e futurista para navegar, pesquisar e visualizar detalhes sobre uma vasta coleção de animes. O design é fortemente inspirado em uma estética cyberpunk/sci-fi, com um esquema de cores neon, tipografia moderna e layouts dinâmicos.

O projeto foi estruturado seguindo os princípios de uma arquitetura limpa, separando a lógica de apresentação, a lógica de negócios e as fontes de dados para garantir manutenibilidade e escalabilidade. Com a integração do Firebase, o Animonarch agora oferece funcionalidades personalizadas para o usuário, como salvar animes favoritos.

## Funcionalidades e Design Implementados

Esta seção documenta o estado final e estável do aplicativo.

### Arquitetura e Estrutura

*   **Arquitetura Limpa:** O projeto está organizado em três camadas principais:
    *   `data`: Contém os modelos (`anime_model.dart`), repositórios e os serviços responsáveis pela comunicação com as fontes de dados (`jikan_api_service.dart`, `firestore_service.dart`).
    *   `presentation`: Inclui as Views (telas como `home_screen.dart` e `anime_details_screen.dart`), os ViewModels (`home_viewmodel.dart`, `anime_details_viewmodel.dart`) que gerenciam o estado da UI, e os widgets reutilizáveis.
    *   `core`: Abriga a lógica central e compartilhada, como a configuração do tema (`app_theme.dart`), cores (`app_colors.dart`) e o cliente HTTP.
*   **Gerenciamento de Estado:** O estado da UI é gerenciado pelo padrão `ViewModel` (usando `ChangeNotifier` do Flutter) em conjunto com o pacote `provider` para injeção de dependência e reconstrução reativa dos widgets.
*   **Navegação:** A navegação é gerenciada pelo `MaterialApp`, com rotas definidas dinamicamente para a tela de detalhes do anime.

### Design e Experiência do Usuário (UX)

*   **Tema Sci-Fi/Cyberpunk:**
    *   **Paleta de Cores:** Foco em um fundo escuro (`#121212`) com acentos vibrantes de neon (`Colors.cyanAccent`), criando um alto contraste que é visualmente impressionante e legível.
    *   **Tipografia:** Utiliza a fonte `Orbitron` do Google Fonts para títulos e elementos de destaque.
*   **Tela Inicial (`HomeScreen`):**
    *   **Layout Responsivo:** Apresenta um layout limpo com um `AppBar` estilizado e um carrossel horizontal de animes populares.
*   **Tela de Detalhes (`AnimeDetailsScreen`):**
    *   **Layout com `SliverAppBar`:** Cria um efeito de cabeçalho expansível e colapsável com a imagem do anime.
    *   **Informações Detalhadas:** Exibe a sinopse, tipo, episódios, nota e classificação.

### Funcionalidades de Usuário (com Firebase)

*   **Autenticação (Implícita):** O aplicativo utiliza o Firebase para persistir dados, preparando o terreno para uma futura autenticação de usuários.
*   **Favoritos em Tempo Real:**
    *   Na tela de detalhes, um botão de coração (`<3`) permite ao usuário favoritar ou desfavoritar um anime.
    *   O estado do botão (cheio/vazio, cor neon) é atualizado em tempo real, refletindo o status salvo no Cloud Firestore.
    *   As alterações são persistidas na coleção `favorites` do Firestore.

### Funcionalidades Técnicas

*   **Comunicação com API Externa:** O `JikanApiService` utiliza o pacote `dio` para fazer requisições HTTP à API Jikan.
*   **Persistência de Dados com Firebase:** O `FirestoreService` utiliza o `cloud_firestore` para interagir com o banco de dados NoSQL do Firebase.
*   **Theming Centralizado:** O arquivo `lib/core/theme/app_theme.dart` define `ThemeData` para garantir uma aparência consistente.

## Plano para a Solicitação Atual (Concluído)

**Solicitação do Usuário:** "Crie um aplicativo de catálogo de animes e adicione a funcionalidade de favoritar."

**Plano de Execução (Finalizado):**

1.  **Estrutura e UI Base:**
    *   Analisar e estruturar o projeto com arquitetura limpa.
    *   Implementar a busca e exibição de animes da API Jikan.
    *   Desenvolver a UI inicial com a estética cyberpunk/sci-fi.
    *   **Resultado:** Catálogo de animes funcional e estilizado.

2.  **Integração com Firebase:**
    *   Adicionar as dependências do Firebase (`firebase_core`, `cloud_firestore`).
    *   Configurar os arquivos `build.gradle` e `google-services.json` para o Android, resolvendo a `MissingPluginException`.
    *   Inicializar o Firebase no `main.dart`.
    *   **Resultado:** Projeto corretamente configurado para usar os serviços do Firebase.

3.  **Implementação da Funcionalidade de Favoritos:**
    *   Criar o `FirestoreService` para gerenciar as operações de favoritos.
    *   Atualizar o `AnimeDetailsViewModel` para gerenciar o estado `isFavorite`, ouvindo as mudanças do Firestore em tempo real.
    *   Configurar a injeção de dependência na `main.dart` para o `FirestoreService` e o `ViewModel` atualizado.
    *   Modificar a `AnimeDetailsScreen` para incluir um botão de favorito reativo que chama a lógica do `ViewModel`.
    *   **Resultado:** Funcionalidade de favoritar totalmente implementada e persistida no Firebase.
