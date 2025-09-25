// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'festival_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$festivalsNotifierHash() => r'ec4ee8d98397c3dac2467046b501f6e521224923';

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

abstract class _$FestivalsNotifier
    extends BuildlessAsyncNotifier<FestivalsState> {
  late final String category;

  FutureOr<FestivalsState> build(
    String category,
  );
}

/// See also [FestivalsNotifier].
@ProviderFor(FestivalsNotifier)
const festivalsNotifierProvider = FestivalsNotifierFamily();

/// See also [FestivalsNotifier].
class FestivalsNotifierFamily extends Family<AsyncValue<FestivalsState>> {
  /// See also [FestivalsNotifier].
  const FestivalsNotifierFamily();

  /// See also [FestivalsNotifier].
  FestivalsNotifierProvider call(
    String category,
  ) {
    return FestivalsNotifierProvider(
      category,
    );
  }

  @override
  FestivalsNotifierProvider getProviderOverride(
    covariant FestivalsNotifierProvider provider,
  ) {
    return call(
      provider.category,
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
  String? get name => r'festivalsNotifierProvider';
}

/// See also [FestivalsNotifier].
class FestivalsNotifierProvider
    extends AsyncNotifierProviderImpl<FestivalsNotifier, FestivalsState> {
  /// See also [FestivalsNotifier].
  FestivalsNotifierProvider(
    String category,
  ) : this._internal(
          () => FestivalsNotifier()..category = category,
          from: festivalsNotifierProvider,
          name: r'festivalsNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$festivalsNotifierHash,
          dependencies: FestivalsNotifierFamily._dependencies,
          allTransitiveDependencies:
              FestivalsNotifierFamily._allTransitiveDependencies,
          category: category,
        );

  FestivalsNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.category,
  }) : super.internal();

  final String category;

  @override
  FutureOr<FestivalsState> runNotifierBuild(
    covariant FestivalsNotifier notifier,
  ) {
    return notifier.build(
      category,
    );
  }

  @override
  Override overrideWith(FestivalsNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: FestivalsNotifierProvider._internal(
        () => create()..category = category,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        category: category,
      ),
    );
  }

  @override
  AsyncNotifierProviderElement<FestivalsNotifier, FestivalsState>
      createElement() {
    return _FestivalsNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FestivalsNotifierProvider && other.category == category;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, category.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FestivalsNotifierRef on AsyncNotifierProviderRef<FestivalsState> {
  /// The parameter `category` of this provider.
  String get category;
}

class _FestivalsNotifierProviderElement
    extends AsyncNotifierProviderElement<FestivalsNotifier, FestivalsState>
    with FestivalsNotifierRef {
  _FestivalsNotifierProviderElement(super.provider);

  @override
  String get category => (origin as FestivalsNotifierProvider).category;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
