import React from 'react';

class Calculator extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      result: 0,
      num1: "",
      num2: ""
    }
    this.setNum1 = this.setNum1.bind(this);
    this.setNum2 = this.setNum2.bind(this);
    this.add = this.add.bind(this);
    this.subtract = this.subtract.bind(this);
    this.multiply = this.multiply.bind(this);
    this.divide = this.divide.bind(this);
    this.clear = this.clear.bind(this);
  }
  
  setNum1(e) {
  e.preventDefault();
  this.setState({ num1: parseInt(e.currentTarget.value)});
}

  setNum2(e) {
  e.preventDefault();
  this.setState({ num2: parseInt(e.currentTarget.value)});
}

  add(e) {
    e.preventDefault();
    this.setState({result: this.state.num1 + this.state.num2});
  }
  
  subtract(e) {
    e.preventDefault();
    this.setState({result: this.state.num1 - this.state.num2});
  }
  
  multiply(e) {
    e.preventDefault();
    this.setState({result: this.state.num1 * this.state.num2});
  }
  
  divide(e) {
    e.preventDefault();
    this.setState({result: this.state.num1 / this.state.num2});
  }
  
  clear(e) {
    e.preventDefault();
   this.setState({
      result: 0,
      num1: "",
      num2: ""
    }); 
  }
  
  

  // your code here

  render() {
    return (
      <div>
        <h1>{this.state.result}</h1>
        <br/>
        <label>Number 1 &nbsp;
        <input type="text" value={this.state.num1} onChange={this.setNum1}/>
        </label>
        <label>Number 2 &nbsp;
        <input type="text" value={this.state.num2} onChange={this.setNum2}/>
        </label>
        <br/>
        <button onClick={this.add}>+</button>
        <button onClick={this.subtract}>-</button>
        <button onClick={this.multiply}>x</button>
        <button onClick={this.divide}>/</button>
        <br/>
        <button onClick={this.clear}>Clear</button>
      </div>
    );
  }
}

export default Calculator;