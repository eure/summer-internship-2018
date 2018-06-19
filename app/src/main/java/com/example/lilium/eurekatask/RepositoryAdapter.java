package com.example.lilium.eurekatask;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import java.util.ArrayList;


public class RepositoryAdapter extends BaseAdapter {
    ArrayList<RepositoryList.RepoItem> items;
    LayoutInflater li;
    Context context;
    public RepositoryAdapter(ArrayList<RepositoryList.RepoItem> items, Context context) {
        this.items = items;
        this.context = context;
        this.li = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);

    }

    @Override
    public int getCount() {
        return items.size();
    }

    @Override
    public Object getItem(int i) {
        return items.get(i);
    }

    @Override
    public long getItemId(int i) {
        return 0;
    }

    @Override
    public View getView(int i, View view, ViewGroup viewGroup) {
        view = li.inflate(R.layout.repository_list_row,viewGroup,false);
        ((TextView)(view.findViewById(R.id.repname))).setText(items.get(i).name);
        ((TextView)(view.findViewById(R.id.repstars))).setText(Integer.toString(items.get(i).stargazers_count));
        return view;
    }
}
