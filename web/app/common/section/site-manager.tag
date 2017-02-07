<site-manager>
    <yield></yield>

    <style>

    </style>

    <script type="text/es6">
        import './site-section.tag';

        this.mixin('redux');
        this.visibleSections = [this.opts.section];

        this.addSubscriber((store) => {
          console.log ('Store:', store);
        });
        this.on('mount', () => {
            if (this.tags['site-section']) {
              this.tags['site-section'].forEach( (tag, index) => {
                      console.log("nnn", this.visibleSections.find);

                if (this.visibleSections.find(elm => elm === tag.opts.name)) {
                  tag.show();
                } else {
                  tag.hide();
                }
            });
          }
        });

    </script>
</site-manager>
