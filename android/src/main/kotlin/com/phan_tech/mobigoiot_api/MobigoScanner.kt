package com.phan_tech.mobigoiot_api

import android.os.Handler
import android.os.Looper
import android.util.Log
import com.mobiiot.androidqapi.api.MobiIotScannerApi
import com.mobydata.CSscanner
import com.mobydata.CSscannerCallback
import com.mobydata.EVResult
import io.flutter.plugin.common.EventChannel
import org.json.JSONObject

class MobigoScanner {
    companion object {

        fun scannerIsOpen(): Boolean{
            return MobiIotScannerApi.isScannerOpened()
        }


        fun startScanner(
            turnOnFlash: Boolean,
            turnOnBeep: Boolean,
            turnOnVibration: Boolean,
            scannerMode: String,
            delay: Int,
        ): Boolean{
            return try {

                val scannerInterfaceService: CSscanner = MobiIotScannerApi.scannerInterfaceService

                scannerInterfaceService.setFlash(turnOnFlash)
                scannerInterfaceService.setScannerBeep(turnOnBeep)
                scannerInterfaceService.setScannerVibrating(turnOnVibration)
                scannerInterfaceService.setScanMode(scannerMode)
                scannerInterfaceService.setContinuousModeDelay(delay)
                if(scannerMode != "TRIGGER"){
                    scannerInterfaceService.startScanner()
                }

                true
            }catch (e: Exception){
                false
            }
        }


        fun startScanner(): Boolean{
            return try {

                val scannerInterfaceService: CSscanner = MobiIotScannerApi.scannerInterfaceService
                scannerInterfaceService.startScanner()
                true
            }catch (e: Exception){
                false
            }
        }
        fun stopScanner(): Boolean{
            return try {
                val scannerInterfaceService: CSscanner = MobiIotScannerApi.scannerInterfaceService
                scannerInterfaceService.stopScanner()
                true
            }catch (e: Exception){
                false
            }
        }

        fun getScanResult(eventSink: EventChannel.EventSink? ){
            try {
                val scannerInterfaceService: CSscanner = MobiIotScannerApi.scannerInterfaceService
                val mCScannerCallback: CSscannerCallback.Stub = object : CSscannerCallback.Stub() {
                    override fun getResults(evResult: EVResult) {
                        val res = mutableMapOf<String, Any>()
                        res["value"] = evResult.stringValue
                        res["symbology"] = evResult.symbology
                        res["subtype"] = evResult.subtype
                        res["aimID"] = evResult.aimID
                        res["decoderType"] = evResult.decoderType

                        Handler(Looper.getMainLooper()).post {
                            eventSink?.success(res)
                        }


                    }
                }
                scannerInterfaceService.getScanResult(mCScannerCallback)
            }catch (e: Exception){
                eventSink?.success(null)
            }
        }
    }



}