import React from 'react';

// ユーザのアバター, リポジトリをリスト表示するコンポーネント
class GitList extends React.Component {
    render() {
        return(
            <ul>
                {this.props.apiList}
            </ul>
        );
    }
}

export default GitList;