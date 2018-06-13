import React, {Component } from 'react';
import PropTypes from 'prop-types';
import queryString from 'query-string';

import { getGithubRepositoryInfo } from '../domain/Repository';

class ShowPage extends Component {
  constructor(props) {
    super(props);
    this.state = {
      description: '',
      userImage: '/person.jpg', // publicで用意してある画像
    };
  }
  
  componentWillMount() {
    this.getInfo();
  }
  
  // urlの末尾に記載されているパラメーターを取得する
  getParams() {
    const params = queryString.parse(this.props.location.search);
    return {user: params.user, repository: params.repository};
  }
  
  // rails側で用意したAPIからrepositoryの詳細情報を取得
  getInfo() {
    const param = this.getParams();
    getGithubRepositoryInfo(param.user, param.repository)
      .then(result => { 
         this.setState({
           description: result.description,
           userImage: result.userImage,
         });
      });
  }
  
  render() {
    const params = this.getParams();
    return (
      <div className="container">
        <div className="repository">
          <img src={this.state.userImage}/>
          <a href={"https://github.com/"+params.user+"/"+params.repository}>
            <h3>{params.user+"/"+params.repository}</h3>
          </a>
          <p>{this.state.description}</p>
        </div>
      </div>
    );
  }
}

ShowPage.propTypes = {
  location: PropTypes.shape({ search: PropTypes.string }).isRequired,
};

export default ShowPage;