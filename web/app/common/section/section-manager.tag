<section-manager>
    <yield></yield>

    <style>

    </style>

    <script type="text/es6">
        import './section-content.tag';

        this.mixin('redux');
        this.visibleSections = [this.opts.section];

        this.addSubscriber((store) => {
          this.show(this.getState()['site-manager'].section);
        });

        this.on('mount', () => this.show(this.visibleSections));

        this.show = (section) => {
          if (this.tags['section-content']) {
            this.tags['section-content'].forEach((sectionTag) => {
              if (section.find(elm => elm === sectionTag.opts.name)) {
                sectionTag.show();
              } else {
                sectionTag.hide();
              }
          });
        }
      }

    </script>
</section-manager>
