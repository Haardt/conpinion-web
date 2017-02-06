<top-menu>
    <div class='ui attached stackable menu'>
        <div class='ui container'>
            <yield/>
        </div>
    </div>


    <script type='text/es6'>
        import "./../../../public/app/semantic/components/menu.css";
        import './top-menu-item.tag';

        this.on('mount', () => {
/*
            for (let menuItem of this.root.querySelectorAll('top-menu-item')) {
               console.log(menuItem);
            }
                           */

        });
    </script>

</top-menu>
