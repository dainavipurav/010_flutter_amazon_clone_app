part of 'utils.dart';

final firebaseAuth = FirebaseAuth.instance;
final firebaseStorage = FirebaseStorage.instance;
final firebaseFirestore = FirebaseFirestore.instance;

/// Show snackbar
/// content will be the message shown to the user
void showSnackbar(BuildContext context, {required String content}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

/// Store user credentials to firebase firestore database
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

/// Data to be fetched from realtime database
/// pass file name from firebase realtime database
Future<String?> getDataByFileNameFromRealtimeDatabase(BuildContext context,
    {required String dbFileName}) async {
  try {
    final uri = Uri.https(
      firebaseDbRef,
      '$dbCollectionName/$dbFileName',
    );
    final response = await http.get(uri);

    if (response.statusCode >= 400) {
      showSnackbar(
        context,
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
      context,
      content: loadDataError,
    );
    return null;
  }
}

/// To get all products list from the app
Future<List<Product>> getAllProducts(BuildContext context) async {
  String productData = await getDataByFileNameFromRealtimeDatabase(
        context,
        dbFileName: productsFileName,
      ) ??
      '[]';

  final List<dynamic> listData = json.decode(productData);

  List<Product> products = [];

  for (final item in listData) {
    products.add(
      Product.fromJson(item),
    );
  }
  return products;
}

/// To get list of favorite product ids
Future<List<int>> getFavoriteProductIdList() async {
  final currentUser = firebaseAuth.currentUser;
  final documentRef = firebaseFirestore
      .collection(favoriteProductsCollectionKey)
      .doc(currentUser!.uid);
  final favoriteListMap = await documentRef.get();
  if (favoriteListMap.data() == null ||
      favoriteListMap.data()![favoriteListDocumentKey] == null) {
    return [];
  }

  return favoriteListMap.data()![favoriteListDocumentKey].cast<int>();
}

Future<Map<String, dynamic>> getCartProductListMap() async {
  final currentUser = firebaseAuth.currentUser;
  final documentRef = firebaseFirestore
      .collection(cartProductsCollectionKey)
      .doc(currentUser!.uid);
  final cartListMap = await documentRef.get();
  if (cartListMap.data() == null ||
      cartListMap.data()![cartListDocumentKey] == null) {
    return {};
  }

  print(cartListMap.data()![cartListDocumentKey]);

  return cartListMap.data()![cartListDocumentKey];
}

/// Add to favorite
Future<void> toggleFavorite(BuildContext context,
    {required int prductId}) async {
  try {
    final currentUser = firebaseAuth.currentUser;
    final documentRef = firebaseFirestore
        .collection(favoriteProductsCollectionKey)
        .doc(currentUser!.uid);

    final favoriteListMap = await documentRef.get();

    print('${favoriteListMap.data()}, ${favoriteListMap.data().runtimeType}');

    if (favoriteListMap.data() == null ||
        favoriteListMap.data()![favoriteListDocumentKey] == null) {
      await documentRef.set({
        favoriteListDocumentKey: [prductId],
      });
      showSnackbar(
        context,
        content: addedToFavorite,
      );
      return;
    }

    final favList = favoriteListMap.data()![favoriteListDocumentKey];
    if (favList.contains(prductId)) {
      favList.remove(prductId);
      await documentRef.set({
        favoriteListDocumentKey: favList,
      });
      showSnackbar(
        context,
        content: removedFromFavorite,
      );
      return;
    }
    favList.add(prductId);
    await documentRef.set({
      favoriteListDocumentKey: favList,
    });
    showSnackbar(
      context,
      content: addedToFavorite,
    );
  } on FirebaseException catch (e) {
    showSnackbar(
      context,
      content: e.message ?? errorOcurred,
    );
  }
}

Future<void> updateProductQuantityInCartList(
  BuildContext context, {
  required int productId,
  int quantity = 1,
  QuantityAction action = QuantityAction.increase,
}) async {
  try {
    final currentUser = firebaseAuth.currentUser;
    final documentRef = firebaseFirestore
        .collection(cartProductsCollectionKey)
        .doc(currentUser!.uid);

    final documentRefData = await documentRef.get();

    print('${documentRefData.data()}, ${documentRefData.data().runtimeType}');

    if (documentRefData.data() == null ||
        documentRefData.data()![cartListDocumentKey] == null) {
      await documentRef.set({
        cartListDocumentKey: {productId.toString(): quantity},
      });

      showSnackbar(
        context,
        content: addedToCart,
      );

      return;
    }

    final cartListMap = documentRefData.data()![cartListDocumentKey];
    final productQuantityInCart = cartListMap[productId.toString()] ?? 0;

    if (productQuantityInCart > 0 && action == QuantityAction.remove) {
      cartListMap.remove(productId.toString());
      await documentRef.set({
        cartListDocumentKey: cartListMap,
      });
      showSnackbar(
        context,
        content: removedFromCart,
      );
      return;
    }

    if (productQuantityInCart > 0 && action == QuantityAction.decrease) {
      if (productQuantityInCart == 1) {
        cartListMap.remove(productId.toString());
        await documentRef.set({
          cartListDocumentKey: cartListMap,
        });
        showSnackbar(
          context,
          content: removedFromCart,
        );
        return;
      } else {
        cartListMap[productId.toString()] = productQuantityInCart - 1;
        showSnackbar(
          context,
          content: quantityUpdated,
        );
        await documentRef.set({
          cartListDocumentKey: cartListMap,
        });
        return;
      }
    }

    if (action == QuantityAction.increase) {
      cartListMap[productId.toString()] = productQuantityInCart + 1;
      await documentRef.set({
        cartListDocumentKey: cartListMap,
      });

      showSnackbar(
        context,
        content: quantityUpdated,
      );
      return;
    }

    if (action == QuantityAction.add) {
      cartListMap[productId.toString()] = productQuantityInCart + quantity;
      await documentRef.set({
        cartListDocumentKey: cartListMap,
      });
      showSnackbar(
        context,
        content: addedToCart,
      );

      return;
    }
  } on FirebaseException catch (e) {
    showSnackbar(
      context,
      content: e.message ?? errorOcurred,
    );
  }
}

String generateRandomKey(Map<String, dynamic> map) {
  const int keyLength = 8;
  const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  Random random = Random();

  while (true) {
    String randomKey = String.fromCharCodes(Iterable.generate(
      keyLength,
      (_) => chars.codeUnitAt(random.nextInt(chars.length)),
    ));

    if (!map.containsKey(randomKey)) {
      return randomKey;
    }
  }
}
