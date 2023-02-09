import 'package:flutter/material.dart';
import 'empty_grocery_screen.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import 'grocery_item_screen.dart';

class GroceryScreen extends StatelessWidget {
  const GroceryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final manager = Provider.of<GroceryManager>(context, listen: false);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GroceryItemScreen(
                  onCreate: (item) {
                    manager.addItem(item);
                    Navigator.pop(context);
                  },
                  onUpdate: (item) {

                  },
              ),
            ),
          );
        },
      ),
      body: buildGroceryScreen(),
    );
  }

  Widget buildGroceryScreen() {
    // changeNotifyをlistenするためにConsumerを使う必要がある
    // ConsumerはgroceryItemsが変更されると、自分自身の下にあるウィジェットを再構築する
    // Consumerは極力Widget更新が必要な箇所だけラップする。上から囲んでしまうとツリー全体が再構築されてしまう
    return Consumer<GroceryManager>(
      builder: (context, manager, child) {
        if (manager.groceryItems.isNotEmpty) {
          // TODO: Add GroceryListScreen
          return Container();
        } else {
          return const EmptyGroceryScreen();
        }
      },
    );
  }
}