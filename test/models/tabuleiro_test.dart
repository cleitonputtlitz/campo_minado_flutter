
import 'package:campo_minado/models/tabuleiro.dart';
import 'package:flutter_test/flutter_test.dart';

void main(List<String> args) {
  test('Ganhar jogo', (){
    Tabuleiro tabuleiro = Tabuleiro(colunas: 2, linhas: 2, qtdBombas: 0);   

    tabuleiro.campos[0].minar();
    tabuleiro.campos[3].minar();
    tabuleiro.campos[0].alternarMarcacao();
    tabuleiro.campos[1].abrir();
    tabuleiro.campos[2].abrir();
    tabuleiro.campos[3].alternarMarcacao();

    expect(tabuleiro.resolvido, true);

  });
}