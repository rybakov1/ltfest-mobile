import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/api_client.dart';
import '../models/order.dart';
import '../models/payment.dart';
import '../services/api_exception.dart';

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  return OrderRepository(ref.watch(apiClientProvider));
});

class OrderRepository with ApiErrorHandler {
  final ApiClient _client;

  OrderRepository(this._client);

  // ── Orders ──

  Future<Order> createOrder(Order order) async {
    final data = {
      'data': {
        'name': order.name,
        'email': order.email,
        'phone': order.phone,
        'amount': order.amount,
        'type': order.type,
        'details': order.details,
        'paymentId': order.paymentId,
        'paymentStatus': order.paymentStatus,
        if (order.festival?.id != null)
          'festival': {
            'connect': [order.festival!.id]
          },
        if (order.laboratory?.id != null)
          'laboratory': {
            'connect': [order.laboratory!.id]
          },
        if (order.productInStock?.id != null)
          'product_in_stock': {
            'connect': [order.productInStock!.id]
          },
      },
    };

    if (kDebugMode) {
      debugPrint('📡 [POST] /api/orders');
    }

    try {
      final response = await _client.createOrder(data);
      return Order.fromJson(response['data'] as Map<String, dynamic>);
    } catch (e) {
      handleError(e);
    }
  }

  Future<List<Order>> getOrdersByUser(int userId) async {
    try {
      final response = await _client.getOrders({
        'filters[user][id][\$eq]': userId,
        'populate': '*',
      });
      final data = response['data'] as List<dynamic>;
      return data.map((e) => Order.fromJson(e)).toList();
    } catch (e) {
      handleError(e);
    }
  }

  Future<Order> getOrderById(String id) async {
    try {
      final response = await _client.getOrderById(id, {'populate': '*'});
      return Order.fromJson(response['data'] as Map<String, dynamic>);
    } catch (e) {
      handleError(e);
    }
  }

  Future<Order> updateOrder({
    required String id,
    String? paymentStatus,
    String? paymentId,
    Map<String, dynamic>? details,
  }) async {
    final data = {
      'data': {
        if (paymentStatus != null) 'paymentStatus': paymentStatus,
        if (paymentId != null) 'paymentId': paymentId,
        if (details != null) 'details': details,
      },
    };

    try {
      final response = await _client.updateOrder(id, data);
      return Order.fromJson(response['data'] as Map<String, dynamic>);
    } catch (e) {
      handleError(e);
    }
  }

  // ── Payments ──

  Future<PaymentInitResponse> initPayment({
    required Map<String, dynamic> orderData,
    required Map<String, dynamic> paymentData,
  }) async {
    try {
      final response = await _client.initPayment({
        'orderData': orderData,
        'paymentData': paymentData,
      });
      return PaymentInitResponse.fromJson(response);
    } catch (e) {
      handleError(e);
    }
  }

  Future<PaymentStateResponse> getPaymentState(String paymentId) async {
    try {
      final response = await _client.getPaymentState({'paymentId': paymentId});
      return PaymentStateResponse.fromJson(response);
    } catch (e) {
      handleError(e);
    }
  }

  Future<PaymentStateResponse> confirmPayment(String paymentId) async {
    try {
      final response = await _client.confirmPayment({'paymentId': paymentId});
      return PaymentStateResponse.fromJson(response);
    } catch (e) {
      handleError(e);
    }
  }
}
