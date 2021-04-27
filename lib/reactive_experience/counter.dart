import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class MyRxDartPage extends StatelessWidget {
    final CounterModel _counter = CounterModel();

    MyRxDartPage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Testando RxDart'),
            ),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Text('Você clicou no botão: '),
                        StreamBuilder<int>(
                            stream: _counter.stream,
                            builder: (context, snapshot) {
                                return Text(
                                    '${snapshot.data} vezes',
                                    style: Theme.of(context).textTheme.headline4,
                                );
                            },
                        ),
                    ],
                ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        FloatingActionButton(
                            onPressed: () => _counter.decrease(),
                            tooltip: 'Diminuir',
                            child: Icon(Icons.remove),
                        ),
                        FloatingActionButton(
                            onPressed: () => _counter.increase(),
                            tooltip: 'Aumentar',
                            child: Icon(Icons.add),
                        )
                    ],
                ),
            ),
        );
    }
}

class CounterModel extends ChangeNotifier {
    /// Controlador do fluxo do tipo int que inicia com 0
    final count = BehaviorSubject<int>.seeded(0);

    /// Saída de dados
    Stream<int> get stream => count.stream;

    /// Entrada de dados
    // Sink<int> get entrada => count.sink;

    /// Getter que retorna o valor atual
    int get value => count.value!;

    /// Função que aumenta o valor do contador
    void increase() {
        count.sink.add(value + 1);
    }

    /// Função que diminui o valor do contador
    void decrease() {
        count.sink.add(value - 1);
    }

    /// Fechando o controller
    @override
    void dispose() {
        count.close();
        super.dispose();
    }
}
