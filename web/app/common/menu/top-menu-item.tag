<top-menu-item>
    <a class="{ active: active } item"  onclick={menuClick}>
        <yield/>
    </a>

    <script type="es6">
        this.mixin('router');


        this.active = this.opts.active;

        this.on('update', () => {
//            console.log(this.opts.active == "true");

        });

        this.menuClick = () => {
          this.routeTo(this.opts.route);
        }
    </script>

</top-menu-item>
