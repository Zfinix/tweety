import 'package:dart_frog/dart_frog.dart';
import 'package:tweety/tweety_core.dart';

Handler middleware(Handler handler) {
  final tweetyCore = TweetyCore();

  return handler.use(provider<TweetyCore>((context) => tweetyCore));
}
