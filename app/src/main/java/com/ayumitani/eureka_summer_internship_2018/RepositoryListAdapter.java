package com.ayumitani.eureka_summer_internship_2018;

import android.content.Context;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

import java.util.ArrayList;

public class RepositoryListAdapter extends ArrayAdapter<Repository> {

    public static final int resource = R.layout.custom_listview_item;

    public RepositoryListAdapter(@NonNull Context context) {
        super(context, 0);
    }

    @NonNull
    @Override
    public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {

        View view;

        if (convertView == null) {
            LayoutInflater inflater = LayoutInflater.from(getContext());
            view = inflater.inflate(resource, parent, false);
        } else {
            view = convertView;
        }

        Repository repository = getItem(position);

        TextView name = (TextView) view.findViewById(R.id.name);
        name.setText(repository.name);

        return view;
    }

}

