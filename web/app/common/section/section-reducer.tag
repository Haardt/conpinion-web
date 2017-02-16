<section-reducer>
    <script type="text/es6">
      import { SHOW_SECTION } from './section-actions.js'

      this.initState = {
        section: ['']
      }

      this.name = () => 'section-manager';

      this.reducer = {
        [SHOW_SECTION](state = initialState, action) {
            return {'section': action.section};
          },
        };
    </script>
</section-reducer>
