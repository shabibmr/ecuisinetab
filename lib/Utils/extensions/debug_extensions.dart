extension MapExtenson on Map {
  void printTypes() {
    forEach((key, value) {
      print('$key is ${value.runtimeType}');
    });
  }
}
