import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';

import '../../providers/utility/location_provider.dart';
import '../../utils/validations.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'location_fields.dart';

class FarmRegistrationPage extends StatefulWidget {
  const FarmRegistrationPage({super.key});

  @override
  State<FarmRegistrationPage> createState() => _FarmRegistrationPageState();
}

class _FarmRegistrationPageState extends State<FarmRegistrationPage> {
  final addressController = TextEditingController();

  final nameController = TextEditingController();

  final coverageController = TextEditingController();

  final descriptionController = TextEditingController();

  final imagePickedController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fetchRegions();
  }

  void fetchRegions() {
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      locationProvider.clearAllSelections();
      await locationProvider.getAllRegions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: HeroIcon(
              HeroIcons.arrowLeft,
              color: Colors.white,
            )),
        backgroundColor: Colors.green,
        title: Text(
          "Farm Registration",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 10,
              children: [
                CustomTextFormField(
                  label: "Name",
                  controller: nameController,
                  validator: (value) => Validator.validateName(value, context),
                ),
                CustomTextFormField(
                  label: "Coverage",
                  controller: coverageController,
                  validator: (value) =>
                      Validator.validateAddress(value, context),
                ),
                CustomTextFormField(
                  label: "Description",
                  controller: descriptionController,
                  validator: (value) =>
                      Validator.validateTextOrMessage(value, context),
                  maxLines: 3,
                ),
                LocationFields(addressController: addressController),
                CustomTextFormField(
                  label: "Farm Image",
                  isImagePicker: true,
                  controller: imagePickedController,
                  validator: (value) =>
                      Validator.validateAddress(value, context),
                ),
                Selector<LocationProvider, bool>(
                    selector: (p0, p1) => p1.isSubmitEnabled,
                    builder: (context, isSubmitEnabled, child) {
                      return SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: isSubmitEnabled
                              ? CustomButton(
                                  buttonText: "Register",
                                  onPressed: () {
                                    if (_formKey.currentState?.validate() ??
                                        false) {}
                                  })
                              : SizedBox.shrink());
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
