import '../models/address.dart';
import '../models/ordered_product.dart';
import 'enums.dart';

class OrderDetails {
  static Address? address;
  static String? addressId;
  static PaymentType paymentMethod = PaymentType.cod;
  static List<OrderedProduct> selectedProducts = [];
  static double totalAmount = 0;
  static String? orderId;
}
