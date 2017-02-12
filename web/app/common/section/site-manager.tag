<site-manager>
    <yield></yield>

    <style>

    </style>

    <script type="text/es6">
        import './site-section.tag';

        this.mixin('redux');
        this.visibleSections = [this.opts.section];

        this.addSubscriber((store) => {
          console.log ('Manager-Store-Subscribe ->', this.getState());
          this.show(this.getState()['site-manager'].section);
        });

        this.on('mount', () => this.show(this.visibleSections));

        this.show = (section) => {
          if (this.tags['site-section']) {
            this.tags['site-section'].forEach((sectionTag) => {
              if (section.find(elm => elm === sectionTag.opts.name)) {
                sectionTag.show();
              } else {
                sectionTag.hide();
              }
          });
        }
      }

    </script>
</site-manager>
