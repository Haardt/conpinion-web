<section-manager>
    <yield></yield>

    <style>

    </style>

    <script type="text/es6">
        import './section-content.tag';
        import './section-group.tag';

        this.mixin('redux');
        this.visibleSections = [this.opts.section];
        this.on('mount', () => this.processGroups(this.visibleSections, (sections) => sections.show()));

        this.addSubscriber((store) => {
          let state = this.getState()['section-manager'];
          let processTag = !!state.added ? (sections) => sections.show() : (sections) => sections.hide();
          let sections = !!state.added ? state.added : state.removed;
          this.processGroups(sections, processTag);
        });

        this.processGroups = (sections, processTag) => {
          let groups = this.tags['section-group'];
          if (!groups) {
              this.processSections(sections, this.tags, processTag, false);
              return;
          }

          if (! Array.isArray(groups)) {
            groups=[groups];
          }
          groups.forEach((groupTag) => {
            if (! groupTag.onlyOnMembers || this._isMember(groupTag.tags['section-content'], sections)) {
              this.processSections(sections, groupTag.tags, processTag,
                groupTag.hideOthers);
            }
          });
        }

        this.processSections = (sections, tag, processTag, hideOtherTags) => {
          this._getSectionContent(tag).forEach((sectionTag) => {
            if (sections.find(elm => elm === sectionTag.opts.name)) {
              processTag(sectionTag);
            } else if (hideOtherTags) {
              sectionTag.hide();
            }
          });
        };

        this._getSectionContent = (tag) => {
          let sectionTags = tag['section-content'];
          if (! sectionTags) {
            return [];
          }

          if (! Array.isArray(sectionTags)) {
            return [sectionTags];
          }
          return sectionTags;
        }

        this._isMember = (array1, array2) => {
          return array1.filter((n) => array2.indexOf(n.opts.name) !== -1).length > 0;
        };

    </script>
</section-manager>
