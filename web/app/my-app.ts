import './my-test';

@template("view/my-app.html")
class MyApp extends Riot.Element
{
   // ...
  mounted()
   {
      console.log ("Hallo");
      //var bla = new MyTest();
   }


}

riot.mount('*');