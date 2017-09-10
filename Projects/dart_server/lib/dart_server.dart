




import 'json_broker.dart';
import 'json_broker.server.dart';

class ClipboardService extends DescribedService {

  static final ServiceDescription SERVICE_DESCRIPTION = new ServiceDescription('ClipboardService');

  String value = "hey hey";


  /*
DATA=$(cat <<-EOD
["request",{},"ClipboardService",1,0,"ping",{}]
EOD
)
curl -X POST  -d "$DATA" http://localhost:10000/services
   */
  void ping()
  {

    print('TestService.ping!');
  }

  /*
DATA=$(cat <<-EOD
["request",{},"ClipboardService",1,0,"getClipboard",{}]
EOD
)
curl -X POST  -d "$DATA" http://localhost:10000/services
   */
  String getClipboard() {

    return this.value;
  }

  /*
DATA=$(cat <<-EOD
["request",{},"ClipboardService",1,0,"setClipboard",{"value":"test"}]
EOD
)
curl -X POST  -d "$DATA" http://localhost:10000/services
   */
  void setClipboard( String value ) {

    this.value = value;
  }

  @override
  BrokerMessage process(BrokerMessage request) {

    String methodName = request.methodName;

    switch( methodName ) {

      case "getClipboard":

        var response = request.buildResponse();
        response.namedParameters["value"] = getClipboard();
        return response;

      case "setClipboard":

        this.setClipboard( request.namedParameters["value"] );
        return request.buildResponse();
    }

    throw ServiceHelper.methodNotFound( this, SERVICE_DESCRIPTION, request);

  }

  @override
  ServiceDescription get serviceDescription => SERVICE_DESCRIPTION;
}