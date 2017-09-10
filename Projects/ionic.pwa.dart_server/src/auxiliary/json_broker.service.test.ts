
import {Http, Headers, RequestOptionsArgs} from "@angular/http"
import {BrokerAdapter,BrokerMessage} from "./json_broker";
import 'rxjs/Rx';


const SERVICE_NAME = "json_broker.TestService";


export class TestProxy {


  constructor( private brokerAdapter:BrokerAdapter ) {
  }

  async ping()   {

    let request = BrokerMessage.buildRequest( SERVICE_NAME, "ping"  );
    let response = await this.brokerAdapter.dispatch( request );
    // response.namedParameters[""]

    //
    //
    // let request = BrokerMessage.buildRequest( SERVICE_NAME, "ping" );
    //
    // return this.adapter.dispatch( request ).then(
    //   () => {}
    // );
  }
}
