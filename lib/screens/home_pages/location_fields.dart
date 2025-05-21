import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/utility/location_provider.dart';
import '../../utils/validations.dart';
import '../../widgets/custom_dropdown_field.dart';

class LocationFields extends StatelessWidget {
  final TextEditingController addressController;

  const LocationFields({required this.addressController, super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(
      builder: (context, locationProvider, child) {
        return Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: double.infinity,
              child: CustomDropdownField(
                label: "Region",
                validator: (value) => Validator.validateAddress(value, context),
                items: locationProvider.regionData.data
                    .map((region) => {
                          "text": region.name,
                          "value": region.uniqueId,
                        })
                    .toList(),
                onChanged: (value) {
                  locationProvider.clearAllSelections();
                  String regionId = value.toString();
                  addressController.text = regionId.toString();
                  locationProvider.getDistrict(regionUniqueId: regionId);
                },
              ),
            ),
            if (locationProvider.districtData.data.isNotEmpty)
              SizedBox(
                width: double.infinity,
                child: CustomDropdownField(
                  label: "District",
                  validator: (value) =>
                      Validator.validateAddress(value, context),
                  items: locationProvider.districtData.data
                      .map((data) => {
                            "text": data.name,
                            "value": data.uniqueId.toString(),
                          })
                      .toList(),
                  onChanged: (value) {
                    locationProvider.clearWardData();
                    String districtId = value.toString();
                    locationProvider.getWards(districtUniqueId: districtId);
                  },
                ),
              ),
            if (locationProvider.districtData.data.isNotEmpty)
              if (locationProvider.wardData.data.isNotEmpty)
                SizedBox(
                  width: double.infinity,
                  child: CustomDropdownField(
                    label: "Ward",
                    validator: (value) =>
                        Validator.validateAddress(value, context),
                    items: locationProvider.wardData.data
                        .map((data) => {
                              "text": data.name,
                              "value": data.uniqueId.toString(),
                            })
                        .toList(),
                    onChanged: (value) {
                      locationProvider.enableSubmit();
                      addressController.text = value.toString();
                    },
                  ),
                ),
          ],
        );
      },
    );
  }
}
