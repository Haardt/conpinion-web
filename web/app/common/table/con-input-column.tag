<con-input-column>
  <p><b> { value } </b></p>

  <script type="es6">
    this.value = this.opts.columnValue;
    
    this.on('update', ()=> {
      this.value = this.opts.columnValue;
    });
  </script>
</con-input-column>
