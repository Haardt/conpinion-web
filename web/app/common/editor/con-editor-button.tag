<con-editor-button>

  <button onclick={buttonClicked}>{label}</button>

  <script type="es6">
    import { findFunction, findConTag } from './../app/con-app-utils.js';

    this.editor = {};
    this.key = this.opts.key;
    this.label = this.opts.label;
    this.fieldValue = this.opts.fieldValue;

    this.buttonClicked = () => this.editor._updateData((editorId, data) => {
      let func = this.opts.function;
      findFunction(func, this.parent)[func](editorId, data);
    });

    this.on('update', () => {
      this.label = this.opts.label;
    });

    this.on('mount', () => {
        this.editor = findConTag('con-editor', this.parent);
    });
  </script>
</con-editor-button>
