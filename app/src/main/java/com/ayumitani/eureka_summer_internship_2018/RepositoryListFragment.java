package com.ayumitani.eureka_summer_internship_2018;

import android.app.ListFragment;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;


public class RepositoryListFragment extends ListFragment {

    private RepositoryListAdapter adapter;

    public RepositoryListFragment() {

    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        adapter = new RepositoryListAdapter(getActivity());
        setListAdapter(adapter);

        adapter.add("name1", "userName", "language", "url", 2344445);
        adapter.add("name2", "userName", "language", "url", 2344445);
        adapter.add("name3", "userName", "language", "url", 2344445);


        String url = "https://api.github.com/search/repositories?q=languages:Java";

    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        return inflater.inflate(R.layout.fragment_repository_list, container, false);
    }

}

