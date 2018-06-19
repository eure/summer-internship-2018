// https://api.github.com/users/ユーザー名/repos で一覧を取得
import React, { Component } from 'react';
import { PropTypes } from 'prop-types';
import Loader from './components/Loader'; // load用のmodal
import {
   StyleSheet,
   Text,
   View,
   Image,
   ScrollView
 } from 'react-native';

export default class detail extends Component {

  static navigationOptions = ({ navigation }) => ({
    headerStyle:{
        backgroundColor: 'transparent',
        position: 'absolute',
        top: 0,
        left:0,
        right: 0,
        borderBottomWidth: 0,
        elevation: 0,   
      },
    });

	constructor(props) {
  	super(props);
  	this.state = {
  		item: this.props.navigation.state.params.item, 
  	};
  	this.renderListings = this.renderListings.bind(this);
  }

  renderListings() {
  const { item } = this.state;
     return(
        <View>
        <Text style = {[{fontSize: 30}, {color: "blue"}, {marginBottom: 20}, {textAlign: 'center'}]}>
          {item.name}レポジトリ
        </Text>
        {Object.entries(item.owner).map(([key,value])=>{
            return (
            	<View 
            	  key={key}
            	  style = {[{margintop: 10}, {marginBottom: 10}]}
            	>
            	  <Text>
            	    {key}: {String(value)}
            	  </Text>
            	   <View style = {[{margin:10}]}>
            	    <Image 
            	      source = { key === "avatar_url" && {uri: value}}
            	      style = {{width: 70, height: 70}}
            	      resizeMode = "contain"
            	    />
            	   </View>
            	</View>);
        })}
        </View>

      )
  }

  render() {
  	return(
  		<View style = {styles.wrapper}>
  		<ScrollView style = {styles.scrollView}>
  	      {this.renderListings()}
  	    </ScrollView>
  	    </View>
  	);
  }
  }

  const styles = StyleSheet.create({
  	wrapper: {
  		flex: 1,
  		backgroundColor: "pink",
  	},
  	scrollView: {
  		marginTop: 20,
  		marginLeft: 10,
  		marginBottom: 20,
  		marginRight: 10,
  	},
  	textStyle: {
  		fontSize: 60,
        fontWeight: "300",
  	}
  });










