import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:siyou_b2b/main.dart';
import 'package:siyou_b2b/models/Theme.dart';
import 'package:siyou_b2b/providers/ProductProvider.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/Search_Item.dart';
import 'package:siyou_b2b/utlis/utils.dart';

class FilterDialogWidget1 extends StatefulWidget {
  final ProductListProvider productProvider;

  const FilterDialogWidget1({Key key, this.productProvider, String barcode})
      : super(key: key);

  @override
  _FilterDialog1State createState() => _FilterDialog1State();
}

class _FilterDialog1State extends State<FilterDialogWidget1> {
  final TextEditingController _controller = TextEditingController();

  AppLocalizations lang;

  // Store _store;

  _FilterDialog1State();

  scanBarCode() async {
    String code = await scanCode(context, lang);
    _controller.text = code;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => LanguageProvider(child: SearchItem(search: code)),
        ));
    /*widget.productProvider.resetList(context,
        keyword: _controller.text,
        chainId: _currentChain?.id ?? "",
        supplier: _currentSupplier?.id ?? "",
        category: _currentCategory?.id ?? "");*/
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = AppLocalizations.of(context);

    // widget.productProvider.getLists(context);
    //_store = Provider.of<LoginProvider>(context, listen: false).store;
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);

    final edgeInsets = const EdgeInsets.all(8.0);
    return Container(
      child: Padding(
        padding: edgeInsets,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Padding(
              padding: edgeInsets,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                          labelText: lang.tr('Barcode'),
                          icon: Icon(Icons.label)),
                      maxLines: 1,
                      onSubmitted: (_) => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => LanguageProvider(
                                child: SearchItem(search: _controller.text)),
                          )),
                    ),
                    flex: 4,
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      child: InkWell(
                        onTap: () async => await scanBarCode(),
                        child: Padding(
                          padding: edgeInsets,
                          child: SvgPicture.asset(
                            'assets/svg/barcode-scanner.svg',
                            fit: BoxFit.contain,
                            color: MyThemes.getAccentDark(context),
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
          ],
        ),
      ),
    );
  }
}
