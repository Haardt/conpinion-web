<con-view>

  <div show="{ visible }">
      <yield></yield>
  </div>

  <style>
  </style>

  <script type="es6">
  import { findConTag } from './con-app-utils.js';

  this.on('mount', () => {
    let conApp = findConTag('con-app', this.parent);
    conApp.addView(this);
   });

   this.show = () => {
      this.visible = true;
      this.update();
   }

   this.hide = () => {
      this.visible = false;
      this.update();
   }
  </script>
</con-view>
