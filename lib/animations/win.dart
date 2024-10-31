import 'package:flutter/material.dart';

class Win extends StatefulWidget {
  const Win({required this.child,required this.animate,required this.delay , super.key});

  final Widget child;
  final bool animate;
  final int delay;
  @override
  State<Win> createState() => _WinState();
}

class _WinState extends State<Win> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<Offset> _animation;


  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration:const Duration(milliseconds: 1000));


    _animation = TweenSequence<Offset>(
        [
          TweenSequenceItem(tween: Tween(begin: const Offset(0,0),  end:const Offset(0,-0.75)), weight: 15),    //kolejne sekwencje animacji
          TweenSequenceItem(tween: Tween(begin: const Offset(0,-0.75),  end: const Offset(0,0)), weight: 10),
          TweenSequenceItem(tween: Tween(begin:const Offset(0, 0) , end: const Offset(0, -0.3)), weight: 12),
          TweenSequenceItem(tween: Tween(begin:const Offset(0, -0.3) , end: const Offset(0, 0)), weight: 8),
        ]
    ).animate(CurvedAnimation(parent: _controller,  curve: Curves.easeInOutSine));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant Win oldWidget) {
    if(widget.animate)
      {
        Future.delayed(Duration(milliseconds: widget.delay), (){  //tutaj tez przeliczanie na podstawie poziomu
          _controller.forward();
        });

      }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(position: _animation,
      child: widget.child,
    );
  }
}
