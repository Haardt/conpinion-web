require('./bundle.css');

require('./common/section/section-manager');

require('./my-test');



<my-app>
    <div>
        This is a my custom element!!!!!1
    </div>

    <section-manager>
        <site-section active="true">
            <div class="ui center aligned header">
                Section-Test
            </div>
        </site-ssection>
    </section-manager>

    <my-test>

    </my-test>

    var hello: string = 'Hallo2';

</my-app>

riot.mount('*');