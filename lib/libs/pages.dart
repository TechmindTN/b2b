import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:siyou_b2b/libs/page_model.dart';

class Page extends StatelessWidget {
  final PageModel viewModel;
  final double percentVisible;

  Page({
    this.viewModel,
    this.percentVisible = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color: viewModel.color,
        child: Opacity(
          opacity: percentVisible,
          child:Transform(
              transform: Matrix4.translationValues(
                  0.0, 50.0 * (1.0 - percentVisible), 0.0),
              child: Padding(
                padding: EdgeInsets.only(bottom: 0.0),
                child: _renderImageAsset(viewModel.heroAssetPath,
                    width: MediaQuery. of(context). size. width, height: MediaQuery. of(context). size. height, color: viewModel.heroAssetColor),
              ),
            ), /*Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            
            /*Transform(
              transform: Matrix4.translationValues(
                  0.0, 30.0 * (1.0 - percentVisible), 0.0),
              child: Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: viewModel.title),
            ),
            Transform(
              transform: Matrix4.translationValues(
                  0.0, 30.0 * (1.0 - percentVisible), 0.0),
              child: Padding(
                  padding: EdgeInsets.only(bottom: 75.0),
                  child: viewModel.body),
            ),*/
          ]),*/
        ));
  }
}

Widget _renderImageAsset(String assetPath,
    {double width = 24, double height = 24, Color color}) {
  if (assetPath.toLowerCase().endsWith(".svg")) {
    return SvgPicture.asset(
      assetPath,
      width: width,
      height: height,
      color: color,
    );
  } else {
    return Image.asset(
      assetPath,
      color: color,
      width: width,
      height: height,
      fit: BoxFit.fill,
    );
  }
}
