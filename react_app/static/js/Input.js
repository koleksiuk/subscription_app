import FormStoreActions from "./FormStoreActions"
import FormStore from "./stores/FormStore"

export default React.createClass({
  getInitialState: function() {
    var valid = this.testLength('') && this.testRegexp('');

    var state = {value: '', hasError: false, valid: valid}

    this.fieldChanged(state);

    return state;
  },

  getDefaultProps: function() {
    return {
      requiredLength: 3,
      regex: null
    }
  },

  handleChange: function(event) {
    var val = event.target.value;
    var hasError = false;
    var valid    = true;

    if (!this.testLength(val) || !this.testRegexp(val)) {
      hasError = true;
      valid    = false;
    }

    var state = {
      value:    val,
      hasError: hasError,
      valid:    valid
    };

    this.setState(state);

    // this.setState is asynchronous;
    this.fieldChanged(state);
  },

  testLength: function(val) {
    return val.length >= this.props.requiredLength;
  },

  testRegexp: function(val) {
    if(this.props.regex) {
      var r = new RegExp(this.props.regex);

      // Test value against regexp
      return r.test(val);
    }

    return true;
  },

  fieldChanged: function(state) {
    FormStoreActions.fieldChanged(this.props.name, state.value);
  },

  render: function() {
    var value = this.state.value;

    var classes = classNames({
      'form-group': true,
      'has-error': this.state.hasError
    });

    return (
      <div className={classes}>
        <input className="form-control" type="text" name={this.props.name} placeholder={this.props.placeholder} value={value} onChange={this.handleChange} />
      </div>
    )
  }
})
