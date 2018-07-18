import React from 'react';
import axios from 'axios';
import Snackbar from 'material-ui/Snackbar';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';
import TextField from '@material-ui/core/TextField';
import Button from '@material-ui/core/Button';

const styles = {
    buttonWrap: { 
        marginTop: '2%'
    },

    textBoxWrap: {
        marginTop: '2%',
    },

    textBox: {
        width: '50%',
    },

    centering: {
        textAlign: 'center',
    }
}

//検索画面を表示するコンポーネント
class Search extends React.Component{

    constructor(props) {
        super(props);

        this.state = {
            open: false,　//Snackbarの開閉状態
            message:'',　//Snackbarに表示するメッセージ
        };
        
        this.handleButtonClick = this.handleButtonClick.bind(this)
    }

    //Github APIからユーザー情報の取得
    handleButtonClick(){
        let userName = document.querySelector('#name_box').value;
        let url = 'https://api.github.com/users/'+userName+'/repos';
        const regex = new RegExp('^[亜-熙ぁ-んァ-ヶ]+$');

        if(userName === ''){
            this.setState({
                open: true,
                message: 'ユーザー名が未入力です'
            });
            return false;
        }

        if(regex.test(userName)){
            this.setState({
                open: true,
                message: 'ユーザー名に日本語は使用できません'
            });
            return false;
        }

        //API get
        axios.get(url).then(

            (res) => {
                if(res['data'].length === 0){
                    this.setState({
                        open: true,
                        message: ' ユーザーが見つかりませんでした'
                    });
                    return false;
                }

                //StoreにuserNameと、リポジトリ情報をセット
                this.props.setUserName(userName);
                this.props.setUserRepo(res['data']);

                //リポジトリ一覧へ遷移
                this.props.history.push('/repos');
            },

            (res) => {
                if(res.response.status === 404){
                    this.setState({
                        open: true,
                        message: 'ユーザーが見つかりませんでした.'
                    });
                    return false;
                }
            }
        ).catch(
            (err)=>{
                console.log(err.response.status);
                if(err.response.status === 404){
                    this.setState({
                        open: true,
                        message: '通信に失敗しました.'
                    });
                    return false;
                }
            }
        );
    }

    //Snackbarを閉じるための関数
    handleRequestClose(){
        this.setState({
          open: false,
        });
    }

    render(){
        return(
            <MuiThemeProvider>
                <div>
                    <h1 style={styles.centering}>Repository Browser</h1>
                    <p style={styles.centering}>Githubのユーザー名を入力し、そのユーザーのリポジトリを閲覧できます</p>
                    <div style={styles.centering}>
                        <TextField
                            id="name_box"
                            label="Github User Name"
                            name="user_name"
                            style={styles.textBox}
                        />
                    </div>         
                    <div style={Object.assign({},...[styles.buttonWrap,styles.centering])}>  
                        <Button variant="outlined" onClick={this.handleButtonClick.bind(this)}>
                            検索する
                        </Button>
                    </div>
                    <Snackbar
                        open={this.state.open}
                        onClose={this.handleRequestClose}
                        autoHideDuration={3000}
                        style={styles.centering}
                        message={<span id="message-id">{this.state.message}</span>}
                    />
                </div>
            </MuiThemeProvider>
        )
    }
}

export default(Search);