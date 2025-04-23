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
      'pergunta': 'Qual das seguintes marcas é de um carro?',
      'opcoes': ['Fiat', 'Honda', 'Kawasaki'],
      'respostaCorreta': 'Fiat',
      'imagem': 'mcqueen.jfif'
    },
    {
      'pergunta': 'Qual das seguintes marcas é de uma moto?',
      'opcoes': ['Volkswagen', 'Chevrolet', 'Kawasaki'],
      'respostaCorreta': 'Kawasaki',
      'imagem': 'moto.jfif'
    },
    {
      'pergunta': 'Quantos planetas fazem parte do sistema solar ?',
      'opcoes': ['6', '8', '9'],
      'respostaCorreta': '8',
      'imagem': 'espaco.jfif'
    },
    {
      'pergunta': 'Bivolt, refere-se a algo que é carregado em',
      'opcoes': ['tomadas com ambas voltagens', 'tomadas com voltagem de 110v', 'tomadas com voltagem de 220v'],
      'respostaCorreta': 'tomadas com ambas voltagens',
      'imagem': 'eletrecidade.jfif'
    },
    {
      'pergunta': 'Qual a capital do Ceará?',
      'opcoes': ['Fortaleza', 'Crato', 'Caucaia'],
      'respostaCorreta': 'Fortaleza',
      'imagem': 'brasil.jfif'
    },
    {
      'pergunta': 'Qual a capital do Brasil?',
      'opcoes': ['Brasília', 'São Paulo', 'Rio de Janeiro'],
      'respostaCorreta': 'Brasília',
      'imagem': 'brasil 2.jfif'
    },
    {
      'pergunta': 'No "Minecraft", se você mistura água e lava, gera o quê?',
      'opcoes': ['pedregulho', 'terra', 'terracota'],
      'respostaCorreta': 'pedregulho',
      'imagem': 'minecraft.jfif'
    },
    {
      'pergunta': 'Qual a forma molecular da água?',
      'opcoes': ['H₂O', 'C₂H₆O', 'CH₄'],
      'respostaCorreta': 'H₂O',
      'imagem': 'quimica.jfif'
    },
    {
      'pergunta': 'O Ceará fica na região',
      'opcoes': ['Norte', 'Nordeste', 'Sul'],
      'respostaCorreta': 'Nordeste',
      'imagem': 'ceara.jfif'
    },
    {
      'pergunta': 'O presidente Lula tem nas mãos',
      'opcoes': ['8 dedos', '9 dedos', '10 dedos'],
      'respostaCorreta': '9 dedos',
      'imagem': 'lula.jfif'
    }
  ];
  //inicializa os valores do quiz
  int perguntaAtual = 0;
  int pontos = 0;
  String? mensagem;
  bool quizFinalizado = false;
  String imagem = '';
  final String prefixo = 'assets/images/';

  @override
  void initState() {
    super.initState();
    imagem = prefixo + perguntas[perguntaAtual]['imagem'];
  }

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
      //muda a variável da imagem
    if (perguntaAtual + 1 <= perguntas.length - 1){
      imagem = prefixo + perguntas[perguntaAtual+1]['imagem'];
    }
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
        backgroundColor: const Color.fromARGB(255, 0, 81, 119),
        appBar: AppBar(title: Text(
            'Quiz flutter', 
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold,
              fontFamily: 'Arial',
              fontSize: 35
            ),
          ), 
          backgroundColor: Color.fromARGB(255, 255, 255, 255)),
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
              Image.asset(imagem, height: 300, width: 300),
              SizedBox(height: 20),
              Text(
                style: TextStyle(
                  fontFamily: 'Arial',
                  fontSize: 30
                )
                ,perguntas[perguntaAtual]['pergunta'],
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