import 'package:flutter_test/flutter_test.dart';

import 'package:adguard_home_manager/functions/unix_crypt.dart';

void main() {
  test('matches openssl passwd for md5, sha256, and sha512 crypt', () {
    expect(
      unixCrypt('password', 1, 'abcd1234'),
      r'$1$abcd1234$Kx528z52Ohx1JLSzliZmw0',
    );
    expect(
      unixCrypt('password', 5, 'abcdefghijklmnop'),
      r'$5$abcdefghijklmnop$ieyonWfl7MR75BuN79Fkt2PqhPI43TsNZYGUObDGVI/',
    );
    expect(
      unixCrypt('password', 6, 'abcdefghijklmnop'),
      r'$6$abcdefghijklmnop$0aenUFHf897F9u0tURIHOeACWajSuVGa7jgJGyq.DKZm/WXl/IZFvPbneFydBjomEOgM.Sh1m0L3KsS1.H5b//',
    );
  });

  test('truncates an md5 salt to 8 characters', () {
    expect(
      unixCrypt('password', 1, 'abcd1234extra'),
      unixCrypt('password', 1, 'abcd1234'),
    );
  });

  test('rejects an unknown algorithm', () {
    expect(() => unixCrypt('password', 2, 'salt'), throwsUnsupportedError);
  });
}
