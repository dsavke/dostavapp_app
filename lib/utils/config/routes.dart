import 'package:flutter/widgets.dart';

import '../../screens/account_selector.dart';
import '../../screens/find_supplier.dart';
import '../../screens/register_supplier_man.dart';

class AppRoutes {
  final routes = {
    AccountSelectorScreen.routeName: (BuildContext ctx) =>
        AccountSelectorScreen(),
    RegisterSupplierManScreen.routeName: (BuildContext ctx) =>
        RegisterSupplierManScreen(),
    FindSupplierScreen.routeName: (BuildContext ctx) => FindSupplierScreen(),
  };

  static const String initialRoute = AccountSelectorScreen.routeName;
}
