import React from 'react';
import axios from 'axios';

import SearchBox from './SearchBox';
import GitList from './GitList';
import Avatar from './Avatar';
import Repos from './Repos';

import '../css/style.css';

/*
一番上位のコンポーネント.
検索ボックスの入力値を受け取りAPIに問い合わせ
ユーザーのアバターとレポジトリのURLをリスト表示し
それぞれのURLをクリックすると詳細画面に遷移する.
*/
class App extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            // ページ遷移のための変数
            currentPage: 'route',
            // リスト押下したURLを保存
            url_val: '',
            // リスト表示されるhtmlタグを保存
            apiList: []
        };
        this.searchName = this.searchName.bind(this);
        this.handleClick = this.handleClick.bind(this);
        this.goRoute = this.goRoute.bind(this);
    }

    // リストのURLを押下した時に呼ばれる関数
    handleClick(key, value) {
        if(key === 'avatar_url') {
            this.setState({currentPage: 'avatar'});
        }else if(key === 'repos_url') {
            this.setState({currentPage: 'repos'});
        }
        this.setState({url_val: value});
    }

    // 遷移先の画面から1つ前のリスト表示の画面に戻る関数
    // 各遷移先の画面から呼ばれる
    goRoute() {
        this.setState({currentPage: 'route'});
    }

    // 検索ボックスの入力値をもとにAPIに問い合わせ
    // アバターのURLとリポジトリの情報をリストとして保存
    searchName(name) {
        // 指定したユーザーのデータをAPIから取得
        const request = axios.create({
            baseURL: 'https://api.github.com'
        })
        request.get(`/users/${name}`)
        // APIの戻り値responseの各データを取得
        .then(response => {
            let lists = [];
            this.setState({apiList: lists});
            Object.keys(response.data).forEach((key) => {
                let value = response.data[key];
                if (String(value).match(/(avatar|repos)/)) {
                    lists.push (
                        <li key={key}>
                            <span>{key}:</span><span className="can-click" onClick={() => this.handleClick(key, value)}>{value}</span>
                        </li>
                    );
                }
                /*
                else {
                    lists.push (
                        <li key={key}>
                            <span>{key}: {value}</span>
                        </li>
                    );
                };
                */
            });

            this.setState({apiList: lists});
        })
        .catch(err => {
            console.log(err);
        });
    }

    render () {
        let Content = null;

        // currentPageの値により{Content}の表示内容切り替え
        switch(this.state.currentPage) {
            case "route":
                Content = <GitList apiList={this.state.apiList} />;
                break;
            case "avatar":
                Content = <Avatar url={this.state.url_val} goRoute={this.goRoute} />;
                break;
            case "repos":
                Content = <Repos url={this.state.url_val} goRoute={this.goRoute} />;
                break;
        }

        return (
            <React.Fragment>
                <SearchBox onSubmits={this.searchName}/>
                {Content}
            </React.Fragment>
        );
    }
}

export default App;