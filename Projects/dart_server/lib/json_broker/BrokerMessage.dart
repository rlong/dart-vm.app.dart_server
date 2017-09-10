

class BrokerMessage {


  String messageType;
  Map metaData;
  String serviceName;
  int majorVersion;
  int minorVersion;
  String methodName;
  Map associativeParameters;
  List orderedParameters;


  BrokerMessage(List value) {

    this.messageType = value[0];
    this.metaData = value[1];
    this.serviceName = value[2];
    this.majorVersion = value[3];
    this.minorVersion = value[4];
    this.methodName = value[5];

    if( 7 == value.length ) {

      final params = value[6];
      if( params is List ) {

        this.orderedParameters = params;
      } else {

        this.associativeParameters = params;
      }
    }
  }

}