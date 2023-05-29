package com.gs3.plugins.caf

import com.getcapacitor.Plugin
import com.getcapacitor.PluginCall
import com.getcapacitor.PluginMethod
import com.getcapacitor.annotation.CapacitorPlugin



@CapacitorPlugin(name = "Caf")
class CafPlugin : Plugin() {
    // Identity
    @PluginMethod
    fun verifyPolicy(call: PluginCall) {
        val personId = call.getString("personId")
        val jwt = call.getString("jwt")
        val policyId = call.getString("policyId")
        if (personId == null || jwt == null || policyId == null) {
            call.reject("missing params: jwt, personId or policyId ");
        } else {
            call.setKeepAlive(true);
            val mIdentity = IdentityPlugin(this.activity)
            getBridge().activity.runOnUiThread {
                mIdentity.verifyPolicy(
                    personId,
                    jwt,
                    policyId,
                    call
                )
            }

        }
    }


    // Face Authenticator
    /* @PluginMethod
    fun faceAuthenticator(call: PluginCall) {
        val cpf = call.getString("cpf")
        val jwt = call.getString("jwt")
        if (cpf == null || jwt == null) {
            call.reject("missing params: jwt or cpf ");
        } else {
            call.setKeepAlive(true)
            val mFaceAuthenticator = FaceAuthenticatorPlugin(this.activity);
            startActivityForResult(call, mFaceAuthenticator.faceAuthenticator(jwt, cpf), "faceAuthenticatorResult")
        }
    }

    @ActivityCallback
    private fun faceAuthenticatorResult(call: PluginCall, result: ActivityResult) {
        val resultCode: Int = result.resultCode
        if (resultCode == Activity.RESULT_OK && result.resultData != null) {
            val mFaceAuthenticatorResult: FaceAuthenticatorResult = result.resultData
                .getSerializableExtra(FaceAuthenticatorResult.PARAMETER_NAME) as FaceAuthenticatorResult
            if (mFaceAuthenticatorResult.wasSuccessful()) {
                val responseMap: HashMap<String, Any?> = HashMap()
                responseMap["success"] = Boolean.TRUE
                responseMap["isAuthenticated"] = mFaceAuthenticatorResult.isAuthenticated;
                responseMap["signedResponse"] = mFaceAuthenticatorResult.signedResponse
                responseMap["trackingId"] = mFaceAuthenticatorResult.trackingId
                responseMap["lensFacing"] = mFaceAuthenticatorResult.lensFacing
                val jsonObject = JSONObject(responseMap)
                val result = JSObject()
                result.put("results", jsonObject);
                call.resolve(result)
            } else {
                call.reject(mFaceAuthenticatorResult.sdkFailure?.message)
            }
        } else {
            call.reject("Algo de errado aconteceu, tente novamente mais tarde")
        }
    } */

}
