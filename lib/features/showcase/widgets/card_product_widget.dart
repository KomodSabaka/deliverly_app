import 'package:flutter/material.dart';

import '../../../common/utils/constants.dart';

class CardProductWidget extends StatefulWidget {
  final String image;
  final String name;
  final String price;

  const CardProductWidget({
    Key? key,
    required this.image,
    required this.name,
    required this.price,
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
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(8),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(widget.image),
                    fit: BoxFit.cover,
                  ),
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
              widget.name,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              '${widget.price} руб.',
              overflow: TextOverflow.ellipsis,
              style:
                  Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
