import React from 'react';
import axios from 'axios';

// ユーザーの保持するpublicレポジトリとそのスター数を表示するコンポーネント
class Repos extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      apiList: []
    };
  }

  // コンポーネント配置前に呼び出される関数
  // リスト表示するhtmlタグを作成
  componentWillMount() {
    this.setState({apiList: []});
    // reposのURLに対して再度APIに問い合わせ
    const request = axios.create({
      baseURL: this.props.url
    })
    request.get()
    .then(response => {
      let lists = [];
      const repoLists = (response.data).map((resp) => {
        lists.push(
          <li key={resp.id}>
            ☆<span>{resp.stargazers_count}:</span>{resp.html_url}
          </li>
        );
      });
      this.setState({apiList: lists});
    })
    .catch(err => {
          console.log(err);
    });
  }

  render() {
    return(
      <div>
        <ul>
          {this.state.apiList}
        </ul>
        <button onClick={this.props.goRoute}>Return</button>
      </div>
    );
  }
}

export default Repos;