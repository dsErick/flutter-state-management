import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/cart.dart';

class MyItemsPage extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return ChangeNotifierProvider(
            create: (context) => CartModel(),
            child: Scaffold(
                appBar: AppBar(
                    title: const Text('Provider'),
                    actions: <Widget>[
                        IconButton(
                            icon: Icon(Icons.favorite),
                            onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute<void>(
                                    builder: (_) => MyCartPage(),
                                ));
                            },
                        ),
                    ],
                ),
                // body: Consumer<CartModel>(
                //     builder: (context, cart, child) {
                //         print(cart.items);

                //         return ListView.builder(
                //             itemBuilder: (BuildContext context, int index) {
                //                 return ListTile(
                //                     title: Text('Hello World'),
                //                 );
                //             },
                //             itemCount: 2,
                //         );
                //     },
                // ),
                body: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                        final cart = context.watch<CartModel>();
                        final item = cart.getById(index);
                        final hasItem = cart.hasItem(item);

                        return ListTile(
                            title: Text(item.name),
                            trailing: IconButton(
                                icon: Icon(hasItem ? Icons.remove : Icons.add),
                                onPressed: () {
                                    hasItem
                                        ? cart.remove(item)
                                        : cart.add(item);
                                },
                            ),
                        );
                    },
                    itemCount: 2,
                ),
            ),
        );
    }
}

class MyCartPage extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Cart items'),
            ),
            body: Center(
                child: const Text('Cart Items'),
            ),
        );
    }
}
