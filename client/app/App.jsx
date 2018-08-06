import * as React from "react";
import {Panel, Badge, Jumbotron, Tab, Tabs} from "react-bootstrap";

export default class App extends React.Component {
  constructor(props) {
    super(props);
    this.changePage = this.changePage.bind(this);
    this.state = {
      pageData: [],
      key: "all"
    };
  }
  changePage(key) {
    fetch("./api/trend/" + key)
      .then((x) => x.json())
      .then((json) => {
        this.setState({
          pageData: JSON.parse(json)
        });
      });
    this.setState({key: key});
  }

  componentDidMount() {
    fetch("./api/trend/all")
      .then((x) => x.json())
      .then((json) => {
        this.setState({
          pageData: JSON.parse(json)
        });
      });
  }

  render() {
    const { pageData, key } = this.state;
    return (
      <div style={{ width: "80%", height: "auto", margin: "5% 10%"}}>
        <Jumbotron>
          <h1>&nbsp;&nbsp;&nbsp;Github Trend</h1>
          <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;githubのトレンドです</p>
        </Jumbotron>
        <Tabs activeKey={key} onSelect={this.changePage} id="controlled-tab-example">
          <Tab eventKey={"all"} title="All">
          </Tab>
          <Tab eventKey={"go"} title="Go">
          </Tab>
          <Tab eventKey={"javascript"} title="JavaScript">
          </Tab>
          <Tab eventKey={"python"} title="Python">
          </Tab>
          <Tab eventKey={"shell"} title="Shell">
          </Tab>
        </Tabs>
        <div style={{ width: "80%", margin: "5% 5%"}}>
          {pageData.map(function(index) {
            return (
              <Panel bsStyle="primary" >
                <Panel.Heading>
                  <Panel.Title>
                    <a href={"https://github.com" + index.link}>
                    	{index.name}
                    </a>
                  	</Panel.Title>
                </Panel.Heading>
                <Panel.Body>{index.info}</Panel.Body>
                <Panel.Footer>
                  <Badge>{index.lang}</Badge>
                  &nbsp;&nbsp;<b>star</b>&nbsp;<Badge>{index.star}</Badge>
                  &nbsp;<b>fork</b>&nbsp;<Badge>{index.fork}</Badge>
                </Panel.Footer>
              </Panel>
            );
          })}
        </div>
        <footer>
          <b>@2018 hukuda222</b>
        </footer>
      </div>

    );
  }
}
