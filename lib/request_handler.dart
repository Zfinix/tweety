import 'dart:io';
import 'package:dart_frog/dart_frog.dart';

/// Handle Errors from Requests
Future<Response> requestHandler(
  Future<Response?> Function() handler,
) async {
  try {
    return (await handler()) ?? Response.json(body: {});
  } catch (e) {
    return Response(
      body: e.toString(),
      statusCode: HttpStatus.internalServerError,
    );
  }
}
