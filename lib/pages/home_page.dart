import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  _body() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Lottie.asset(
            'assets/animations/payment.json',
            controller: _controller,
            onLoaded: (composition) {
              _controller.duration = composition.duration;
              _controller.repeat();
            },
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) => Row(
              children: <Widget>[
                Expanded(
                  child: Slider(
                    value: _controller.value,
                    onChanged: (newValue) {
                      _controller.value = newValue;
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(
                      _controller.isAnimating ? Icons.stop : Icons.play_arrow),
                  onPressed: () {
                    setState(() {
                      if (_controller.isAnimating) {
                        _controller.stop();
                      } else {
                        _controller.repeat();
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
