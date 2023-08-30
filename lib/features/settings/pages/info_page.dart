import 'dart:io';
import 'package:deliverly_app/common/app_settings/app_settings.dart';
import 'package:deliverly_app/common/enums/mode_enum.dart';
import 'package:deliverly_app/common/navigation/routes.dart';
import 'package:deliverly_app/features/auth/controller/auth_controller.dart';
import 'package:deliverly_app/features/settings/controllers/client_settings_controller.dart';
import 'package:deliverly_app/features/settings/controllers/seller_settings_controller.dart';
import 'package:deliverly_app/models/pay_card.dart';
import 'package:deliverly_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/utils/constants.dart';
import '../../../common/utils/utils.dart';
import '../../../common/widgets/back_arrow_widget.dart';
import '../../../common/widgets/input_field_widget.dart';
import '../../../generated/l10n.dart';

class InfoPage extends ConsumerStatefulWidget {
  const InfoPage({
    Key? key,
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

  void _saveCompany() async {
    if (_nameController.text.isEmpty) {
      showSnakeBar(context, S.of(context).enter_name_company);
    } else if (_phoneOrDescriptionController.text.isEmpty) {
      showSnakeBar(context, S.of(context).enter_description_company);
    } else if (image == null && ref.watch(appSettingsProvider).user == null) {
      showSnakeBar(context, S.of(context).add_pic_company);
    } else {
      await ref.read(sellerSettingsController).changeCompany(
            name: _nameController.text,
            description: _phoneOrDescriptionController.text,
            photo: image!,
          );
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.storeLayout,
        (route) => false,
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
        ref.read(authController).signUp(
              context: context,
              phoneNumber: _phoneOrDescriptionController.text,
              mode: ModeEnum.client,
            );
      } else {
        await ref.read(clientSettingsController).changeUser(
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
      isAnon = ref.read(authController).isUserAnonymous();
    });
  }

  @override
  void didChangeDependencies() {
    var user = ref.watch(appSettingsProvider).user;
    if (user != null && user is Seller) {
      _nameController.text = user.name;
      _phoneOrDescriptionController.text = user.description;
    }
    if (user != null && user is Client) {
      _nameController.text = user.name;
      _phoneOrDescriptionController.text = user.phone;
      card = user.card;
      _cardNumberController.text = user.card.number;
      _cardNameController.text = user.card.userName;
      _cardDateController.text = user.card.date;
      _cardRCVController.text = user.card.rcv;
    }
    super.didChangeDependencies();
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
    var isClientMode = ref.watch(appSettingsProvider.notifier).isClientMode;
    var user = ref.watch(appSettingsProvider).user;
    return Scaffold(
      appBar: AppBar(
        leading: BackArrowWidget(
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: disableIndicator(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  isClientMode
                      ? S.of(context).editing_user_information
                      : S.of(context).editing_store_information,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                isClientMode
                    ? const SizedBox()
                    : Stack(
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
                                : user != null && user is Seller
                                    ? Image.network(
                                        user.photo!,
                                        fit: BoxFit.cover,
                                      )
                                    : const SizedBox(),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () => setState(() => image = null),
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
                  hintText: isClientMode
                      ? S.of(context).how_call_you
                      : S.of(context).enter_name_company,
                  controller: _nameController,
                ),
                const SizedBox(height: 14),
                isClientMode
                    ? InputFieldWidget(
                        hintText: S.of(context).enter_phone_number,
                        controller: _phoneOrDescriptionController,
                        maxLength: 16,
                        keyboardType: TextInputType.phone,
                        onChanged: (value) => phoneNumberFormat(
                          value: value,
                          controller: _phoneOrDescriptionController,
                        ),
                      )
                    : InputFieldWidget(
                        hintText: S.of(context).enter_description_company,
                        controller: _phoneOrDescriptionController,
                        maxLine: null,
                      ),
                const SizedBox(height: 24),
                isClientMode
                    ? ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.clientCardPage,
                            arguments: {
                              'cardNumberController': _cardNumberController,
                              'cardNameController': _cardNameController,
                              'cardDateController': _cardDateController,
                              'cardRCVController': _cardRCVController,
                              'saveCard': saveCard,
                            },
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
                isClientMode ? const SizedBox(height: 24) : const SizedBox(),
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
                      onPressed: isClientMode ? _saveUser : _saveCompany,
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
