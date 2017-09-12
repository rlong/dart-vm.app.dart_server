

import 'dart_annex.dart';
import 'dart:io';
import 'dart:convert';
import 'http_server.dart';
import 'json_broker.dart';


abstract class DescribedService extends Service {

  ServiceDescription get serviceDescription;

}

abstract class Service {

  BrokerMessage process(BrokerMessage request);
}


class ServiceDescription {

  String serviceName;

  ServiceDescription( String serviceName ) {
    this.serviceName = serviceName;
  }


  // vvv http://pchalin.blogspot.ie/2014/04/defining-equality-and-hashcode-for-dart.html

  bool operator ==(o) => o is ServiceDescription && o.serviceName == serviceName;

  int get hashCode => serviceName.hashCode;

  // ^^^ http://pchalin.blogspot.ie/2014/04/defining-equality-and-hashcode-for-dart.html


}


class ServiceHelper {

  static BaseException methodNotFound(Object originator, ServiceDescription serviceDescription, BrokerMessage request)
  {

    BaseException answer = new BaseException(originator, 'Unknown methodName; methodName = "${request.methodName}"');
    return answer;
  }
}

class ServicesRegistry implements Service{

  Map<String,DescribedService> registry = new Map();

  @override
  BrokerMessage process(BrokerMessage request) {

    if( ! registry.containsKey( request.serviceName )) {

      throw new BaseException(this, 'Unknown serviceName; request.serviceName = "${request.serviceName}"');
    }

    return registry[ request.serviceName ].process( request );
  }
}


class ServicesRequestHandler implements RequestHandler {


  ServicesRegistry servicesRegistry;


  ServicesRequestHandler() {

    this.servicesRegistry = new ServicesRegistry();
  }


  processRequest(HttpRequest httpRequest) async {

    // vvv https://www.dartlang.org/tutorials/dart-vm/httpserver

    var jsonRequest = await httpRequest.transform(UTF8.decoder).join();

    var serviceRequest = new BrokerMessage( JSON.decode(jsonRequest) );
    var serviceResponse = this.servicesRegistry.process( serviceRequest );

    var jsonResponse = JSON.encode(serviceResponse.toList());
    httpRequest.response..statusCode = HttpStatus.OK
      ..write( jsonResponse )
      ..close();

    // ^^^ https://www.dartlang.org/tutorials/dart-vm/httpserver

  }



}