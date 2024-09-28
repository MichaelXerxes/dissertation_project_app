import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dissertation_project_app/core/main_utils/constants.dart';
import 'package:dissertation_project_app/core/main_utils/error_handling.dart';

class InternetConnectionChecker {
  static Future<bool> isInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    final hasConnection = connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile;

    if (!hasConnection) return false;

    try {
      final networkStatus =
          await InternetAddress.lookup(Constants.CHECK_NETWORK_STATUS_URL)
              .timeout(const Duration(
                  seconds: Constants.CHECK_NETWORK_STATUS_TIMEOUT_IN_SECONDS));
      return networkStatus.isNotEmpty && networkStatus[0].rawAddress.isNotEmpty;
    } on SocketException catch (e, stacktrace) {
      ErrorHandler.showLog(e, stacktrace);
      return false;
    } on TimeoutException catch (e, stacktrace) {
      ErrorHandler.showLog(e, stacktrace);
      return false;
    }
  }

  static Future<bool> isNotInternetConnection() async {
    return !await isInternetConnection();
  }
}
