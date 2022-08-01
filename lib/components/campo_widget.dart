
import 'package:flutter/material.dart';

import '../models/campo.dart';

class CampoWidget extends StatelessWidget {

  final Campo campo;
  final void Function(Campo) onAbrir;
  final void Function(Campo) alternarMarcacao;

  const CampoWidget({Key? key, required this.campo, required this.onAbrir, required this.alternarMarcacao}) : super(key: key);  

   Widget _getImage() {
    int qtdeMinas = campo.qtdeMinasNaVizinhaca;
    if (campo.aberto && campo.minado && campo.explodido) {
      return Image.asset('images/bomba_0.jpeg');
    } else if (campo.aberto && campo.minado) {
      return Image.asset('images/bomba_1.jpeg');
    } else if (campo.aberto) {
      return Image.asset('images/aberto_$qtdeMinas.jpeg');
    } else if (campo.marcado) {
      return Image.asset('images/bandeira.jpeg');
    } else {
      return Image.asset('images/fechado.jpeg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onAbrir(campo),
      onLongPress: () => alternarMarcacao(campo),
      child: _getImage(),
            
    );
  }
}