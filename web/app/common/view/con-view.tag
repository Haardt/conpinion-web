<con-view>

  <div show="{ visible }">
      <yield></yield>
  </div>

  <style>
  </style>

  <script type="text/es6">
  this.on('mount', () => {
    let conApp = this.findConAppTag(this.parent);
    conApp.addView(this);
   });

   this.findConAppTag = (parent) => {
      if (parent.root.localName !== 'con-app') {
        return this.findConAppTag(parent.parent);
      }
      return parent;
   }
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
