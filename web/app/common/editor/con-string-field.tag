<con-string-field>

    <p>
    <div show={hasValidationError}>
        <b>{validationError}</b>
    </div>
    {label}
    <input ref="string" oninput={inputChanged} name={key} value={fieldValue}/>
    </p>

    <script type="es6">
        import {findConTag} from './../app/con-app-utils.js';

        this.mixin('redux');

        this.hasValidationError = false;
        this.validationError = '';
        this.key = this.opts.key;
        this.label = this.opts.label;
        this.fieldValue = this.opts.fieldValue;

        this.inputChanged = event => {
            console.log(event);
        }

        this.setEditorName = (editorName) => {
            console.log('Set editor', editorName, this.opts.key);
            this.editorName = editorName;
        }

        this.on('update', () => {
            this.key = this.opts.key;
            this.label = this.opts.label;
        });

        this.on('mount', () => {
            let editor = findConTag('con-editor', this.parent);
            editor.addFieldDescription(this);

            this.addSubscriber(state => {
                let editor = state.editor;
                if (!editor[this.editorName]) {
                    return;
                }
                let editorData = editor[this.editorName][editor[this.editorName].loadingId];
                if (editorData) {
                    this.hasValidationError = false;
                    if (editorData.loading === true) {
                        if (editorData.cachedData) {
                            this.fieldValue = editorData.cachedData[this.opts.key] + ' ...Loading';
                        } else {
                            this.fieldValue = 'Loading';
                        }
                    }
                    else if (editorData.loading === false) {
                        this.fieldValue = editorData.data[this.opts.key];
                    }
                    else if (editorData.error) {
                        this.validationError = editorData.data.validation[this.opts.key];
                        this.hasValidationError = !!editorData.data.validation[this.opts.key];
                    }
                    this.update();
                }
            });
        });

    </script>
</con-string-field>
