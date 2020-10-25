import 'package:jap_vocab/models/item.dart';

class LoadingItemsAction {}

class LoadedItemsAction {
  final List<Item> items;

  const LoadedItemsAction(this.items);
}

class LoadingItemAction {}

class LoadedItemAction {
  final Item item;
  const LoadedItemAction(this.item);
}
