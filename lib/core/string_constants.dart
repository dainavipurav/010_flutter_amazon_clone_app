part of 'utils.dart';

const String firebaseDbRef = 'clone-7833c-default-rtdb.firebaseio.com';

const String userIdKey = 'user_id';
const String usernameKey = 'username';
const String userEmailKey = 'user_email';
const String userPasswordKey = 'user_password';

const String isLoggedInKey = 'is_logged_in';

const String userCollectionKey = 'users';
const String favoriteProductsCollectionKey = 'favorite_products';
const String favoriteListDocumentKey = 'favorite_list';
const String cartProductsCollectionKey = 'cart_products';
const String cartListDocumentKey = 'cart_list';

const String signUpSuccesMsg =
    'Successfully created account. A verification email has been sent to registered email. $verifyEmailMsg';
const String signupErrorMsg = 'Error occurred while signing up user.';
const String errorOcurred = 'Error occurred';

const String loginSuccessMsg = 'Logged in successfully.';
const String loginErrorMsg = 'Error occurred while login user.';

const verifyEmailMsg = 'Please verify your email before signing in.';

const String processDetailsSuccesMsg = 'Successfully processed data.';

const String home = 'Home';
const String cart = 'Cart';
const String profile = 'Profile';

const String dbCollectionName = 'amazon';
const String productsFileName = 'products.json';
const String categoriesFileName = 'categories.json';
const String subCategoriesFileName = 'sub_categories.json';

const String loadDataError =
    'Error ocurred while fetching data. Please try again later.';

const String searchHint = 'Search Amazon.in';
const String addedToFavorite = 'Product added to favorite.';
const String removedFromFavorite = 'Product removed from favorite.';
const String addedToCart = 'Product added to cart.';
const String removedFromCart = 'Product removed from cart.';
const String quantityUpdated = 'Product quantity updated.';

const String noDataFound = 'No Data Found';
const String details = 'Details';
const String add = 'Add';
const String productDetails = 'Product details';
const String productLimitExceed = 'You\'ve reached maximum product limit.';
