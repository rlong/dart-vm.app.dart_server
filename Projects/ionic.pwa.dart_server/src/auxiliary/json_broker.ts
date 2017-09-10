
import {Http, Headers, RequestOptionsArgs} from "@angular/http"
import 'rxjs/Rx';



export class BrokerMessage {

  messageType: string = "request"; // 'fault'/'oneway'/'request'/'response'/'event'
  metaData: any = {};
  serviceName: string = "__SERVICE_NAME__";
  majorVersion: number = 1;
  minorVersion: number = 0;
  methodName: string = "__METHOD_NAME__";
  namedParameters: any = {};
  orderedParameters: any[];

  constructor(poja?: any[]) { // poja: plain old javascript array
    if (poja) {
      this.messageType = poja[0];
      this.metaData = poja[1];
      this.serviceName = poja[2];
      this.majorVersion = poja[3];
      this.minorVersion = poja[4];
      this.methodName = poja[5];
      let params = poja[6];
      if (Array.isArray(params)) {
        this.orderedParameters = params;
      } else {
        this.namedParameters = params;
      }
    }
  }


  public static buildRequest(serviceName: string, methodName: string): BrokerMessage {

    let answer: BrokerMessage = new BrokerMessage();
    answer.serviceName = serviceName;
    answer.methodName = methodName;
    return answer;

  }

  public static buildRequestWithOrderedParameters(serviceName: string,
                                                  methodName: string,
                                                  orderedParameters: any[] = []): BrokerMessage {

    let answer: BrokerMessage = new BrokerMessage();
    answer.serviceName = serviceName;
    answer.methodName = methodName;
    answer.orderedParameters = orderedParameters;

    return answer;

  }

  toArray(): any[] {
    var answer = new Array(6);
    answer[0] = this.messageType;
    answer[1] = this.metaData;
    answer[2] = this.serviceName;
    answer[3] = this.majorVersion;
    answer[4] = this.minorVersion;
    answer[5] = this.methodName;
    answer[6] = this.namedParameters;
    if (this.orderedParameters) {
      answer[6] = this.orderedParameters;
    }
    return answer;
  }

  toData(): any {
    return JSON.stringify(this.toArray());
  }
}


export class BrokerAdapter {


  constructor( private http:Http ) {

  }

  async dispatch(request: BrokerMessage): Promise<BrokerMessage> {

    let response = await this.http.post( "/services", request.toData() ).first().toPromise();
    return new BrokerMessage( response.json() );
  }
}
