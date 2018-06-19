package com.example.lilium.eurekatask;

import android.content.Intent;
import android.net.Uri;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

public class RepositoryDetail extends AppCompatActivity {
    String name;
    String url;
    String update;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_repository_detail);

        url=getIntent().getStringExtra("url");
        name = getIntent().getStringExtra("name");
        update = getIntent().getStringExtra("update");
        int stars = getIntent().getIntExtra("stars",-1);

        ((TextView)findViewById(R.id.detai_name)).setText("レポジトリ名:"+name);
        ((TextView)findViewById(R.id.detail_stars)).setText("スター数:"+Integer.toString(stars));
        ((TextView)findViewById(R.id.detail_update)).setText("最終更新:"+update.substring(0,10));

        Button tweet = findViewById(R.id.detail_twitter);
        Button github = findViewById(R.id.detail_github);

        tweet.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                String twitterUrl = "https://twitter.com/share?text=";
                twitterUrl+=name+"って面白そうなレポジトリ見つけたよ!";
                Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse(twitterUrl));
                startActivity(intent);
            }
        });

        github.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Uri uri = Uri.parse(url);
                Intent i = new Intent(Intent.ACTION_VIEW,uri);
                startActivity(i);
            }
        });




    }
}
