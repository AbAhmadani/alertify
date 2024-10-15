part of alertify;

class CustomAlert extends StatefulWidget {
  final String uniqueKey;

  const CustomAlert({Key? key, required this.uniqueKey}) : super(key: key);

  @override
  _CustomAlertState createState() => _CustomAlertState();
}

class _CustomAlertState extends State<CustomAlert> {
  bool _isVisible = false;
  double _height = 0.0;
  Timer? _timer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final notifier = context.watch<AlertNotifier>();
    if (notifier.isVisible(widget.uniqueKey)) {
      _showAlert(notifier);
    } else {
      _hideAlert(notifier);
    }
  }

  void _showAlert(AlertNotifier notifier) {
    _timer?.cancel();
    setState(() {
      _isVisible = true;
      _height = 50.0;
    });

    final duration = notifier.getDuration(widget.uniqueKey);
    _timer = Timer(Duration(seconds: duration), () {
      _hideAlert(notifier);
    });
  }

  void _hideAlert(AlertNotifier notifier) {
    setState(() {
      _height = 0.0;
    });

    _timer?.cancel();

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        notifier.hideAlert(widget.uniqueKey);
        setState(() {
          _isVisible = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: _height,
      child: _isVisible
          ? _buildAlertContent(
              context.read<AlertNotifier>().getMessage(widget.uniqueKey),
              context.read<AlertNotifier>().getType(widget.uniqueKey),
              context.read<AlertNotifier>(),
            )
          : const SizedBox.shrink(),
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
      child: Row(
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
      ),
    );
  }
}
