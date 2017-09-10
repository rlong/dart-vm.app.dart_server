
import 'dart_annex.dart';

class BrokerMessage {

  BrokerMessageType messageType;
  Map metaData;
  String serviceName;
  int majorVersion;
  int minorVersion;
  String methodName;
  Map namedParameters;
  List orderedParameters;

  BrokerMessage([List value = null]) {

    if( null != value ) {

      this.messageType = BrokerMessageType.lookup( value[0] );
      this.metaData = value[1];
      this.serviceName = value[2];
      this.majorVersion = value[3];
      this.minorVersion = value[4];
      this.methodName = value[5];
      this.namedParameters = value[6];
    }
  }

  BrokerMessage buildResponse()
  {
    BrokerMessage answer = new BrokerMessage();

    answer.messageType = BrokerMessageType.RESPONSE;
    answer.metaData = this.metaData;
    answer.serviceName = this.serviceName;
    answer.majorVersion = this.majorVersion;
    answer.minorVersion = this.minorVersion;
    answer.methodName = this.methodName;
    answer.namedParameters = new Map();

    return answer;
  }


  List toList() {
    List answer;

    answer = new List(7);
//    if (null != this.namedParameters || null != this.orderedParameters) {
//    } else {
//      answer = new List(6);
//    }
    answer[0] = this.messageType.value;
    answer[1] = this.metaData;
    answer[2] = this.serviceName;
    answer[3] = this.majorVersion;
    answer[4] = this.minorVersion;
    answer[5] = this.methodName;
    answer[6] = this.namedParameters;

//    if (null != this.namedParameters) {
//      answer[6] = this.namedParameters;
//    } else if (null != this.orderedParameters) {
//      answer[6] = this.orderedParameters;
//    }
    return answer;
  }
}

class BrokerMessageType {


  static final BrokerMessageType FAULT = new BrokerMessageType( 'fault');
  static final BrokerMessageType META_REQUEST = new BrokerMessageType("meta-request");
  static final BrokerMessageType META_RESPONSE = new BrokerMessageType("meta-response");
  static final BrokerMessageType NOTIFICATION = new BrokerMessageType("notification");
  static final BrokerMessageType ONEWAY = new BrokerMessageType("oneway");
  static final BrokerMessageType REQUEST = new BrokerMessageType("request");
  static final BrokerMessageType RESPONSE = new BrokerMessageType("response");

  static final List<BrokerMessageType> TYPES = [FAULT, META_REQUEST, META_RESPONSE, NOTIFICATION, ONEWAY, REQUEST, RESPONSE];

  String value;

  BrokerMessageType( String value ) {

    this.value = value;
  }


  static lookup( String value ) {

    for( var candidate in TYPES ) {

      if( candidate.value == value ) {

        return candidate;
      }
    }

    throw new BaseException( BrokerMessageType, 'bad type: $value');
  }


  // vvv http://pchalin.blogspot.ie/2014/04/defining-equality-and-hashcode-for-dart.html
  bool operator ==(o) => o is BrokerMessageType && o.value == value;
  // ^^^ http://pchalin.blogspot.ie/2014/04/defining-equality-and-hashcode-for-dart.html




}