import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/map_navigation.dart';
import '../widgets/supplier_map.dart';

import '../providers/supplier_provider.dart';

import '../repositories/supplier_repository.dart';

import '../models/supplier.dart';

import '../utils/ui/colors.dart';
import '../utils/ui/images.dart';

class FindSupplierScreen extends StatelessWidget {
  static const routeName = '/findSupplierScreen';
  @override
  Widget build(BuildContext context) {
    Supplier supplier =
        Provider.of<SupplierProvider>(context, listen: false).supplier;

    return Scaffold(
      appBar: _FindSupplierAppBar(
        supplier: supplier,
      ),
      body: Stack(
        children: [
          supplier == null
              ? StreamBuilder<Event>(
                  stream: SupplierRepository().getAvailableSuppliers(),
                  builder: (BuildContext ctx, snapshot) {
                    if (snapshot.hasError || !snapshot.hasData)
                      return Center(
                        child: Text('Loading...'),
                      );

                    return SupplierMap(snapshot.data.snapshot);
                  },
                )
              : SupplierMap(null),
          MapNavigation(
            supplier: supplier,
          ),
        ],
      ),
    );
  }
}

class _FindSupplierAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  final Supplier supplier;

  const _FindSupplierAppBar({Key key, this.supplier}) : super(key: key);

  @override
  _FindSupplierAppBarState createState() => _FindSupplierAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _FindSupplierAppBarState extends State<_FindSupplierAppBar> {
  bool _available = false;

  @override
  void initState() {
    _available = widget.supplier?.available;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: SvgPicture.asset(Images.logo_red),
      ),
      actions: [
        if (widget.supplier != null)
          Switch(
            onChanged: _onChangeAvailability,
            value: _available,
            activeColor: AppColors.red,
          ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SvgPicture.asset(Images.menu_3_line),
        ),
      ],
      titleSpacing: 0,
      backgroundColor: Colors.white,
      elevation: 2.0,
    );
  }

  void _onChangeAvailability(bool value) async {
    setState(() {
      _available = !_available;
    });
    await Provider.of<SupplierProvider>(context, listen: false)
        .changeAvailability(_available);
  }
}
