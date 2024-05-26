import 'package:flutter_riverpod/flutter_riverpod.dart';

class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    super.didUpdateProvider(
      provider,
      previousValue,
      newValue,
      container,
    );

    print(
      '[UPDATED] provider: $provider / Prev: $previousValue / new: $newValue',
    );
  }

  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    super.didAddProvider(
      provider,
      value,
      container,
    );

    print('[INSERTED] provider: $provider / value: $value');
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    super.didDisposeProvider(
      provider,
      container,
    );

    print('[DELETED]: provider: $provider');
  }
}
