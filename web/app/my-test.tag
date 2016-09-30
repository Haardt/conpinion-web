<my-test>
    <div>
        Test123456 { hello }
    </div>
    <script type="text/typescript">
        var text: string = 'hallo!!!1';
        this.hello = text;
        this.on ('update', function() {
          this.hello = text;
          });
    </script>
</my-test>