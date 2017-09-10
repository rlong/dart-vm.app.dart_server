


import {Http, Headers, RequestOptionsArgs} from "@angular/http"
import {BrokerAdapter,BrokerMessage} from "./json_broker";
import 'rxjs/Rx';


const SERVICE_NAME = "ClipboardService";


export class ClipboardProxy {


  constructor( private brokerAdapter:BrokerAdapter ) {
  }

  async ping()   {

    let request = BrokerMessage.buildRequest( SERVICE_NAME, "ping"  );
    let response = await this.brokerAdapter.dispatch( request );
  }

  async getClipboard(): Promise<string> {

    let request = BrokerMessage.buildRequest( SERVICE_NAME, "getClipboard"  );
    let response = await this.brokerAdapter.dispatch( request );
    return response.namedParameters["value"];
  }

  async setClipboard( value: string ) {

    let request = BrokerMessage.buildRequest( SERVICE_NAME, "setClipboard"  );
    request.namedParameters["value"] = value;
    let response = await this.brokerAdapter.dispatch( request );
  }
}

