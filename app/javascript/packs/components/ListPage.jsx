import React, { Component } from 'react';
import _ from 'lodash';

import TrendsTable from './TrendsTable';
import { getGithubTrends } from '../domain/Trends';

// 与えられたsortkeyでtrendsを降順にソート
const sortedTrends = (trends, sortKey) => 
  _.sortBy(trends, t => t[sortKey]).reverse();

class ListPage extends Component {
  constructor(props) {
    super(props);
    this.state = {
      errorMessage: ''
    };
  }
  
  // エラーメッセージをsateにセットする
  setErrorMessage(message) {
    this.setState({errorMessage: message});
  }
  
  // 与えられたsortkeyとそれを使ってソートしたtrendsをstateにセット
  handleSortKeyChange(sortKey) {
    this.setState({ sortKey, trends: sortedTrends(this.state.trends, sortKey)});
  }
  
  // ページ読み込み時railsのgithubtrends APIを叩く
  // ReactのAPI処理は ../lib/Github Railsはapp/controllers/api/v1 を参照
  componentDidMount() {
    getGithubTrends()
      .then(trends => { 
        console.log(trends);
        this.setState({ trends });
      })
      .catch(() => {
        this.setErrorMessage('通信に失敗しました');
     });
  }
  
  render() {
    return (
      <div className="container">
        <h1>Github Trends</h1>
        <h4>{this.state.errorMessage}</h4>
        <TrendsTable 
          trends={this.state.trends} 
          sortKey={this.state.sortKey}
          onSort={sortKey => this.handleSortKeyChange(sortKey)}
        />
      </div>
    );
  }
}

export default ListPage;