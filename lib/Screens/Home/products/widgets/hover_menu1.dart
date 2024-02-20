/* A new file for the last menu option to make it's drop down position not go beyond screen size.
The dropdown position starts from the
remaining screen portion and end exactly where the option item name ends.
 */
import 'package:flutter/material.dart';

class HoverMenu1 extends StatefulWidget {
  final Widget title;
  final double? width;
  final List<Widget> items;

  const HoverMenu1({
    Key? key,
    required this.title,
    this.items = const [],
    this.width,
  }) : super(key: key);

  @override
  HoverMenu1State createState() => HoverMenu1State();
}

class HoverMenu1State extends State<HoverMenu1> {
  OverlayEntry? _overlayEntry;
  final _focusNode = FocusNode();
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChanged() {
    if (_focusNode.hasFocus) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    } else {
      _overlayEntry?.remove();
      _removeOverlay();
    }
  }

  void _removeOverlay() {
    _isHovered = false;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      focusNode: _focusNode,
      onHover: (isHovered) {
        if (isHovered && !_isHovered) {
          _focusNode.requestFocus();
          _isHovered = true;
        } else if (!isHovered && _isHovered) {
          _focusNode.unfocus(); // Unfocus when cursor leaves the overlay
          _isHovered = false;
        }
      },
      onPressed: () {},
      child: widget.title,
    );
  }

  OverlayEntry _createOverlayEntry() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      maintainState: true,
      builder: (context) => Positioned(
        right: offset.dy - size.width * 0.7,
        top: offset.dy + size.height,
        width: widget.width ?? 200,
        child: TextButton(
          onPressed: () {},
          onHover: (isHovered) {
            setState(() {
              _isHovered = isHovered;
              if (isHovered) {
                _focusNode.requestFocus();
              } else if (!isHovered && !_isHovered) {
                _focusNode.unfocus();
              }
            });
          },

          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: widget.items,
          ),
        ),
      ),
    );
  }
}
