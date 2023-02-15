import 'dart:io';

import 'package:deliverly_app/auth/repository/auth_repository.dart';
import 'package:deliverly_app/common/settings/pages/user_card_page.dart';
import 'package:deliverly_app/common/settings/repositores/user_settings_repository.dart';
import 'package:deliverly_app/models/card_model.dart';
import 'package:deliverly_app/models/company_model.dart';
import 'package:deliverly_app/models/user_model.dart';
import 'package:deliverly_app/utils/widgets/input_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../generated/l10n.dart';
import '../../../utils/colors.dart';
import '../../../utils/utils.dart';
import '../repositores/seller_settings_repository.dart';

class InfoPage extends ConsumerStatefulWidget {
  final bool isUserMode;
  final CompanyModel? company;
  final UserModel? user;

  const InfoPage({
    Key? key,
    required this.isUserMode,
    this.company,
    this.user,
  }) : super(key: key);

  @override
  ConsumerState createState() => _InfoCompanyPageState();
}

class _InfoCompanyPageState extends ConsumerState<InfoPage> {
  late final TextEditingController _firstController;
  late final TextEditingController _secondController;
  late final TextEditingController _cardNumberController;
  late final TextEditingController _cardNameController;
  late final TextEditingController _cardDateController;
  late final TextEditingController _cardRCVController;
  File? image;
  CardModel? card;
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
    var emptyAvatar = await getImageFileFromAssets('empty_avatar.png');
    setState(() {
      image = emptyAvatar;
    });
  }

  void _saveCompany() {
    if (_firstController.text.isEmpty) {
      showSnakeBar(context, S.of(context).enter_name_company);
    } else if (_secondController.text.isEmpty) {
      showSnakeBar(context, S.of(context).enter_description_company);
    } else if (image == null) {
      showSnakeBar(context, S.of(context).add_pic_company);
    } else {
      if (isAnon) {
      } else {}
      ref.read(sellerSettingRepository).changeCompany(
            context: context,
            nameCompany: _firstController.text,
            descriptionCompany: _secondController.text,
            photo: image!,
          );
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
      card = CardModel(
        cardNumber: _cardNumberController.text,
        cardName: _cardNameController.text,
        cardDate: _cardDateController.text,
        cardRCV: _cardRCVController.text,
      );
      showSnakeBar(context, S.of(context).card_saved);
    }
  }

  void _saveUser() async {
    if (_firstController.text.isEmpty) {
      showSnakeBar(context, S.of(context).how_call_you);
    } else if (_secondController.text.isEmpty) {
      showSnakeBar(context, S.of(context).enter_phone_number);
    } else if (card == null) {
      showSnakeBar(context, S.of(context).add_card);
    } else {
      if (isAnon) {
        ref
            .read(authRepository)
            .signUser(context: context, phone: _secondController.text);
      } else {
        ref.read(userSettingRepository).changeUser(
              context: context,
              nameUser: _firstController.text,
              phoneUser: _secondController.text,
              card: card!,
              photo: image!,
              userData: widget.user,
            );
      }
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
    _firstController = TextEditingController();
    _secondController = TextEditingController();
    _cardNumberController = TextEditingController();
    _cardNameController = TextEditingController();
    _cardDateController = TextEditingController();
    _cardRCVController = TextEditingController();
    if (widget.company != null) {
      _firstController.text = widget.company!.nameCompany;
      _secondController.text = widget.company!.descriptionCompany;
    }
    if (widget.user != null) {
      _firstController.text = widget.user!.name;
      _secondController.text = widget.user!.phone;
      card = widget.user!.card;
      _cardNumberController.text = widget.user!.card.cardNumber;
      _cardNameController.text = widget.user!.card.cardName;
      _cardDateController.text = widget.user!.card.cardDate;
      _cardRCVController.text = widget.user!.card.cardRCV;
    }
    if(widget.user == null && widget.company == null) {
      _addEmptyImage();
    }
  }


  @override
  void dispose() {
    _firstController.dispose();
    _secondController.dispose();
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
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/arrow_back.svg'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: disableIndicator(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  widget.isUserMode
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
                          : widget.company != null
                              ? Image.network(
                                  widget.company!.photo,
                                  fit: BoxFit.cover,
                                )
                              : widget.user != null
                                  ? Image.network(
                                      widget.user!.urlPhoto,
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
                  hintText: widget.isUserMode
                      ? S.of(context).how_call_you
                      : S.of(context).enter_name_company,
                  controller: _firstController,
                ),
                const SizedBox(height: 14),
                widget.isUserMode
                    ? InputFieldWidget(
                        hintText: S.of(context).enter_phone_number,
                        controller: _secondController,
                        isPhoneField: true,
                        keyboardType: TextInputType.phone,
                      )
                    : InputFieldWidget(
                        hintText: S.of(context).enter_description_company,
                        controller: _secondController,
                        isDescription: true,
                      ),
                const SizedBox(height: 24),
                widget.isUserMode
                    ? ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserCardPage(
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
                widget.isUserMode
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
                      onPressed: widget.isUserMode ? _saveUser : _saveCompany,
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
