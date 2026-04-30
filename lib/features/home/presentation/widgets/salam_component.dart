import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:quran_app/config/app/theme/app_colors.dart';

class SalamComponent extends StatelessWidget {
  final String eng;
  final String arab;
  final String subTitle;
  const SalamComponent({super.key, required this.eng, required this.arab, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(width:double.infinity,
        height: 100,
        decoration: BoxDecoration(color: AppColors.green700,borderRadius: BorderRadius.circular(12)),

        child: Column(children: [Text(eng,style: GoogleFonts.nunito(
          color: AppColors.white500,fontSize: 20,fontWeight: FontWeight.bold
        )),
        SizedBox(height: 5,),
        Text(arab,style: GoogleFonts.nunito(color: AppColors.green100,fontSize: 18,fontWeight: FontWeight.bold),),
        SizedBox(height: 5,),
        Text(subTitle,style: GoogleFonts.nunito(color: AppColors.white500,fontSize: 16,fontWeight: FontWeight.bold),)
        ],),
      ),
    );
  }
}
