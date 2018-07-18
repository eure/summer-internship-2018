import React from 'react';

import ArrowBack from '@material-ui/icons/ArrowBack';
import Avatar from '@material-ui/core/Avatar';
import Button from '@material-ui/core/Button';
import Card from '@material-ui/core/Card';
import CardActions from '@material-ui/core/CardActions';
import CardContent from '@material-ui/core/CardContent';
import Chip from '@material-ui/core/Chip';
import Divider from '@material-ui/core/Divider';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';
import Snackbar from 'material-ui/Snackbar';
import Typography from '@material-ui/core/Typography';

import { withStyles } from '@material-ui/core/styles';

const styles = {
    chipBox: {
        padding: '2% 0 0 0',
        display: 'flex',
        flexDirection: 'row',
    },

    listBox: {
        margin: '1% 0',
    },

    chips: {
        margin: '0 1% 0 0',
    },

    title: {
        paddingBottom: '0.5%',
    },

    description: {
        padding: '0.5% 0 0 0',
    },

    descriptionText: {
        padding: '0 0 0.5% 0',
    },

    centering: {
        textAlign: 'center',
    }
};

//リポジトリ一覧を表示するコンポーネント
class Repos extends React.Component{

    constructor(props) {
        super(props);

        this.state = {
            open: false, //Snackbarの開閉状態
            message:'',　//Snackbarに表示するメッセージ
        };

        this.dispatchDetail = this.dispatchDetail.bind(this);
        this.dispathPrevious = this.dispathPrevious.bind(this);
    }

    //詳細画面への遷移を実行
    dispatchDetail(key){
        this.props.setSelectRepository(this.props.repos[key]);
        this.props.history.push('/repos/detail');
    }

    //Click to previous pageボタンの動作
    dispathPrevious(){
        this.props.history.push('/');
    }

    //Snackbarを閉じるための関数
    handleRequestClose(){
        this.setState({
            open: false,
        });
    }

    render(){
        let repos = this.props.repos; // リポジトリ一覧を取得
        let list = []; //Cardを一時的に格納する配列

        for(let i= 0;i < repos.length;i++){
            list.push(
                <div key={i} style={styles.listBox}>
                    <Card>
                        <CardContent>
                            <Typography color="textSecondary">
                                {repos[i].owner.login}
                            </Typography>
                            <Typography variant="title" component="h2" style={styles.title}>
                                {repos[i].full_name}
                            </Typography>
                            <Divider />
                            <Typography variant="subheading" style={styles.description}>
                               description:
                            </Typography>
                            <Typography component="p" style={styles.descriptionText}>
                                {repos[i].description}
                            </Typography>
                            <Divider />
                            <div style={styles.chipBox}>
                                {(() => {
                                    if(repos[i].language != null)
                                        return <Chip label={repos[i].language} style={styles.chips}/>;
                                    
                                })()}

                                 <Chip
                                    avatar={<Avatar>☆</Avatar>}
                                    label={repos[i].stargazers_count}
                                    style={styles.chips}
                                />       
                            </div>         
                        </CardContent>
                        <CardActions>
                            <Button size="small" onClick={this.dispatchDetail.bind(this,i)}>詳細を見る</Button>
                        </CardActions>
                    </Card>
            </div>             
            );
        }

        return (
            <MuiThemeProvider>
                <div>
                    <h1 style={styles.centering}>{this.props.userName} のリポジトリ一覧</h1>
                    <div>
                        <Button variant="contained" onClick={this.dispathPrevious.bind(this)}>
                            <ArrowBack />前のページへ.
                        </Button>
                    </div>
                    {list}
                    <Snackbar
                        open={this.state.open}
                        onClose={this.handleRequestClose}
                        autoHideDuration={3000}
                        message={<span id="message-id">{this.state.message}</span>}
                    />
                </div>
            </MuiThemeProvider>
        );
    }
}

export default withStyles(styles)(Repos);
