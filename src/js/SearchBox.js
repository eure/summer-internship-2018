import React from 'react';

// GitHubのユーザー情報を検索するためのコンポーネント
class SearchBox extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            user: ''
        }
        this.handleChange = this.handleChange.bind(this);
        this.handleSubmit = this.handleSubmit.bind(this);
    }

    // ボタン押下で呼ばれる関数
    // 親コンポーネント(App.js)に入力値を送信
    handleSubmit(e) {
        e.preventDefault();
        this.props.onSubmits(this.state.user);
    }

    // textが書き換えられるたびに呼び出される関数
    // テキスト入力値を個のコンポーネントのstateに保存
    handleChange(e) {
        this.setState({user: e.target.value});
    }

    render() {
        return (
            <form onSubmit={this.handleSubmit}>
                <span className="user-name">User Name:</span>
                <input type="text" placeholder="goodfeli" name="user" id="text-box" onChange={this.handleChange} />
                <button type="submit" className="submit">Search</button>
            </form>
        );
    }
}

export default SearchBox;