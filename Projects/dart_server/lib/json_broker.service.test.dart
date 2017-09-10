
import 'json_broker.dart';
import 'json_broker.server.dart';

class TestService extends DescribedService {

  static final ServiceDescription SERVICE_DESCRIPTION = new ServiceDescription('json_broker.TestService');


  /*
DATA=$(cat <<-EOD
["request",{},"json_broker.TestService",1,0,"ping",{}]
EOD
)
curl -X POST  -d "$DATA" http://localhost:10000/services

   */
  void ping()
  {

    print('TestService.ping!');
  }

  @override
  BrokerMessage process(BrokerMessage request) {

    String methodName = request.methodName;

    switch( methodName ) {
      case "ping":
        this.ping();
        return request.buildResponse();
    }

    throw ServiceHelper.methodNotFound( this, SERVICE_DESCRIPTION, request);

  }

  @override
  ServiceDescription get serviceDescription => SERVICE_DESCRIPTION;
}