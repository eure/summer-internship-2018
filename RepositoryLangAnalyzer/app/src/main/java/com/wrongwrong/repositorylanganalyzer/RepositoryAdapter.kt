package com.wrongwrong.repositorylanganalyzer

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.BaseAdapter
import android.widget.TextView

class RepositoryAdapter (context: Context,
                         language: String,
                         repositories: ArrayList<String>,
                         languages: ArrayList<String>,
                         descriptions: ArrayList<String>) : BaseAdapter() {
    var cont = context
    var layoutInflater = cont.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
    var repDescPairs = ArrayList<Pair<String, String>>()

    init {
        (0 until repositories.count()).forEach { i -> if(language.equals(languages[i])) repDescPairs.add(Pair(repositories[i], descriptions[i])) }
    }

    override fun getCount(): Int {
        return repDescPairs.count()
    }

    override fun getItemId(position: Int): Long {
        return position.toLong()
    }

    override fun getItem(position: Int): Pair<String, String> {
        return repDescPairs[position]
    }

    override fun getView(position: Int, convertView: View?, parent: ViewGroup?): View {
        var view = layoutInflater.inflate(R.layout.repository_item, parent, false)
        view.findViewById<TextView>(R.id.rep_name).text = repDescPairs[position].first
        view.findViewById<TextView>(R.id.description).text = repDescPairs[position].second

        return view
    }
}