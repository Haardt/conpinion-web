<top-menu>
    <div class='ui attached stackable menu'>
        <div class='ui container'>
            <yield/>
        </div>
    </div>

    <link rel="stylesheet" type="text/css" href="../../semantic/components/menu.css">

    <script type='text/typescript'>
        this.on('mount', () => {
            for (let menuItem of this.root.querySelectorAll('top-menu-item')) {
               console.log(menuItem);
            }
        });
    </script>

</top-menu>
