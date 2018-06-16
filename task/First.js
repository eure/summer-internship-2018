// https://api.github.com/users/ユーザー名/repos で一覧を取得
import React, { Component } from 'react';
import { PropTypes } from 'prop-types';
import Loader from './components/Loader'; // load用のmodal
import {
   StyleSheet,
   ListView,
   Text,
   View,
   TouchableHighlight,
 } from 'react-native';

// guthub_API
var REQUEST_URL = 'https://api.github.com/users/NakajiTatsuya/repos';
 
export default class First extends Component {

  static navigationOptions = {
    title: 'My Repositry',
    headerTitleStyle : {textAlign: 'center', alignSelf:'center'},
    headerStyle:{
        backgroundColor: 'transparent',
        position: 'absolute',
        top: 0,
        left:0,
        right: 0,
        borderBottomWidth: 0,
        elevation: 0,   
      },
    };

  constructor(props) {
    super(props);
    this.state = {
      items: new ListView.DataSource({
        rowHasChanged: (row1, row2) => row1 !== row2,
      }),
      loaded: false,
      loadingVisible: false,
    };
    this.renderLoadingView = this.renderLoadingView.bind(this);
    this.renderListingView = this.renderListingView.bind(this);
    this.renderItem = this.renderItem.bind(this);
    this.onClickRow = this.onClickRow.bind(this);
  }

  //ComponentがDOMツリーに追加されたらデータ取得
  componentDidMount() {
    this.fetchData();
  }

  //描画
  render() {

    var site = this.state.loaded
    if (!site) {
      // loadedのstateが falseの時は ロード中のViewを返す
      return this.renderLoadingView();
    }
    // ListViewを返す
    return this.renderListingView();
  }

  //  ローディング用のViewを返す関数作成
  renderLoadingView() {
    const { loadingVisible } = this.state;
    return (
        <View style={styles.container}>
          <View style = {styles.textWrapper}>
            <Text style = {styles.loadingText}>
                ロード中...
            </Text>
          </View>
            <Loader
              modalVisible = {true}
              animationType = "fade"
            />
        </View>
    );
  }

  //ListingViewを返す関数
  renderListingView() {
    return (
        <ListView
          style = {styles.listView}
          dataSource = {this.state.items}  // データソースが入る
          renderRow = {this.renderItem}
        />
    );
  }

  //  一行ごとにアイテムを並べる
  renderItem (item) {
    return (
      <TouchableHighlight
        activeOpacity = {0.2}
        underlayColor = "yellow"
        onPress={() => {
        this.onClickRow(item)
      }}
      >
        <View style={styles.container}>
          <Text style = {[{marginTop: 30}, {marginBottom: 30}]}>
            {item.name}
          </Text>
        </View>
      </TouchableHighlight>
    )
  }

  //  行をクリック
  onClickRow (item) {
    const {navigate} = this.props.navigation; 
    navigate('Detail', { item });
  }

  // データ取得関数の用意
  fetchData() {
    fetch(REQUEST_URL)
        .then((response) => response.json())
        .then((responseData) => {
          // ステートに値を設定
            this.setState({
          items: this.state.items.cloneWithRows(responseData),
          loaded: true,
          loadingVisible: false,
            });
        })
        .done();
  }
}
 
const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  textWrapper: {
    backgroundColor: "yellow",
    height: "100%",
  },
  loadingText: {
    textAlign: 'center',
    top: '40%',
    fontSize: 60,
    fontWeight: "300",
  },
  listView: {
    top: 20,
    left: 20
  },
});
 

































