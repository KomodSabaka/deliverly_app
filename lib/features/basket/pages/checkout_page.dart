import 'package:deliverly_app/common/widgets/input_field_widget.dart';
import 'package:deliverly_app/features/basket/repository/checkout_repository.dart';
import 'package:deliverly_app/features/basket/widgets/input_field_with_button.dart';
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

  void _selectTime() async {
    var time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) _timeController.text = time.format(context);
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
    }
  }

  void _selectAddress() {
    ref.read(checkoutRepositoryProvider).selectAddress(
          context: context,
          addressController: _addressController,
        );
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: size.width * 0.45,
                  child: InputFieldWidget(
                    controller: _entranceController,
                    hintText: 'Enter entrance',
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.45,
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
                    onPressed: () {},
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
