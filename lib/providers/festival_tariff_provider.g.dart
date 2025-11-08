// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'festival_tariff_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$festivalTariffsHash() => r'c08b8daa9b15eb37003ac83d9b262ea8cb486b6b';

/// See also [festivalTariffs].
@ProviderFor(festivalTariffs)
final festivalTariffsProvider =
    AutoDisposeFutureProvider<List<FestivalTariff>>.internal(
  festivalTariffs,
  name: r'festivalTariffsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$festivalTariffsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FestivalTariffsRef = AutoDisposeFutureProviderRef<List<FestivalTariff>>;
String _$tariffsForFestivalHash() =>
    r'8549b0fe584fe0c8a406a9eeaefa817145ca32a2';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [tariffsForFestival].
@ProviderFor(tariffsForFestival)
const tariffsForFestivalProvider = TariffsForFestivalFamily();

/// See also [tariffsForFestival].
class TariffsForFestivalFamily
    extends Family<AsyncValue<List<FestivalTariff>>> {
  /// See also [tariffsForFestival].
  const TariffsForFestivalFamily();

  /// See also [tariffsForFestival].
  TariffsForFestivalProvider call(
    int festivalId,
  ) {
    return TariffsForFestivalProvider(
      festivalId,
    );
  }

  @override
  TariffsForFestivalProvider getProviderOverride(
    covariant TariffsForFestivalProvider provider,
  ) {
    return call(
      provider.festivalId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'tariffsForFestivalProvider';
}

/// See also [tariffsForFestival].
class TariffsForFestivalProvider
    extends AutoDisposeFutureProvider<List<FestivalTariff>> {
  /// See also [tariffsForFestival].
  TariffsForFestivalProvider(
    int festivalId,
  ) : this._internal(
          (ref) => tariffsForFestival(
            ref as TariffsForFestivalRef,
            festivalId,
          ),
          from: tariffsForFestivalProvider,
          name: r'tariffsForFestivalProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$tariffsForFestivalHash,
          dependencies: TariffsForFestivalFamily._dependencies,
          allTransitiveDependencies:
              TariffsForFestivalFamily._allTransitiveDependencies,
          festivalId: festivalId,
        );

  TariffsForFestivalProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.festivalId,
  }) : super.internal();

  final int festivalId;

  @override
  Override overrideWith(
    FutureOr<List<FestivalTariff>> Function(TariffsForFestivalRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TariffsForFestivalProvider._internal(
        (ref) => create(ref as TariffsForFestivalRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        festivalId: festivalId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<FestivalTariff>> createElement() {
    return _TariffsForFestivalProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TariffsForFestivalProvider &&
        other.festivalId == festivalId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, festivalId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TariffsForFestivalRef
    on AutoDisposeFutureProviderRef<List<FestivalTariff>> {
  /// The parameter `festivalId` of this provider.
  int get festivalId;
}

class _TariffsForFestivalProviderElement
    extends AutoDisposeFutureProviderElement<List<FestivalTariff>>
    with TariffsForFestivalRef {
  _TariffsForFestivalProviderElement(super.provider);

  @override
  int get festivalId => (origin as TariffsForFestivalProvider).festivalId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
