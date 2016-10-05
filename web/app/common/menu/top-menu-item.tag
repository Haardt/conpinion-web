<top-menu-item>
    <a class="{ active: active } item">
        <yield/>
    </a>

    <script type="text/typescript">
        this.active = this.opts.active;

        this.on('update', () => {
//            console.log(this.opts.active == "true");

        });
    </script>

</top-menu-item>
