<section-reducer>
    <script type="text/es6">
      import { SHOW_SECTION, HIDE_SECTION } from './section-actions.js'
      import { ROUTING_FINISHED } from '../router/route-actions.js'

      this.initState = {
        sections: ['']
      }

      this.name = () => 'section-manager';

      let self = this;

      this.reducer = {
        [SHOW_SECTION](state = initialState, action) {
            return {
              'sections': self._combineSections(state, action.sections.slice(0)),
              'added': action.sections
            };
          },
        [HIDE_SECTION](state = initialState, action) {
            let newState = state.section.filter( (elm) => ! action.sections.includes(elm) );
            return {
              'sections': newState,
              'removed': action.sections
            };
          },
        [ROUTING_FINISHED](state = initialState, action) {
            return {
              'sections': self._combineSections(state, action.sections.slice(0)),
              'added': action.sections
            };
          }
        };

      this._combineSections = (state, sections) => {
        return state.sections.reduce ( (acc, cur) => {
          if (cur === '' || acc.find( (elm) => cur === elm)) {
              return acc;
          }
          acc.push(cur);
          return acc;
        }, sections);
      }
    </script>
</section-reducer>
