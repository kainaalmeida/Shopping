import 'package:flutter/material.dart';
import 'package:shopping_bloc/models/product-list-item.model.dart';
import 'package:shopping_bloc/ui/shared/widgets/product/product-card.widget.dart';
import 'package:shopping_bloc/ui/shared/widgets/shared/loader.widget.dart';

class ProducList extends StatelessWidget {
  final List<ProductListItemModel> products;

  ProducList({@required this.products});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 410,
      child: Loader(
        object: products,
        callback: list,
      ),
    );
  }

  Widget list() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.all(5),
          child: ProductCard(
            item: products[index],
          ),
        );
      },
    );
  }
}
