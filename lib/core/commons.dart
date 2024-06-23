part of 'utils.dart';

final firebaseAuth = FirebaseAuth.instance;
final firebaseStorage = FirebaseStorage.instance;
final firebaseFirestore = FirebaseFirestore.instance;

void showSnackbar(BuildContext context, {required String content}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

Future<void> storUserDetailsTofirestore({
  required String password,
  required String userName,
}) async {
  await firebaseFirestore
      .collection(userCollectionKey)
      .doc(firebaseAuth.currentUser!.uid)
      .set({
    userIdKey: firebaseAuth.currentUser!.uid,
    usernameKey: userName,
    userEmailKey: firebaseAuth.currentUser!.email,
    userPasswordKey: password,
  });
}

Future<String?> getDataByKeyFromRealtimeDatabase(String dbFileName) async {
  try {
    final uri = Uri.https(
      firebaseDbRef,
      '$dbCollectionName/$dbFileName',
    );
    final response = await http.get(uri);

    if (response.statusCode >= 400) {
      showSnackbar(
        Get.context!,
        content: loadDataError,
      );
    }

    if (response.body == 'null') {
      return null;
    }
    print(response.body);

    return response.body;
  } catch (error) {
    print(error);
    showSnackbar(
      Get.context!,
      content: loadDataError,
    );
    return null;
  }
}
