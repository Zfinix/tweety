import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:tweety/request_handler.dart';
import 'package:tweety/tweety_core.dart';

Future<Response> onRequest(RequestContext context) async {
  return requestHandler(
    () async {
      final param = context.request.uri.queryParameters.entries.first;
      final core = context.read<TweetyCore>();

      await core.initialize();
      await core.goto(param.value);

      if (param.key == 'text') {
        final text = await core.getTweetText<dynamic>();
        return Response.json(body: {'data': text});
      }

      if (param.key == 'screenshot') {
        final screenshot = await core.screenshotTweet();
        return Response.bytes(
          body: screenshot,
          headers: {
            HttpHeaders.contentTypeHeader: 'image/png',
            HttpHeaders.accessControlAllowOriginHeader: '*',
          },
        );
      }

      await core.closeBrowser();
      return null;
    },
  );
}
