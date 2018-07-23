package com.ayumitani.eureka_summer_internship_2018;

import android.os.Parcel;
import android.os.Parcelable;

public class Repository implements Parcelable {

    public String name;
    public String userName;
    public String language;
    public String url;

    public Repository(String name, String userName, String language, String url) {
        this.name = name;
        this.userName = userName;
        this.language = language;
        this.url = url;
    }

    public Repository(Parcel in) {
        this.name = in.readString();
        this.userName = in.readString();
        this.language = in.readString();
        this.url = in.readString();
    }


    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel dest, int flags) {
        dest.writeString(name);
        dest.writeString(userName);
        dest.writeString(language);
        dest.writeString(url);
    }

    public static final Creator<Repository> CREATOR = new Creator<Repository>() {
        @Override
        public Repository createFromParcel(Parcel in) {
            return new Repository(in);
        }

        @Override
        public Repository[] newArray(int size) {
            return new Repository[size];
        }
    };


}
