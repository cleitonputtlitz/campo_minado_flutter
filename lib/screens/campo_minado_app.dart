
import 'dart:collection';
import 'dart:math';

import 'package:campo_minado/components/resultado_widget.dart';
import 'package:campo_minado/components/tabuleiro_widget.dart';
import 'package:campo_minado/models/explosao_exception.dart';
import 'package:campo_minado/models/tabuleiro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/campo.dart';

class CampoMinadoApp extends StatefulWidget {
  const CampoMinadoApp({ Key? key }) : super(key: key);

  @override
  State<CampoMinadoApp> createState() => _CampoMinadoAppState();
}

class _CampoMinadoAppState extends State<CampoMinadoApp> {

  var _venceu;
  Tabuleiro _tabuleiro = Tabuleiro(colunas: 0, linhas: 0, qtdBombas: 0);

  Tabuleiro _getTabuleiro(double largura, double altura){
    if(_tabuleiro.colunas == 0){
      int qtdeColunas = 12;
      double tamanhoCampo = largura / qtdeColunas;
      int qtdeLinhas = (altura / tamanhoCampo).floor();

      _tabuleiro = Tabuleiro(colunas: qtdeColunas, linhas: qtdeLinhas, qtdBombas: Random().nextInt(100) );
    }    
    return _tabuleiro;
  }

  void _reiniciar(){
    setState(() {
      _tabuleiro.reiniciar();
      _venceu = null;
    });
  }

  void _abrir(Campo c){
    if(_venceu != null)
      return;

    setState(() {
      try{
        c.abrir();
        if(_tabuleiro.resolvido)
          _venceu = true;
      } on ExplosaoException {
          _tabuleiro.revelarBombas();
          _venceu = false;
      }
    });
  }

  void _alternarMarcacao(Campo c){
    if(_venceu != null)
      return;
    setState(() {
      c.alternarMarcacao();
      if(_tabuleiro.resolvido)
          _venceu = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Campo campo = Campo(linha: 0, coluna: 0);

    SystemChrome.setPreferredOrientations(//mantem sempre na mesma orientação
      [
      DeviceOrientation.portraitUp
      ]
    );
    
    return MaterialApp(
        home: Scaffold(
          appBar: ResultadoWidget(
            venceu: _venceu, 
            onReiniciar: _reiniciar
            ),          
          body: Container(
            color: Colors.grey,
            child: LayoutBuilder(
              builder: ((context, constraints) {
                return TabuleiroWidget(
                  tabuleiro: _getTabuleiro(constraints.maxWidth, constraints.maxHeight), 
                  onAbrir: _abrir,
                  onAlternarMarcacao: _alternarMarcacao
                );
              }) ,
              ),
          )
          )
    );
  }
}
