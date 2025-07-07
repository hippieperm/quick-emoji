import '../models/emoji_category.dart';

class SearchService {
  static final SearchService _instance = SearchService._internal();

  factory SearchService() {
    return _instance;
  }

  SearchService._internal();

  // 이모지 키워드 매핑 데이터
  final Map<String, List<String>> _emojiKeywords = {
    '😀': ['웃음', '미소', '행복', '기쁨', 'smile', 'happy'],
    '😃': ['웃음', '미소', '행복', '기쁨', 'smile', 'happy', 'joy'],
    '😄': ['웃음', '미소', '행복', '기쁨', 'smile', 'happy', 'joy'],
    '😁': ['웃음', '미소', '행복', '기쁨', 'smile', 'happy', 'grin'],
    '😆': ['웃음', '미소', '행복', '기쁨', 'smile', 'happy', 'laugh'],
    '😅': ['웃음', '식은땀', '당황', 'smile', 'sweat', 'awkward'],
    '🤣': ['웃음', '폭소', '재미', 'laugh', 'funny', 'lol'],
    '😂': ['웃음', '눈물', '폭소', '재미', 'laugh', 'tears', 'joy'],
    '🙂': ['웃음', '미소', '행복', '기쁨', 'smile', 'happy'],
    '😊': ['웃음', '미소', '행복', '기쁨', '부끄러움', 'smile', 'happy', 'shy'],
    '😇': ['웃음', '미소', '천사', '순수', '착함', 'smile', 'angel', 'innocent'],
    '🥰': ['사랑', '애정', '하트', '행복', 'love', 'affection', 'heart'],
    '😍': ['사랑', '애정', '하트', '행복', '눈하트', 'love', 'heart', 'adore'],
    '🤩': ['별', '반짝', '흥분', '행복', 'star', 'excited', 'wow'],
    '☺️': ['웃음', '미소', '행복', '기쁨', 'smile', 'happy', 'relaxed'],
    '😋': ['맛있다', '음식', '먹다', '행복', 'yummy', 'food', 'delicious'],
    '😘': ['키스', '사랑', '애정', '하트', 'kiss', 'love', 'heart'],
    '😗': ['키스', '사랑', '애정', 'kiss', 'love'],
    '😚': ['키스', '사랑', '애정', '부끄러움', 'kiss', 'love', 'shy'],
    '😙': ['키스', '사랑', '애정', '미소', 'kiss', 'love', 'smile'],
    '😔': ['슬픔', '우울', '실망', '생각', 'sad', 'disappointed', 'pensive'],
    '😕': ['혼란', '의문', '고민', 'confused', 'puzzled'],
    '🙁': ['슬픔', '실망', '불만', 'sad', 'disappointed'],
    '☹️': ['슬픔', '실망', '불만', 'sad', 'disappointed', 'frown'],
    '😣': ['괴로움', '고통', '힘들다', 'pain', 'struggling'],
    '😖': ['괴로움', '당황', '혼란', 'pain', 'confused', 'troubled'],
    '😫': ['피곤', '지침', '힘들다', 'tired', 'exhausted'],
    '😩': ['피곤', '지침', '절망', 'tired', 'despair'],
    '🥺': ['부탁', '애원', '슬픔', '귀여움', 'please', 'beg', 'sad', 'cute'],
    '😢': ['슬픔', '울음', '눈물', 'sad', 'cry', 'tear'],
    '😭': ['슬픔', '울음', '눈물', '오열', 'sad', 'cry', 'tear', 'sob'],
    '😤': ['화남', '분노', '콧김', 'angry', 'mad', 'rage'],
    '😠': ['화남', '분노', '짜증', 'angry', 'mad', 'annoyed'],
    '😡': ['화남', '분노', '격분', '짜증', 'angry', 'mad', 'rage'],
    '🤬': ['화남', '분노', '욕설', '격분', 'angry', 'mad', 'rage', 'curse'],
    '😱': ['무서움', '공포', '비명', '충격', 'scared', 'fear', 'scream', 'shock'],
    '😨': ['무서움', '공포', '충격', '놀람', 'scared', 'fear', 'shock'],
    '😰': ['무서움', '걱정', '식은땀', '불안', 'scared', 'worry', 'sweat', 'anxious'],
    '😥': ['실망', '안도', '땀', 'disappointed', 'relief', 'sweat'],
    '😓': ['땀', '걱정', '실망', '부담', 'sweat', 'worry', 'pressure'],
    '🤗': ['포옹', '안아주다', '행복', 'hug', 'embrace', 'happy'],
    '🤭': ['놀람', '웃음', '부끄러움', '비밀', 'surprise', 'laugh', 'shy', 'secret'],
    '🤫': ['조용', '비밀', '쉿', 'quiet', 'secret', 'shush'],
    '🤔': ['생각', '고민', '의문', 'think', 'wonder', 'question'],
    '🤐': ['침묵', '입닫다', '비밀', 'silence', 'zip', 'secret'],
    '🤨': ['의심', '의아', '눈썹', 'doubt', 'suspicious', 'eyebrow'],
    '😐': ['무표정', '중립', '덤덤', 'neutral', 'expressionless'],
    '😑': ['무표정', '지루함', '짜증', 'expressionless', 'bored', 'annoyed'],
    '😶': ['무표정', '말없음', '침묵', 'expressionless', 'silent'],
    '😏': ['비웃음', '야비함', '자신감', 'smirk', 'confidence'],
    '😒': ['짜증', '불만', '지루함', 'annoyed', 'displeased', 'bored'],
    '🙄': ['짜증', '눈굴림', '지루함', 'annoyed', 'eye-roll', 'bored'],
    '😬': ['당황', '어색', '불편', 'awkward', 'uncomfortable', 'grimace'],
    '🤥': ['거짓말', '피노키오', '코', 'lie', 'pinocchio', 'nose'],
    '😌': ['안도', '평화', '편안', '행복', 'relief', 'peace', 'relaxed'],
    '😴': ['잠', '수면', '피곤', '졸림', 'sleep', 'tired', 'drowsy'],
    '😪': ['잠', '수면', '피곤', '졸림', 'sleep', 'tired', 'drowsy'],
    '🤤': ['침', '군침', '맛있다', '음식', 'drool', 'food', 'yummy'],
    '😷': ['마스크', '질병', '아픔', '코로나', 'mask', 'sick', 'ill', 'covid'],
    '🤒': ['열', '아픔', '질병', '온도계', 'fever', 'sick', 'ill', 'thermometer'],
    '🤕': ['부상', '아픔', '붕대', '다침', 'injury', 'sick', 'hurt', 'bandage'],
    '🤢': ['구역질', '메스꺼움', '아픔', '질병', 'nausea', 'sick', 'ill'],
    '🤮': ['구토', '토하다', '아픔', '질병', 'vomit', 'sick', 'ill'],
    '🤧': ['재채기', '콧물', '감기', '아픔', 'sneeze', 'cold', 'sick'],
    '🥵': ['더위', '열', '뜨거움', '땀', 'hot', 'heat', 'sweat'],
    '🥶': ['추위', '얼음', '차가움', '떨림', 'cold', 'ice', 'freezing'],
    '🥳': ['축하', '파티', '생일', '행복', 'celebrate', 'party', 'birthday', 'happy'],
    '😎': ['멋짐', '선글라스', '쿨', '자신감', 'cool', 'sunglasses', 'confidence'],
    '🤓': ['덕후', '안경', '공부', '똑똑', 'nerd', 'glasses', 'smart'],
    '🧐': ['의심', '관찰', '검토', '안경', 'doubt', 'examine', 'monocle'],
    '😲': ['놀람', '충격', '경악', 'surprise', 'shock', 'astonished'],
    '😳': ['당황', '부끄러움', '얼굴빨개짐', 'embarrassed', 'shy', 'blush'],
    '🥴': ['취함', '혼란', '어지러움', '술', 'drunk', 'confused', 'dizzy', 'alcohol'],
    '😵': ['어지러움', '혼란', '죽음', '충격', 'dizzy', 'confused', 'shocked'],
    '🤯': [
      '폭발',
      '충격',
      '놀람',
      '스트레스',
      'explosion',
      'shock',
      'surprise',
      'stress',
    ],

    // 동물 관련 키워드
    '🐶': ['개', '강아지', '동물', '애완', '반려', 'dog', 'puppy', 'animal', 'pet'],
    '🐱': ['고양이', '냥이', '동물', '애완', '반려', 'cat', 'kitten', 'animal', 'pet'],
    '🐭': ['쥐', '생쥐', '동물', 'mouse', 'animal'],
    '🐹': ['햄스터', '동물', '애완', '반려', 'hamster', 'animal', 'pet'],
    '🐰': ['토끼', '동물', '애완', '반려', 'rabbit', 'bunny', 'animal', 'pet'],
    '🦊': ['여우', '동물', 'fox', 'animal'],
    '🐻': ['곰', '동물', 'bear', 'animal'],
    '🐼': ['팬더', '동물', 'panda', 'animal'],
    '🐨': ['코알라', '동물', 'koala', 'animal'],
    '🐯': ['호랑이', '동물', 'tiger', 'animal'],
    '🦁': ['사자', '동물', 'lion', 'animal'],
    '🐮': ['소', '동물', 'cow', 'animal'],
    '🐷': ['돼지', '동물', 'pig', 'animal'],
    '🐸': ['개구리', '동물', 'frog', 'animal'],
    '🐵': ['원숭이', '동물', 'monkey', 'animal'],

    // 음식 관련 키워드
    '🍎': ['사과', '과일', '음식', 'apple', 'fruit', 'food'],
    '🍐': ['배', '과일', '음식', 'pear', 'fruit', 'food'],
    '🍊': ['귤', '오렌지', '과일', '음식', 'orange', 'tangerine', 'fruit', 'food'],
    '🍋': ['레몬', '과일', '음식', 'lemon', 'fruit', 'food'],
    '🍌': ['바나나', '과일', '음식', 'banana', 'fruit', 'food'],
    '🍉': ['수박', '과일', '음식', 'watermelon', 'fruit', 'food'],
    '🍇': ['포도', '과일', '음식', 'grape', 'fruit', 'food'],
    '🍓': ['딸기', '과일', '음식', 'strawberry', 'fruit', 'food'],
    '🍒': ['체리', '과일', '음식', 'cherry', 'fruit', 'food'],
    '🍑': ['복숭아', '과일', '음식', 'peach', 'fruit', 'food'],
    '🍍': ['파인애플', '과일', '음식', 'pineapple', 'fruit', 'food'],
    '🥥': ['코코넛', '과일', '음식', 'coconut', 'fruit', 'food'],
    '🥝': ['키위', '과일', '음식', 'kiwi', 'fruit', 'food'],
    '🍅': ['토마토', '채소', '음식', 'tomato', 'vegetable', 'food'],
    '🥑': ['아보카도', '과일', '음식', 'avocado', 'fruit', 'food'],

    // 기타 많이 사용되는 이모지 키워드
    '❤️': ['사랑', '하트', '좋아요', '애정', 'love', 'heart', 'like'],
    '👍': ['좋아요', '엄지', '긍정', '동의', 'like', 'thumbs up', 'agree'],
    '👎': ['싫어요', '엄지', '부정', '반대', 'dislike', 'thumbs down', 'disagree'],
    '👏': ['박수', '축하', '환호', '응원', 'clap', 'applause', 'cheer'],
    '🙏': ['기도', '감사', '부탁', '제발', 'pray', 'thank', 'please'],
    '👋': ['인사', '안녕', '손흔들기', '헬로', 'wave', 'hello', 'hi', 'goodbye'],
    '✌️': ['브이', '승리', '평화', 'peace', 'victory', 'v sign'],
    '🔥': ['불', '화재', '인기', '뜨거움', 'fire', 'hot', 'trending', 'lit'],
    '⭐': ['별', '스타', '인기', '평가', 'star', 'rating', 'favorite'],
    '💯': ['100점', '만점', '완벽', '최고', '100', 'perfect', 'score'],
    '💪': ['근육', '힘', '강함', '운동', 'muscle', 'strength', 'workout', 'gym'],
    '👀': ['눈', '보다', '주목', '관심', 'eyes', 'look', 'see', 'attention'],
    '🎉': [
      '축하',
      '파티',
      '이벤트',
      '생일',
      'celebration',
      'party',
      'event',
      'birthday',
    ],
    '🎁': ['선물', '생일', '축하', '깜짝', 'gift', 'present', 'birthday', 'surprise'],
    '🌈': ['무지개', '다양성', '희망', '행운', 'rainbow', 'diversity', 'hope', 'luck'],
  };

  // 초성 맵핑
  final Map<String, String> _choseongMap = {
    'ㄱ': '[가-깋]',
    'ㄲ': '[까-낗]',
    'ㄴ': '[나-닣]',
    'ㄷ': '[다-딯]',
    'ㄸ': '[따-띻]',
    'ㄹ': '[라-맇]',
    'ㅁ': '[마-밓]',
    'ㅂ': '[바-빟]',
    'ㅃ': '[빠-삫]',
    'ㅅ': '[사-싷]',
    'ㅆ': '[싸-앃]',
    'ㅇ': '[아-잏]',
    'ㅈ': '[자-짛]',
    'ㅉ': '[짜-찧]',
    'ㅊ': '[차-칳]',
    'ㅋ': '[카-킿]',
    'ㅌ': '[타-팋]',
    'ㅍ': '[파-핗]',
    'ㅎ': '[하-힣]',
  };

  // 이모지 검색 함수
  List<String> searchEmojis(String query, List<EmojiCategory> categories) {
    if (query.isEmpty) {
      return [];
    }

    // 모든 이모지 목록 생성
    List<String> allEmojis = [];
    for (var category in categories) {
      allEmojis.addAll(category.emojis);
    }

    // 중복 제거
    allEmojis = allEmojis.toSet().toList();

    // 검색어 소문자 변환
    final lowercaseQuery = query.toLowerCase();

    // 초성 검색 패턴 생성
    String pattern = '';
    bool isChoseong = false;

    for (int i = 0; i < lowercaseQuery.length; i++) {
      String char = lowercaseQuery[i];
      if (_choseongMap.containsKey(char)) {
        pattern += _choseongMap[char]!;
        isChoseong = true;
      } else {
        pattern += char;
      }
    }

    // 검색 결과 저장
    Set<String> results = {};

    // 초성 검색인 경우
    if (isChoseong) {
      RegExp regExp = RegExp(pattern);

      _emojiKeywords.forEach((emoji, keywords) {
        for (String keyword in keywords) {
          if (regExp.hasMatch(keyword)) {
            results.add(emoji);
            break;
          }
        }
      });
    }
    // 일반 검색인 경우
    else {
      _emojiKeywords.forEach((emoji, keywords) {
        for (String keyword in keywords) {
          if (keyword.toLowerCase().contains(lowercaseQuery)) {
            results.add(emoji);
            break;
          }
        }
      });
    }

    return results.toList();
  }
}
