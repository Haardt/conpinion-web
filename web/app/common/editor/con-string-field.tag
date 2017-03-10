<con-string-field>
  <script type="text/es6">
    import { findConTag } from './../app/con-app-utils.js';

    this.on('mount', () => {
        let editor = findConTag('con-editor', this.parent);
        editor.addField(this);
    });
  </script>
</con-string-field>
