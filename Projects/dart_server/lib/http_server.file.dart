


import 'dart:async';
import 'dart:io';
import 'http_server.dart';


// https://github.com/rlong/dotnet.lib.HttpLibrary/blob/master/file.server/FileGetRequestHandler.cs
class FileGetRequestHandler implements RequestHandler {


  String rootPath;
  Directory root;

  FileGetRequestHandler( String rootPath) {
    this.rootPath = rootPath;
    this.root = new Directory(rootPath);

  }

  init() async {

    if (!(await root.exists())) {

      print( '!(await root.exists()); "${this.rootPath}" does not exist');
    }

  }

  Future<String> getETag( File file ) async {

    DateTime lastModified = await file.lastModified();
    int length = await file.length();
    return "${lastModified.millisecondsSinceEpoch}.${length}";

  }

  @override
  processRequest(HttpRequest request) async {

    // print("req.requestedUri.path: ${request.requestedUri.path}");
    // print("req.uri: ${request.uri}");

    var requestedPath = request.requestedUri.path;
    if( '/' == requestedPath[requestedPath.length -1 ] ) {
      requestedPath += "index.html";
    }
    var assetPath = rootPath + requestedPath;
    // print("assetPath: $assetPath");

    var file = new File( assetPath );



    if (await file.exists()) {

      print("Serving index.html.");
      request.response.headers.contentType = ContentTypesProvider.lookup( assetPath );

      // client has already been here ?
      {

        String eTag = await getETag( file );

        // String ifNoneMatch = request.getHttpHeader("if-none-match");
        String ifNoneMatch = request.headers.value( HttpHeaders.IF_NONE_MATCH );

        if (null != ifNoneMatch && ifNoneMatch == eTag ) {

          request.response..statusCode = HttpStatus.NOT_MODIFIED
            ..close();
          return;
        }

        request.response.headers.set(HttpHeaders.ETAG, eTag);
      }

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