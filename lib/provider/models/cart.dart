import 'dart:collection';

import 'package:flutter/foundation.dart';

class CartModel extends ChangeNotifier {
    /// Cart items
    final List<Item> _items = [];

    /// An unmodifiable view of the items in the cart.
    UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

    /// The current total price of all items
    double get totalPrice => _items.fold(0, (double prev, Item item) => prev + item.price);

    /// Add a new [Item] by [id].
    Item getById(int id) {
        return Item(id: id, name: 'Item $id');
    }

    /// Check for a [item] on cart [_items].
    bool hasItem(Item item) {
        return _items.contains(item);
    }

    /// Add a new [Item] to cart [_items].
    void add(Item item) {
        if (!this.hasItem(item)) {
            _items.add(item);
        }

        notifyListeners();
    }

    /// Remove the given [Item] from cart [_items].
    void remove(Item item) {
        if (this.hasItem(item)) {
            _items.remove(item);
        }

        notifyListeners();
    }
}

class Item {
    final int id;
    final String name;
    final double price;

    Item({ required this.id, required this.name, this.price = 0 });

    @override
    int get hashCode => id;

    @override
    bool operator ==(Object other) => other is Item && other.id == id;
}
