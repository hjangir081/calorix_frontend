enum ProfileStatus {
  initial,
  loading,
  success,
  error,
}
const _sentinel = Object();
class ProfileState {
  final ProfileStatus status;

  final String firstName;
  final String lastName;
  final String email;
  final String age;
  final String? dob;
  final String? gender;
  final String? imagePath;
  final String? errorMessage;
  final String? firstNameError;
  final String? lastNameError;
  final String? emailError;
  final String? dobError;
  final String? goal;
  final String? genderError;
  final String? weight;
  final String? height;
  final String? heightError;
  final String? weightError;
  final String? goalError;
  final String? dietType;
  final List<String> cuisines;
  final String? dietTypeError;
  final String? cuisinesError;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.firstName = '',
    this.dob,
    this.gender,
    this.goal,
    this.lastName = '',
    this.email = '',
    this.age = '',
    this.imagePath,
    this.dietType,
    this.cuisines = const [],
    this.dietTypeError,
    this.cuisinesError,
    this.errorMessage, this.firstNameError, this.lastNameError, this.emailError, this.dobError, this.genderError, this.weight, this.height, this.heightError, this.weightError, this.goalError
  });

  ProfileState copyWith({
    ProfileStatus? status,
    String? firstName,
    String? dob,
    String? lastName,
    String? email,
    String? age,
    String? goal,
    String? gender,
    String? imagePath,
    String? errorMessage,
    Object? firstNameError = _sentinel,
    Object? lastNameError = _sentinel,
    Object? emailError = _sentinel,
    Object? dobError = _sentinel,
    Object? genderError = _sentinel,
    String? weight,
    String? height,
    String? heightError,
    String? weightError,
    String? goalError,
    String? dietType,
    List<String>? cuisines,
    String? dietTypeError,
    String? cuisinesError,
  }) {
    return ProfileState(
      status: status ?? this.status,
      dob: dob ?? this.dob,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      goal: goal ?? this.goal,
      imagePath: imagePath ?? this.imagePath,
      errorMessage: errorMessage,
      firstNameError: firstNameError == _sentinel ? this.firstNameError : firstNameError as String?,
      lastNameError: lastNameError == _sentinel ? this.lastNameError : lastNameError as String?,
      emailError: emailError == _sentinel ? this.emailError : emailError as String?,
      dobError: dobError == _sentinel ? this.dobError : dobError as String?,
      genderError: genderError == _sentinel ? this.genderError : genderError as String?,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      heightError: heightError ?? this.heightError,
      weightError: weightError ?? this.weightError,
      goalError: goalError ?? this.goalError,
      dietType: dietType ?? this.dietType,
      cuisines: cuisines ?? this.cuisines,
      dietTypeError: dietTypeError ?? this.dietTypeError,
      cuisinesError: cuisinesError ?? this.cuisinesError,
    );
  }
}