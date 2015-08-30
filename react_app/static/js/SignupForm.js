import Input from './Input'
import FormStore from './stores/FormStore'
import SendButton from './SendButton'

export default React.createClass({
  mixins: [
    Reflux.connect(FormStore, 'formState'),
  ],

  render: function() {
    return (
      <form>
        <Input name="email" placeholder="Email" regex="(.+)@(.+){2,}\.(.+){2,}" requiredLength="6" />
        <Input name="first_name" placeholder="First name (min. 3 characters)" />
        <Input name="last_name" placeholder="Last name (not required)" requiredLength="0" />
        <SendButton formState={this.state.formState} />
      </form>
    )
  }
})
