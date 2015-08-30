import FormStoreActions from "../FormStoreActions"
import Signup from  "../models/Signup"

export default Reflux.createStore({
  listenables: [FormStoreActions],

  init() {
    this.fields = {}
    this.pending = false
    this.valid   = false;
    this.sent    = false;
  },

  getInitialState(){
    return this;
  },

  onFieldChanged(field, state){
    this.fields[field] = state;

    var validFields = $.map(this.fields, function(i, el) {
      return this.fields[el].valid;
    }.bind(this))

    this.valid = ($.grep(validFields, function(el) { return el == false; }).length == 0);

    this.triggerState();

  },

  onSend(btn) {
    if(this.valid) {
      this.pending = true;

      this.triggerState();

      (new Signup(this.fields)).send().then(
        function() {
          this.sent    = true;
          this.pending = false;
          this.triggerState();
        }.bind(this),
        function() {
          this.sent    = false;
          this.pending = false;
          this.triggerState();
        }.bind(this)
      )
    }
  },

  triggerState() {
    this.trigger(this);
  }
})

