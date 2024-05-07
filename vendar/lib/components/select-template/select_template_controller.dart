import 'package:vendar/model/template.dart';

class SelectTemplateController {
  final List<Template> templates = const [
    Template(
        name: 'Small old wardrobe',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1lbLefW-zCvm_UyZDrAkA1g0W3TjMi0UU',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1PzKWRET0acLJ6p4kvT4t7AQ9mozmGE0G'),
    Template(
        name: 'Small brown wardrobe',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1QvLGfvynhK1EO7OkOvEnU3nWB1L_AnJN',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1Bhq0wRUqtu2COjB6Rsbm_ych6rDsqyPX'),
    Template(
        name: 'Medium old wardrobe',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1RbzHodmmTD5tqMYldtBvcclB_pUSgwOq',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=170OmadEb6Kap-Rwxnx3JiCI66iH6eLUk'),
    Template(
        name: 'Large white wardrobe',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1HRTR6uDS8M6T4uUOeE45QkQsiU4L48lS',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1Yb7Vt06M1R_Aym63Kq7GF0zq9TklHq_l'),
    Template(
        name: 'Large hallway wardrobe',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1wZIi33wI8WL9BShfSbbZVZokUcOXOu62',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1Ko_ZCS97VmKDHL6DFZb8BKN3DepZelxd'),
    Template(
        name: 'Victorian wooden table',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1WBId3zDGBS-gmqK_HSvsupKM5yBxk-Uo',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=18o6KITZroHuefcERe0-Z64w_s0z9Fs_7'),
    Template(
        name: 'Victorian style desk',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1qBKsmyWHcg7MCMUgL3NvZzyDbvpNv7y4',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1qYexgfCck8Tn5P3362jW8DwU21dxgBev'),
    Template(
        name: 'Ultrawide monitor',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1wn95xsP8eF2MRttgBJKQ18CB7YTT4TGO',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1waL9D4GPZ7DmytncwRQxDVb7wXBqASfQ'),
    Template(
        name: 'TV cabinet Andersen',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1V7mntPA-ITP6L787frHzjQXkaN1FfpwG',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1NsRFJEay4gAgyTKbzCxYzJa_QA86FOg3'),
    Template(
        name: 'TV cabinet',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=16NZ-ucfPx1IG6847vy49cMzSbZaaY1_V',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1x7kQkp24bn2o9_QQpKKqfTHy2buMuR9Z'),
    Template(
        name: 'TV cabinet 2',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1kd12iU9Tb8fNRxIKXq_5yuyzMa5j6jcM',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1e0ZYOmPix99T6gwZNegKrVP7krZQSVc_'),
    Template(
        name: 'Dark brown table',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1WAIvN-dDiM7mXX7L7PSJjgkJ1aEJ_lNA',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=13-whlhlFkaVko_GRpgyJEteeqh8_gs8M'),
    Template(
        name: 'Brown table',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1qp2sCbIWuNjqFsALv5KhirEFSJ3KD7KT',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=13ryif1QRoHr2O734uGC7cLFM-Y8zJwm9'),
    Template(
        name: 'Stove with hood',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1v8maNIBPSdtZnybJ5_kdKRKni4PG6sjh',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1QiAOLUkgx8wnr-9vA4YDFId5DQ0evp-C'),
    Template(
        name: 'Sofa set 1',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1zef4c8uEanbWFmJh6rzb09SUV_yun3he',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1WJMNr5kr2ox4KT0JlMbaMOwZLgw21d1q'),
    Template(
        name: 'Single wooden bed',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1Vs_q4-7fWituqhJWPgUona4N5Py8PFVq',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1pXHGVF4pFnJELLoeLQG36Qa7K-n3YXJA'),
    Template(
        name: 'Rounded Chair',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1T743uZdZFmQ-AhI-c0EkgHDb7hmyVWJX',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1c6oTnko0L13NX1A-KN29fuFkvCmEsout'),
    Template(
        name: 'Round coffee table',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=14JqGbQxvWymjRb2po2v7MtTin9NIy_83',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1Bt__0pz1zOEu2KfC6DopXiI2TwtWJl3n'),
    Template(
        name: 'Black PC case',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1BTp6JyS9GzuMMOPgHBgzMP6-QhCL4bY-',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=12ojrQlodQSEPaW4jwjKv6jx1e1-c72P_'),
    Template(
        name: 'Black leather office chair',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1MFbzld_2RtAaqEtEvwlaTYSsPnfedNr7',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1_8gkPg-ozH5m3PJwvDSJIrnWqtEjwViw'),
    Template(
        name: 'Modern office chair',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1Bw-NPa57rGNlp0Dn05nT4bkOcwrf8-d4',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1JgtsdBEveqEmr04T9rHjFtZwKRp2Qv17'),
    Template(
        name: 'Monitor',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1-oQoSubEW69jDcGraF2hCcsSa81etYGx',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1carZfKoDNHDS2icOLyoGKXnC4sthshl8'),
    Template(
        name: 'Modern wooden wardrobe',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1lo1TGROf9RSAHmvLXdjZj37424je4lzS',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1tFvEUd2apR_5a4TQ79wpwJDaRGwmVlz9'),
    Template(
        name: 'Modern L sofa',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1sH7sxEHTM35oG_ytCyv6ZrAvRKGbMihc',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=13jZDqx0YUaKxgIsIUVbJyjPzYd3Grrf8'),
    Template(
        name: 'Modern ottoman',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1LfYfLeSHGtfM90f9GE41CNqrR0z4773y',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1emL7tkEOAHvYFdKinNA81ap_nBKwYIg8'),
    Template(
        name: 'Modern large sofa',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1b_xMU0Ft7fx5rkBQUbb10I6zjyhzk_zP',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1VyTtQ_bh9Ojhd-brVpJdn0gp6UrmUeoL'),
    Template(
        name: 'White microwave',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1AeKLQbQo0LAwLlYaYzWKGxe9Pqnra-lR',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1kGP2NGCg6_tncmXwwqgVxHPLRDLwPy7t'),
    Template(
        name: 'Living room cabinet',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1q1fcmccRa8sz1ztCv4yUkm7tNGT2z2_p',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=17vppfOQBbNm1PzHyfgfiHAmgr-i3fRa8'),
    Template(
        name: 'Small leather sofa',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1y0wJ5KDWT42r94RV77GPirBbHU96aiev',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1uPaqseHqW6525DEQaUtTL9H7ov3_a9Bj'),
    Template(
        name: 'Large leather sofa',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1c2jObjyIovuNRyfXl-pvwtMWCoELp7VN',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1T-W6EWstE5gbNUQ0qTLsGmuAgxGVUDCA'),
    Template(
        name: 'Small victorian sofa',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=103oaHQhs4qWKMG95l34OeSVBDvq6E2du',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1ssIgGhotvEZ2SwJJfh4pn96Nd6Wl6xb_'),
    Template(
        name: 'White bedside table',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=14cYHsBBQnQKGZhQPHzU07dvb_oTcg4rw',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1_bR77Uusn8nw0fvCX_23bMCI5Upzk_1S'),
    Template(
        name: 'Laptop',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1BPRx6pdApIHCJoxwSb0GXjcQcWfW3IAT',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1Q3PCb5Fi19URIBlRNn2U5iHympqCeBdP'),
    Template(
        name: 'Dell laptop',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=18r49x6kvuLpFrPK_hGgR6vpMGjDsQxkT',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1pHVJ6qboH2pqUORDs6AX1ulsYOlemx-n'),
    Template(
        name: 'Asus laptop',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1XZdKEuVSQ1s_x0_drlyOFpMwh_TmCfTN',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=16ETXc9YaQh-J4DDJozgdj3ti1Jq4wErO'),
    Template(
        name: 'Brown bedside table',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1XJyFuRaOVgblaRzieSSs_FyWDw6oKVmf',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1OitTnsvLV90crQiQ4bgUGnxQWF38u8dy'),
    Template(
        name: 'Industrial table',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1LMA5snPk3NGxsBRxRp22j22RJiKSHFHw',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1jGRG1F0-5ng6BjlEaLkbHy7cHdPNU0K5'),
    Template(
        name: 'Dark brown drawer',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1hwYi8KBEEzykuZEIrZKT-rRWYdhHgjud',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1VXMWUCkclCH_kY7OzDshpYe49J9P3_9h'),
    Template(
        name: 'White drawer',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1nu6GwseyX8LknGxuDK4cHoQYzHUp83MP',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=16LMg7aDBxXdhQecBmfOE8OZfgVsJkT5R'),
    Template(
        name: 'White cabinet',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1xu1EWKO9NCdgJ0_24YNGuIa_1BK2-Szw ',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1R4aOmcEDZDpGchvLy9DhmDz6W11ZNlaF'),
    Template(
        name: 'Gaming chair',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=17DOcmNJU4BPe1GAi14v91DItuSz7vORL',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1BxtBto4JgllQadUv3i2Y6ere7tiD2th_'),
    Template(
        name: 'Small single door fridge',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1XUjTapePqnqCMPkKFoiq2ADBEO4t2haS',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=127koKHBm0VsZDpE3XlhUsHPYUAzBD7kw'),
    Template(
        name: 'Modern single door fridge',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=16HIK8irvH1ImlwjwDGJoN2rdPi4bfvVd',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1xS0bugy2IormBTzXBP7DwceuP_TmmoiK'),
    Template(
        name: 'Double door fridge',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1tdc5tfHeulCz9DAAFofrGi9xfaHZWwyE',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1TiGMUO_IHWe_pwkQqb-7SMmhNmUFZTnA'),
    Template(
        name: 'Double door fridge with freezer',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=19KH2G2m3VLKSf13ov3cvxPhjnoif3oGh',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1hCdnknEwdXpMq4oQTVYwu1cgLEQxjWK8'),
    Template(
        name: 'Dining cabinet',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1wd3ep_CS85gICJ-X_y4F2gSz9JrvF6IH',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1NprLOoBkYj5gCVsk5mQ39gEQLXMQd2jC'),
    Template(
        name: 'Washing machine',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1vcP_iCNoEsZ6pLXPOgbXHGSJXqpWlY_Q',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1GUui2CSuU1W0r8WnpnweyBt6J8UBhA-H'),
    Template(
        name: 'Small brown drawer',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1fDbsFi0PYmlsKpycqW48R5aKGgNTGpym',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1th4davurUw4788PGYOXqQmTRZn6Vyn3S'),
    Template(
        name: 'Dishwasher',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1-F7ld5yrug2tokwCxbCjPpbDvJCjG72Z',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1y399Xz_dCeQDcFfZxPHN6Vo_UKJoWIX2'),
    Template(
        name: 'Built-in dishwasher',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=16w2nP9cYo11NWGNF4QIYxHbG7ECgqMBL',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=187v2rAR-myu1w_6OT-nBh3vtTMA8s0bB'),
    Template(
        name: 'Dining Set',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1OEuA49Gi9Y1_CxyBzVFiTdY7MqAbFPzd',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1mTnG72ofVsdbAS2RacOaPwaH1Mwj-jEO'),
    Template(
        name: 'Desk with drawers',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1QiQjtZekJlTy8Q9IIktC4t3_V-laZOZd',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1vM4B94yBF7FT_GfYiXZsauWZAI8cYlVX'),
    Template(
        name: 'Sailor bed',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1i8GECGbXAF3ZwCHLU3yxwc6nOL1FHOMj',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1dMI6i0xjhpA5R4IJci3eINMRtkbNloXG'),
    Template(
        name: 'Narrow double bed',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=155f9_K6-sXDEp0ommAHokxfkFHlbD-kc',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1-D0wf1kmJZFz_HhRdhfYi_giJX6uoONC'),
    Template(
        name: 'King sized bed with curtains',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=122GE1k0QDuDET4AlTBpqgjozu98vJtD_',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1GLiVbxeG8LWRDOFJ2b46Z5y7L-Xos_eX'),
    Template(
        name: 'Gaming PC',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1fnHZcK15pdqjal0tMM4FmjgZg5Joc8KQ',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=16xVxpdTcEBYdFlK3ZtTV7M85OatkAb71'),
    Template(
        name: 'Curved gaming monitor',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1j3EGdiCRKxTdUqoUWegrHsVrk9kwpb3D',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1-9s3tEUvZ_h8qxJ0dmX3f3qp3q1fUY8v'),
    Template(
        name: 'Wooden chair',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1wpn65yjA0d8hrjybvZosdRjEftYCKKYi',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1pU-QNuK_Vw7QwQe6cdOujHCFuqG01nEl'),
    Template(
        name: 'Bunk bed',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1lc7gvSu3UW-aRXKGnQ0_voPQJiMjHwxO',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1ijN1fbuMiry09iv62mgQ4qTqbhzZeohu'),
    Template(
        name: 'Large ottoman',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1XU3fHyWvFBbk-vZxh1f5ScBqYowwXEfR',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1Fia8gNPUqecswoeGBPrbwVvio17gY11Z'),
    Template(
        name: 'Black and white bedside table',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1DEqZLdRl4RXQ6cwzZc5yge6zOFBL52zV',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1Gg99xKBEmaORCHooBaiB_Xu-ACvL6Cxe'),
    Template(
        name: 'Office table',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1EqA9T0S6kTcJv3QzRwC4J9uRjHT-Havl',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1nSQkPZIXl2ta1seeJQYIpkebe59KXeOs'),
    Template(
        name: 'Office chair',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=1QKmquvJEo_iC0wZvJVryX6Vdjgzezv-u',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=1gzcSXvkKcDXMyut03EdTOJdhpW6UrY-i'),
    Template(
        name: 'Flat screen TV',
        modelSrc:
            'https://drive.google.com/uc?export=download&id=17tkm9JLKLjcQtaF_beXIq-UVGGUuZNam',
        imageSrc:
            'https://drive.google.com/uc?export=download&id=11VbdIIae-RVtdY1sQrA88bCDOuZWRP9o'),
  ];

  List<Template> getFilteredTemplates(String query) {
    if (query.isEmpty) {
      return templates;
    } else {
      return templates.where((template) {
        return template.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }
}
