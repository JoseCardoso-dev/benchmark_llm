# Benchmark entre Modelos de IA com RAG

---

## Objetivos  
Realizar um benchmark comparativo entre modelos de IA utilizando um conjunto de 45 questões para determinar qual modelo apresenta melhor desempenho. O processo incluiu a automação do envio das perguntas e a análise das respostas com um modelo julgador. Além disso, na segunda etapa do projeto, foi implementada a técnica de Retrieval-Augmented Generation (RAG) para verificar se o desempenho dos modelos melhorava com o suporte de documentos externos.

---

## Ferramentas Utilizadas  
- **Ollama**: Para baixar e rodar os modelos de IA localmente.  
- **Dart**: Para desenvolver o script de automação do envio das questões.  
- **Python (Streamlit)**: Para implementar o sistema de RAG com interface web.  
- **LangChain**: Para gerenciar a ingestão de documentos e geração de respostas no RAG.  
- **ChromaDB**: Como armazenamento vetorial para a busca de contextos relevantes.  
- **CSV**: Formato utilizado para armazenar as questões e o gabarito.  

---

## Modelos Avaliados  
- **llama3.2:lates**  
- **gemma:2b**  

### Modelo Julgador  
- **phi3:3.8b**: Utilizado para analisar as respostas dos modelos e determinar o número de acertos de cada um.

---

## Etapa 1: Benchmark Inicial  

### Descrição  
Nesta etapa, foi realizado o benchmark inicial dos modelos de IA sem o uso de RAG, enviando um conjunto de 45 perguntas diretamente para os modelos e avaliando suas respostas.

### Resultados (Sem RAG)  
- **Modelo (llama3.2:lates)**: 10 acertos  
- **Modelo (gemma:2b)**: 7 acertos  

---

## Configuração e Execução  

### 1. Instalar o Ollama  
O Ollama é uma ferramenta que permite o download e execução de modelos de IA localmente.

```bash
# MacOS
brew install ollama

# Verificar instalação
ollama list
```

### 2. Baixar os Modelos de IA
```bash
# Baixar os modelos com Ollama
ollama pull llama3.2:lates
ollama pull gemma:2b
ollama pull phi3:3.8b
```

### 3. Instalar o Dart
O script de automação foi desenvolvido em Dart:

```bash
# Verificar instalação
dart --version
```

### 4. Executar o Script de Benchmark
```bash
dart run automacao.dart
```

---

## Etapa 2: Benchmark com RAG

### Descrição
Nesta etapa, foi adicionada a técnica de Retrieval-Augmented Generation (RAG), permitindo que os modelos utilizassem documentos externos para melhorar o contexto e, consequentemente, o desempenho nas respostas. Para isso, foram desenvolvidos os seguintes scripts:

- **App.py**: Interface web com Streamlit para fazer upload de PDFs e interagir com os modelos.
- **rag.py**: Lógica do RAG, utilizando o LangChain para divisão de textos, armazenamento vetorial com ChromaDB e integração com o ChatOllama.

---

### Resultados (Com RAG)
- **Modelo (llama3.2:lates)**: 12 acertos
- **Modelo (gemma:2b)**: 8 acertos

---

### Funcionalidades
- **Upload de PDFs**: O usuário pode enviar um ou mais PDFs, que são divididos em chunks e armazenados em um banco de vetores.
- **Busca de Contexto**: Para cada pergunta, o sistema busca os trechos mais relevantes nos PDFs e usa essa informação para gerar uma resposta mais precisa.
- **Interface Interativa**: Desenvolvida com Streamlit, a interface permite uma interação fácil com o sistema.

---

### Passo a Passo de Configuração e Execução do RAG

#### 1. Instalar Dependências
```bash
pip install streamlit langchain chromadb
```

#### 2. Clonar o Repositório
```bash
git clone https://github.com/JoseCardoso-dev/benchmark_llm.git
cd benchmark_llm
```

#### 3. Executar o RAG com Streamlit
```bash
streamlit run app.py
```

---

#### 4. Utilização
1. Acesse a interface web gerada pelo Streamlit.
2. Faça o upload dos PDFs que servirão como base de conhecimento.
3. Envie perguntas na caixa de texto e veja as respostas geradas usando RAG.

---

### Arquitetura do RAG

- **app.py**  
  - Interface web usando Streamlit para upload de PDFs e interação com os modelos.
  - Gera um chat interativo exibindo as mensagens do usuário e as respostas do modelo.

- **rag.py**  
  - Usa LangChain para:
    - Ingestão e divisão dos PDFs em chunks.
    - Armazenamento vetorial com ChromaDB.
    - Busca dos trechos mais relevantes para cada pergunta.
    - Geração de respostas usando ChatOllama com o contexto encontrado.
  - **Prompt Engineering**: O modelo é instruído a responder utilizando as informações encontradas nos PDFs.

---

## Considerações Finais
- **Melhoria de Desempenho**: Com o uso do RAG, ambos os modelos tiveram um aumento no número de acertos:
  - **llama3.2:lates** aumentou de 10 para 12 acertos.
  - **gemma:2b** aumentou de 7 para 8 acertos.

- **Conclusão**: O uso de RAG demonstrou ser uma abordagem eficiente para fornecer contexto adicional aos modelos, melhorando a precisão das respostas.

---

### Professor
**Genaro Fernandes de Carvalho Costa**

---

### Disciplina
**TÓPICOS ESPECIAIS EM TECNOLOGIA I**

---

### Alunos
- José Roberto
- Victor
- Rubem
- Manuela
- Yuri
