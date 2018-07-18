import React from 'react';
import { withStyles } from '@material-ui/core/styles';
import Card from '@material-ui/core/Card';
import CardContent from '@material-ui/core/CardContent';
import CardHeader from '@material-ui/core/CardHeader';
import Button from '@material-ui/core/Button';
import Typography from '@material-ui/core/Typography';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';
import Chip from '@material-ui/core/Chip';
import Avatar from '@material-ui/core/Avatar';
import Divider from '@material-ui/core/Divider';

import ArrowBack from '@material-ui/icons/ArrowBack';

import Dialog from '@material-ui/core/Dialog';
import DialogActions from '@material-ui/core/DialogActions';
import DialogContent from '@material-ui/core/DialogContent';
import DialogContentText from '@material-ui/core/DialogContentText';
import DialogTitle from '@material-ui/core/DialogTitle';

const styles = {
    chipBox: {
        padding: '2% 0 0 0',
        display: 'flex',
        flexDirection: 'row'
    },

    listBox: {
        margin: '1% 0'
    },

    chips: {
        margin: '0 1% 0 0'
    },

    title: {
        paddingBottom: '0.5%',
    },

    contentPaddingTop: {
        padding: '0.5% 0 0 0',
    },

    contentPaddingBottom: {
        padding: '0 0 0.5% 0',
    },

    img: {
        objectFit: 'cover',
        width: '100%',
        height: '100%',
    },

    centering: {
        textAlign: 'center',
    }
};

//リポジトリの詳細表示コンポーネント
class RepositoryDetail extends React.Component{

    constructor(props) {
        super(props);

        this.state = {
            open: false, //Snackbarの開閉状態
            openDialog: false, //Dialogの開閉状態
            message:'',　//Snackbarに表示するメッセージ
        };

        this.dispatchPrevious = this.dispatchPrevious.bind(this);
        this.confirmAccess = this.confirmAccess.bind(this);
        this.handleAccess = this.handleAccess.bind(this);
        this.handleClose = this.handleClose.bind(this);
    }

    //Click to previous pageボタンの動作
    dispatchPrevious(){
        this.props.history.push('/repos');
    }

    //URLをクリックした際の確認ダイアログ表示
    confirmAccess(e){
        e.preventDefault();
        this.setState({ openDialog: true })
    }

    //外部URLを別タブで開く
    handleAccess(url){
        open( url, "_blank" ) ;
        this.setState({ openDialog: false });
    }
    
    //Dialogを閉じる
    handleClose = () => {
        this.setState({ openDialog: false });
    };
    
    //Snackbarを閉じるための関数
    handleRequestClose(){
        this.setState({
            open: false,
        });
    }

    render(){
        //propsからReposで選択されたリポジトリを取得
        let repo = this.props.repo;

        return (
            <MuiThemeProvider>
                <div>
                    <h1 style={styles.centering}>リポジトリ詳細</h1>
                    <div>
                        <Button variant="contained" onClick={this.dispatchPrevious.bind(this)}>
                            <ArrowBack />前のページへ
                        </Button>
                    </div>
                    <div style={styles.listBox}>
                        <Card>
                            <CardHeader
                                avatar={
                                <Avatar aria-label="Recipe">
                                    <img src={repo.owner.avatar_url} style={styles.img}/>
                                </Avatar>
                                }
                                title={repo.owner.login}
                            />
                            <CardContent>

                                <Typography variant="title" component="h2" style={styles.title}>
                                    {repo.full_name}
                                </Typography>

                                <Divider />

                                <Typography variant="subheading" style={styles.contentPaddingTop}>
                                    description:
                                </Typography>

                                <Typography component="p" style={styles.contentPaddingBottom}>
                                    {repo.description}
                                </Typography>

                                <Divider />

                                <Typography variant="subheading" style={styles.contentPaddingTop}>
                                   Created at:
                                </Typography>
                                <Typography component="p" style={styles.contentPaddingBottom}>
                                    {repo.created_at}
                                </Typography>

                                <Divider />

                                <Typography variant="subheading" style={styles.contentPaddingTop}>
                                   Updated at:
                                </Typography>
                                <Typography component="p" style={styles.contentPaddingBottom}>
                                    {repo.updated_at}
                                </Typography>

                                <Divider />

                                <Typography variant="subheading" style={styles.contentPaddingTop}>
                                    URL:
                                </Typography>
                                <Typography component="p" style={styles.contentPaddingBottom}>
                                   <a href={repo.html_url} onClick={this.confirmAccess.bind(this)}>{repo.html_url}</a>
                                </Typography>

                                <Divider />

                                <Typography variant="subheading" style={styles.contentPaddingTop}>
                                    Clone URL:
                                </Typography>
                                <Typography component="p" style={styles.contentPaddingBottom}>
                                   {repo.clone_url}
                                </Typography>

                                <Divider />
                                <div style={styles.chipBox}>
                                    {(() => {
                                        if(repo.language != null)
                                            return <Chip label={repo.language} style={styles.chips}/>;
                                        
                                    })()}
                                        <Chip
                                        avatar={<Avatar>☆</Avatar>}
                                        label={repo.stargazers_count}
                                        style={styles.chips}
                                    />       
                                </div>         
                            </CardContent>
                        </Card>
                    </div>

                    {/* 警告用ダイアログ */}
                    <Dialog
                        open={this.state.openDialog}
                        onClose={this.handleClose}
                        aria-labelledby="alert-dialog-title"
                        aria-describedby="alert-dialog-description"
                    >
                    <DialogTitle id="alert-dialog-title">注意</DialogTitle>
                    <DialogContent>
                        <DialogContentText id="alert-dialog-description">
                        {repo.html_url}へアクセスします。よろしいですか？
                        </DialogContentText>
                    </DialogContent>
                    <DialogActions>
                        <Button onClick={this.handleClose.bind(this)} color="primary">
                            中止
                        </Button>
                        <Button onClick={this.handleAccess.bind(this,repo.html_url)} color="primary" autoFocus>
                            アクセス
                        </Button>
                    </DialogActions>
                    </Dialog>     
                </div>
            </MuiThemeProvider>
        );
    }
}

export default withStyles(styles)(RepositoryDetail);
