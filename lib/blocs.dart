/**
 * created by Nishith on 24/4/21.
 */
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class BlocProvider extends HookWidget {
  BlocProvider(this.child);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [Provider.value(value: 0)],
      child: child,
    );
  }
}
