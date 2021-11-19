enum FirebaseTable {
  USER,
}

extension SelectedColorExtension on FirebaseTable {

  String get name {
    switch (this) {
      case FirebaseTable.USER:
        return 'users';
      // case FirebaseTable.USER:
      //   return 'This is the Secondary Color';
      // default:
      //   return 'SelectedScheme Title is null';
    }
  }
}
