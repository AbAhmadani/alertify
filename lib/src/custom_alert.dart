part of alertify;

class CustomAlert extends StatefulWidget {
  final String uniqueKey;

  const CustomAlert({Key? key, required this.uniqueKey}) : super(key: key);

  @override
  _CustomAlertState createState() => _CustomAlertState();
}

class _CustomAlertState extends State<CustomAlert> {
  bool _isVisible = false;
  double _height = 0.0; // Track height for animation
  Timer? _timer; // Timer variable to manage the auto-hide

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final notifier = context.watch<AlertNotifier>();
    // Check if the alert is visible
    if (notifier.isVisible(widget.uniqueKey)) {
      _showAlert(notifier);
    } else if (!notifier.isVisible(widget.uniqueKey)) {
      _hideAlert(notifier);
    }
  }

  void _showAlert(AlertNotifier notifier) {
    // Cancel the existing timer if it's active
    _timer?.cancel();

    // Set the state to make the alert visible
    setState(() {
      _isVisible = true;
      _height = 50.0; // Set height to 50 when visible
    });

    // Start a new timer to auto-hide the alert after the specified duration
    final duration = notifier.getDuration(widget.uniqueKey);
    _timer = Timer(Duration(seconds: duration), () {
      _hideAlert(notifier);
    });
  }

  void _hideAlert(AlertNotifier notifier) {
    setState(() {
      _height = 0.0; // Set height to 0 when hiding
    });

    // Cancel the timer if it's active
    _timer?.cancel();

    Future.delayed(const Duration(milliseconds: 300), () {
      // Update visibility after the animation duration.
      if (mounted) {
        notifier.hideAlert(widget.uniqueKey);
        setState(() {
          _isVisible = false; // Update visibility state after hiding
        });
      }
    });
  }

  @override
  void dispose() {
    // Ensure the timer is canceled when the widget is disposed
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: _height, // Animate height
      child: _isVisible
          ? _buildAlertContent(
              context.read<AlertNotifier>().getMessage(widget.uniqueKey),
              context.read<AlertNotifier>().getType(widget.uniqueKey),
              context.read<AlertNotifier>(),
            )
          : const SizedBox.shrink(), // Return empty box if not visible
    );
  }

  Widget _buildAlertContent(
      String message, AlertType type, AlertNotifier notifier) {
    IconData iconData;
    Color backgroundColor;
    Color borderColor;

    switch (type) {
      case AlertType.success:
        iconData = Icons.check_circle_outline;
        backgroundColor = Colors.green[100]!;
        borderColor = Colors.green[600]!;
        break;
      case AlertType.error:
        iconData = Icons.error_outline;
        backgroundColor = Colors.red[100]!;
        borderColor = Colors.red[600]!;
        break;
      case AlertType.warning:
        iconData = Icons.warning_amber_outlined;
        backgroundColor = Colors.amber[100]!;
        borderColor = Colors.amber[600]!;
        break;
      case AlertType.info:
      default:
        iconData = Icons.info_outline;
        backgroundColor = Colors.blue[100]!;
        borderColor = Colors.blue[600]!;
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: borderColor, width: 2.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.all(5),
      child: _height > 25
          ? Row(
              children: [
                Icon(iconData, color: borderColor),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  iconSize: 20,
                  icon: const Icon(Icons.close),
                  color: borderColor,
                  onPressed: () {
                    _hideAlert(notifier);
                  },
                ),
              ],
            )
          : Container(),
    );
  }
}
