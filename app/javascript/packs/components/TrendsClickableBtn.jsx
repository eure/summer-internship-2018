import React, { Component } from 'react';

  // sortボタンが押されたときの処理を行うコンポーネント
class TrendsClickableBtn extends Component {
  constructor(props) {
    super(props);
    this.state = {
    };
  }
  
  handleClickBtn(sortKey) {
    // 再レンダリング
    this.setState(this.state);
    // sortKeyを渡し，sortする
    this.props.onSort(sortKey);
  }
  
  render() {
    return (
      <div 
        onClick={() => this.handleClickBtn(this.props.label)}
        className={'sortbtn ' + (this.props.sortKey === this.props.label ? 'active' : '')}
      >
        {this.props.label}
      </div>
    );
  }
}

export default TrendsClickableBtn;