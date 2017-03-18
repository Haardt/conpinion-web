<con-table-button>

  <button onclick={buttonClicked}>{label}</button>

  <script type="text/es6">
    import { findFunction, findConTag } from './../app/con-app-utils.js';

    this.row = {};
    this.key = this.opts.key;
    this.label = this.opts.label;

    this.buttonClicked = () => {
      let id = this.row.opts.rowId
      let func = this.opts.function;
      findFunction(func, this.parent)[func](id);
    };

    this.on('update', () => {
      this.label = this.opts.label;
    });

    this.on('mount', () => {
        this.row = findConTag('con-row', this.parent);
    });
  </script>
</con-table-button>
