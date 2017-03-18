<con-editor-button>

  <button onclick={buttonClicked}>{label}</button>

  <script type="text/es6">
    import { findFunction, findConTag } from './../app/con-app-utils.js';

    this.editor = {};
    this.key = this.opts.key;
    this.label = this.opts.label;
    this.fieldValue = this.opts.fieldValue;

    this.updateValue = (value) => this.fieldValue = value;
    this.buttonClicked = () => this.editor._updateData((data) => {
      let func = this.opts.function;
      findFunction(func, this.parent)[func](data);
    });

    this.on('update', () => {
      this.label = this.opts.label;
    });

    this.on('mount', () => {
        this.editor = findConTag('con-editor', this.parent);
    });
  </script>
</con-editor-button>
