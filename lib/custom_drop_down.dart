// custom_drop_down.dart

import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  OverlayEntry? _overlayEntry;
  String? selectedValue;
  final List<String> items = ['shimaa', 'shimaaaaa', 'shimaaaaaaaaaaaaaaaa'];

  void _toggleDropdown(BuildContext context) {
    _overlayEntry == null ? _showDropdown(context) : _removeDropdown();
  }

  void _showDropdown(BuildContext context) {
    Size mediaquery = MediaQuery.of(context).size;
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset position = renderBox.localToGlobal(Offset.zero);
    final double maxWidth =
        _getMaxTextWidth(items, context) + mediaquery.width * 0.15;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx,
        top: position.dy + renderBox.size.height,
        width: maxWidth,
        child: Material(
          elevation: 4,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: items
                .map((item) => ListTile(
                      title: Text(item),
                      onTap: () {
                        setState(() => selectedValue = item);
                        _removeDropdown();
                      },
                    ))
                .toList(),
          ),
        ),
      ),
    );
//-------------------------------------------
    Overlay.of(context).insert(_overlayEntry!);
  }

  double _getMaxTextWidth(List<String> items, BuildContext context) {
    double maxWidth = 0;
    for (String item in items) {
      final TextPainter textPainter = TextPainter(
        text: TextSpan(text: item, style: DefaultTextStyle.of(context).style),
        maxLines: 1,
        textDirection: TextDirection.ltr,
      )..layout();
      maxWidth = maxWidth > textPainter.width ? maxWidth : textPainter.width;
    }
    return maxWidth;
  }

  void _removeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _toggleDropdown(context),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(selectedValue ?? "Select Item"),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
