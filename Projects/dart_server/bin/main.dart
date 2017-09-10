
import '../lib/dart_server.dart';
import '../lib/json_broker.server.dart';
import '../lib/json_broker.service.test.dart';
import '../lib/http_server.file.dart';
import 'dart:io';

int calculate() {
  return 6 * 7;
}

//void checkIndexed_db() {
//
//  print('IdbFactory.supported: ${IdbFactory.supported}');
//  if (IdbFactory.supported) {
//  }
//  else {
//  }
//}



main(List<String> arguments) async {

  print('Hello world: ${calculate()}!');

  var httpServer;
  try {
    httpServer =
    await HttpServer.bind(InternetAddress.ANY_IP_V4, 60419 );

  } catch (e) {
    print("Couldn't bind to port 10000: $e");
    exit(-1);
  }

  print('listening on localhost, port ${httpServer.port}');

  if( false ) {

    await for (HttpRequest request in httpServer) {
      request.response..write('Hello, world!')
        ..close();
    }
  }


  ServicesRequestHandler servicesRequestHandler;
  {
    servicesRequestHandler = new ServicesRequestHandler();
    servicesRequestHandler.servicesRegistry.registry[TestService.SERVICE_DESCRIPTION.serviceName] = new TestService();
    servicesRequestHandler.servicesRegistry.registry[ClipboardService.SERVICE_DESCRIPTION.serviceName] = new ClipboardService();
  }


  String rootPath = '/home/lrlong/Projects/dart-vm.app.dart_server/Projects/site/www';
  FileRequestHandler fileRequestHandler = new FileRequestHandler(rootPath);
  await fileRequestHandler.init();


  await for (HttpRequest request in httpServer) {

    if( '/services' == request.requestedUri.path ) {

      servicesRequestHandler.processRequest( request );

    } else {

      fileRequestHandler.processRequest(request );
    }

  }


}
