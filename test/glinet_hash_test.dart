import 'package:flutter_test/flutter_test.dart';

import 'package:adguard_home_manager/services/glinet_auth.dart';

void main() {
  const cipher = r'$1$shGzEq91$.TLXit4pO5gGOdru0MYHz.';
  const nonce = 'SGgyhFWf3lFrIpX2BFImBjE1gv2AKPC2';

  test('uses md5 when older firmware omits hash-method', () {
    expect(
      glinetLoginHash(username: 'root', cipher: cipher, nonce: nonce),
      '6e5fd33bbd77a67eb108cf0b8bbdb9be',
    );
  });

  test('uses sha256 when firmware 4.10 sends hash-method', () {
    expect(
      glinetLoginHash(
        username: 'root',
        cipher: cipher,
        nonce: nonce,
        hashMethod: 'sha256',
      ),
      'b92b060f495b5e2681d0e5266e2ce6249427d41f8452c44018ca1fe228f8ab30',
    );
  });
}
