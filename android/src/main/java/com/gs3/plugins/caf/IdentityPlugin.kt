package com.gs3.plugins.caf

import android.content.Context
import com.combateafraude.identity.input.Identity
import com.combateafraude.identity.input.VerifyPolicyListener
import com.combateafraude.identity.output.Failure
import org.json.JSONObject

class IdentityPlugin(api_key: String, context: Context) {
    var identity: Identity = Identity.Builder(api_key, context).build();

    fun verifyPolicy(personId: String){
        identity.verifyPolicy(personId, "123", object : VerifyPolicyListener {
            override fun onSuccess(isAuthorized: Boolean, attestation: String?) {
                val ret = JSONObject()
                ret.put("isAuthorized", isAuthorized)
                ret.put("attestation", attestation)
            }
            override fun onError(failure: Failure?) {
                TODO("Not yet implemented")
            }

        })
    }
}