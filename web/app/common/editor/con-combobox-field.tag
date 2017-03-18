<con-combobox-field>

  <p>
  <div show={hasValidationError}>
    <b>{validationError}</b>
  </div>
  <b>{label}</b>
  <input ref="combobox" name={key} value={fieldValue}/>
  </p>


  <script type="text/es6">
    import { findConTag } from './../app/con-app-utils.js';

    this.hasValidationError = false;
    this.validationError = '';
    this.key = this.opts.key;
    this.label = this.opts.label;
    this.fieldValue = this.opts.fieldValue;

    this.updateState = (state) => {
      this.hasValidationError = false;
      if (state.loading === true) {
        this.fieldValue = 'Loading';
      }
      else if (state.loading === false) {
        this.fieldValue = state.data[this.opts.key];
      }
      else if (state.error) {
        this.validationError = state.data.validation[this.opts.key];
        this.hasValidationError = !!state.data.validation[this.opts.key];
      }
    }
    this.save = data => data[this.key] = this.refs.combobox.value;

    this.on('update', () => {
      this.key = this.opts.key;
      this.label = this.opts.label;
    });

    this.on('mount', () => {
        let editor = findConTag('con-editor', this.parent);
        editor.addFieldDescription(this);
    });
  </script>
</con-combobox-field>
