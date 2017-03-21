<router-test>
    <route-definitions>
        <route-entry route="/tests/*" function='callbackTest1'/>
        <route-entry route="/tests" function='callbackTest2'/>
    </route-definitions>

    <redux-reducer>
        <route-reducer></route-reducer>
    </redux-reducer>

    <script type="es6">
        this.callbackTest1 = () => {
            this.test1 = true;
        };
        this.callbackTest2 = () => {
            this.test2 = true;
        };

        this.getTest1 = () => this.test1;
        this.getTest2 = () => this.test2;
    </script>
</router-test>
