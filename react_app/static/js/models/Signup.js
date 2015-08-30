export default class Signup {
  constructor(fields) {
    this.fields = fields;
  }

  send() {
    var postData = this.data();

    return new Promise(function(resolve, reject) {
      $.ajax({
        type: "POST",
        url: "http://localhost:2300/api/subscribe",
        data: postData,
        dataType: 'json'
      }).done(
        function(data) { resolve(data); }
      ).error(
        function(data) { reject(); }
      );
    });
  }

  data() {
    return { subscription: this.fields };
  }
}
