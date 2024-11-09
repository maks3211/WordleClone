import 'package:flutter/material.dart';

class Bounce extends StatefulWidget {
  const Bounce ({required this.child,required this.aniamte , super.key});

  final Widget child;
  final bool aniamte;

  @override
  State<Bounce> createState() => _State();
}

class _State extends State<Bounce> with SingleTickerProviderStateMixin {

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController =AnimationController(vsync: this, duration:const Duration(milliseconds: 200));
    _animation = TweenSequence<double>(
      [
        TweenSequenceItem(tween: Tween(begin: 1.0,  end: 1.3), weight: 1),    //kolejne sekwencje animacji
        TweenSequenceItem(tween: Tween(begin: 1.3,  end: 1.0), weight: 1),
      ]
    ).animate(CurvedAnimation(parent: _animationController,  curve: Curves.bounceInOut));
    super.initState();
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

/*  @override
  void didUpdateWidget(covariant Bounce oldWidget) {
    if(widget.aniamte)
      {
        _animationController.reset();
        _animationController.forward();
      }
    super.didUpdateWidget(oldWidget);
  }*/

  @override
  void didUpdateWidget(covariant Bounce oldWidget) {
    if(widget.aniamte)
      {
        WidgetsBinding.instance.addPostFrameCallback((timestamp){
          if(mounted)
            {
              _animationController.reset();
              _animationController.forward();
            }
        });
      }
    super.didUpdateWidget(oldWidget);
  }


  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: _animation, child: widget.child);
  }
}
