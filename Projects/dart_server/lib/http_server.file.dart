


import 'dart:io';
import 'package:dart_server/http_server.dart';


class FileRequestHandler {


  String rootPath;
  Directory root;

  FileRequestHandler( String rootPath) {
    this.rootPath = rootPath;
    this.root = new Directory(rootPath);

  }

  init() async {

    if (!(await root.exists())) {

      print( '!(await root.exists()); "${this.rootPath}" does not exist');
    }

  }

  @override
  processRequest(HttpRequest request) async {

    print("req.requestedUri.path: ${request.requestedUri.path}");
    print("req.uri: ${request.uri}");

    var requestedPath = request.requestedUri.path;
    if( '/' == requestedPath[requestedPath.length -1 ] ) {
      requestedPath += "index.html";
    }
    var assetPath = rootPath + requestedPath;
    print("assetPath: $assetPath");

    var file = new File( assetPath );

    if (await file.exists()) {

      print("Serving index.html.");
      request.response.headers.contentType = ContentTypesProvider.lookup( assetPath );

      try {
        await file.openRead().pipe(request.response);
      } catch (e) {
        print("Couldn't read file: $e");
        exit(-1);
      }
    } else {

      request.response..statusCode = HttpStatus.NOT_FOUND
        ..close();
    }
  }
}