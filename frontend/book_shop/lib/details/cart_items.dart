import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartItems {
  final String name;
  final String imageUrl;
  final String author;
  int quantity = 1;
  final int price;
  final int discount;

  CartItems({
    required this.name,
    required this.imageUrl,
    required this.author,
    required this.price,
    required this.discount,
  });
}

class CartNotifier extends StateNotifier<List<CartItems>> {
  CartNotifier(super.state);

  void addItem(CartItems item) {
    final index = state.indexWhere((i) => i.name == item.name);

    if (index >= 0) {
      state[index].quantity++;
    } else {
      state.add(item);
    }
  }

  void removeItem(CartItems item) {
    final index = state.indexWhere((i) => i.name == item.name);

    if (item.quantity > 1) {
      state[index].quantity--;
    } else {
      state.remove(item);
    }
  }

  int subTotal() {
    return state.fold(0, (sum, item) => sum + (item.quantity * item.price)) +
        state.fold(0, (sum, item) => sum + (item.quantity * item.discount));
  }

  int totalDiscount() {
    return state.fold(0, (sum, item) => sum + (item.quantity * item.discount));
  }

  int total() {
    return state.fold(0, (sum, item) => sum + (item.quantity * item.price));
  }
}
