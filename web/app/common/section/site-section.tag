<site-section if="{ active }">

    <div>
        <yield></yield>
    </div>
    
    <style>

    </style>

    <script type="text/typescript">
       this.active = this.opts.active == 'true';

        this.on('update', function() {

            console.log("site-section");
            });

    </script>
</site-section>
