<con-string-column>
  <p> { value } </p>

  <script type="es6">
    this.value = this.opts.columnValue;

    this.on('update', ()=> {
      this.value = this.opts.columnValue;
    });
  </script>
</con-string-column>
