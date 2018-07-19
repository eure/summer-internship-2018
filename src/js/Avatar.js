import React from 'react';

// アバター画像を表示するコンポーネント
class Avatar extends React.Component {
    render() {
        return(
            <div>
                <img src={this.props.url} />
                <p>
                  <button onClick={this.props.goRoute}>Return</button>
                </p>
            </div>
        );
    }
}

export default Avatar;