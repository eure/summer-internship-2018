import React, { Component } from 'react';
import { PropTypes } from 'prop-types';
import {
	View,
	Text,
	TextInput,
	TouchableHighlight,
	StyleSheet,
	KeyboardAvoidingView,
} from 'react-native';  

export default class LogIn extends Component {
	constructor(props) {
		super(props);
		this.state = {
			userName: "",
		},
		this.onChangeText = this.onChangeText.bind(this);
	}

	onChangeText(userName) {
		this.setState({ userName });	
	}

	render() {
		const { userName } = this.state;
		const { navigate } = this.props.navigation;
		return(
			<View style = {styles.view}>
			<View style = {styles.textInputWrapper}>
            <TextInput 
			  style = {[{color: "green", borderBottomWidth: 1, borderColor: 'gray'}]}
			  keyboardType = 'default'
			  editable = {true}
		 	  onChangeText={this.onChangeText}
			  autoFocus = {true}
			  autoCapitalize = {false}
			  autoCorrect = {false}
			  // value = "GitHub user name here!" android simulator では、これを入れると文字入力ができない!!
			  placeholder = "user name here"
			  underlineColorAndroid = "transparent"
			/>
			</View>
			<TouchableHighlight
			    style = {styles.showButton}
			    onPress = {() => navigate('First', { userName })}
			  >
			  <View style = {styles.opacityWrapper}>
			    <Text style = {styles.showButtonText}>
			      See Repo
			    </Text>
			  </View>
			</TouchableHighlight>
			</View>
			);
		}
		}

		const styles = StyleSheet.create({
			view: {
				display: 'flex',
				left: 0,
				right: 0,
				top: 0,
				bottom: 0,
			},
			textInputWrapper: {
				marginTop: 100,
				marginLeft: 30,
				marginRight: 30,
				marginBottom: 30,
				height: 40,
			},
			showButton: {
				marginTop: 30,
				alignItems: 'center',
			},
			opacityWrapper: {
				paddingLeft: 20,
				paddingRight: 20,
				paddingTop: 12,
				paddingBottom: 12,
				borderRadius: 40,
				backgroundColor: "yellow",
				marginBottom: 15,
				width: '100%',
			},
			showButtonText: {
				fontSize: 25,
				textAlign: 'center',
			}
		});








