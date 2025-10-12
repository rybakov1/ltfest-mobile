class PaymentInitResponse {
  final bool success;
  final String? paymentUrl;
  final String? paymentId;
  final String? message;
  final String? status;
  final String? errorCode;

  PaymentInitResponse({
    required this.success,
    this.paymentUrl,
    this.paymentId,
    this.message,
    this.status,
    this.errorCode,
  });

  factory PaymentInitResponse.fromJson(Map<String, dynamic> json) {
    // --- ДОБАВЛЯЕМ ЛОГ ЗДЕСЬ ---
    print('--- PARSING PaymentInitResponse ---');
    print('Received JSON: $json');
    // --- КОНЕЦ ЛОГА ---

    final response = PaymentInitResponse(
      success: json['Success'] ?? false,
      paymentUrl: json['PaymentURL'],
      paymentId: json['PaymentId']?.toString(),
      message: json['Message'],
      status: json['Status'],
      errorCode: json['ErrorCode']?.toString(),
    );

    // --- ДОБАВЛЯЕМ ЛОГ РЕЗУЛЬТАТА ---
    print('Parsed paymentUrl: ${response.paymentUrl}');
    print('--- PARSING FINISHED ---');
    // --- КОНЕЦ ЛОГА ---

    return response;
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