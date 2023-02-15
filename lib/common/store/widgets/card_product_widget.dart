import 'package:deliverly_app/utils/colors.dart';
import 'package:flutter/material.dart';

class CardProductWidget extends StatefulWidget {
  final String urlImage;
  final String nameProduct;
  final String priceProduct;

  const CardProductWidget({
    Key? key,
    required this.urlImage,
    required this.nameProduct,
    required this.priceProduct,
  }) : super(key: key);

  @override
  State<CardProductWidget> createState() => _CardProductWidgetState();
}

class _CardProductWidgetState extends State<CardProductWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 211,
      width: 177,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: 177,
                height: 140,
                decoration:  BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(8),
                  ),
                  image: DecorationImage(image: NetworkImage(widget.urlImage),fit: BoxFit.cover,)
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 16,
            ),
            child: Text(
              widget.nameProduct,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              '${widget.priceProduct} руб.',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
