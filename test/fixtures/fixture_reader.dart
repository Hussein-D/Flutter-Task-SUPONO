import 'dart:io';

String fixtureRead(String fileName) {
  return File('test/fixtures/$fileName').readAsStringSync();
}
