package com.gs3.plugins.caf

import com.getcapacitor.Plugin
import com.getcapacitor.PluginCall
import com.getcapacitor.PluginMethod
import com.getcapacitor.annotation.CapacitorPlugin

@CapacitorPlugin(name = "Caf")
class CafPlugin : Plugin() {
    @PluginMethod
    fun verifyPolicy(call: PluginCall) {
        val personId = call.getString("personId")
        val jwt = call.getString("jwt")
        if (personId == null || jwt == null) {
            call.reject("missing params: jwt or personId ");
        } else {
            call.setKeepAlive(true);
            val identity = IdentityPlugin(this.activity)
            getBridge().activity.runOnUiThread { identity.verifyPolicy(personId, jwt, call) }

        }
    }

}
