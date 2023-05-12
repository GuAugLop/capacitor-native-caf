package com.gs3.plugins.caf

import com.getcapacitor.JSObject
import com.getcapacitor.PluginCall
import com.getcapacitor.PluginMethod

class Identity(api_key: String) {
  val api_key = api_key

  fun Identity(): JSObject {
    val ret = JSObject()
    ret.put("api_key", this.api_key)
    return ret
  }
}
