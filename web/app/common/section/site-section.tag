<site-section if="{ active }">

    <div>
        <yield></yield>
    </div>
    
    <style>

    </style>

    <script type="text/es6">
       this.active = this.opts.active == 'true';
        this.on('update', function() {
            console.log("site-section update");
            });
    </script>
</site-section>
