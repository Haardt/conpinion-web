<top-menu>
    <div class="ui borderless main menu">
        <div class="ui text container">
            <div href="#" class="header item">
                <p>{menuTitle}</p>
            </div>
            <yield />
        </div>
    </div>

    <script type='es6'>
        import "./../../../public/app/semantic/components/menu.css";
        import "./../../../public/app/semantic/components/container.css";
        import "./../../../public/app/semantic/components/header.css";
        import './top-menu-item.tag';

        this.menuTitle = this.opts.menuTitle;

        this.on('mount', () => {
            console.log("sdfsdf", this.opts.menuTitle);
            this.menuTitle = this.opts.menuTitle;
/*
            for (let menuItem of this.root.querySelectorAll('top-menu-item')) {
               console.log(menuItem);
            }
                           */

        });
    </script>

</top-menu>
