import React from 'react';
import { BrowserRouter, Route} from 'react-router-dom';

import { Provider } from 'react-redux';

import Search from '../container/Search';
import Repos from '../container/Repos';
import RepositoryDetail from '../container/RepositoryDetail';

import { PersistGate } from 'redux-persist/integration/react'
import store, { persistor } from '../store/ConfigureStore'

// ルーター
const Routers = () => (
    <BrowserRouter>
    <div>
        <Route exact path={'/'} component={Search} />
        <Route exact path={'/repos'} component={Repos} />
        <Route exact path={'/repos/detail'} component={RepositoryDetail} />
    </div>   
    </BrowserRouter>
)

export default class App extends React.Component{
    render(){
        return(
            <Provider store={store}>
                <PersistGate loading={null} persistor={persistor}>
                    <Routers />
                </PersistGate>
            </Provider>
        )
    }
}

