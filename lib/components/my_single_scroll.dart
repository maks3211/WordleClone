import 'package:flutter/material.dart';

import '../constants/colors.dart';

class MySingleScroll extends StatefulWidget {
  final Widget child; // Parametr child, który przyjmuje zawartość (np. Column)
  final bool showScrollButton; // Parametr, który kontroluje widoczność przycisku przewijania

  const MySingleScroll({Key? key, required this.child, this.showScrollButton = true}) : super(key: key);

  @override
  _MySingleScrollState createState() => _MySingleScrollState();
}

class _MySingleScrollState extends State<MySingleScroll> {
  final ScrollController _scrollController = ScrollController(); // ScrollController
  bool _isAtBottom = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      setState(() {
        _isAtBottom = true;
      });
    } else {
      setState(() {
        _isAtBottom = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: widget.child,
          ),
          if (widget.showScrollButton && !_isAtBottom)
            Positioned(
              bottom: 20,
              right: 20,
              child: Container(
                decoration: const BoxDecoration(
                  color: lightThemeLightShade, // Kolor tła przycisku (możesz zmienić)
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_downward),
                  onPressed: () {
                    _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}