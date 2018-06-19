package com.example.lilium.eurekatask;

import android.content.Context;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.Spinner;
import android.widget.Toast;

import java.util.logging.Logger;

public class SelectLanguageActivity extends AppCompatActivity {
    Spinner languageSpinner;
    Button decideButton;
    Context context;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_select);


        context = this;
        languageSpinner = findViewById(R.id.spinner);
        String spinnerItems[] = {"Javascript", "Python", "Java", "Kotlin"};

        ArrayAdapter<String> adapter
                = new ArrayAdapter<>(this, android.R.layout.simple_spinner_item, spinnerItems);

        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        languageSpinner.setAdapter(adapter);



        decideButton = findViewById(R.id.decide_button);
        decideButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent i = new Intent(getApplication(),RepositoryListActivity.class);

                i.putExtra("language",languageSpinner.getSelectedItem().toString());
                startActivity(i);
            }
        });


    }
}
