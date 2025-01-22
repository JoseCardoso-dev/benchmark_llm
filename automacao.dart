import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:http/http.dart' as http;

void main() async {
  late List<String> dataSets;
  late String gabarito;

  List<String> modelos = ['llama3.2:latest', 'gemma:2b', 'phi3:3.8b'];
  Map<String, dynamic> responses = {};

  print('====================');
  print('START: ${DateTime.now()}');

  dataSets = await getDataSet();
  gabarito = await getGabarito();

  for (var model in modelos.take(modelos.length - 1)) {
    responses[model] = '';

    for (var prompt in dataSets) {
      var response = await generateText(model: model, prompt: '''
Responda **somente com o número da questão e a letra da resposta correspondente**, sem adicionar comentários, explicações ou qualquer texto extra.

**Formato obrigatório de saída:**
Questão (número da questão) - (letra da resposta)

**Exemplo:**
Questão 1 - A

Importante:
- Não escreva nada além do número da questão e da letra.
- Não inclua o texto das perguntas ou das respostas, apenas siga o formato exigido.

Perguntas:
$prompt
''');

      responses[model] += response.toString() + '\n';
    }
  }

  var promptJuiz = '''
Você atuará como juiz neste experimento. Abaixo estão as respostas fornecidas por ${modelos.length - 1} modelos.

No final, está o gabarito para conferência. Sua tarefa é **contar e informar quantas questões cada modelo acertou**, comparando as respostas com o gabarito fornecido.

**Formato obrigatório de saída:**
Modelo (nome do modelo): X acertos
Modelo (nome do modelo): X acertos
...
Modelo N: X acertos

Importante:
- Apenas forneça o número de acertos de cada modelo no formato especificado.
- Não inclua comentários, explicações ou cálculos intermediários.
- Certifique-se de seguir o formato solicitado exatamente. \n \n
  ''';

  print('Calculando parecer final...');
  for (var model in modelos.take(modelos.length - 1)) {
    promptJuiz += 'Modelo: $model \n Respostas: \n ${responses[model]} \n \n';
  }

  promptJuiz += gabarito;

  var parecerFinal = await generateText(
    model: modelos.last,
    prompt: promptJuiz,
  );

  print('====================');
  print('Parecer final: $parecerFinal');

  print('END: ${DateTime.now()}');
  print('====================');
}

Future<String?> generateText({
  required String model,
  required String prompt,
}) async {
  var url = Uri.parse('http://localhost:11434/api/generate');
  var headers = {
    'Content-Type': 'application/json',
  };

  var data = {
    'model': model,
    'prompt': prompt,
    'stream': false,
  };

  var response = await http.post(
    url,
    headers: headers,
    body: jsonEncode(data),
  );

  if (response.statusCode == 200) {
    var result = jsonDecode(response.body);
    return result['response'];
  } else {
    return null;
  }
}

Future<List<String>> getDataSet() async {
  var datasetPath = 'C:\\dev\\llm\\benchmark_llm\\data\\questionario.csv';

  var file = File(datasetPath);
  var csvString = await file.readAsString();

  var csvData = CsvToListConverter().convert(csvString);

  List<String> result = [];
  String group = '';

  for (int i = 0; i < csvData.length; i++) {
    group += csvData[i].sublist(0, 6).join('\n') + '\n \n';

    result.add(group);
    group = '';

    // if ((i + 1) % 10 == 0 || i == csvData.length - 1) {
    //  result.add(group);
    // group = '';
    // }
  }

  return result;
}

Future<String> getGabarito() async {
  var datasetPath = 'C:\\dev\\llm\\benchmark_llm\\data\\questionario.csv';

  var file = File(datasetPath);
  var csvString = await file.readAsString();

  var csvData = CsvToListConverter().convert(csvString);

  String gabarito = 'GABARITO DE RESPOSTAS: \n \n';

  for (int i = 0; i < csvData.length; i++) {
    gabarito += 'Questão ${i + 1}: ' + csvData[i][6] + '\n';
  }

  return gabarito;
}
