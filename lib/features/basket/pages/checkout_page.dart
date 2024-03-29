import 'package:deliverly_app/common/app_settings/app_settings.dart';
import 'package:deliverly_app/common/widgets/input_field_widget.dart';
import 'package:deliverly_app/features/basket/repository/checkout_repository.dart';
import 'package:deliverly_app/features/basket/widgets/input_field_with_button.dart';
import 'package:deliverly_app/models/address.dart';
import 'package:deliverly_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../common/widgets/back_arrow_widget.dart';
import '../../../generated/l10n.dart';

class CheckoutPage extends ConsumerStatefulWidget {
  const CheckoutPage({super.key});

  @override
  ConsumerState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends ConsumerState<CheckoutPage> {
  late TextEditingController _dateController;
  late TextEditingController _timeController;
  late TextEditingController _addressController;
  late TextEditingController _entranceController;
  late TextEditingController _apartmentController;
  DateTime? deliveryDate;

  void _selectTime() async {
    var time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      _timeController.text = time.format(context);
    }
  }

  void _selectDate() async {
    var date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      _dateController.text = DateFormat('dd-MM-yyyy').format(date);
      setState(() {
        deliveryDate = date;
      });
    }
  }

  void _selectAddress() {
    ref.read(checkoutRepositoryProvider).selectAddress(
          context: context,
          addressController: _addressController,
        );
  }

  void _buyProducts() {
    ref.read(checkoutRepositoryProvider).buyProducts(
        deliveryDate: deliveryDate!,
        deliveryTime: _timeController.text,
        address: Address(
          street: _addressController.text,
          entrance: _entranceController.text,
          apartment: _apartmentController.text,
        ));
    Navigator.of(context).pop();
  }

  void initAddress() {
    var user = ref.watch(appSettingsProvider).user as Client;
    if(user.address != null) {
      _addressController.text = user.address!.street;
      _entranceController.text = user.address!.entrance;
      _apartmentController.text = user.address!.apartment;
    }
  }


  @override
  void didChangeDependencies() {
    initAddress();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _dateController = TextEditingController();
    _timeController = TextEditingController();
    _addressController = TextEditingController();
    _entranceController = TextEditingController();
    _apartmentController = TextEditingController();
    super.initState();
  }

  // @override
  // void dispose() {
  //   _dateController.dispose();
  //   _entranceController.dispose();
  //   _addressController.dispose();
  //   _entranceController.dispose();
  //   _apartmentController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: BackArrowWidget(
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputFieldWithButton(
              controller: _dateController,
              onPressed: _selectDate,
              buttonText: 'Select date',
            ),
            const SizedBox(height: 16),
            InputFieldWithButton(
              controller: _timeController,
              onPressed: _selectTime,
              buttonText: 'Select time',
            ),
            const SizedBox(height: 16),
            InputFieldWithButton(
              controller: _addressController,
              onPressed: _selectAddress,
              buttonText: 'Select address',
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: size.width * 0.35,
                  child: InputFieldWidget(
                    controller: _entranceController,
                    hintText: 'Enter entrance',
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.35,
                  child: InputFieldWidget(
                    controller: _apartmentController,
                    hintText: 'Enter apartment',
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: SizedBox.fromSize(
                  size: Size(size.width * 0.9, size.height * 0.07),
                  child: ElevatedButton(
                    onPressed: _buyProducts,
                    child: Text(S.of(context).pay),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
