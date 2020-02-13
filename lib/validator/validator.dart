import 'package:flutter/widgets.dart' show FormFieldValidator;

FormFieldValidator<String> composeValidator(List<FormFieldValidator<String>> validators) {
  return (value) {
    for (final validator in validators) {
      final String result = validator(value);
      if (result != null) {
        return result;
      }
    }

    return null;
  };
}

FormFieldValidator<String> isEmpty() => (dynamic value) => value?.isEmpty == true ? 'Ce champs est obligatoire' : null;

FormFieldValidator<String> isEmail() => (String value) => RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value) == false ? 'Ce champs doit être un email' : null;