library hover_menu;

import 'package:almed_in/Screens/Home/company_list_screen.dart';
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
  final _titleFocusNode = FocusNode();
  final _overlayFocusNode = FocusNode();
  bool _isTitleHovered = false;
  bool _isOverlayHovered = false;

  @override
  void initState() {
    super.initState();
    _titleFocusNode.addListener(_onTitleFocusChanged);
    _overlayFocusNode.addListener(_onOverlayFocusChanged);
  }

  @override
  void dispose() {
    _titleFocusNode.dispose();
    _overlayFocusNode.dispose();
    super.dispose();
  }

  void _onTitleFocusChanged() {
    setState(() {
      _isTitleHovered = _titleFocusNode.hasFocus;
    });

    if (_titleFocusNode.hasFocus) {
      _showOverlay();
    } else if (!_overlayFocusNode.hasFocus) {
      _hideOverlay();
    }
  }

  void _onOverlayFocusChanged() {
    setState(() {
      _isOverlayHovered = _overlayFocusNode.hasFocus;
    });

    if (_overlayFocusNode.hasFocus) {
      _showOverlay();
    } else if (!_titleFocusNode.hasFocus) {
      _hideOverlay();
    }
  }

  void _showOverlay() {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context)?.insert(_overlayEntry!);
    }
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isTitleHovered = true;
        });
        _titleFocusNode.requestFocus();
      },
      onExit: (_) {
        setState(() {
          _isTitleHovered = false;
        });
        if (!_isOverlayHovered) {
          _titleFocusNode.unfocus();
        }
      },
      child: TextButton(
        focusNode: _titleFocusNode,
        onPressed: () {
        },
        child: widget.title,
      ),
    );
  }

  // OverlayEntry _createOverlayEntry() {
  //   final renderBox = context.findRenderObject() as RenderBox;
  //   final size = renderBox.size;
  //   final offset = renderBox.localToGlobal(Offset.zero);
  //
  //   return OverlayEntry(
  //     maintainState: true,
  //     builder: (context) => Positioned(
  //       right: offset.dy-size.width,
  //       top: offset.dy + size.height,
  //       width: widget.width ?? 200,
  //       child: MouseRegion(
  //         onEnter: (_) {
  //           setState(() {
  //             _isOverlayHovered = true;
  //           });
  //           _overlayFocusNode.requestFocus();
  //         },
  //         onExit: (_) {
  //           setState(() {
  //             _isOverlayHovered = false;
  //           });
  //           if (!_isTitleHovered) {
  //             _overlayFocusNode.unfocus();
  //           }
  //         },
  //         child: Container(
  //           child: ListView(
  //             padding: EdgeInsets.zero,
  //             shrinkWrap: true,
  //             children: widget.items,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  OverlayEntry _createOverlayEntry() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      maintainState: true,
      builder: (context) => Positioned(
        right: offset.dy - size.width,
        top: offset.dy + size.height,
        width: widget.width ?? 200,
        child: MouseRegion(
          onEnter: (_) {
            setState(() {
              _isOverlayHovered = true;
            });
            _overlayFocusNode.requestFocus();
          },
          onExit: (_) {
            setState(() {
              _isOverlayHovered = false;
            });
            if (!_isTitleHovered && !_isOverlayHovered) {
              _overlayFocusNode.unfocus();
               _hideOverlay();
            }
          },
          child: Container(

            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: widget.items,
            ),
          ),
        ),
      ),
    );
  }

}
