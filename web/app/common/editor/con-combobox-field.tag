<con-combobox-field>

  <p>
  <b>{label}</b>
  <input name={key} value={fieldValue}/>
  </p>


  <script type="text/es6">
    import { findConTag } from './../app/con-app-utils.js';

    this.key = this.opts.key;
    this.label = this.opts.label;
    this.fieldValue = this.opts.fieldValue;

    this.updateValue = (value) => this.fieldValue = value;

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
