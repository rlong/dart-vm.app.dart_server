import { Component, OnInit } from '@angular/core';
import { NavController } from 'ionic-angular';
import {Http, Headers, RequestOptionsArgs} from "@angular/http"
import {BrokerAdapter} from "../../auxiliary/json_broker";
import {TestProxy} from "../../auxiliary/json_broker.service.test";
import {ClipboardProxy} from "../../auxiliary/dart_server";
import { } from "@angular/core";

@Component({
  selector: 'page-home',
  templateUrl: 'home.html'
})
export class HomePage implements OnInit {

  public testProxy: TestProxy;
  public clipboardProxy: ClipboardProxy;
  public clipboardValue: string = "...";
  public lines: number = 5;

  constructor(public navCtrl: NavController, private http:Http) {

    let brokerAdapter: BrokerAdapter = new BrokerAdapter( http );
    this.testProxy = new TestProxy( brokerAdapter );
    this.clipboardProxy = new ClipboardProxy( brokerAdapter );
  }


  async ngOnInit() {

    this.getClipboard();
  }


  async getClipboard() {

    this.clipboardValue = await this.clipboardProxy.getClipboard();

  }

  async setClipboard() {

    await this.clipboardProxy.setClipboard( this.clipboardValue );
  }

}
