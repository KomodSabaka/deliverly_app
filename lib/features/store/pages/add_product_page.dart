import 'dart:io';

import 'package:deliverly_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/utils/constants.dart';
import '../../../common/utils/utils.dart';
import '../../../common/widgets/back_arrow_widget.dart';
import '../../../common/widgets/input_field_widget.dart';
import '../../../generated/l10n.dart';
import '../repositores/seller_store_repository.dart';

class AddProductPage extends ConsumerStatefulWidget {
  final bool isRefactoring;
  final Product? product;

  const AddProductPage({
    Key? key,
    required this.isRefactoring,
    this.product,
  }) : super(key: key);

  @override
  ConsumerState<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends ConsumerState<AddProductPage>
    with SingleTickerProviderStateMixin {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  File? image;

  Future<void> selectImage(BuildContext context) async {
    var pickedImage = await pickImage(context);
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  void _saveProduct() {
    if (widget.isRefactoring == false && image == null) {
      showSnakeBar(context, S.of(context).add_pic_product);
    } else if (_nameController.text.isEmpty) {
      showSnakeBar(context, S.of(context).add_name_product);
    } else if (_nameController.text.isEmpty) {
      showSnakeBar(context, S.of(context).add_description_product);
    } else if (_nameController.text.isEmpty) {
      showSnakeBar(context, S.of(context).add_cost_product);
    } else {
      if (widget.isRefactoring) {
        ref.read(sellerStoreRepository).refactorProduct(
              context: context,
              product: widget.product!,
              name: _nameController.text,
              price: _priceController.text,
              description: _descriptionController.text,
              image: image,
            );
      } else {
        ref.read(sellerStoreRepository).addProducts(
              context: context,
              name: _nameController.text,
              price: _priceController.text,
              description: _descriptionController.text,
              image: image!,
            );
      }
    }
  }

  @override
  void initState() {
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _priceController = TextEditingController();
    if (widget.isRefactoring) {
      _nameController.text = widget.product!.name;
      _descriptionController.text = widget.product!.description;
      _priceController.text = widget.product!.price;
    }
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackArrowWidget(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                S.of(context).new_product,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 24),
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: borderColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: image != null
                        ? Image.file(
                            image!,
                            fit: BoxFit.cover,
                          )
                        : widget.isRefactoring
                            ? Image.network(
                                widget.product!.image,
                                fit: BoxFit.cover,
                              )
                            : const SizedBox(),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          if (image != null) {
                            setState(() {
                              image = null;
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.delete,
                          size: 45,
                          color: primaryButtonColor,
                        ),
                      ),
                      const SizedBox(height: 50),
                      IconButton(
                        onPressed: () => selectImage(context),
                        icon: const Icon(
                          Icons.add,
                          size: 45,
                          color: primaryButtonColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              InputFieldWidget(
                hintText: S.of(context).enter_name_product,
                controller: _nameController,
              ),
              const SizedBox(height: 24),
              InputFieldWidget(
                hintText: S.of(context).enter_description_product,
                controller: _descriptionController,
                isDescription: true,
              ),
              const SizedBox(height: 24),
              InputFieldWidget(
                hintText: S.of(context).enter_cost_in_rub,
                controller: _priceController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 34),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: SizedBox(
                      width: 100,
                      child: Text(
                        S.of(context).back,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _saveProduct(),
                    child: SizedBox(
                      width: 100,
                      child: Text(
                        widget.isRefactoring
                            ? S.of(context).change
                            : S.of(context).add,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
