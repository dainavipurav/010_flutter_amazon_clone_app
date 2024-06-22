part of 'utils.dart';

final defaultBox = GetStorage();
final userDetailsBox = GetStorage('user_details');

Future<void> eraseAllBoxes() async {
  await defaultBox.erase();
  await userDetailsBox.erase();
}

Future<void> initializeAllBoxes() async {
  await GetStorage.init();
  await GetStorage.init('user_details');
}

Future<void> saveUserDetails(
    {required UserCredential userCrdentials,
    required String userPassword}) async {
  await userDetailsBox.write(userIdKey, userCrdentials.user!.uid);
  await userDetailsBox.write(usernameKey, userCrdentials.user!.displayName);
  await userDetailsBox.write(userEmailKey, userCrdentials.user!.email);
  await userDetailsBox.write(userPasswordKey, userPassword);
}

Future<void> setLoginKey(bool value) async {
  await userDetailsBox.write(isLoggedInKey, value);
}

String get getUserId {
  final userId = userDetailsBox.read(userIdKey) ?? '';
  return userId;
}

bool get getLoginFlagValue {
  final isLoggedIn = userDetailsBox.read(isLoggedInKey) ?? false;
  return isLoggedIn;
}
