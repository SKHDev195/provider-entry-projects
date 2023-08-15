import 'package:state_notifier/state_notifier.dart';

import 'counter.dart';

enum TotalLevel {
  bronze,
  silver,
  gold,
}

class CounterLevel extends StateNotifier<TotalLevel> with LocatorMixin {
  CounterLevel()
      : super(
          TotalLevel.bronze,
        );

  @override
  void update(Locator watch) {
    final currentCounter = watch<CounterState>().count;

    state = switch (currentCounter) {
      >= 100 => TotalLevel.gold,
      > 50 && < 100 => TotalLevel.silver,
      _ => TotalLevel.bronze,
    };

    super.update(watch);
  }
}
