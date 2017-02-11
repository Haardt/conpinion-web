<site-manager>
    <yield></yield>

    <style>

    </style>

    <script type="text/es6">
        import './site-section.tag';

        this.mixin('redux');
        this.visibleSections = [this.opts.section];
        this.addSubscriber((store) => {
          console.log ('Manager-Store-Subscribe', this.getState()[0].section);
          this.show(this.getState()[0].section);
        });
        this.on('mount', () => this.show(this.visibleSections));

        this.show = (section) => {
          if (this.tags['site-section']) {
            this.tags['site-section'].forEach((tag, index) => {
                    console.log("nnn", section.find);

              if (section.find(elm => elm === tag.opts.name)) {
                tag.show();
              } else {
                tag.hide();
              }
          });
        }
      }

    </script>
</site-manager>
