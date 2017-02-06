<redux-subscriber>

  <yield>
  </yield>

  <script type='text/es6'>
    this.mixin('redux');
    console.log ("Object-Keys:", this.tags);
    this.on('mount', () => {
      console.log ("Object-Keys:", Object.keys(this.tags));
    });
  </script>

</redux-subscriber>