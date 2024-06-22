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
