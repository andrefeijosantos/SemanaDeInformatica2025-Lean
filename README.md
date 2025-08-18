![Universidade Federal de Viçosa.](ufv.jpg)

# Introdução ao Assistente de Provas Lean
Minicurso apresentado na **30ª Semana de Informática** da **Univerisdade Federal de Viçosa (UFV)**. \
Autor: André Luiz Feijó dos Santos (GitHub: @andrefeijosantos)

## Resumo

Assistentes de provas são ferramentas desenvolvidas para auxiliar a construção de provas formais. Esses sistemas permitem que o usuário modele teorias, defina estruturas matemáticas, formule teoremas e conduza demonstrações com suporte automatizado, garantindo que cada passo da prova esteja de acordo com regras bem definidas de um sistema formal. Essas ferramentas têm sido amplamente utilizadas na prova de novos teoremas e na revisão de clássicos, como recurso de estudo e como apoio a desenvolvedores na verificação da corretude de suas implementações.

Neste minicurso, será apresentada uma introdução à linguagem funcional e assistente de provas Lean. Serão abordados conceitos básicos de programação funcional, avaliação de expressões e de tipos, tipos indutivos, notação personalizada e provas por simplificação, reescrita, análise de casos e indução.

## Conteúdo Programático

Os temas abordados nesse minicurso são:

* Introdução
  * O que é Lean?
  * Programação Funcional
  * O que são Assistentes de prova?

* Programação em Lean
  * Lean Language server
  * Avaliação de Expressões e Tipos
  * Declaração de Variáveis e Funções
  * Tipos em Lean
  * Declaração de tipos indutivos

* Provas em Lean
  * Provas por Simplificação
  * Provas por Reescrita
  * Provas por Análise de Casos
  * Provas por Indução

* Conclusões

## Arquivos

Este repositório contém os seguintes arquivos (relacionados à apresentação):

* [`ProgFun.lean`](ProgFun.lean)\
    Implementa as avaliações, variáveis e funções apresentadas na seção de conceitos básicos de Programação Funcional em Lean.

* [`MyBool.lean`](MyBool.lean)\
    Implementa o tipo MyBool, apresentado na seção de Programação em Lean, além de um conjunto de funções e os cabeçalhos dos teoremas a serem provados.

* [`MyNat.lean`](MyNat.lean)\
    Implementa o tipo MyNat, apresentado na seção de Programação em Lean, além de um conjunto de funções e os cabeçalhos dos teoremas a serem provados.

* [`solucoes/MyBool.lean`](solucoes/MyBool.lean)\
    Contém todas as definições de `MyBool.lean` e a prova dos teoremas declarados.

* [`solucoes/MyNat.lean`](solucoes/MyNat.lean)\
    Contém todas as definições de `MyNat.lean` e a prova dos teoremas declarados.

* [`slides/main.pdf`](slides/main.pdf)\
    Slides apresentados durante o minicurso.

* [`slides/main.pdf`](slides/extras.pdf)\
    Slides **extras**, não apresentados durante o minicurso, sobre Teoria de Tipos Dependentes.