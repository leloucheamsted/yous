import 'package:equatable/equatable.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';

class SignUpWithEmailEntity extends Entity with EquatableMixin {
  const SignUpWithEmailEntity({
    required this.email,
    required this.countryCode,
    required this.giftCode,
    required this.createSubscription,
  });

  final String email;
  final String countryCode;
  final String? giftCode;
  final bool createSubscription;

  @override
  List<Object?> get props => [
        email,
        countryCode,
        giftCode,
        createSubscription,
      ];
}
