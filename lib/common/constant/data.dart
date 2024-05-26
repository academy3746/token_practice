import 'dart:io';

const accessTokenKey = 'ACCESS_TOKEN';

const refreshTokenKey = 'REFRESH_TOKEN';

const androidIp = '10.0.2.2:3000';

const iosIp = '127.0.0.1:3000';

final ip = Platform.isAndroid ? androidIp : iosIp;