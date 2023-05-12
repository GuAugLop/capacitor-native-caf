package com.gs3.plugins.caf

import com.getcapacitor.JSObject
import com.getcapacitor.Plugin
import com.getcapacitor.PluginCall
import com.getcapacitor.PluginMethod
import com.getcapacitor.annotation.CapacitorPlugin

@CapacitorPlugin(name = "Caf")
class CafPlugin : Plugin() {
  var api_key = ""
  val idendity_ = Identity(this.api_key);

  @PluginMethod
  fun initialize(call: PluginCall) {
    val api_key = call.getString("api_key")
    if(api_key == null){
      call.reject("api_key is required");
    } else {
      this.api_key = api_key
      call.resolve()
    }
  }

  fun checkApiKey(call: PluginCall) {
    if(this.api_key.length == 0){
      call.reject("api_key is missing")
    }
  }

  @PluginMethod
  fun identity(call: PluginCall){
    this.checkApiKey(call);
  }

}
