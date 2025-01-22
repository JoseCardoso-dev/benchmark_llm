# Benchmark entre Modelos de IA

## Objetivos
Realizar um benchmark comparativo entre modelos de IA utilizando um conjunto de 45 questões para determinar qual modelo apresenta melhor desempenho. O processo incluiu a automação do envio das perguntas e a análise das respostas com um modelo julgador.

## Ferramentas Utilizadas
- **Ollama**: Para baixar e rodar os modelos de IA localmente.
- **Dart**: Para desenvolver o script de automação do envio das questões.
- **CSV**: Formato utilizado para armazenar as questões e o gabarito.

### Modelos Avaliados
1. **llama3.2:lates**
2. **gemma:2b**

### Modelo Julgador
- **phi3:3.8b**: Utilizado para analisar as respostas dos modelos e determinar o número de acertos de cada um.

## Passo a Passo de Configuração e Execução

### 1. Baixar e Instalar o Ollama
O Ollama é uma ferramenta que permite o download e execução de modelos de IA localmente.

#### Passos:
1. Acesse o site oficial do Ollama: [https://ollama.ai](https://ollama.ai)
2. Siga as instruções para instalar o Ollama no seu sistema operacional:
   - **MacOS**: Use Homebrew:  
     ```bash
     brew install ollama
     ```
   - **Windows**: Baixe o instalador diretamente do site.
3. Após a instalação, verifique se o Ollama está funcionando corretamente:
   ```bash
   ollama list
   ```

### 2. Baixar os Modelos de IA
Use o comando abaixo para baixar os modelos necessários:
```bash
ollama pull llama3.2:lates
oollama pull gemma:2b
ollama pull phi3:3.8b
```

### 3. Preparar o Ambiente de Execução

#### Instalar o Dart
1. Acesse [https://dart.dev/get-dart](https://dart.dev/get-dart) para instalar o Dart no seu sistema operacional.
2. Confirme a instalação:
   ```bash
   dart --version
   ```

#### Clonar o Repositório
Clone o repositório contendo o script de automação:
```bash
git clone https://github.com/JoseCardoso-dev/benchmark_llm.git
cd benchmark_llm
```

### 4. Executar o Script de Benchmark
Certifique-se de que o arquivo CSV com as questões e o gabarito está no diretório do projeto.

Execute o script em Dart para realizar o benchmark:
```bash
dart run automacao.dart
```

### 5. Resultados
Após a execução, o script exibirá os resultados no console e salvará as respostas em um arquivo de saída:
- **Modelo (llama3.2:lates)**: 10 acertos
- **Modelo (gemma:2b)**: 7 acertos

## Professor
- Genaro Fernandes de Carvalho Costa

## Disciplina
- TÓPICOS ESPECIAIS EM TECNOLOGIA I

## Alunos
- José Roberto, Victor, Rubem, Manuela e Yuri

