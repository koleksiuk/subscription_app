import FormStoreActions from "./FormStoreActions"
import FormStore from "./stores/FormStore"

export default React.createClass({

  getInitialState: function() {
    return {};
  },

  handleClick: function(event) {
    event.preventDefault();

    FormStoreActions.send();

    this.setState({})
  },

  render: function() {
    var buttonValue = "Sign up!";
    var disabled    = !this.props.formState.valid;

    if(this.props.formState.sent) {
      this.disabled = true;
      buttonValue = "Signed up!";
    }
    else if(this.props.formState.pending) {
      this.disabled = true;
      buttonValue = "Sending...";
    } else {
      this.disabled = false;
    }


    return (
      <button className="btn btn-lg btn-default" onClick={this.handleClick} disabled={disabled}>{buttonValue}</button>
    )
  }
})
