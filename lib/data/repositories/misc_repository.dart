import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/api_client.dart';
import '../models/loyalty_card.dart';
import '../models/promocode.dart';
import '../services/api_exception.dart';

final miscRepositoryProvider = Provider<MiscRepository>((ref) {
  return MiscRepository(ref.watch(apiClientProvider));
});

class MiscRepository with ApiErrorHandler {
  final ApiClient _client;

  MiscRepository(this._client);

  // ── Promo Codes ──

  Future<PromoCode> getPromoCodeByCode(String code) async {
    try {
      final response = await _client.getPromoCodes({
        'filters[code][\$eq]': code,
        'populate': '*',
      });
      final List<dynamic> data = (response['data'] as List?) ?? [];
      if (data.isEmpty) throw ApiException(message: 'Промокод не найден');
      return PromoCode.fromJson(data.first as Map<String, dynamic>);
    } catch (e) {
      handleError(e);
    }
  }

  Future<PromoCode> applyPromoCode(PromoCode promoCode) async {
    try {
      if (promoCode.currentUses >= promoCode.maxUses) {
        throw ApiException(
          message: 'Промокод уже был использован максимальное количество раз',
        );
      }
      final response = await _client.updatePromoCode(promoCode.documentId, {
        'data': {'currentUses': promoCode.currentUses + 1},
      });
      return PromoCode.fromJson(response['data'] as Map<String, dynamic>);
    } catch (e) {
      handleError(e);
    }
  }

  Future<PromoCode> getPromoCodeById(int id) async {
    try {
      final response = await _client.getPromoCodeById(id);
      return PromoCode.fromJson(response['data'] as Map<String, dynamic>);
    } catch (e) {
      handleError(e);
    }
  }

  // ── Loyalty Cards ──

  Future<LoyaltyCard> getLoyaltyCardByNumber(String cardNumber) async {
    try {
      final response = await _client.getLoyaltyCards({
        'filters[cardNumber][\$eq]': cardNumber,
        'populate': '*',
      });
      final List<dynamic> data = (response['data'] as List?) ?? [];
      if (data.isEmpty) throw ApiException(message: 'Карта не найдена');
      return LoyaltyCard.fromJson(data.first as Map<String, dynamic>);
    } catch (e) {
      handleError(e);
    }
  }

  // ── Support ──

  Future<void> sendSupportMessage({
    required String name,
    required String email,
    required String phone,
    required String reason,
    required String message,
    required String device,
    required String appVersion,
    List<int>? attachmentIds,
  }) async {
    try {
      final Map<String, dynamic> data = {
        'name': name,
        'email': email,
        'phone': phone,
        'reason': reason,
        'message': message,
        'device': device,
        'app_version': appVersion,
      };
      if (attachmentIds != null && attachmentIds.isNotEmpty) {
        data['attachments'] = attachmentIds;
      }
      await _client.sendSupportMessage({'data': data});
    } catch (e) {
      handleError(e);
    }
  }

  Future<int> uploadFile(String filePath) async {
    try {
      final fileName = filePath.split(RegExp(r'[\\/]+')).last;
      final formData = FormData.fromMap({
        'files': await MultipartFile.fromFile(filePath, filename: fileName),
      });

      final data = await _client.uploadFile(formData);
      if (data.isNotEmpty && data.first is Map<String, dynamic>) {
        final id = (data.first as Map<String, dynamic>)['id'];
        if (id is int) return id;
        if (id is num) return id.toInt();
      }

      throw ApiException(message: 'File upload failed');
    } catch (e) {
      handleError(e);
    }
  }

  // ── Push Tokens ──

  Future<void> registerPushToken({
    required int userId,
    required String token,
    required String provider,
    required String platform,
  }) async {
    try {
      final data = {
        'data': {
          'users_permissions_user': userId,
          'token': token,
          'provider': provider,
          'platform': platform,
        }
      };

      if (kDebugMode) {
        debugPrint('📡 [POST] /api/push-tokens');
        debugPrint('Token data: provider=$provider, platform=$platform');
      }

      final response = await _client.registerPushToken(data);

      if (response.response.statusCode == 405) {
        debugPrint(
          '⚠️ [PushService] /push-tokens недоступен (405). Токен не сохранён.',
        );
        return;
      }

      if (response.response.statusCode != 200 &&
          response.response.statusCode != 201) {
        throw ApiException(message: 'Не удалось зарегистрировать push token');
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      handleError(e);
    }
  }
}
