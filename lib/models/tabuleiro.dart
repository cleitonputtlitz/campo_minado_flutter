
import 'dart:math';

import 'package:flutter/material.dart';

import 'campo.dart';

class Tabuleiro {
  final int linhas;
  final int colunas;
  final int qtdBombas;

  final List<Campo> _campos = [];

  Tabuleiro({
    required this.linhas,
    required this.colunas,
    required this.qtdBombas
  }) {
    _criarCampos();
    _relacionarVizinhos();
    _sortearMinas();
  }

  void reiniciar(){
    _campos.forEach((e) {e.reiniciar(); });
    _sortearMinas();
  }

  void revelarBombas() {
    _campos.forEach((e) {e.revelarBombas(); });
  }

  void _criarCampos() {
    for(var l = 0; l < linhas; l++){
      for(var c = 0; c < colunas; c++){
        _campos.add(Campo(linha: l, coluna: c));
      }
    }

  }

  void _relacionarVizinhos() {
    for(var c in _campos){
      for(var v in _campos) {
        c.adicionarVizinho(v);
      }

    }
  }

  void _sortearMinas(){
    int sorteadas = 0;

    if(qtdBombas > linhas * colunas){
      return;
    }

    while(sorteadas < qtdBombas){
      int i = Random().nextInt(_campos.length);

      if(!_campos[i].minado){
        _campos[i].minar();
        sorteadas++;
      }

    }
  }
  
  List<Campo> get campos {
    return _campos;
  }

  bool get resolvido {
    return _campos.every((e) => e.resolvido);
  }

}