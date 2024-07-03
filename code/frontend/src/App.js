import logo from './logo.svg';
import './App.css';
import { Routes, Route, Link } from 'react-router-dom';
import Search from './components/search';
import Notices from './components/notices';
import Profile from './components/profile';
import Home from './components/home';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <nav>
          <Link to='/search'>search</Link> |
          <Link to='/notices'>notices</Link> |
          <Link to='/profile'>profile</Link>
        </nav>
      </header>
      <Routes>
        <Route path='/'/>
        <Route path='/search' element={<Search />} />
        <Route path='/notices' element={<Notices />} />
      </Routes>
        
      <Routes>
        <Route path='/' element={<Home/>}/>
        <Route path='/profile' element={<Profile />} />
      </Routes>
      <nav className='bottomNav'>
        <Link to='/'>Home</Link> |
        <Link to='/notices'>notices</Link> |
        <Link to='/profile'>profile</Link>
      </nav>
    </div>
  );
}

export default App;
