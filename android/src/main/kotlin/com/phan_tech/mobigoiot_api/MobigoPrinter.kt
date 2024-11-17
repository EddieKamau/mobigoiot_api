package com.phan_tech.mobigoiot_api

import com.mobiiot.androidqapi.api.CsPrinter


class MobigoPrinter {
    companion object {
        fun printTextFull(data: String, textSize: Int, textDirection: Int, textFont: Int, alignment: Int, isBold: Boolean, isUnderlined: Boolean):Boolean{
            return CsPrinter.printText_FullParm(data, textSize, textDirection, textFont, alignment, isBold, isUnderlined)
        }
        fun printText(data: String):Boolean{
            return CsPrinter.printText(data)
        }
        fun printEndLine():Boolean{
            return CsPrinter.printEndLine()
        }
        fun printBitmap(byteArray: ByteArray):Boolean{
            return CsPrinter.printBitmap(byteArray)
        }
    }


}