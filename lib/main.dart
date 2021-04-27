import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
                primarySwatch: Colors.blue,
            ),
            home: MyHomePage(title: 'Flutter Demo Home Page'),
        );
    }
}

class MyHomePage extends StatefulWidget {
    MyHomePage({Key? key, this.title}) : super(key: key);

    final String? title;

    @override
    _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    late CounterModel _counter;

    @override
    void initState() {
        _counter = CounterModel();

        super.initState();
    }

    @override
    void dispose() {
        _counter.dispose();

        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text(widget.title!),
            ),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Text(
                            'Você clicou no botão: ',
                        ),
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
            floatingActionButton: FloatingActionButton(
                onPressed: () => _counter.increase(),
                tooltip: 'Aumentar',
                child: Icon(Icons.add),
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

    /// Função que aumenta o contador
    void increase() {
        count.sink.add(value + 1);
    }

    /// Fechando o controller
    @override
    void dispose() {
        count.close();
        super.dispose();
    }
}
