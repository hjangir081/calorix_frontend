import 'package:calorix_app/utils/constants/countries.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../auth/widgets/phone_input_field.dart';

final phoneProvider =
StateNotifierProvider<PhoneNotifier, CountryCode>((ref) {
  return PhoneNotifier();
});

class PhoneNotifier extends StateNotifier<CountryCode> {
  PhoneNotifier()
      : super(
    countries.firstWhere(
          (c) => c.code == 'IN',
      orElse: () => countries.first,
    ),
  );

  void updateCountry(CountryCode country) {
    state = country;
  }
}