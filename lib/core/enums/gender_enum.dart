enum Gender { MALE, FEMALE, OTHER }

Gender fromIntToGenderEnum(int i) {
  switch (i) {
    case 1:
      return Gender.MALE;
    case 2:
      return Gender.FEMALE;
    default:
      return Gender.OTHER;
  }
}

String fromGenderEnumToString(Gender gender) {
  switch (gender) {
    case Gender.MALE:
      return "1";
    case Gender.FEMALE:
      return "2";
    default:
      return "3";
  }
}
