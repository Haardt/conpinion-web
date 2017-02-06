<site-section>

    <div if="{ visible }">
        <yield></yield>
    </div>
    
    <style>

    </style>

    <script type="text/es6">
       this.visible = false;

       this.show = () => {
        this.visible = true;
        this.update();
       }
       this.hide = () => {
        this.visible = false;
        this.update();
       }
    </script>
</site-section>
