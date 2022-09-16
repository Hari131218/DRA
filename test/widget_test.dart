import 'package:dra_project/AppUtils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Counter', () {
    test('Email Validator', () {
      expect(AppUtils.validateEmail('madhi@gmail.com'), true);
      expect(AppUtils.validateEmail('madhi.gmail.com'), false);
      expect(AppUtils.validateEmail('@.com'), false);
    });

    test('validateProfile', () {
      expect(AppUtils.validateProfile('Madhi'), true);
      expect(AppUtils.validateProfile('123455667'), false);
    });

    test('validateProfilelastName', () {
      expect(AppUtils.validateProfilelastName('alagan'), true);
      expect(AppUtils.validateProfilelastName('789876'), false);
    });

    test('validateEmail', () {
      expect(AppUtils.validateEmail('madhi@gmail.com'), true);
      expect(AppUtils.validateEmail('madhi.gmail.com'), false);
      expect(AppUtils.validateEmail('@.com'), false);
    });

    test('validateProfilemobileNumber', () {
      expect(AppUtils.validateProfilemobileNumber('9876543219'), true);
      expect(
          AppUtils.validateProfilemobileNumber('9876543210900222222'), false);
    });

    test('validateProfilezipCode', () {
      expect(AppUtils.validateProfilezipCode('636001'), true);
      expect(AppUtils.validateProfilezipCode('oooooooooooooooooooo'), false);
    });

    test('validateProfilecity', () {
      expect(AppUtils.validateProfilecity('CHENNAI jggggggggggg'), true);
      expect(AppUtils.validateProfilecity('9999999999999999999999999999999'),
          false);
    });

    test('validateProfilestate', () {
      expect(AppUtils.validateProfilestate('TAMIL NADU'), true);
      expect(AppUtils.validateProfilestate('00000000000'), false);
    });

    test('forgotPassword', () {
      expect(AppUtils.forgotPassword('madhi@gmail.com'), true);
      expect(AppUtils.forgotPassword('madhi.gmail.com'), false);
      expect(AppUtils.forgotPassword('@.com'), false);
    });

    test('password', () {
      expect(AppUtils.password('madhi20@'), true);
      expect(AppUtils.password('%%%%%%%%%%%'), false);
    });

    test('otp', () {
      expect(AppUtils.otp('1235'), true);
      expect(AppUtils.otp('hoii'), false);
    });

    test('checkPassword', () {
      expect(AppUtils.checkPassword('madhi@20', 'madhi@20'), null);
      expect(AppUtils.checkPassword('madhi@20', 'madhi@0'),
          "Password must be same as above");
    });

    test('feet', () {
      expect(AppUtils.feet('1234'), true);
      expect(AppUtils.feet('12345678'), false);
    });
  });
}
