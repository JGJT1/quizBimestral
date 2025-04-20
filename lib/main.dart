import 'package:flutter/material.dart';

void main() {
  runApp(myApp());
}

// StatelessWidget não muda estado
// StatefulWidget muda o estado
class myApp extends StatefulWidget {
  @override
  _myAppState createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  final List<Map<String, dynamic>> perguntas = [
    {
      'pergunta': 'Qual é a capital do Brasil?',
      'opcoes': ['São Paulo', 'Brasília', 'Rio de Janeiro'],
      'respostaCorreta': 'Brasília',
    },
  ];
  //inicializa os valores do quiz
  int perguntaAtual = 0;
  int pontos = 0;
  String? mensagem;
  bool quizFinalizado = false;

  //função que verifica a resposta
  void verificarResposta(String respostaEscolhida) {
    String respostaCorreta = perguntas[perguntaAtual]['respostaCorreta'];

    setState(() {
      if (respostaEscolhida == respostaCorreta) {
        pontos++;
        mensagem = 'Resposta certa! +1';
      } else {
        mensagem = 'Resposta errada!';
      }
    });
    //espera 2 segundos e passa para a próxima pergunta

   Future.delayed(Duration(seconds: 2), () {
    setState(() {
      mensagem = null;
      if(perguntaAtual < perguntas.length - 1){
        perguntaAtual++;
      } else {
        quizFinalizado = true;
      }
    });
  });
  }//fim do método anteior

  

  // método para reiniciar o quiz
  void reiniciarQuiz(){
    setState(() {
      perguntaAtual = 0;
      pontos = 0;
      quizFinalizado = false;
      mensagem = null;
    });
  }

  
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:ThemeData.dark(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(title: Text('Quiz flutter')),
        body: Center(
          child: quizFinalizado ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Parabéns! Você terminou o quiz!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24)
              ),
              SizedBox(height: 20),
              Text(
                'Sua pontuação: $pontos/${perguntas.length}'
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: reiniciarQuiz,
                child: Text('Recomeçar')
              )
            ],
          ) : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network('link-da-imagem.com', width: 100, height: 100),
              SizedBox(height: 20),
              Text(
                perguntas[perguntaAtual]['pergunta'],
                textAlign: TextAlign.center
              ),
              SizedBox(height: 20),
              ...perguntas[perguntaAtual]['opcoes'].map<Widget>((opcao) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: ElevatedButton(
                    onPressed: mensagem == null ? () => verificarResposta(opcao) : null,
                    child: Text(opcao)
                  )
                );
              }).toList(),
              SizedBox(height: 20),
              if (mensagem != null)
                Text(mensagem!),
              SizedBox(height: 20),
              Text('Pontuação: $pontos')
            ],
          )
        ),
      )
    );
  }    
}