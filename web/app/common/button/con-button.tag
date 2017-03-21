<con-button>

  <button onclick={buttonClicked}>{label}</button>

  <script type="es6">
    import { findFunction, findConTag } from './../app/con-app-utils.js';

    this.key = this.opts.key;
    this.label = this.opts.label;

    this.buttonClicked = () => {
      let func = this.opts.function;
      findFunction(func, this.parent)[func]();
    };

    this.on('update', () => {
      this.label = this.opts.label;
    });

    this.on('mount', () => {
    });
  </script>
</con-button>
