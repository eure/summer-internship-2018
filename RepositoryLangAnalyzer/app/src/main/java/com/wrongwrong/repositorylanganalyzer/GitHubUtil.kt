package com.wrongwrong.repositorylanganalyzer

import android.os.Build
import android.support.annotation.RequiresApi
import kotlinx.coroutines.experimental.CommonPool
import kotlinx.coroutines.experimental.async
import java.io.BufferedReader
import java.io.InputStreamReader
import java.net.URL

class GitHubUtil {
    companion object {
        // API叩いてJSON取得
        @RequiresApi(Build.VERSION_CODES.N)
        fun getJsonFromURL(url: URL) = async(CommonPool) {
            var resultJson = ""
            val br = BufferedReader(InputStreamReader( url.openStream() ))

            for(line in br.lines()) resultJson += line

            return@async resultJson
        }

        //入力は,"で分割された前提
        fun getValuesFromSplittedJson(arr: List<String>, value: String): ArrayList<String>{
            var regex = Regex("(?<!.)$value.+")
            var array = ArrayList<String>()
            var result: MatchResult?
            var temp: String

            for(str in arr){
                result = regex.find(str)
                if(result != null){
                    temp = result.value.substring(value.length)
                    if(temp != "null") temp = temp.substring(0, temp.length-1).substring(1)
                    array.add(temp)
                }
            }
            return array
        }

        //言語の項の列から、どの言語がどの順で多いかをソート済みリストとして返す
        fun makeRankOfLangs(langs:  ArrayList<String>): List<Pair<String, Int>>{
            var map = HashMap<String, Int>()
            for(lang in langs){
                if(map.contains(lang)) map[lang] = map[lang]!! +1
                else map.set(lang, 1)
            }
            return map.toList().sortedByDescending { pair -> pair.second }
        }
    }
}