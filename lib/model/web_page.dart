import 'package:meta/meta.dart';

@immutable
class WebPage {
  final String title;
  final String url;

  const WebPage({
    @required this.title,
    @required this.url,
  });
}
