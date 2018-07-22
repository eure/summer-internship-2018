import React from 'react';

class Home extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      data: null
    };
  }

  componentDidMount() {
    fetch(`${process.env.REACT_APP_API_BASE_URL}/repos/Microsoft/vscode/events?access_token=${process.env.REACT_APP_ACCESS_TOKEN}`)
      .then(response => response.json())
      .then(data => this.setState({ data }))
      .catch(err => console.error(err));
  }

  render() {
    const { data } = this.state;

    return (
      <div>
        this is Home.
        {data && data.map(item => <div>{item.id}</div>)}
      </div>
    );
  }
}

export default Home;
