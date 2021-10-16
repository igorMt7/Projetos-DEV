import 'package:flutter/material.dart';
import 'package:partilhe/helpers/enums/tipo_frequencia.dart';
import 'package:partilhe/pages/relatorios/stores/relatorios_store.dart';

class Relatorios extends StatelessWidget {
  final store = RelatoriosStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Relatórios'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ElevatedButton(
                onPressed: () async {
                  await store.frequencia(TIPO_FREQUENCIA.MAIOR);
                },
                child: const Text('Relatório de maior frequência'),
              ),
            ),
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ElevatedButton(
                onPressed: () async {
                  await store.frequencia(TIPO_FREQUENCIA.MENOR);
                },
                child: const Text('Relatório de menor frequência'),
              ),
            ),
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ElevatedButton(
                onPressed: () async {
                  await store.dependentes();
                },
                child: const Text('Relatório de dependentes'),
              ),
            ),
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ElevatedButton(
                onPressed: () async {
                  await store.tamanhoRoupa();
                },
                child: const Text('Relatório tamanho de roupa'),
              ),
            ),
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ElevatedButton(
                onPressed: () async {
                  await store.mediaPresencaEventos();
                },
                child: const Text('Média de presença (eventos)'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
