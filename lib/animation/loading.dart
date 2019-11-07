 import 'package:flutter/material.dart';
 
class LoadingBouncingGrid extends StatefulWidget {
  final AnimationController controller;
  final BoxShape _shape;
  final Color backgroundColor;
  final Color borderColor;
  final double size;
  final double borderSize;
  final bool inverted;
  final Duration duration;
  final IndexedWidgetBuilder itemBuilder;
  LoadingBouncingGrid.circle({
    Key key,
    this.controller,
    this.backgroundColor = Colors.green,
    this.borderColor = Colors.transparent,
    this.size = 50.0,
    this.borderSize,
    this.inverted = false,
    this.itemBuilder,
    this.duration = const Duration(milliseconds: 1500),
  })  : assert(backgroundColor != null,
  'loading_animations: property [backgorundColor] must not be null'),
        assert(borderColor != null,
        'loading_animations: property [borderColor] must not be null'),
        assert(size != null,
        'loading_animations: property [size] must not be null'),
        assert(borderSize != null ? borderSize < size / 2 : true,
        'loading_animations: property [borderSize] must not be greater than half the widget size'),
        assert(duration != null,
        'loading_animations: property [duration] must not be null'),
        _shape = BoxShape.circle,
        super(key: key);

  LoadingBouncingGrid.square({
    Key key,
    this.controller,
    this.backgroundColor = Colors.blueGrey,
    this.borderColor = Colors.transparent,
    this.size = 50.0,
    this.borderSize,
    this.inverted = false,
    this.itemBuilder,
    this.duration = const Duration(milliseconds: 1500),
  })  : assert(size != null,
  'loading_animations: property [size] must not be null'),
        assert(borderSize != null ? borderSize < size / 2 : true,
        'loading_animations: property [borderSize] must not be greater than half the widget size'),
        assert(duration != null,
        'loading_animations: property [duration] must not be null'),
        _shape = BoxShape.rectangle,
        super(key: key);

  @override
  _LoadingBouncingGridState createState() => _LoadingBouncingGridState();
}

class _LoadingBouncingGridState extends State<LoadingBouncingGrid>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation1,
      _animation2,
      _animation3,
      _animation4,
      _animation5;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ??
        AnimationController(vsync: this, duration: widget.duration);

    _animation1 = Tween(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    _animation2 = Tween(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.1, 0.7, curve: Curves.easeIn),
      ),
    );

    _animation3 = Tween(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.8, curve: Curves.easeIn),
      ),
    );

    _animation4 = Tween(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.9, curve: Curves.easeIn),
      ),
    );

    _animation5 = Tween(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller
      ..addListener(() => setState(() {}))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
        if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size.square(widget.size),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildSquare(_animation3, 0),
              _buildSquare(_animation4, 1),
              _buildSquare(_animation5, 2),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildSquare(_animation2, 3),
              _buildSquare(_animation3, 4),
              _buildSquare(_animation4, 5),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildSquare(_animation1, 6),
              _buildSquare(_animation2, 7),
              _buildSquare(_animation3, 8),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSquare(Animation<double> animation, int index) {
    int invertedOffset = widget.inverted ? 1 : 0;
    return Transform.scale(
      scale: invertedOffset - animation.value.abs(),
      child: _itemBuilder(index),
    );
  }

  Widget _itemBuilder(int index) {
    return SizedBox.fromSize(
      size: Size.square(widget.size / 3),
      child: widget.itemBuilder != null
          ? widget.itemBuilder(context, index)
          : DecoratedBox(
        decoration: BoxDecoration(
          shape: widget._shape,
          color: widget.backgroundColor,
          border: Border.all(
            color: widget.borderColor,
            width: widget.borderSize ?? widget.size / 24,
            style: BorderStyle.solid,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}



class CustomButton extends StatelessWidget {
  CustomButton({@required this.onPressed});
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      child: RawMaterialButton(
        fillColor: Colors.green,
        splashColor: Colors.greenAccent,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children:  <Widget>[
                Icon(
                  Icons.face,
                  color: Colors.amber,
                ),
              SizedBox(
                width: width/2,
              ),
                Text(
                  "Tap Me",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        onPressed: onPressed,
        shape: const StadiumBorder(),
      ),
    );
  }
}
