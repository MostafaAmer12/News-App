import 'package:flutter/material.dart';
import 'package:news_app/layout/modules/webVvew/web_view_screen.dart';


Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  required Function validate,
  required String label,
  required IconData prefix,
  Function? onTap,
  bool isSecured = false,
  IconData? suffix,
  Function? suffixAction,
  Function? onChange,
  })=>TextFormField(
        controller: controller,
        keyboardType: type,
        obscureText: isSecured,
        validator: (s){
          validate(s);
        },
        onTap: (){
          onTap!();
        },
        onChanged: (s){
          onChange!(s);
        },
        decoration: InputDecoration(
        //hintText: 'Email Address',
        labelText: label,
        prefixIcon: Icon(prefix,),
          suffixIcon: suffix!=null? IconButton(onPressed:(){
            suffixAction!();
          } ,
          icon:Icon(suffix,)):null,
        border: OutlineInputBorder(),
        ),
        /*onFieldSubmitted: (value)
                            {
                              print(value);
                            },
                            onChanged: (value)
                            {
                              print(value);
                            },*/
        );


Widget  buildArticleItem(article,context)=>InkWell(
  onTap: ()
  {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context){
              return WebViewScreen(article['url']);
            }
        )
    );
  },
  child:   Padding(
  
      padding: const EdgeInsets.all(20.0),
  
    child: Row(
  
      children: [
  
        Container(
  
          width: 120,
  
          height: 120,
  
          decoration: BoxDecoration(
  
            borderRadius: BorderRadius.circular(10),
  
            image: DecorationImage(
  
              image: NetworkImage('${article['urlToImage']}'),
  
              fit: BoxFit.cover,
  
            )
  
          ),
  
        ),
  
        SizedBox(
  
          width: 20,
  
        ),
  
        Expanded(
  
        child: Container(
  
        height: 120.0,
  
        child: Column(
  
          mainAxisSize: MainAxisSize.min,
  
          crossAxisAlignment: CrossAxisAlignment.start,
  
          mainAxisAlignment: MainAxisAlignment.start,
  
          children: [
  
            Expanded(
  
              child: Text(
  
                '${article['title']}',
  
                style: const TextStyle(
  
                  fontSize: 18.0,
  
                  fontWeight: FontWeight.w800,),
  
                maxLines: 3,
  
                overflow: TextOverflow.ellipsis,
  
              ),
  
            ),
  
            Text(
  
              '${article['publishedAt']}',
  
              style: TextStyle(
  
                color: Colors.grey,
  
              ),
  
            )
  
          ],
  
        ),
  
  )
  
  )
  
      ]
  
  )
  
  ),
);

