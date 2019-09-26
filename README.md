# investments-app
Um projeto iOS com MVVM, utlizando URLSession e padrões de projeto

## O que foi utilizado
- Arquitetura MVVM
- Shimmer para carregamento das Views
- Localizable para internacionalização
- SwiftLint
- Observable para controle de estado da view
- Testes de UI com Snapshot

### Instruções:
- Para rodar os testes, seja de UI ou Unitário, utilizar o iPhone 8, pois os screenshots feitos pela biblioteca de Snapshot foram feitas para esse dispositivo especificamente.

### Piramide de testes
Foram feitos os testes unitários, testes unitários de tela com Snapshot, e testes automatizados com Snapshot.
- testes unitários garantem que a lógica foi garantida.
- testes unitários de tela com Snapshot garantem que o layout não foi modificado, parte visual em geral.
- Testes de UI com snapshot garantem não apenas o layout, e sim a transição das telas.

### Comentários:
Algo muito bacana que costumo usar nos meus projetos é o viewState, que é muito comum ter um estado que controla sua view
em outras plataformas, como o React Native, Flutter, etc. Fica declarativo e fácil de se trabalhar.
