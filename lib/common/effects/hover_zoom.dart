import 'package:flutter/material.dart';

class HoverZoom extends StatefulWidget {
  final Widget child;
  final double scaleFactor;
  final Duration duration;

  const HoverZoom({
    super.key,
    required this.child,
    this.scaleFactor = 1.1,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  _HoverZoomState createState() => _HoverZoomState();
}

class _HoverZoomState extends State<HoverZoom> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: AnimatedScale(
        scale: _isHovered ? widget.scaleFactor : 1.0,
        duration: widget.duration,
        curve: Curves.ease,
        child: widget.child,
      ),
    );
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
  }
}
