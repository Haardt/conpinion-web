<section-reducer>
    <script type="text/es6">
     import { SHOW_SECTION } from './section-actions.js'


      this.initState = {
        section: ['']
      }

      this.name = () => 'site-manager';

      this.reducer = {
        [SHOW_SECTION](state = initialState, action) {
            return {'section': action.section};
          },
        };
    </script>
</section-reducer>
