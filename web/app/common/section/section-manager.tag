<section-manager>
    <yield></yield>

    <style>

    </style>

    <script type="text/es6">
        import './section-content.tag';

        this.mixin('redux');
        this.visibleSections = [this.opts.section];
        this.on('mount', () => this.processSection(this.visibleSections, (sections) => sections.show()));

        this.addSubscriber((store) => {
          let state = this.getState()['section-manager'];
          let processTag = !!state.added ? (sections) => sections.show() : (sections) => sections.hide();
          let sections = !!state.added ? state.added : state.removed;
          this.processSection(sections, processTag);
        });

        this.processSection = (sections, processTag) => {
          if (this.tags['section-content']) {
            this.tags['section-content'].forEach((sectionTag) => {
              if (sections.find(elm => elm === sectionTag.opts.name)) {
                processTag(sectionTag);
              }
          });
        }
      }

    </script>
</section-manager>
