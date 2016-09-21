<my-test>
    <div>
       Test123456 { hello }
    </div>

    var text: string = 'hallo!!!1';
    this.hello = text;
    this.on ('update', function() {
      this.hello = text;
      });
</my-test>