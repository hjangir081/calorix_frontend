import 'package:calorix_app/utils/design/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/constants/countries.dart';
import '../../../utils/design/app_colors.dart';
import '../../../utils/design/app_radius.dart';
import '../../provider/phone_provider.dart';

class PhoneInputField extends ConsumerWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final String? labelText;
  final String? hintText;
  final bool enabled;

  const PhoneInputField({
    super.key,
    this.controller,
    this.validator,
    this.onChanged,
    this.labelText = 'Phone Number',
    this.hintText = 'Enter phone number',
    this.enabled = true,
  });

  void _showCountryPicker(BuildContext context, WidgetRef ref) {
    final selectedCountry = ref.read(phoneProvider);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return SafeArea(
              child: Column(
                children: [
                  // 🔹 Header
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Text(
                          "Select Country",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        )
                      ],
                    ),
                  ),

                  const Divider(height: 1, color: AppColors.divider,),

                  Expanded(
                    child: ListView.builder(
                      controller: scrollController, // 🔥 IMPORTANT
                      itemCount: countries.length,
                      itemBuilder: (context, index) {
                        final country = countries[index];
                        final isSelected =
                            country.code == selectedCountry.code;

                        return ListTile(
                          leading: Text(
                            country.flag ?? '',
                            style: const TextStyle(fontSize: 22),
                          ),
                          title: Text(country.name),
                          trailing: Text(
                            country.dialCode,
                            style: TextStyle(
                              fontWeight:
                              isSelected ? FontWeight.bold : null,
                            ),
                          ),
                          selected: isSelected,
                          onTap: () {
                            ref
                                .read(phoneProvider.notifier)
                                .updateCountry(country);
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCountry = ref.watch(phoneProvider);

    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      enabled: enabled,
      cursorColor: AppColors.white,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(selectedCountry.maxLength),
      ],
      decoration: InputDecoration(
        hintText: hintText,
        labelStyle: AppQuicksandText.bodyLarge(context).copyWith(fontWeight: FontWeight.w500),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg(context)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg(context)),
          borderSide: BorderSide(color: AppColors.textSecondary),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg(context)),
          borderSide: BorderSide(
            color: AppColors.primaryColor,
            width: 1.5,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg(context)),
          borderSide: const BorderSide(color: Colors.red),
        ),

        prefixIcon: InkWell(
          onTap: enabled ? () => _showCountryPicker(context, ref) : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  selectedCountry.flag ?? '',
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(width: 8),
                Text(
                  selectedCountry.dialCode,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
/// Country code data model
class CountryCode {
  final String code;
  final String name;
  final String dialCode;
  final String? flag;
  final int minLength;
  final int maxLength;

  const CountryCode({
    required this.code,
    required this.name,
    required this.dialCode,
    this.flag,
    required this.minLength,
    required this.maxLength,
  });

  /// Get full phone number with country code
  String getFullNumber(String phoneNumber) {
    return '$dialCode$phoneNumber';
  }
}

