package com.gs3.plugins.caf

import android.util.Log

class Caf {
    fun echo(value: String?): String? {
        Log.i("Echo", value!!)
        return value
    }
}
