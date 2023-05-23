package com.gs3.plugins.caf

import com.getcapacitor.JSObject
import com.getcapacitor.Plugin
import com.getcapacitor.PluginCall
import com.getcapacitor.PluginMethod
import com.getcapacitor.annotation.CapacitorPlugin
import org.json.JSONObject

@CapacitorPlugin(name = "Caf")
class CafPlugin : Plugin() {
    var api_key = ""
    val idendity = IdentityPlugin(this.api_key, this.activity);

    @PluginMethod
    fun initialize(call: PluginCall) {
        val api_key = call.getString("api_key")
        if (api_key == null) {
            call.reject("api_key is required");
        } else {
            this.api_key = api_key
            call.resolve()
        }
    }

    fun checkApiKey(call: PluginCall) {
        if (this.api_key.length == 0) {
            call.reject("api_key is missing")
        }
    }

    @PluginMethod
    fun verifyPolicy(call: PluginCall) {
        this.checkApiKey(call);

        val personId = call.getString("personId")
        if (personId == null) {
            call.reject("personId is required");
        } else {
            val data = this.idendity.verifyPolicy(personId)
            val ret = JSObject(data.toString())
            call.resolve(ret)
        }
    }

}
