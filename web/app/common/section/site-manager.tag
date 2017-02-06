<section-manager>
    <yield></yield>

    <style>

    </style>

    <script type="text/es6">
        import './site-section.tag';

        this.mixin('redux');
        this.activeSections = [this.opts.section];

        this.addSubscriber((store) => {
          console.log ('Store:', store);
          });

        this.on('mount', () => {
            if (this.tags['site-section']) {
              this.tags['site-section'].forEach( (tag, index) => {

                if (this.activeSections.find( elm => elm === tag.opts.name)) {
                  tag.show();
                } else {
                  tag.hide();
                }
            });
          }
        });

    </script>
</section-manager>
