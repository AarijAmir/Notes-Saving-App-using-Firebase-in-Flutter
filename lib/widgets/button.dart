import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ButtonForProceeding extends StatelessWidget {
  const ButtonForProceeding({
    Key? key,
    required this.callback,
    required this.buttonColor,
    required this.text,
  }) : super(key: key);
  final void Function() callback;
  final Color buttonColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: callback,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size.height * 0.1),
        child: Container(
          color: buttonColor,
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class TitleWithButton extends StatefulWidget {
  const TitleWithButton(
      {Key? key,
      required this.height,
      required this.width,
      required this.containerColor,
      required this.titleData,
      required this.callback})
      : super(key: key);
  final double height;
  final double width;
  final Color containerColor;
  final String titleData;
  final void Function() callback;

  @override
  State<TitleWithButton> createState() => _TitleWithButtonState();
}

class _TitleWithButtonState extends State<TitleWithButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController =
      AnimationController(vsync: this, duration: const Duration(seconds: 1))
        ..forward();

  late final Animation<Offset> _animationOfBackContainer =
      Tween(begin: const Offset(0, -1.5), end: Offset.zero).animate(
          CurvedAnimation(
              parent: _animationController, curve: Curves.elasticInOut));

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animationOfBackContainer,
      child: Padding(
        padding: EdgeInsets.all(widget.height * 0.05),
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.containerColor,
            borderRadius: BorderRadius.circular(
              widget.height * 0.15,
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding: EdgeInsets.only(
                    left: constraints.maxHeight * 0.1,
                    right: constraints.maxHeight * 0.1),
                child: Column(
                  children: [
                    const Spacer(
                      flex: 15,
                    ),
                    Expanded(
                      flex: 40,
                      child: Text(
                        widget.titleData,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: constraints.maxHeight * 0.15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Spacer(
                      flex: 10,
                    ),
                    Expanded(
                      flex: 20,
                      child: startNowButton(
                          buttonText: 'Start Here',
                          buttonColor: Colors.orange,
                          height: constraints.maxHeight * 0.22,
                          width: widget.width,
                          onTap: widget.callback),
                    ),
                    const Spacer(
                      flex: 15,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget startNowButton(
      {required String buttonText,
      required Color buttonColor,
      required double height,
      required double width,
      required void Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(height * 0.5),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                buttonText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: height * 0.3,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: width * 0.05),
              const Icon(Icons.arrow_forward, color: Colors.white)
            ],
          ),
        ),
      ),
    );
  }
}
