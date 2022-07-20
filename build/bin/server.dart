// ignore_for_file: prefer_single_quotes, implicit_dynamic_list_literal, prefer_const_constructors, lines_longer_than_80_chars, avoid_dynamic_calls, library_prefixes, directives_ordering

import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import '../routes/index.dart' as routes_index;
import '../routes/api/paystack_webhook.dart' as routes_api_paystack_webhook;


void main() => createServer();

Future<HttpServer> createServer() async {
  final ip = InternetAddress.anyIPv4;
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final handler = Cascade().add(buildRootHandler()).handler;
  return serve(handler, ip, port);
}

Handler buildRootHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..mount('/api', (r) => buildApiHandler()(r))
    ..mount('/', (r) => buildHandler()(r));
  return pipeline.addHandler(router);
}

Handler buildApiHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/paystack_webhook', routes_api_paystack_webhook.onRequest);
  return pipeline.addHandler(router);
}

Handler buildHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', routes_index.onRequest);
  return pipeline.addHandler(router);
}
