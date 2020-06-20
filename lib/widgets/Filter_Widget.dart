import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:siyou_b2b/models/Theme.dart';
import 'package:siyou_b2b/providers/ProductProvider.dart';
import 'package:siyou_b2b/widgets/appprop.dart';

class FilterDialogWidget extends StatefulWidget {
  final ProductListProvider productProvider;

  const FilterDialogWidget({Key key, this.productProvider}) : super(key: key);

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialogWidget> {
  //Suppliers _currentSupplier;
  int suppid;
  int brandid;
  int categoryid;

  AppLocalizations lang;

  _FilterDialogState();

  @override
  void initState() {
    super.initState();
    //widget.productProvider.getLists(context);
    //intil();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = AppLocalizations.of(context);

    //widget.productProvider.getLists(context);
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
            /*Padding(
              padding: edgeInsets,
              child: ExpansionTile(
                leading: Icon(
                  Icons.people,
                  //color: Colors.pinkAccent,
                ),
                title: Text(
                  'Suppliers',
                  style: Theme.of(context).textTheme.title,
                ),
                children: [
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.productProvider.suppliers.length,
                      itemBuilder: (context, i) {
                        return (ListTile(
                          onTap: () {
                            setState(() {
                              suppid == widget.productProvider.suppliers[i].id
                                  ? suppid = null
                                  : suppid =
                                      widget.productProvider.suppliers[i].id;
                            });
                          },
                          title: Text(
                            widget.productProvider.suppliers[i].firstName +
                                ' ' +
                                widget.productProvider.suppliers[i].lastName,
                            style: TextStyle(fontSize: 15),
                          ),
                          trailing:
                              suppid == widget.productProvider.suppliers[i].id
                                  ? Icon(
                                      Icons.check_circle,
                                      color: yellow,
                                      size: 23,
                                    )
                                  : SizedBox(),
                        ));
                      })
                ],
              ),
            ),*/
            Padding(
              padding: edgeInsets,
              child: ExpansionTile(
                leading: Icon(
                  Icons.category,
                  //color: Colors.pinkAccent,
                ),
                title: Text(
                  'Category',
                  style: Theme.of(context).textTheme.title,
                ),
                children: [
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.productProvider.categories.length,
                      itemBuilder: (_, index) {
                        return (ExpansionTile(
                          title: Text(
                            widget
                                .productProvider.categories[index].categoryName,
                            style: Theme.of(context).textTheme.subtitle,
                          ),
                          children: [
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: widget.productProvider
                                    .categories[index].subCategories.length,
                                itemBuilder: (_, i) {
                                  return (ListTile(
                                    onTap: () {
                                      setState(() {
                                        categoryid ==
                                                widget
                                                    .productProvider
                                                    .categories[index]
                                                    .subCategories[i]
                                                    .id
                                            ? categoryid = null
                                            : categoryid = categoryid = widget
                                                .productProvider
                                                .categories[index]
                                                .subCategories[i]
                                                .id;
                                      });
                                    },
                                    title: Text(
                                      widget.productProvider.categories[index]
                                          .subCategories[i].categoryName,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    trailing: categoryid ==
                                            widget
                                                .productProvider
                                                .categories[index]
                                                .subCategories[i]
                                                .id
                                        ? Icon(
                                            Icons.check_circle,
                                            color: yellow,
                                            size: 23,
                                          )
                                        : SizedBox(),
                                  ));
                                })
                          ],
                        ));
                      })
                ],
              ),
            ),
            Padding(
              padding: edgeInsets,
              child: ExpansionTile(
                leading: Icon(
                  Icons.people,
                  //color: Colors.pinkAccent,
                ),
                title: Text(
                  'Brand',
                  style: Theme.of(context).textTheme.title,
                ),
                children: [
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.productProvider.brands.length,
                      itemBuilder: (context, i) {
                        return (ListTile(
                          onTap: () {
                            setState(() {
                              brandid == widget.productProvider.brands[i].id
                                  ? brandid = null
                                  : brandid =
                                      widget.productProvider.brands[i].id;
                            });
                          },
                          title: Text(
                            widget.productProvider.brands[i].brandName,
                            style: TextStyle(fontSize: 15),
                          ),
                          trailing:
                              brandid == widget.productProvider.brands[i].id
                                  ? Icon(
                                      Icons.check_circle,
                                      color: yellow,
                                      size: 23,
                                    )
                                  : SizedBox(),
                        ));
                      })
                ],
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                  widget.productProvider.resetList(
                    context,
                    category: categoryid,
                    brand: brandid,
                    supplierid: suppid,
                    //category: ""
                  );
                },
                color: MyThemes.getAccentLight(context),
                child: Text(
                  lang.tr("Apply"),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FilterDialogsideWidget extends StatefulWidget {
  final ProductListProvider productProvider;

  const FilterDialogsideWidget({Key key, this.productProvider})
      : super(key: key);

  @override
  _FilterDialogsideState createState() => _FilterDialogsideState();
}

class _FilterDialogsideState extends State<FilterDialogsideWidget> {
  //Suppliers _currentSupplier;

  int categoryid;

  AppLocalizations lang;

  _FilterDialogsideState();

  @override
  void initState() {
    super.initState();
    //widget.productProvider.getLists(context);
    //intil();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = AppLocalizations.of(context);

    //widget.productProvider.getLists(context);
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);

    final edgeInsets = const EdgeInsets.all(8.0);
    return new Drawer(
        child: ListView(children: <Widget>[
      Container(
        padding: edgeInsets,
        child: Text(lang.tr('shopOwner.Category'),
            style: Theme.of(context).textTheme.display1.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 25)),
      ),
      ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.productProvider.categories.length,
          itemBuilder: (_, index) {
            return (ExpansionTile(
              title: Text(widget.productProvider.categories[index].categoryName,
                  style: Theme.of(context).textTheme.subhead),
              children: [
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget
                        .productProvider.categories[index].subCategories.length,
                    itemBuilder: (_, i) {
                      return (ListTile(
                        onTap: () {
                          setState(() {
                            categoryid ==
                                    widget.productProvider.categories[index]
                                        .subCategories[i].id
                                ? categoryid = null
                                : categoryid = categoryid = widget
                                    .productProvider
                                    .categories[index]
                                    .subCategories[i]
                                    .id;
                          });
                          Navigator.pop(context);
                          widget.productProvider.resetList(
                            context,
                            category: categoryid,
                          );
                        },
                        title: Text(
                          widget.productProvider.categories[index]
                              .subCategories[i].categoryName,
                          style: TextStyle(fontSize: 15),
                        ),
                        trailing: categoryid ==
                                widget.productProvider.categories[index]
                                    .subCategories[i].id
                            ? Icon(
                                Icons.check_circle,
                                color: yellow,
                                size: 23,
                              )
                            : SizedBox(),
                      ));
                    })
              ],
            ));
          })
    ]));
  }
}

class FilterDialogsideMWidget extends StatefulWidget {
  final ProductListProvider productProvider;

  const FilterDialogsideMWidget({Key key, this.productProvider})
      : super(key: key);

  @override
  _FilterDialogsidemState createState() => _FilterDialogsidemState();
}

class _FilterDialogsidemState extends State<FilterDialogsideMWidget> {
  //Suppliers _currentSupplier;

  int categoryid;

  AppLocalizations lang;

  _FilterDialogsidemState();

  @override
  void initState() {
    super.initState();
    //widget.productProvider.getLists(context);
    //intil();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = AppLocalizations.of(context);

    //widget.productProvider.getLists(context);
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);

    final edgeInsets = const EdgeInsets.all(8.0);
    return new Drawer(
        child: ListView(children: <Widget>[
      Container(
        padding: edgeInsets,
        child: Text(lang.tr('shopOwner.Category'),
            style: Theme.of(context).textTheme.display1.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 25)),
      ),
      ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.productProvider.categories.length,
          itemBuilder: (_, index) {
            return (ExpansionTile(
              title: Text(widget.productProvider.categories[index].categoryName,
                  style: Theme.of(context).textTheme.subhead),
              children: [
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget
                        .productProvider.categories[index].subCategories.length,
                    itemBuilder: (_, i) {
                      return (ListTile(
                        onTap: () {
                          setState(() {
                            categoryid ==
                                    widget.productProvider.categories[index]
                                        .subCategories[i].id
                                ? categoryid = null
                                : categoryid = categoryid = widget
                                    .productProvider
                                    .categories[index]
                                    .subCategories[i]
                                    .id;
                          });
                          Navigator.pop(context);
                          widget.productProvider.resetMList(
                            context,
                            category: categoryid,
                          );
                        },
                        title: Text(
                          widget.productProvider.categories[index]
                              .subCategories[i].categoryName,
                          style: TextStyle(fontSize: 15),
                        ),
                        trailing: categoryid ==
                                widget.productProvider.categories[index]
                                    .subCategories[i].id
                            ? Icon(
                                Icons.check_circle,
                                color: yellow,
                                size: 23,
                              )
                            : SizedBox(),
                      ));
                    })
              ],
            ));
          })
    ]));
  }
}

class FilterDialogsideSupplierWidget extends StatefulWidget {
  final ProductListProvider productProvider;

  const FilterDialogsideSupplierWidget({Key key, this.productProvider})
      : super(key: key);

  @override
  _FilterDialogSuppliersideState createState() =>
      _FilterDialogSuppliersideState();
}

class _FilterDialogSuppliersideState
    extends State<FilterDialogsideSupplierWidget> {
  //Suppliers _currentSupplier;

  int suppid;

  AppLocalizations lang;

  _FilterDialogSuppliersideState();

  @override
  void initState() {
    super.initState();
    //widget.productProvider.getLists(context);
    //intil();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = AppLocalizations.of(context);

    //widget.productProvider.getLists(context);
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);

    final edgeInsets = const EdgeInsets.all(8.0);
    return new Drawer(
        child: ListView(children: <Widget>[
      Container(
        padding: edgeInsets,
        child: Text(lang.tr('shopOwner.Supplier'),
            style: Theme.of(context).textTheme.display1.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 25)),
      ),
      ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.productProvider.suppliers.length,
          itemBuilder: (context, i) {
            return (ListTile(
              onTap: () {
                setState(() {
                  suppid == widget.productProvider.suppliers[i].id
                      ? suppid = null
                      : suppid = widget.productProvider.suppliers[i].id;
                });
                Navigator.pop(context);
                widget.productProvider.resetList(
                  context,
                  supplierid: suppid,
                );
              },
              title: Text(
                widget.productProvider.suppliers[i].firstName +
                    ' ' +
                    widget.productProvider.suppliers[i].lastName,
                style: TextStyle(fontSize: 15),
              ),
              trailing: suppid == widget.productProvider.suppliers[i].id
                  ? Icon(
                      Icons.check_circle,
                      color: yellow,
                      size: 23,
                    )
                  : SizedBox(),
            ));
          })
    ]));
  }
}

class FilterDialogsideBrandWidget extends StatefulWidget {
  final ProductListProvider productProvider;

  const FilterDialogsideBrandWidget({Key key, this.productProvider})
      : super(key: key);

  @override
  _FilterDialogBrandsideState createState() => _FilterDialogBrandsideState();
}

class _FilterDialogBrandsideState extends State<FilterDialogsideBrandWidget> {
  //Suppliers _currentSupplier;

  int brandid;

  AppLocalizations lang;

  _FilterDialogBrandsideState();

  @override
  void initState() {
    super.initState();
    //widget.productProvider.getLists(context);
    //intil();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = AppLocalizations.of(context);

    //widget.productProvider.getLists(context);
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);

    final edgeInsets = const EdgeInsets.all(8.0);
    return new Drawer(
        child: Column(children: <Widget>[
      Container(
        padding: edgeInsets,
        child: Text(lang.tr('shopOwner.Brand'),
            style: Theme.of(context).textTheme.display1.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 25)),
      ),
      Expanded(
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.productProvider.brands.length,
              itemBuilder: (context, i) {
                return (ListTile(
                  onTap: () {
                    setState(() {
                      brandid == widget.productProvider.brands[i].id
                          ? brandid = null
                          : brandid = widget.productProvider.brands[i].id;
                    });
                    Navigator.pop(context);
                    widget.productProvider.resetList(
                      context,
                      brand: brandid,
                    );
                  },
                  title: Text(
                    widget.productProvider.brands[i].brandName,
                    style: TextStyle(fontSize: 15),
                  ),
                  trailing: brandid == widget.productProvider.brands[i].id
                      ? Icon(
                          Icons.check_circle,
                          color: yellow,
                          size: 23,
                        )
                      : SizedBox(),
                ));
              }))
    ]));
  }
}
