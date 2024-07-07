import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../core/enums.dart';
import '../../core/utils.dart';
import '../../widgets/bottom_gadient.dart';
import 'address_details_controller.dart';

class AddressDetails extends StatefulWidget {
  const AddressDetails({super.key});

  @override
  State<AddressDetails> createState() => _AddressDetailsState();
}

class _AddressDetailsState extends State<AddressDetails> {
  final xController = Get.put(AddressDetailsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(address),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                Form(
                  key: xController.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        sectionHeader(contactDetails),
                        const SizedBox(height: 10),
                        contactDetailsSection(),
                        const SizedBox(height: 40),
                        sectionHeader(address),
                        const SizedBox(height: 10),
                        addressSection(),
                        const SizedBox(height: 40),
                        sectionHeader(saveAddressAs),
                        const SizedBox(height: 10),
                        Row(
                          children: AddressType.values.map((element) {
                            return optionButton(element);
                          }).toList(),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
            const BottomGradient(
              height: 150,
            ),
            proceedToCheckout(context),
          ],
        ),
      ),
    );
  }

  Widget proceedToCheckout(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 50,
      child: ElevatedButton(
        onPressed: () => xController.validateFormAndCheckout(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.all(17),
        ),
        child: const Text(
          continueTxt,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget sectionHeader(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }

  Widget contactDetailsSection() {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: name,
          ),
          keyboardType: TextInputType.name,
          controller: xController.nameController,
          focusNode: xController.nameFocusNode,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return nameValidation;
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: const InputDecoration(
            labelText: mobile,
          ),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
          keyboardType: TextInputType.phone,
          controller: xController.mobileController,
          focusNode: xController.mobileFocusNode,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return mobileValidation;
            }
            if (value.length != 10) {
              return validMobileValidation;
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget addressSection() {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: pincode,
          ),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(6),
          ],
          keyboardType: TextInputType.number,
          controller: xController.pincodeController,
          focusNode: xController.pincodeFocusNode,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return pincodeValidation;
            }
            if (value.length != 6) {
              return validPincodeValidation;
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: const InputDecoration(
            labelText: addressLabel,
          ),
          controller: xController.addressController,
          focusNode: xController.addressFocusNode,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return addressValidation;
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: const InputDecoration(
            labelText: localityOrTown,
          ),
          controller: xController.localityController,
          focusNode: xController.localityFocusNode,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return localityValidation;
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: const InputDecoration(
            labelText: cityOrDistrict,
          ),
          controller: xController.cityController,
          focusNode: xController.cityFocusNode,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return cityValidation;
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: const InputDecoration(
            labelText: state,
          ),
          controller: xController.stateController,
          focusNode: xController.stateFocusNode,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return stateValidation;
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget optionButton(AddressType option) {
    return Obx(
      () {
        return Expanded(
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              xController.selectedAddressOption.value = option;
            },
            child: Card(
              color: xController.selectedAddressOption.value == option
                  ? Theme.of(context).colorScheme.primary
                  : null,
              borderOnForeground: true,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    option.name.capitalizeFirst ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: xController.selectedAddressOption.value == option
                          ? Colors.white
                          : null,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
