import 'dart:convert';
import 'dart:typed_data';

import 'package:crypt/crypt.dart';
import 'package:crypto/crypto.dart';

/// Unix crypt(3) hash for the algorithm number GL.iNet returns from `challenge`.
///
/// `1` is MD5-crypt (`$1$`), `5` is SHA-256-crypt (`$5$`), `6` is SHA-512-crypt
/// (`$6$`). SHA variants use the default 5000 rounds, which is what
/// `openssl passwd` and the router both use when the salt has no rounds field.
String unixCrypt(String password, int alg, String salt) {
  switch (alg) {
    case 1:
      return _md5Crypt(password, salt);
    case 5:
      return Crypt.sha256(password, salt: _trim(salt, 16)).toString();
    case 6:
      return Crypt.sha512(password, salt: _trim(salt, 16)).toString();
    default:
      throw UnsupportedError('Unsupported crypt algorithm $alg');
  }
}

String _trim(String salt, int max) {
  return salt.length <= max ? salt : salt.substring(0, max);
}

/// MD5-crypt, matching `openssl passwd -1`. Salt is at most 8 bytes.
String _md5Crypt(String password, String salt) {
  final pass = utf8.encode(password);
  final saltBytes = utf8.encode(_trim(salt, 8));
  final magic = utf8.encode(r'$1$');

  final ctx = BytesBuilder(copy: false)
    ..add(pass)
    ..add(magic)
    ..add(saltBytes);
  final alternate = md5.convert([...pass, ...saltBytes, ...pass]).bytes;
  for (var i = 0; i < pass.length; i++) {
    ctx.addByte(alternate[i % 16]);
  }
  for (var i = pass.length; i != 0; i >>= 1) {
    ctx.addByte(i.isOdd ? 0 : pass[0]);
  }
  var digest = md5.convert(ctx.toBytes()).bytes;

  for (var round = 0; round < 1000; round++) {
    final next = BytesBuilder(copy: false);
    if (round.isOdd) {
      next.add(pass);
    } else {
      next.add(digest);
    }
    if (round % 3 != 0) next.add(saltBytes);
    if (round % 7 != 0) next.add(pass);
    if (round.isOdd) {
      next.add(digest);
    } else {
      next.add(pass);
    }
    digest = md5.convert(next.toBytes()).bytes;
  }

  final encoded = StringBuffer()
    ..write(_to64((digest[0] << 16) | (digest[6] << 8) | digest[12], 4))
    ..write(_to64((digest[1] << 16) | (digest[7] << 8) | digest[13], 4))
    ..write(_to64((digest[2] << 16) | (digest[8] << 8) | digest[14], 4))
    ..write(_to64((digest[3] << 16) | (digest[9] << 8) | digest[15], 4))
    ..write(_to64((digest[4] << 16) | (digest[10] << 8) | digest[5], 4))
    ..write(_to64(digest[11], 2));
  return '\$1\$${_trim(salt, 8)}\$$encoded';
}

const _itoa64 = './0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';

String _to64(int value, int n) {
  final out = StringBuffer();
  var v = value;
  for (var i = 0; i < n; i++) {
    out.write(_itoa64[v & 0x3f]);
    v >>= 6;
  }
  return out.toString();
}
