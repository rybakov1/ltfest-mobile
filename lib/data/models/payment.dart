class PaymentInitResponse {
  final bool success;
  final String? paymentUrl;
  final int? paymentId;
  final String? orderId;
  final int? amount;
  final String? message;
  final String? status;
  final String? errorCode;

  PaymentInitResponse({
    required this.success,
    this.paymentUrl,
    this.paymentId,
    this.orderId,
    this.amount,
    this.message,
    this.status,
    this.errorCode,
  });

  factory PaymentInitResponse.fromJson(Map<String, dynamic> json) {
    // Вспомогательная функция для безопасного парсинга в int
    int? parseToInt(dynamic value) {
      if (value == null) return null;
      if (value is int) return value;
      if (value is String) return int.tryParse(value);
      return null;
    }

    return PaymentInitResponse(
      success: json['Success'] ?? false,
      paymentUrl: json['PaymentURL'],
      // ИСПОЛЬЗУЕМ БЕЗОПАСНЫЙ ПАРСИНГ
      paymentId: parseToInt(json['PaymentId']),
      orderId: json['OrderId']?.toString(), // OrderId лучше всегда хранить как String
      // ИСПОЛЬЗУЕМ БЕЗОПАСНЫЙ ПАРСИНГ
      amount: parseToInt(json['Amount']),
      message: json['Message'],
      status: json['Status'],
      errorCode: json['ErrorCode']?.toString(),
    );
  }
}

class PaymentStateResponse {
  final bool success;
  final String? status;
  final String? message;

  PaymentStateResponse({
    required this.success,
    this.status,
    this.message,
  });

  factory PaymentStateResponse.fromJson(Map<String, dynamic> json) {
    return PaymentStateResponse(
      success: json['Success'] ?? false,
      status: json['Status'],
      message: json['Message'],
    );
  }
}

enum PaymentStatus { initial, loading, ready, success, error, authorized }

class PaymentState {
  final PaymentStatus status;
  final String message;
  final String? paymentUrl;
  final String? paymentId;

  const PaymentState({
    required this.status,
    this.message = '',
    this.paymentUrl,
    this.paymentId,
  });

  PaymentState copyWith({
    PaymentStatus? status,
    String? message,
    String? paymentUrl,
    String? paymentId,
  }) {
    return PaymentState(
      status: status ?? this.status,
      message: message ?? this.message,
      paymentUrl: paymentUrl ?? this.paymentUrl,
      paymentId: paymentId ?? this.paymentId,
    );
  }
}