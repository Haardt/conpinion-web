<section-reducer>
    <script type="text/es6">
      import { SHOW_SECTION, HIDE_SECTION } from './section-actions.js'

      this.initState = {
        section: ['']
      }

      this.name = () => 'section-manager';

      this.reducer = {
        [SHOW_SECTION](state = initialState, action) {
            let newState = state.section.reduce ( (acc, cur) => {
              if (cur === '' || acc.find( (elm) => cur === elm)) {
                  return acc;
              }
              acc.push(cur);
              return acc;
            }, action.section.slice(0));
            return {
              'section': newState,
              'added': action.section
            };
          },
        [HIDE_SECTION](state = initialState, action) {
            let newState = state.section.filter( (elm) => ! action.section.includes(elm) );
            return {
              'section': newState,
              'removed': action.section
            };
          },
        };
    </script>
</section-reducer>
