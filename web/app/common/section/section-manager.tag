<section-manager>
    <yield></yield>

    <style>

    </style>

    <script type="text/es6">
        import './site-section.tag';

//        this.tags.forEach ((tag) => {
//          console.log (tag)
//          });

        this.on('update', function() {
            console.log("section-manager");
            });

    </script>
</section-manager>
