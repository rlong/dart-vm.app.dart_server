

import 'dart:convert';

class BaseException {

  int subject = 0;
  int predicate = 0;
  int object = 0;


  static AsciiCodec asciiCodec = new AsciiCodec();


  BaseException( Object originatingObject, String message ) {

  }

  // BaseException.faultCodeToString( 560361060 );
  static String faultCodeToString( int faultCode ) {

    List<int> chars = new List(4);

    while (0 < faultCode) {

      final asciiCode = faultCode & 0xFF;
      chars.add( asciiCode );
    }

    return asciiCodec.decode( chars );
  }

  // BaseException.stringToFaultCode( '!fnd' );
  static int stringToFaultCode( String faultCode ) {

    int answer = 0;

    if( faultCode.length > 4  ) {
      faultCode = faultCode.substring( 0, 3 );
    }

    var chars = asciiCodec.encode( faultCode );

    for( var char in chars ) {

      answer <<= 8;
      answer |= char;
    }

    return answer;
  }

}