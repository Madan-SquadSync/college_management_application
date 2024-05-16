import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class PhoneCall {
  Future<bool> call(String phoneNumber) async {
    bool? res = await FlutterPhoneDirectCaller.callNumber(phoneNumber);
    return res!;
  }
}
