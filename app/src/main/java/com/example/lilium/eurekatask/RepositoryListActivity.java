package com.example.lilium.eurekatask;

import android.app.ProgressDialog;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.Toast;

import com.google.gson.annotations.Expose;

import java.util.ArrayList;
import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;
import retrofit2.http.GET;
import retrofit2.http.Query;

public class RepositoryListActivity extends AppCompatActivity {

    String query;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_repository_list);


        query = getIntent().getStringExtra("language");
        setTitle("注目の"+query);
        String URL="https://api.github.com/search/";


        Retrofit retrofit =new Retrofit.Builder().baseUrl(URL).addConverterFactory
                (GsonConverterFactory.create()).build();
        GithubAPI api = retrofit.create(GithubAPI.class);
        Call<RepositoryList> repositoryListCall=api.getRepository("language:"+query);

        final ProgressDialog progressDoalog;
        progressDoalog = new ProgressDialog(RepositoryListActivity.this);
        progressDoalog.setMax(100);
        progressDoalog.setMessage("注目の"+query+"のレポジトリを検索中");
        progressDoalog.setTitle("検索中");
        progressDoalog.setProgressStyle(ProgressDialog.STYLE_HORIZONTAL);
        // show it
        progressDoalog.show();


        repositoryListCall.enqueue(new Callback<RepositoryList>() {
            @Override
            public void onResponse(Call<RepositoryList> call, Response<RepositoryList> response) {

                Log.e("hoge",call.request().url().toString());
                final ArrayList<RepositoryList.RepoItem> repoItems = response.body().getRepos();
                Log.e("hoge",repoItems.get(0).getName());
                ListView repList = findViewById(R.id.repList);
                RepositoryAdapter ra = new RepositoryAdapter(repoItems,getApplicationContext());

                repList.setAdapter(ra);
                repList.setOnItemClickListener(new AdapterView.OnItemClickListener() {
                    @Override
                    public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
                        Intent intent = new Intent(getApplication(),RepositoryDetail.class);

                        intent.putExtra("url",repoItems.get(i).getUrl());
                        intent.putExtra("name",repoItems.get(i).getName());
                        intent.putExtra("stars",repoItems.get(i).getStargazers_count());
                        intent.putExtra("update",repoItems.get(i).getUpdated_at());

                        startActivity(intent);
                    }
                });
                progressDoalog.dismiss();
            }

            @Override
            public void onFailure(Call<RepositoryList> call, Throwable t) {
                Log.e("hoge","fail");
                progressDoalog.dismiss();
                Toast.makeText(getApplication(),R.string.connection_failed,Toast.LENGTH_LONG).show();
            }
        });

    }
}

class RepositoryList{

    @Expose
    ArrayList<RepoItem> items;

    public ArrayList<RepoItem>  getRepos() {
        return items;
    }

    class RepoItem {
        @Expose
        String html_url;
        @Expose
        String name;
        @Expose
        int stargazers_count;

        @Expose
        String updated_at;
        public String getUpdated_at() {
            return updated_at;
        }

        public String getUrl() {
            return html_url;
        }

        public String getName() {
            return name;
        }

        public int getStargazers_count() {
            return stargazers_count;
        }
    }
}

interface GithubAPI{
    @GET("repositories")
    Call<RepositoryList> getRepository(@Query("q")String q);


}