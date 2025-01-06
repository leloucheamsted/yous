
import 'package:flutter/material.dart';
import 'package:youscribe/styles/widget_styles.dart';
import 'package:youscribe/styles/youscribe_colors.dart';
import 'package:youscribe/utilities/constants.dart';

class ExplorerItemView extends StatelessWidget {
  const ExplorerItemView(
      {required this.exploreName,
      required this.onCategorySelected,
      required this.fontIcon,
      required this.name,
      required this.isYsClassfification,
      super.key});
  final String exploreName;
  final String fontIcon;
  final String name;
  final bool isYsClassfification;
  final void Function() onCategorySelected;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage(ImagesName.themeBackground),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Ink(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
        child: InkWell(
          borderRadius: BorderRadius.circular(5),
          onTap: onCategorySelected,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              height: 80,
              width: (MediaQuery.of(context).size.width - 70) / 2,
              child: Row(
                crossAxisAlignment: isYsClassfification
                    ? CrossAxisAlignment.stretch
                    : CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      exploreName,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: YouScribeColors.accentColor,
                          overflow: TextOverflow.clip,
                          fontSize: WidgetStyles.subBodySize,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  if (isYsClassfification)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Transform.rotate(
                          angle: -0.4,
                          child: Image.asset(getFacetImage(name),
                              height: 40, width: 40),
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String getFacetImage(String name) {
    switch (name) {
      case FacetName.actualites:
        return ImagesName.themeEducationSmall;
      case FacetName.art:
        return ImagesName.themeArtSmall;
      case FacetName.bdActionEtAventure:
        return ImagesName.themeBdActionEtAventureSmall;
      case FacetName.bdHumoristique:
        return ImagesName.themeBdHumoristiqueSmall;
      case FacetName.bdSfEtFantasy:
        return ImagesName.themeBdSfEtFantasySmall;
      case FacetName.bdSociete:
        return ImagesName.themeBdSocieteSmall;
      case FacetName.comics:
        return ImagesName.themeComicsSmall;
      case FacetName.culture:
        return ImagesName.themeCultureSmall;
      case FacetName.developpementPersonnel:
        return ImagesName.themeDeveloppementPersonnelSmall;
      case FacetName.education:
        return ImagesName.themeEducationSmall;
      case FacetName.enfants:
        return ImagesName.themeEnfantsSmall;
      case FacetName.fictions:
        return ImagesName.themeFictionsSmall;
      case FacetName.health:
        return ImagesName.themeHealthSmall;
      case FacetName.hobbies:
        return ImagesName.themeHobbiesSmall;
      case FacetName.know:
        return ImagesName.themeKnowSmall;
      case FacetName.life:
        return ImagesName.themeLifeSmall;
      case FacetName.lifepro:
        return ImagesName.themeLifeproSmall;
      case FacetName.literature:
        return ImagesName.themeLiteratureSmall;
      case FacetName.mangas:
        return ImagesName.themeMangasSmall;
      case FacetName.news:
        return ImagesName.themeNewsSmall;
      case FacetName.others:
        return ImagesName.themeOthersSmall;
      case FacetName.societe:
        return ImagesName.themeSocieteSmall;
      case FacetName.temoignages:
        return ImagesName.themeTemoignagesSmall;
      case FacetName.young:
        return ImagesName.themeYoungSmall;
      case FacetName.presseJeunesse:
        return ImagesName.themeEnfantsSmall;
      case FacetName.presseInternational:
        return ImagesName.themeOthersSmall;
      default:
        return ImagesName.themeOthersSmall;
    }
  }
}

class FacetName {
  static const young = "young";
  static const literature = "literature";
  static const lifepro = "lifepro";
  static const health = "health";
  static const bdActionEtAventure = "bd_action_et_aventure";
  static const know = "know";
  static const education = "education";
  static const hobbies = "hobbies";
  static const art = "art";
  static const news = "news";
  static const life = "life";
  static const others = "others";
  static const societe = "societe";
  static const culture = "culture";
  static const temoignages = "temoignages";
  static const fictions = "fictions";
  static const enfants = "enfants";
  static const developpementPersonnel = "developpement-personnel";
  static const bdHumoristique = "bd_humoristique";
  static const bdSfEtFantasy = "bd_sf_et_fantasy";
  static const mangas = "mangas";
  static const bdSociete = "bd_societe";
  static const comics = "comics";
  static const presseJeunesse = "presse-jeunesse";
  static const presseProfessionnelle = "presse-professionnelle";
  static const presseInternational = "presse-international";
  static const actualites = "actualites";
  static const lifestyle = "lifestyle";
  static const pratique = "pratique";
  static const cultureEtMedias = "culture-et-médias";
  static const presseSportive = "presse-sportive";
  static const professionnel = "professionnel";
}
