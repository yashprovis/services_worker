import 'package:flutter/material.dart';

// const String firstNamePref = "FIRST_NAME";
// const String lastNamePref = "LAST_NAME";
// const String emailPref = "EMAIL";

// const String streetAddressPref = "STREET_ADDRESS";
// const String cityPref = "CITY";
// const String countryPref = "COUNTRY";

const Color primaryColor = Color(0xFF495C83);
const Color primaryLight = Color(0xFF7A86B6);
const Color secondaryColor = Color(0xFFA8A4CE);
const Color secondaryLight = Color(0xFFC8B6E2);

LinearGradient appGradient = LinearGradient(
    colors: [primaryLight, primaryLight.withOpacity(.5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight);

InputBorder border = OutlineInputBorder(
  borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
  borderRadius: BorderRadius.circular(0),
);
InputBorder errorBorder = OutlineInputBorder(
  borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
  borderRadius: BorderRadius.circular(0),
);
