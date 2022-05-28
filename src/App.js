import { useState } from 'react';
import './App.css';
import NavBar from './NavBar';
import MainMint from './MainMint';


function App() {
  const [accounts, setAccounts] = useState([]);

  return (<div className="App">
    <NavBar accounts={accounts} setAccounts={setAccounts} />
    <MainMint accounts={accounts} setAccounts={setAccounts} />
    </div>
  );
}

export default App;
