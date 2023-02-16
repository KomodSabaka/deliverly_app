import 'dart:io';
import 'package:deliverly_app/models/pay_card.dart';
import 'package:deliverly_app/models/seller.dart';
import 'package:deliverly_app/models/client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/utils/constants.dart';
import '../../../common/utils/utils.dart';
import '../../../common/widgets/back_arrow_widget.dart';
import '../../../common/widgets/input_field_widget.dart';
import '../../../generated/l10n.dart';
import '../../auth/repository/auth_repository.dart';
import '../repositores/client_settings_repository.dart';
import '../repositores/seller_settings_repository.dart';
import 'client_card_page.dart';

class InfoPage extends ConsumerStatefulWidget {
  final bool isClientMode;
  final Seller? seller;
  final Client? client;

  const InfoPage({
    Key? key,
    required this.isClientMode,
    this.seller,
    this.client,
  }) : super(key: key);

  @override
  ConsumerState createState() => _InfoCompanyPageState();
}

class _InfoCompanyPageState extends ConsumerState<InfoPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneOrDescriptionController;
  late final TextEditingController _cardNumberController;
  late final TextEditingController _cardNameController;
  late final TextEditingController _cardDateController;
  late final TextEditingController _cardRCVController;
  File? image;
  PayCard? card;
  bool isAnon = true;

  Future<void> _selectImage() async {
    var pickedImage = await pickImage(context);
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  Future<void> _addEmptyImage() async {
    var emptyAvatar = await getImageFileFromAssets(AppImage.emptyAvatar);
    setState(() {
      image = emptyAvatar;
    });
  }

  void _saveCompany() {
    if (_nameController.text.isEmpty) {
      showSnakeBar(context, S.of(context).enter_name_company);
    } else if (_phoneOrDescriptionController.text.isEmpty) {
      showSnakeBar(context, S.of(context).enter_description_company);
    } else if (image == null) {
      showSnakeBar(context, S.of(context).add_pic_company);
    } else {
      if (isAnon) {
      } else {}
      ref.read(sellerSettingRepository).changeCompany(
            context: context,
            name: _nameController.text,
            description: _phoneOrDescriptionController.text,
            photo: image!,
          );
    }
  }

  void _saveUser() async {
    if (_nameController.text.isEmpty) {
      showSnakeBar(context, S.of(context).how_call_you);
    } else if (_phoneOrDescriptionController.text.isEmpty) {
      showSnakeBar(context, S.of(context).enter_phone_number);
    } else if (card == null) {
      showSnakeBar(context, S.of(context).add_card);
    } else {
      if (isAnon) {
        ref.read(authRepository).signClient(
            context: context, phoneNumber: _phoneOrDescriptionController.text);
      } else {
        ref.read(clientSettingRepository).changeUser(
              context: context,
              name: _nameController.text,
              phone: _phoneOrDescriptionController.text,
              card: card!,
              photo: image!,
            );
      }
    }
  }

  void saveCard() {
    if (_cardNumberController.text.isEmpty) {
      showSnakeBar(context, S.of(context).enter_num_card);
    } else if (_cardNameController.text.isEmpty) {
      showSnakeBar(context, S.of(context).enter_name_card);
    } else if (_cardNameController.text.isEmpty) {
      showSnakeBar(context, S.of(context).enter_date_card);
    } else if (_cardNameController.text.isEmpty) {
      showSnakeBar(context, S.of(context).enter_rcv_card);
    } else {
      card = PayCard(
        number: _cardNumberController.text,
        userName: _cardNameController.text,
        date: _cardDateController.text,
        rcv: _cardRCVController.text,
      );
      showSnakeBar(context, S.of(context).card_saved);
    }
  }

  void _userAnon() {
    setState(() {
      isAnon = ref.read(authRepository).isUserAnonymous();
    });
  }

  @override
  void initState() {
    super.initState();
    _userAnon();
    _nameController = TextEditingController();
    _phoneOrDescriptionController = TextEditingController();
    _cardNumberController = TextEditingController();
    _cardNameController = TextEditingController();
    _cardDateController = TextEditingController();
    _cardRCVController = TextEditingController();
    if (widget.seller != null) {
      _nameController.text = widget.seller!.name;
      _phoneOrDescriptionController.text = widget.seller!.description;
    }
    if (widget.client != null) {
      _nameController.text = widget.client!.name;
      _phoneOrDescriptionController.text = widget.client!.phone;
      card = widget.client!.card;
      _cardNumberController.text = widget.client!.card.number;
      _cardNameController.text = widget.client!.card.userName;
      _cardDateController.text = widget.client!.card.date;
      _cardRCVController.text = widget.client!.card.rcv;
    }
    if (widget.client == null && widget.seller == null) {
      _addEmptyImage();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneOrDescriptionController.dispose();
    _cardNumberController.dispose();
    _cardNameController.dispose();
    _cardDateController.dispose();
    _cardRCVController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackArrowWidget(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: disableIndicator(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  widget.isClientMode
                      ? S.of(context).editing_user_information
                      : S.of(context).editing_store_information,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
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
                          : widget.seller != null
                              ? Image.network(
                                  widget.seller!.photo,
                                  fit: BoxFit.cover,
                                )
                              : widget.client != null
                                  ? Image.network(
                                      widget.client!.photo,
                                      fit: BoxFit.cover,
                                    )
                                  : const SizedBox(),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: _addEmptyImage,
                          icon: const Icon(
                            Icons.delete,
                            size: 45,
                            color: primaryButtonColor,
                          ),
                        ),
                        const SizedBox(height: 50),
                        IconButton(
                          onPressed: _selectImage,
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
                  hintText: widget.isClientMode
                      ? S.of(context).how_call_you
                      : S.of(context).enter_name_company,
                  controller: _nameController,
                ),
                const SizedBox(height: 14),
                widget.isClientMode
                    ? InputFieldWidget(
                        hintText: S.of(context).enter_phone_number,
                        controller: _phoneOrDescriptionController,
                        isPhoneField: true,
                        keyboardType: TextInputType.phone,
                      )
                    : InputFieldWidget(
                        hintText: S.of(context).enter_description_company,
                        controller: _phoneOrDescriptionController,
                        isDescription: true,
                      ),
                const SizedBox(height: 24),
                widget.isClientMode
                    ? ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ClientCardPage(
                                cardNumberController: _cardNumberController,
                                cardNameController: _cardNameController,
                                cardDateController: _cardDateController,
                                cardRCVController: _cardRCVController,
                                saveCard: saveCard,
                              ),
                            ),
                          );
                        },
                        child: SizedBox(
                          width: 100,
                          child: Text(
                            S.of(context).add_card_for_payment,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : const SizedBox(),
                widget.isClientMode
                    ? const SizedBox(height: 24)
                    : const SizedBox(),
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
                      onPressed: widget.isClientMode ? _saveUser : _saveCompany,
                      child: SizedBox(
                        width: 100,
                        child: Text(
                          isAnon
                              ? S.of(context).confirm_phone_num
                              : S.of(context).change,
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
      ),
    );
  }
}
