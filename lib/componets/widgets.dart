import 'package:flutter/material.dart';
import 'package:news_app/pages/web_view_page.dart';
import 'package:news_app/shared/cubit/cubit.dart';

Widget BuildArticleItem(article,context) {
  bool? isDark=NewsCubit.isDark;
  return InkWell(
    onTap: ()
    {
      navigateTo(context, WebViewPage(article['url']));
      print(article['url']);
    },
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image:  DecorationImage(
                  image: NetworkImage(
                      article['urlToImage'] != null ? '${article['urlToImage']}' : 'https://th.bing.com/th/id/R.3156efdb345eadfa73224a6a32531124?rik=sFtdqrFD%2f60DrA&pid=ImgRaw&r=0&sres=1&sresct=1'),
                  fit: BoxFit.cover),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: SizedBox(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children:  [
                  Expanded(
                    child: Text(
                      '${article['title']}',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: isDark ?  Colors.white70:Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey
                    )
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget BuildListView(article){
  return ListView.separated(
    physics: const BouncingScrollPhysics(),
    separatorBuilder:(context,index)=> const Divider(
      thickness: 1,
      endIndent: 10,
      indent: 10,
      color: Colors.grey,
    ),
    itemCount: article.length,
    itemBuilder: (context,index) => BuildArticleItem(article[index],context),
  );
}


class CustomFormField extends StatelessWidget {
  CustomFormField({
    required this.labelText,
    this.prefixIcon,
    this.keyboardType,
    this.onSubmitted,
    this.onChanged,
    this.obscureText=false,
    this.hintText,
    this.suffixIcon,
    this.borderRadius = const BorderRadius.all(Radius.circular(5)),
    this.key,
    this.validator,
    this.controller,
    this.padding
  });


  String labelText;
  String? hintText;
  Widget? prefixIcon;
  Widget? suffixIcon;
  TextInputType? keyboardType;
  ValueChanged<String>? onSubmitted;
  ValueChanged<String>? onChanged;
  String? Function(String ?)? validator;
  bool obscureText;
  BorderRadius borderRadius ;
  Key? key;
  TextEditingController? controller;
  EdgeInsetsGeometry? padding;
  TextStyle? labelStyle;
  TextStyle? hintStyle;
  TextStyle? suffixStyle;
  TextStyle? prefixStyle;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      controller: controller,
      onFieldSubmitted: onSubmitted,
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      decoration:  InputDecoration(
        labelStyle: labelStyle,
        hintStyle: hintStyle,
        suffixStyle: suffixStyle,
        prefixStyle: prefixStyle,
        contentPadding: padding,
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
            borderRadius: borderRadius,
        ),
      ),

    );
  }
}

void navigateTo( context,widget) => Navigator.push(
  context,
  MaterialPageRoute(
      builder: (context)=> widget),
);
