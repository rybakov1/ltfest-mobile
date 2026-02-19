import '../entities/order_info.dart';

class PaymentResponse {
  final bool success;
  final String? paymentUrl;
  final String? paymentId;
  final String? orderId;
  final String? message;

  PaymentResponse({
    required this.success,
    this.paymentUrl,
    this.paymentId,
    this.orderId,
    this.message,
  });
}

abstract class IOrderRepository {
  Future<PaymentResponse> createPayment({
    required OrderInfo order,
    required int totalAmount,
  });

// Future<String> getPaymentStatus(String paymentId);
// Future<List<OrderInfo>> getMyOrders();
}