<user-list>
    <div>
        <con-button label='new' function='new'/>
    </div>

    <con-table ref='users'>
        <yield to="columns">
            <con-column key="firstName" label="firstName" tag="con-string-column"/>
            <con-column key="lastName" label="lastName" tag="con-input-column"/>
        </yield>
        <yield to="buttons">
            <con-table-button label='Edit' function='edit'/>
            <con-table-button label='Delete' function='delete'/>
        </yield>
    </con-table>

    <script type="es6">
        import './../common/table/con-table.tag';
        import './../common/button/con-button.tag';
        import {newRoute} from './../common/router/route-actions.js'

        this.mixin('redux');

        this.edit = id => {
            this.dispatch(newRoute('/users/' + id));
        }

        this.delete = id => {
            this.dispatch(newRoute('/users/' + id));
        }

        this.new = () => {
            this.dispatch(newRoute('/users/new'));
        }

        this.on('mount', () => {
        });
    </script>
</user-list>