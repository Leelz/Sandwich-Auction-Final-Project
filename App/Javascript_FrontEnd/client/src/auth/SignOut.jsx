import React from 'react'
// import PropTypes from 'prop-types';
import { Link } from 'react-router'

class SignOut extends React.Component{

  constructor(){
    super()
    this.signOut = this.signOut.bind(this)
  }
  
  signOut(event){
    event.preventDefault()
    const request = new XMLHttpRequest()
    request.open("DELETE", this.props.url)
    request.setRequestHeader("Content-Type", "application/json")
    request.withCredentials = true
    request.onload = () => {
      console.log('signed out', request.status)
      if (request.status === 204){
        this.props.onSignOut(null)
      }
    }
    request.send(null)
  }

  render() {
    return (
       <div>
        <button onClick={this.signOut}>Sign Out</button>
        <Link className='sandwiches-link' to='/sandwiches'>View Sandwiches</Link>
      </div>
    )
  }
}

export default SignOut