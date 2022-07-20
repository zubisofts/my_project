import 'dart:convert';
import 'dart:developer';

import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final request = context.request;
  Uri url = request.url;
  final body = await request.json();
  log('REQUEST BODY: ${url.path}');

  return Response.json(
    body: <String, dynamic>{'status': true, 'path': url.path}..addAll(body),
  );
}
