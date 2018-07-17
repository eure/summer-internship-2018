package com.wrongwrong.repositorylanganalyzer

import android.content.Context
import android.content.Intent
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.os.NetworkOnMainThreadException
import android.view.inputmethod.InputMethodManager
import android.widget.Button
import android.widget.EditText
import android.widget.ListView
import android.widget.Toast
import com.wrongwrong.repositorylanganalyzer.GitHubUtil.Companion.getValuesFromSplittedJson
import com.wrongwrong.repositorylanganalyzer.GitHubUtil.Companion.makeRankOfLangs
import kotlinx.coroutines.experimental.android.UI
import kotlinx.coroutines.experimental.launch
import java.io.FileNotFoundException
import java.net.URL

class MainActivity : AppCompatActivity() {
    lateinit var reps: ArrayList<String>
    lateinit var langs: ArrayList<String>
    lateinit var descriptions: ArrayList<String>

    //ボタン押したときの挙動設定
    private fun initButton(){
        var input = findViewById<EditText>(R.id.inputAccount)
        var b = findViewById<Button>(R.id.launchButton)
        b.setOnClickListener {
            //キーボードの非表示
            var imm = (getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager)
            if (imm.isActive) imm.toggleSoftInput(InputMethodManager.HIDE_IMPLICIT_ONLY, 0)

            Toast.makeText(this, "開始", Toast.LENGTH_LONG).show()
            var context = this
            //ボタンを無効化しjson取得など
            b.isEnabled = false
            launch(UI) {
                try {
                    var jsonArr = GitHubUtil.getJsonFromURL(URL("https://api.github.com/users/${input.text}/repos")).await().split(",\"")
                    reps = getValuesFromSplittedJson(jsonArr, "full_name\":")
                    langs = getValuesFromSplittedJson(jsonArr, "language\":")
                    for(i in 0 until langs.count()) if(langs[i] == "null") langs[i] = "Other Language"
                    descriptions = getValuesFromSplittedJson(jsonArr, "description\":")

                    if(langs.count() != 0) {
                        var rankOfLangs = makeRankOfLangs(langs)

                        var lv = findViewById<ListView>(R.id.listView)
                        lv.adapter = LanguageAdapter(context, rankOfLangs, langs.count())
                        Toast.makeText(context, "正常に取得を完了しました。", Toast.LENGTH_SHORT).show()
                    } else Toast.makeText(context, "リポジトリを取得できませんでした。", Toast.LENGTH_SHORT).show()
                } catch (e: FileNotFoundException) {
                    Toast.makeText(context, "リポジトリを見つけられませんでした。ユーザー名が正しいか確認してください。", Toast.LENGTH_SHORT).show()
                } catch (e: NetworkOnMainThreadException) {
                    Toast.makeText(context, "ネットワークに接続できませんでした。", Toast.LENGTH_SHORT).show()
                } finally {
                    b.isEnabled = true
                }
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        initButton()
        findViewById<ListView>(R.id.listView).setOnItemClickListener{parent, v, position, id ->
            var intent = Intent(this.applicationContext, RepositoryActivity::class.java)
            intent.putExtra("language", (parent.getItemAtPosition(position) as Pair<String, Int>).first)
            intent.putExtra("repositories", reps)
            intent.putExtra("languages", langs)
            intent.putExtra("descriptions", descriptions)
            startActivity(intent)
        }
    }
}
