<section-group>
    <yield></yield>

    <style>
    </style>

    <script type="es6">

    this.on('mount', () => {
      this.onlyOnMembers = this.opts.onlyOnMembers === 'false' ? false : true;
      this.hideOthers = this.opts.hideOthers === 'false' ? false : true;
    });
    </script>
</section-group>
