import 'package:deliverly_app/common/app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/constants/app_palette.dart';

class CardProductWidget extends ConsumerStatefulWidget {
  final String image;
  final String name;
  final double price;

  const CardProductWidget({
    Key? key,
    required this.image,
    required this.name,
    required this.price,
  }) : super(key: key);

  @override
  ConsumerState<CardProductWidget> createState() => _CardProductWidgetState();
}

class _CardProductWidgetState extends ConsumerState<CardProductWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: AppPalette.borderColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
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
            padding: const EdgeInsets.only(left: 16.0, bottom: 12),
            child: Text(
              '${ref.watch(appSettingsProvider.notifier).calculateInUsersCurrency(costInDollars: widget.price).toStringAsFixed(1)} руб.',
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
