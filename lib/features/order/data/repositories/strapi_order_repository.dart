import 'package:ltfest/features/order/domain/entities/order_enums.dart';

import '../../../../data/services/api_service.dart';
import '../../domain/entities/order_info.dart';
import '../../domain/repositories/i_order_repository.dart';

class StrapiOrderRepository implements IOrderRepository {
  final ApiService _apiService;

  StrapiOrderRepository(this._apiService);

  @override
  Future<PaymentResponse> createPayment({
    required OrderInfo order,
    required int totalAmount,
  }) async {
    final orderData = _mapEntityToStrapi(order, totalAmount);
    // Удаляем null значения
    orderData.removeWhere((key, value) => value == null);

    final response = await _apiService.initPayment(
      orderData: orderData,
      paymentData: {
        'amount': totalAmount,
        'description':
            'Оплата заказа от ${order.payerName} с мобильного приложения',
        'successUrl': 'ltfestapp://payment/success/{PaymentId}',
        'failUrl': 'ltfestapp://payment/fail/{PaymentId}',
      },
    );

    return PaymentResponse(
      success: response.success,
      paymentUrl: response.paymentUrl,
      paymentId: response.paymentId?.toString(),
      orderId: response.orderId,
      message: response.message,
    );
  }

  Map<String, dynamic> _mapEntityToStrapi(
    OrderInfo order,
    int amount,
  ) {
    final Map<String, dynamic> details = {};

    switch (order) {
      case FestivalOrder o:
        details['Имя коллектива'] = o.collectiveName;
        details['Имена участников'] = o.participantNames;
        details['Количество мест'] = o.seatCount;
        details['Фестиваль'] = o.festival.title;
        details['Тариф'] = o.festivalTariff.title;
        break;
      case LaboratoryOrder o:
        details['Название коллектива'] = o.collectiveName;
        details['Информация о коллективе'] = o.collectiveInfo;
        details['Город проживания'] = o.residence;
        details['Дата рождения'] = o.birthdate;
        details['Образование'] = o.education;
        details['Количество мест'] = o.seatCount;
        details['Лаборатория'] = o.laboratory.title;
        details['Тип обучения'] = o.learningType.type;
        break;
      case ProductOrder o:
        details['Название коллектива'] = o.collectiveName;
        details['Корзина'] = o.items
            .where((item) => item.productInStock != null)
            .map(
              (item) => {
                'ID товара': item.productInStock!.id,
                'Название': item.productInStock!.product?.name ?? 'Товар',
                'Характеристики':
                    '${item.productInStock!.productColor.title}, ${item.productInStock!.productSize.title}',
                'Количество': item.quantity,
                'Цена за штуку': item.productInStock!.price,
              },
            )
            .toList();
        details['Метод доставки'] = o.deliveryMethod == DeliveryMethod.onFestival
            ? "Заберу на фестивале"
            : "Доставка до адреса";
        if (o.address != null && o.address!.isNotEmpty) {
          details['Адрес доставки'] = o.address;
        }
        if (o.selectedFestival != null) {
          details['Фестиваль'] = o.selectedFestival!.title;
        }
        break;
    }

    if (order.promoCode != null && order.promoCode!.isNotEmpty) {
      details['Промокод'] = order.promoCode;
    }

    // Очистка деталей от пустых значений
    details.removeWhere((key, value) =>
        value == null || value == '' || (value is int && value == 0));

    final List<Map<String, dynamic>> orderedDetailsList =
        details.entries.map((entry) => {entry.key: entry.value}).toList();

    return {
      'name': order.payerName,
      'email': order.email,
      'phone': order.phone,
      'amount': amount,
      'type': _getTypeString(order),
      'details': orderedDetailsList,
      'user': order.userId ?? 0,
      'promo_code': order.promoCode,
      
      'festival': order is FestivalOrder
          ? order.festival.id
          : (order is ProductOrder ? order.selectedFestival?.id : null),
          
      'festival_tariff':
          order is FestivalOrder ? order.festivalTariff.id : null,
          
      'laboratory_learning_type':
          order is LaboratoryOrder ? order.learningType.id : null,
    };
  }

  String _getTypeString(OrderInfo order) => switch (order) {
        FestivalOrder _ => 'festival-tariff',
        LaboratoryOrder _ => 'laboratory',
        ProductOrder _ => 'product',
      };
}
