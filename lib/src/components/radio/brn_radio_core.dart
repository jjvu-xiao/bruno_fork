import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// 描述: radio组件
/// 1. 支持单选/多选
/// 2. 支持传入待选择widget，可以显示在选择按钮的左边或者右边
/// 3. 传入widget时，widget和选择按钮使用Row包裹，支持传入Row的属性[MainAxisAlignment]和[MainAxisSize]

class BrnRadioCore extends StatefulWidget {
  /// 标识当前Radio的Index
  final int radioIndex;

  /// 初始值，是否被选择
  /// 默认false
  final bool isSelected;

  /// 是否禁用当前选项
  /// 默认false
  final bool disable;

  /// 选择按钮的padding
  /// 默认EdgeInsets.all(5)
  final EdgeInsets iconPadding;

  /// 配合使用的控件，比如卡片或者text
  final Widget child;

  /// 控件是否在选择按钮的右边，
  /// true时 控件在选择按钮右边
  /// false时 控件在选择按钮的左边
  /// 默认true
  final bool childOnRight;

  /// 控件和选择按钮在row布局里面的alignment
  /// 默认值MainAxisAlignment.start
  final MainAxisAlignment mainAxisAlignment;

  /// 控件和选择按钮在row布局里面的mainAxisSize
  /// 默认值MainAxisSize.min
  final MainAxisSize mainAxisSize;

  final Image selectedImage;

  final Image unselectedImage;

  final Image disSelectedImage;

  final Image disUnselectedImage;

  final VoidCallback onRadioItemClick;

  const BrnRadioCore(
      {Key key,
      @required this.radioIndex,
      this.disable = false,
      this.isSelected = false,
      this.iconPadding,
      this.child,
      this.childOnRight = true,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.mainAxisSize = MainAxisSize.min,
      this.selectedImage,
      this.unselectedImage,
      this.disSelectedImage,
      this.disUnselectedImage,
      this.onRadioItemClick})
      : super(key: key);

  @override
  _BrnRadioCoreState createState() => _BrnRadioCoreState();
}

class _BrnRadioCoreState extends State<BrnRadioCore> {
  bool _isSelected;
  bool _disable;

  @override
  void initState() {
    _isSelected = widget.isSelected;
    _disable = widget.disable;
    super.initState();
  }

  @override
  void didUpdateWidget(BrnRadioCore oldWidget) {
    super.didUpdateWidget(oldWidget);
    _isSelected = widget.isSelected;
    _disable = widget.disable;
  }

  @override
  Widget build(BuildContext context) {
//    Image selectedImage = bruno_forkTools.getAssetImageWithBandColor(
//        widget.radioType == BrnRadioType.single
//            ? BrnAsset.ICON_RADIO_SINGLE_SELECTED
//            : BrnAsset.ICON_RADIO_MULTI_SELECTED);
//    Image unselectedImage = bruno_forkTools.getAssetImage(BrnAsset.ICON_RADIO_UNSELECTED);
//    Image disSelectedImage = bruno_forkTools.getAssetImage(widget.radioType == BrnRadioType.single
//        ? BrnAsset.ICON_RADIO_DISABLE_SINGLE_SELECTED
//        : BrnAsset.ICON_RADIO_DISABLE_MULTI_SELECTED);
//    Image disUnselectedImage = bruno_forkTools.getAssetImage(BrnAsset.ICON_RADIO_DISABLE_UNSELECTED);

    Widget icon = Container(
      padding: widget.iconPadding ?? EdgeInsets.all(5),
      child: this._isSelected
          ? (this._disable ? widget.disSelectedImage : widget.selectedImage)
          : (this._disable ? widget.disUnselectedImage : widget.unselectedImage),
    );

    Widget radioWidget;
    if (widget.child == null) {
      // 没设置左右widget的时候就不返回row
      radioWidget = icon;
    } else {
      List<Widget> list = List();
      if (widget.childOnRight) {
        list.add(icon);
        list.add(widget.child);
      } else {
        list.add(widget.child);
        list.add(icon);
      }
      radioWidget = Row(
        mainAxisSize: widget.mainAxisSize,
        mainAxisAlignment: widget.mainAxisAlignment,
        children: list,
      );
    }

    return GestureDetector(
      child: radioWidget,
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (widget.disable == true) return;
        widget.onRadioItemClick();
//        if (widget.onValueChangedAtIndex != null) {
//          if (widget.radioType == BrnRadioType.single) {
//            // 单选
//            widget.onValueChangedAtIndex(widget.radioIndex, true);
//          } else {
//            // 多选
//            setState(() {
//              _isSelected = !_isSelected;
//            });
//            widget.onValueChangedAtIndex(widget.radioIndex, _isSelected);
//          }
//        }
      },
    );
  }
}

/// radio类型
enum BrnRadioType {
  /// 多选
  multi,

  /// 单选
  single,
}
