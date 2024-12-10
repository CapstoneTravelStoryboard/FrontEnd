
List<Map<String, Object>> travelList = [
  //유저가 등록한 모든 여행지 리스트
  {
    "trip_id": 1,
    "title": '제주도 가족여행',
    "destination_list": ['제주시, 서귀포시'], //방문 행정구역 (랜드마크도 됨)
    "day_start": "2024-03-01", //여행날짜
    "storyboardList": <Map<String, dynamic>>[storyboard1_1,storyboard1_2,storyboard1_3], //해당 여행 소속 스토리보드 모음. 추후 URL로 요청
  },
  {
    "trip_id": 2,
    "title": '나의 겨울여행',
    "destination_list": ['전주시, 여수시, 종로구'],
    "day_start": "2025-01-02", //여행날짜
    "storyboardList": <Map<String, dynamic>>[storyboard2_1,storyboard2_2,storyboard2_3],
  },
  {
    "trip_id": 3,
    "title": '나의 겨울여행',
    "destination_list": [''],
    "day_start": "", //여행날짜
    "storyboardList": <Map<String, dynamic>>[],
  },
];

Map<String, dynamic> storyboard1_1 = {
  //travel1의 첫번째 스토리보드
  "travel_id": 1, // 여행 아이디 (int)
  "storyboard_id": 1, // 스토리보드 아이디 (int)
  "userId": 101, // 사용자 ID (int)
  "season" : "봄",
  "title": "한라산 등반", // 제목 (String)
  "destination": "한라산", // 목적지 (String)
  "companions": "가족", // 동반자 (String)
  "purpose": "등산과 자연 체험", // 목적 (String)
  "start_date": "2024-03-01", // 방문 날짜 (String, 날짜 포맷)
  "createdAt": "2024-03-01T08:00:00.000", // 생성 날짜 (String, ISO 8601)
  "updatedAt": "2024-03-02T08:00:00.000", // 업데이트 날짜 (String, ISO 8601)
  "sceneList": <Map<String, dynamic>>[scene1_1_1,scene1_1_2,scene1_1_3,scene1_1_4,scene1_1_5],
};
//final List<Map<String, dynamic>> sceneList = storyboard1_1['sceneList'] as List<Map<String, dynamic>>;

Map<String, dynamic> scene1_1_1 = {
  "scene_id": 1, //주 키
  "storyboard_id": 1, // 소속 스토리보드 아이디 외래키
  "order_num": 1,
  "sceneTitle": "숲길에서의 시작",
  "description":
  "등산을 시작하며 초입의 숲길을 걸어가는 장면으로, 여행의 첫 시작을 상징하며 숲의 평화로운 분위기를 보여줍니다.",
  "camera_angle":
  "(Wide Shot) 넓은 시야를 통해 숲의 아름다운 전경과 등장인물들을 동시에 담아내며, 자연의 웅장함을 강조합니다.",
  "camera_movement":
  "(Static) 카메라가 움직이지 않고 고정된 상태에서 피사체가 움직이도록 설정하여 안정적인 분위기를 연출합니다",
  "composition": "(Centered) 장면의 주요 요소를 화면 중앙에 배치하여 안정감과 명확한 초점을 제공합니다",
  "image_url": "https://example.com/scene1.jpg",
  "created_at": "2024-03-01T08:00:00.000",
  "updated_at": "2024-03-01T08:30:00.000"
};
Map<String, dynamic> scene1_1_2 = {
  "scene_id": 2, //주 키
  "storyboard_id": 1, // 소속 스토리보드 아이디 외래키
  "order_num": 2,
  "sceneTitle": "숲 속의 휴식",
  "description":
  "숲 속에서 휴식을 취하는 장면으로, 자연의 고요함과 여유로움을 담아내고 있습니다. 등장인물들이 숲의 평화로운 분위기 속에서 쉬며 여행의 여유를 즐기는 모습을 표현합니다.",
  "camera_angle": "Close-Up (근접 촬영으로, 인물이나 특정 디테일을 강조)",
  "camera_movement": "Tracking (카메라가 인물의 움직임을 부드럽게 따라가는 방식)",
  "composition": "Dynamic (비대칭적이고 생동감 있는 구도로 자연과 인물의 조화를 강조)",
  "image_url": "https://example.com/scene1.jpg",
  "created_at": "2024-03-01T08:00:00.000",
  "updated_at": "2024-03-01T08:30:00.000"
};
Map<String, dynamic> scene1_1_3 = {
  "scene_id": 3, //주 키
  "storyboard_id": 1, // 소속 스토리보드 아이디 외래키
  "order_num": 3,
  "sceneTitle": "중턱에서의 감탄",
  "description":
  "한라산 중턱에서 멋진 경치를 감상하는 장면으로, 광활한 자연의 풍경과 여행자들의 감탄을 동시에 담아내는 순간을 표현합니다. 주변의 경치와 인물 간의 조화로 자연의 웅장함을 부각합니다.",
  "camera_angle": "Overhead (카메라를 높은 위치에서 내려다보는 각도로, 경치의 스케일과 배경을 강조)",
  "camera_movement": "Pan Right (카메라를 오른쪽으로 회전하며 풍경의 연속성을 부드럽게 보여줌)",
  "composition": "Symmetrical (장면을 대칭적으로 배치하여 안정감과 조화로운 미감을 전달)",
  "image_url": "https://example.com/scene1.jpg",
  "created_at": "2024-03-01T08:00:00.000",
  "updated_at": "2024-03-01T08:30:00.000"
};
Map<String, dynamic> scene1_1_4 = {
  "scene_id": 4, //주 키
  "storyboard_id": 1, // 소속 스토리보드 아이디 외래키
  "order_num": 4,
  "sceneTitle": "정상에서의 성취",
  "description":
  "정상에 도착하여 기념사진을 찍는 장면으로, 여행의 성취감을 담아냅니다. 인물들이 기쁨과 만족감을 표현하며 특별한 순간을 사진으로 기록하는 모습을 보여줍니다.",
  "camera_angle": "Medium Shot (인물과 배경이 함께 담긴 거리로, 인물의 표정과 주변 환경을 균형 있게 보여줌)",
  "camera_movement": "Zoom In (카메라가 천천히 인물 쪽으로 확대되어 장면의 감정적인 깊이를 강조)",
  "composition": "Centered (주요 피사체를 화면 중앙에 배치하여 안정감과 초점의 명확함을 전달)",
  "image_url": "https://example.com/scene1.jpg",
  "created_at": "2024-03-01T08:00:00.000",
  "updated_at": "2024-03-01T08:30:00.000"
};
Map<String, dynamic> scene1_1_5 = {
  "scene_id": 5, //주 키
  "storyboard_id": 1, // 소속 스토리보드 아이디 외래키
  "order_num": 5,
  "sceneTitle": "하산의 여운",
  "description":
  "하산하며 숲길의 노을을 감상하는 장면으로, 하루의 끝을 평화롭게 마무리하는 순간을 표현합니다. 숲길을 따라 떨어지는 햇빛과 노을의 따뜻한 색감이 여운을 남기며 감동적인 분위기를 연출합니다.",
  "camera_angle": "Wide Shot (넓은 시야로 숲길과 노을의 경치를 모두 담아내며 자연의 아름다움을 강조)",
  "camera_movement": "Static (카메라를 고정하여 노을과 숲의 고요함을 안정적으로 표현)",
  "composition": "Balanced (장면의 양쪽 요소를 균형 있게 배치하여 조화롭고 평화로운 분위기를 전달)",
  "image_url": "https://example.com/scene1.jpg",
  "created_at": "2024-03-01T08:00:00.000",
  "updated_at": "2024-03-01T08:30:00.000"
};


Map<String, dynamic> storyboard1_2 = {
  //travel1의 2번째 스토리보드
  "travel_id": 1, // 여행 아이디 (int)
  "storyboard_id": 2, // 스토리보드 아이디 (int)
  "userId": 101, // 사용자 ID (int)
  "title": "우도 자전거 여행",
  "season" : "여름",
  "destination": "우도",
  "companions": "부모님",
  "purpose": "바다와 경치 감상",
  "start_date": "2024-03-01", // 방문 날짜 (String, 날짜 포맷)
  "createdAt": "2024-03-10T10:00:00.000",
  "updatedAt": "2024-03-10T12:00:00.000",
  "scenesList": <Map<String, dynamic>>[scene1_2_1,scene1_2_2,scene1_2_3,scene1_2_4,scene1_2_5] //나중에 url로 대체
};

Map<String, dynamic> scene1_2_1 = {
  "scene_id": 1, //주 키
  "storyboard_id": 1, // 소속 스토리보드 아이디 외래키
  "order_num": 1,
  "sceneTitle": "우도에서의 시작",
  "description":
  "우도의 입구에서 자전거를 대여하는 장면으로, 여행의 시작을 준비하는 모습을 보여줍니다. 자전거와 여행자들이 우도의 여유로운 분위기 속에서 설렘을 느끼는 순간을 담아냅니다.",
  "camera_angle": "Medium Shot (인물과 자전거를 적절한 거리에서 담아, 행동과 주변 환경의 조화를 강조)",
  "camera_movement": "Zoom Out (카메라가 점차 멀어지며 장면의 전체적인 맥락과 공간감을 확대하여 보여줌)",
  "composition": "Symmetrical (자전거와 인물들이 화면의 중심에 대칭적으로 배치되어 안정적이고 정돈된 느낌을 전달)",
  "image_url": "https://example.com/scene1.jpg",
  "created_at": "2024-03-01T08:00:00.000",
  "updated_at": "2024-03-01T08:30:00.000"
};

Map<String, dynamic> scene1_2_2 = {
  "scene_id": 2, //주 키
  "storyboard_id": 1, // 소속 스토리보드 아이디 외래키
  "order_num": 2,
  "sceneTitle": "해안가의 자유",
  "description":
  "자전거를 타고 해안가를 따라 달리는 장면으로, 바다와 자연을 배경으로 한 자유롭고 활기찬 분위기를 담아냅니다. 여행자들이 바람을 느끼며 해안선을 따라 달리는 모습이 시원함과 역동성을 강조합니다.",
  "camera_angle": "Wide Shot (넓은 시야로 해안가와 자전거를 함께 담아 자연의 스케일과 움직임을 강조)",
  "camera_movement": "Tracking (카메라가 자전거의 움직임을 따라가며 장면에 생동감을 더함)",
  "composition": "Centered (자전거와 해안선을 화면 중앙에 배치하여 초점의 명확성을 유지하며 장면의 균형을 잡음)",
  "image_url": "https://example.com/scene1.jpg",
  "created_at": "2024-03-01T08:00:00.000",
  "updated_at": "2024-03-01T08:30:00.000"
};

Map<String, dynamic> scene1_2_3 = {
  "scene_id": 3, //주 키
  "storyboard_id": 1, // 소속 스토리보드 아이디 외래키
  "order_num": 3,
  "sceneTitle": "바다와의 휴식",
  "description":
  "바다를 배경으로 쉬는 장면으로, 여행자들이 고요한 바다의 풍경을 감상하며 휴식을 취하는 모습을 담아냅니다. 평온한 순간 속에서 자연과의 조화를 느낄 수 있는 장면입니다.",
  "camera_angle": "Close-Up (인물의 표정이나 손동작 등 세부적인 요소를 강조하여 감정과 분위기를 부각)",
  "camera_movement": "Zoom In (카메라가 천천히 인물에게 가까워지며 감정의 집중도와 장면의 몰입감을 높임)",
  "composition": "Dynamic (다채로운 프레임 구성을 통해 바다와 인물 간의 상호작용을 강조하며 장면에 생동감을 부여)",
  "image_url": "https://example.com/scene1.jpg",
  "created_at": "2024-03-01T08:00:00.000",
  "updated_at": "2024-03-01T08:30:00.000"
};

Map<String, dynamic> scene1_2_4 = {
  "scene_id": 4, //주 키
  "storyboard_id": 1, // 소속 스토리보드 아이디 외래키
  "order_num": 4,
  "sceneTitle": "전망대에서의 감탄",
  "description":
  "우도의 전망대에서 풍경을 감상하는 장면으로, 광활한 자연의 아름다움과 여행자들의 감탄을 담아냅니다. 바다와 하늘이 어우러진 풍경이 장면의 중심을 이루며, 여행의 여유로움을 전달합니다.",
  "camera_angle": "Overhead (전망대와 주변 풍경을 높은 시점에서 내려다보며 장면의 스케일과 공간감을 강조)",
  "camera_movement": "Pan Left (카메라가 왼쪽으로 이동하며 풍경의 연속성을 자연스럽게 보여줌)",
  "composition": "Balanced (풍경과 여행자들을 화면의 양쪽에 균형 있게 배치하여 안정적이고 조화로운 느낌을 전달)",
  "image_url": "https://example.com/scene1.jpg",
  "created_at": "2024-03-01T08:00:00.000",
  "updated_at": "2024-03-01T08:30:00.000"
};

Map<String, dynamic> scene1_2_5 = {
  "scene_id": 5, //주 키
  "storyboard_id": 1, // 소속 스토리보드 아이디 외래키
  "order_num": 5,
  "sceneTitle": "여정의 마무리",
  "description":
  "자전거를 반납하며 여행을 마무리하는 장면으로, 즐거웠던 여정을 끝내는 아쉬움과 만족감을 담아냅니다. 여행자들이 자전거를 정리하며 마지막 순간을 정리하는 모습을 보여줍니다.",
  "camera_angle": "Medium Shot (자전거와 인물의 행동을 적절한 거리에서 담아내며, 장면의 세부적인 감정을 강조)",
  "camera_movement": "Static (고정된 카메라로 차분하고 안정적인 분위기를 연출하며 마무리의 느낌을 전달)",
  "composition": "Symmetrical (자전거와 여행자들을 화면 중앙에 대칭적으로 배치하여 정돈되고 깔끔한 마무리를 표현)",
  "image_url": "https://example.com/scene1.jpg",
  "created_at": "2024-03-01T08:00:00.000",
  "updated_at": "2024-03-01T08:30:00.000"
};


Map<String, dynamic> storyboard1_3 = {
  //travel1의 2번째 스토리보드
  "travel_id": 1, // 여행 아이디 (int)
  "storyboard_id": 3, // 스토리보드 아이디 (int)
  "userId": 101, // 사용자 ID (int)
  "title": "천지연 폭포 야경",
  "season" : "가을",
  "destination": "천지연 폭포",
  "companions": "가족",
  "purpose": "야경 감상과 사진 촬영",
  "start_date": "2024-03-02", // 방문 날짜 (String, 날짜 포맷)
  "createdAt": "2024-03-20T19:00:00.000",
  "updatedAt": "2024-03-20T21:00:00.000",
  "scenesList": <Map<String, dynamic>>[scene1_3_1,scene1_3_2,scene1_3_3,scene1_3_4,scene1_3_5]
};

Map<String, dynamic> scene1_3_1 = {
  "scene_id": 1,
  "storyboard_id": 3,
  "order_num": 1,
  "sceneTitle": "천지연 폭포 입구의 기대감",
  "description": "천지연 폭포 입구에 도착하는 장면으로, 웅장한 폭포의 시작점을 보여주며 여행자들의 기대감과 설렘을 표현합니다. 입구의 자연 풍경과 폭포로 이어지는 길을 강조하여 장면의 분위기를 고조시킵니다.",
  "camera_angle": "Wide Shot (입구와 주변 환경을 넓은 시야로 담아 폭포로 이어지는 장면의 스케일을 강조)",
  "camera_movement": "Static (고정된 카메라로 입구의 웅장함과 안정감을 전달)",
  "composition": "Centered (폭포 입구를 화면의 중앙에 배치하여 초점과 균형감을 명확히 유지)",
  "image_url": "https://example.com/scene1.jpg",
  "created_at": "2024-03-20T19:00:00.000",
  "updated_at": "2024-03-20T19:15:00.000"
};
Map<String, dynamic> scene1_3_2 = {
  "scene_id": 2,
  "storyboard_id": 3,
  "order_num": 2,
  "sceneTitle": "길목에서 감상하는 야경",
  "description": "폭포로 가는 길목에서 펼쳐진 야경을 감상하는 장면으로, 어둠 속에서도 빛나는 자연의 고요함과 아름다움을 담아냅니다. 폭포로 이어지는 길과 주변 풍경이 여행자들의 감탄을 불러일으킵니다.",
  "camera_angle": "Overhead (높은 시점에서 길과 풍경을 내려다보며 공간감과 야경의 스케일을 강조)",
  "camera_movement": "Zoom In (카메라가 천천히 길목의 특정 지점으로 확대되어 장면의 디테일과 몰입감을 높임)",
  "composition": "Dynamic (다양한 요소가 비대칭적으로 배치되어 야경의 생동감과 깊이를 전달)",
  "image_url": "https://example.com/scene2.jpg",
  "created_at": "2024-03-20T19:30:00.000",
  "updated_at": "2024-03-20T19:45:00.000"
};
Map<String, dynamic> scene1_3_3 = {
  "scene_id": 3,
  "storyboard_id": 3,
  "order_num": 3,
  "sceneTitle": "폭포를 배경으로 남기는 추억",
  "description": "천지연 폭포를 배경으로 사진을 찍는 장면으로, 웅장한 폭포와 여행자들의 즐거운 표정을 함께 담아 특별한 추억을 기록합니다.",
  "camera_angle": "Close-Up (여행자들의 표정과 자세를 근접 촬영하여 감정과 생동감을 부각)",
  "camera_movement": "Pan Right (카메라가 오른쪽으로 천천히 이동하며 배경과 인물의 조화를 자연스럽게 표현)",
  "composition": "Symmetrical (폭포와 여행자들을 화면 중앙에 대칭적으로 배치하여 정돈된 느낌과 안정감을 강조)",
  "image_url": "https://example.com/scene3.jpg",
  "created_at": "2024-03-20T20:00:00.000",
  "updated_at": "2024-03-20T20:15:00.000"
};
Map<String, dynamic> scene1_3_4 = {
  "scene_id": 4,
  "storyboard_id": 3,
  "order_num": 4,
  "sceneTitle": "폭포 옆에서 느끼는 평화",
  "description": "폭포 옆 산책길에서 야경을 감상하는 장면으로, 고요한 자연과 어우러진 빛의 조화 속에서 여행자들이 평화로운 순간을 만끽하는 모습을 담아냅니다.",
  "camera_angle": "Medium Shot (여행자와 주변 환경을 적절한 거리에서 담아 자연과의 조화를 강조)",
  "camera_movement": "Static (고정된 카메라로 산책길과 야경의 정적이고 안정적인 분위기를 표현)",
  "composition": "Balanced (장면의 양쪽 요소를 균형 있게 배치하여 조화롭고 차분한 느낌을 전달)",
  "image_url": "https://example.com/scene4.jpg",
  "created_at": "2024-03-20T20:30:00.000",
  "updated_at": "2024-03-20T20:45:00.000"
};
Map<String, dynamic> scene1_3_5 = {
  "scene_id": 5,
  "storyboard_id": 3,
  "order_num": 5,
  "sceneTitle": "여정을 마무리하는 순간",
  "description": "천지연 폭포 앞에서 여행을 마무리하는 장면으로, 웅장한 폭포와 여행자들의 여유로운 모습이 하루의 끝을 상징적으로 보여줍니다.",
  "camera_angle": "Wide Shot (폭포와 여행자들을 넓은 시야로 담아 전체적인 풍경과 여운을 강조)",
  "camera_movement": "Zoom Out (카메라가 점차 멀어지며 장면의 스케일을 확대하고 여행의 마무리를 부각)",
  "composition": "Centered (주요 요소를 화면 중앙에 배치하여 초점과 안정감을 제공)",
  "image_url": "https://example.com/scene5.jpg",
  "created_at": "2024-03-20T20:45:00.000",
  "updated_at": "2024-03-20T21:00:00.000"
};

Map<String, dynamic> storyboard2_1 = {
  //travel2의 1번째 스토리보드
  "travel_id": 2, // 여행 아이디 (int)
  "storyboard_id": 1, // 스토리보드 아이디 (int)
  "userId": 101, // 사용자 ID (int)
  "title": "전통의 맛, 전주비빔밥과 한옥 체험",
  "season" : "겨울",
  "destination": "전북 전주 한옥마을",
  "companions": "가족",
  "purpose": "가족여행",
  "start_date": "2024-04-06", // 방문 날짜 (String, 날짜 포맷)
  "createdAt": "2024-04-05T09:00:00.000",
  "updatedAt": "2024-04-05T12:00:00.000",
  "scenesList": <Map<String, dynamic>>[scene2_1_1,scene2_1_2,scene2_1_3,scene2_1_4,scene2_1_5]
};

Map<String, dynamic> storyboard2_2 = {
  //travel2의 2번째 스토리보드
  "travel_id": 2, // 여행 아이디 (int)
  "storyboard_id": 2, // 스토리보드 아이디 (int)
  "userId": 101, // 사용자 ID (int)
  "season" : "봄",
  "title": "겨울 바다 속 로맨스, 여수 해상케이블카 데이트",
  "destination": "여수 해상케이블카",
  "companions": "연인",
  "purpose": "바다풍경",
  "start_date": "2025-01-19", // 방문 날짜 (String, 날짜 포맷)
  "createdAt": "2024-04-15T14:00:00.000",
  "updatedAt": "2024-04-15T16:30:00.000",
  "scenesList": <Map<String, dynamic>>[scene2_2_1,scene2_2_2,scene2_2_3,scene2_2_4]
};

Map<String, dynamic> storyboard2_3 = {
  //travel2의 3번째 스토리보드
  "travel_id": 3, // 여행 아이디 (int)
  "storyboard_id": 2, // 스토리보드 아이디 (int)
  "userId": 101, // 사용자 ID (int)
  "title": "겨울 속 왕궁: 경복궁의 역사와 비밀",
  "destination": "경복궁",
  "companions": "친구",
  "season" : "여름",
  "purpose": "역사여행",
  "start_date": "2025-01-14", // 방문 날짜 (String, 날짜 포맷)
  "createdAt": "2024-04-15T14:00:00.000",
  "updatedAt": "2024-04-15T16:30:00.000",
  "scenesList": <Map<String, dynamic>>[scene2_3_1,scene2_3_2,scene2_3_3,scene2_3_4,scene2_3_5]
};

Map<String, dynamic> scene2_1_1 = {
  "scene_id": 1,
  "storyboard_id": 1,
  "order_num": 1,
  "sceneTitle": "고즈넉한 아침의 시작",
  "description": "전주 한옥마을의 아침 풍경이 펼쳐집니다. 창살을 통해 비치는 부드러운 햇살이 마루를 감싸안으며, 가족들이 한옥의 정취를 느끼며 아침을 맞이하는 모습이 담깁니다.",
  "camera_angle": "Dutch Angle (창문 너머로 들어오는 햇살을 비스듬하게 포착하여 아침의 고요함 속에 숨겨진 긴장감을 subtly 강조)",
  "camera_movement": "Pan (창문에서 마루로 부드럽게 이동하며, 가족들의 아침 일상을 자연스럽게 따라감)",
  "composition": "Framed (창살을 통해 들어오는 햇살과 가족들을 중심에 배치하여 따뜻함과 평화로움을 강조)",
  "image_url": "https://example.com/scene1.jpg",
  "created_at": "2024-03-01T08:00:00.000",
  "updated_at": "2024-03-01T08:30:00.000"
};
Map<String, dynamic> scene2_1_2 = {
  "scene_id": 2,
  "storyboard_id": 1,
  "order_num": 2,
  "sceneTitle": "한옥의 매력 탐방",
  "description": "가족들이 한옥마을의 골목길을 거닐며, 전통 한옥의 아름다움을 감상하는 장면이 이어집니다. 한옥의 지붕선과 담장이 조화롭게 어우러진 모습을 보여줍니다.",
  "camera_angle": "Wide Shot (넓은 앵글로 한옥의 전경과 가족들의 움직임을 자연스럽게 포착)",
  "camera_movement": "Tracking (가족들의 움직임을 따라가며 한옥의 디테일을 클로즈업으로 보여줌)",
  "composition": "Symmetrical (한옥의 지붕선이 강조되며, 가족들이 중심에 배치되어 전통과 현대의 조화를 표현)",
  "image_url": "https://example.com/scene1.jpg",
  "created_at": "2024-03-01T08:00:00.000",
  "updated_at": "2024-03-01T08:30:00.000"
};
Map<String, dynamic> scene2_1_3 = {
  "scene_id": 3,
  "storyboard_id": 1,
  "order_num": 3,
  "sceneTitle": "온돌방 체험의 따뜻함",
  "description": "가족들이 한옥생활체험관에서 온돌방을 체험하는 장면입니다. 따뜻한 온돌 위에 앉아 전통 한식을 즐기는 모습이 담깁니다.",
  "camera_angle": "Close-Up (온돌방의 아늑한 분위기를 강조하며, 가족들의 표정과 전통 한식의 디테일을 포착)",
  "camera_movement": "Cross (온돌방 내부를 다양한 각도로 교차 촬영하며 따뜻함을 강조)",
  "composition": "Centered (온돌방의 중심에 가족들이 둘러앉아 전통 한식과의 조화를 이루는 구도)",
  "image_url": "https://example.com/scene1.jpg",
  "created_at": "2024-03-01T08:00:00.000",
  "updated_at": "2024-03-01T08:30:00.000"
};
Map<String, dynamic> scene2_1_4 = {
  "scene_id": 4,
  "storyboard_id": 1,
  "order_num": 4,
  "sceneTitle": "전주비빔밥의 맛",
  "description": "전주비빔밥을 만드는 과정과 가족들이 함께 비빔밥을 즐기는 장면이 이어집니다. 신선한 재료들이 하나씩 그릇에 담기는 모습이 생생하게 보여집니다.",
  "camera_angle": "Close-Up (비빔밥의 재료들을 클로즈업으로 포착하며, 색감과 질감을 강조)",
  "camera_movement": "Handheld (자연스러운 움직임으로 비빔밥의 준비 과정을 따라가며 화목한 분위기를 연출)",
  "composition": "Dynamic (비빔밥을 중심으로 가족들이 둘러싸 화목한 분위기를 강조)",
  "image_url": "https://example.com/scene1.jpg",
  "created_at": "2024-03-01T08:00:00.000",
  "updated_at": "2024-03-01T08:30:00.000"
};
Map<String, dynamic> scene2_1_5 = {
  "scene_id": 5,
  "storyboard_id": 1,
  "order_num": 5,
  "sceneTitle": "감미로운 야경",
  "description": "전주 한옥마을의 밤이 찾아오고, 천사초롱과 조명들이 한옥담장을 비추며 감미로운 야경을 만들어냅니다. 가족들이 야경을 감상하며 하루를 마무리하는 모습이 담깁니다.",
  "camera_angle": "Dutch Angle (감미로운 야경 속에서의 특별한 감정과 순간을 강조하기 위해 살짝 기울어진 앵글을 사용)",
  "camera_movement": "Slow Pan (천천히 한옥마을의 야경을 스캔하며 가족들의 감상 장면을 자연스럽게 포착)",
  "composition": "Layered (조명이 한옥담장을 따라 이어지며, 가족들이 중심에 배치되어 밤의 아름다움을 강조)",
  "image_url": "https://example.com/scene1.jpg",
  "created_at": "2024-03-01T08:00:00.000",
  "updated_at": "2024-03-01T08:30:00.000"
};

Map<String, dynamic> scene2_2_1 = {
  "scene_id": 1,
  "storyboard_id": 4,
  "order_num": 1,
  "sceneTitle": "사랑의 시작",
  "description": "두 연인이 손을 잡고 여수 해상케이블카 탑승장으로 걸어가는 장면으로 시작합니다. 그들의 실루엣이 겨울 햇살에 비춰져 따뜻한 분위기를 자아냅니다.",
  "camera_angle": "Low Angle (낮은 각도에서 두 사람의 실루엣을 담아내며, 그 뒤로 펼쳐진 케이블카와 바다를 함께 포착)",
  "camera_movement": "Follow (카메라는 천천히 두 사람을 따라가며, 그들의 발걸음에 맞춰 부드럽게 이동)",
  "composition": "Centered (두 연인이 화면 중앙에 위치하며, 그 뒤로 케이블카와 바다가 자연스럽게 배경을 이루어 로맨틱한 순간을 강조)",
  "image_url": "https://example.com/scene1.jpg",
  "created_at": "2024-03-25T10:00:00.000",
  "updated_at": "2024-03-25T10:30:00.000"
};
Map<String, dynamic> scene2_2_2 = {
  "scene_id": 2,
  "storyboard_id": 4,
  "order_num": 2,
  "sceneTitle": "크리스털 캐빈의 설렘",
  "description": "두 연인이 크리스털 캐빈에 탑승하여 발 밑의 투명한 바닥을 통해 바다를 바라보는 장면입니다. 그들의 얼굴에 설렘과 약간의 긴장감이 스쳐갑니다.",
  "camera_angle": "Close-Up (캐빈 내부에서 두 사람의 표정과 발 밑의 바다를 동시에 담아냄)",
  "camera_movement": "Orbit (카메라는 캐빈 내부를 부드럽게 회전하며, 두 사람의 표정과 바다의 풍경을 번갈아가며 보여줌)",
  "composition": "Centered (두 사람의 얼굴이 화면의 중심에 위치하며, 그 아래로 투명한 바닥과 바다가 펼쳐져 시각적인 깊이를 더함)",
  "image_url": "https://example.com/scene2.jpg",
  "created_at": "2024-03-25T10:45:00.000",
  "updated_at": "2024-03-25T11:00:00.000"
};
Map<String, dynamic> scene2_2_3 = {
  "scene_id": 3,
  "storyboard_id": 4,
  "order_num": 3,
  "sceneTitle": "바다 위의 로맨스",
  "description": "케이블카가 바다 위를 지나며 두 연인이 서로를 바라보며 미소 짓는 장면입니다. 바다와 하늘이 어우러진 풍경이 그들의 배경을 장식합니다.",
  "camera_angle": "Wide Shot (케이블카 외부에서 두 사람을 비추며, 그 뒤로 펼쳐진 광활한 바다와 하늘을 함께 담음)",
  "camera_movement": "Tracking (카메라는 케이블카와 함께 천천히 이동하며, 두 사람의 모습을 다양한 각도에서 포착)",
  "composition": "Offset (두 연인이 화면의 오른쪽에 위치하고, 왼쪽으로는 넓게 펼쳐진 바다와 하늘이 자리잡아 로맨틱한 분위기를 강조)",
  "image_url": "https://example.com/scene3.jpg",
  "created_at": "2024-03-25T11:15:00.000",
  "updated_at": "2024-03-25T11:30:00.000"
};
Map<String, dynamic> scene2_2_4 = {
  "scene_id": 4,
  "storyboard_id": 4,
  "order_num": 4,
  "sceneTitle": "저녁의 추억",
  "description": "케이블카에서 내려와 손을 잡고 걷는 두 사람의 뒷모습을 보여줍니다. 겨울 저녁의 차가운 공기 속에서도 그들의 따뜻한 감정이 전해집니다.",
  "camera_angle": "Over-the-Shoulder (두 사람의 뒷모습을 따라가며, 그들이 걸어가는 길과 주변 겨울 풍경을 함께 담음)",
  "camera_movement": "Follow (카메라는 두 사람의 발걸음에 맞춰 부드럽게 뒤따라가며 뒷모습을 자연스럽게 포착)",
  "composition": "Linear Perspective (두 사람의 뒷모습이 화면 중앙에 위치하며, 그들이 걸어가는 길이 화면의 깊이를 더해줌)",
  "image_url": "https://example.com/scene4.jpg",
  "created_at": "2024-03-25T11:45:00.000",
  "updated_at": "2024-03-25T12:00:00.000"
};


Map<String, dynamic> scene2_3_1 = {
  "scene_id": 1,
  "storyboard_id": 5,
  "order_num": 1,
  "sceneTitle": "겨울 속의 왕궁: 경복궁의 첫인상",
  "description": "경복궁의 웅장한 입구인 흥례문을 지나며, 눈 덮인 궁궐의 전경이 펼쳐집니다. 겨울의 차가운 공기 속에서 고요하게 서 있는 궁궐의 모습이 인상적입니다.",
  "camera_angle": "Wide Shot (넓은 앵글로 흥례문을 중심으로 잡아, 그 뒤로 펼쳐진 경복궁의 전경을 담아냄)",
  "camera_movement": "Forward Tracking (천천히 전진하며 흥례문을 지나, 경복궁의 내부로 자연스럽게 시선을 이끌어감)",
  "composition": "Symmetrical (흥례문을 중심으로 좌우 대칭을 이루며, 그 뒤로 펼쳐진 궁궐의 전경이 깊이감을 더함)",
  "image_url": "https://example.com/scene1.jpg",
  "created_at": "2024-03-30T09:00:00.000",
  "updated_at": "2024-03-30T09:30:00.000"
};
Map<String, dynamic> scene2_3_2 ={
  "scene_id": 2,
  "storyboard_id": 5,
  "order_num": 2,
  "sceneTitle": "근정전의 위엄",
  "description": "경복궁의 중심, 근정전의 웅장한 모습을 클로즈업으로 보여줍니다. 눈 위에 서 있는 근정전은 마치 시간을 초월한 듯한 고요함을 자아냅니다.",
  "camera_angle": "Close-Up (근정전의 정면을 정중앙에서 잡아, 그 위엄을 강조함)",
  "camera_movement": "Tilt Down (카메라는 위에서 아래로 천천히 내려오며, 근정전의 디테일을 하나하나 살펴봄)",
  "composition": "Centered (근정전이 화면의 중앙에 위치하며, 그 주위의 눈 덮인 풍경이 조화를 이루어 고요한 느낌을 줌)",
  "image_url": "https://example.com/scene2.jpg",
  "created_at": "2024-03-30T09:45:00.000",
  "updated_at": "2024-03-30T10:00:00.000"
};
Map<String, dynamic> scene2_3_3 = {
  "scene_id": 3,
  "storyboard_id": 5,
  "order_num": 3,
  "sceneTitle": "경회루의 고요한 아름다움",
  "description": "경회루의 연못이 얼어붙어 있는 장면을 보여줍니다. 연못 위로 비치는 겨울 햇살이 경회루의 고즈넉한 아름다움을 더욱 돋보이게 합니다.",
  "camera_angle": "Wide Shot (경회루를 연못 건너편에서 넓게 잡아, 연못과 함께 경회루의 전경을 담음)",
  "camera_movement": "Dolly In (카메라는 연못 위를 부드럽게 스치며 경회루를 향해 다가감)",
  "composition": "Offset (경회루가 화면의 오른쪽에 위치하고, 왼쪽에는 얼어붙은 연못이 자리 잡아 균형 잡힌 구도를 이룸)",
  "image_url": "https://example.com/scene3.jpg",
  "created_at": "2024-03-30T10:15:00.000",
  "updated_at": "2024-03-30T10:30:00.000"
};
Map<String, dynamic> scene2_3_4 = {
  "scene_id": 4,
  "storyboard_id": 5,
  "order_num": 4,
  "sceneTitle": "향원정의 비밀",
  "description": "향원정의 고즈넉한 정자와 그 주변의 겨울 풍경을 보여줍니다. 눈 덮인 정자와 나무들이 조화를 이루며, 마치 동화 속 한 장면처럼 보입니다.",
  "camera_angle": "Wide Shot (향원정을 중심으로, 그 주변의 겨울 풍경을 넓게 담음)",
  "camera_movement": "Orbit (카메라는 정자를 중심으로 천천히 회전하며, 주변 풍경을 자연스럽게 보여줌)",
  "composition": "Centered (향원정이 화면의 중앙에 위치하며, 그 주위의 눈 덮인 나무들이 부드러운 곡선을 이루어 포근한 느낌을 줌)",
  "image_url": "https://example.com/scene4.jpg",
  "created_at": "2024-03-30T10:45:00.000",
  "updated_at": "2024-03-30T11:00:00.000"
};
Map<String, dynamic> scene2_3_5 ={
  "scene_id": 5,
  "storyboard_id": 5,
  "order_num": 5,
  "sceneTitle": "지나간 세월",
  "description": "해질녘, 경복궁을 멀리서 바라보며 점점 어두워지는 하늘과 함께 영상이 조용히 마무리됩니다. 경복궁의 실루엣이 황혼 속에서 더욱 선명하게 드러납니다.",
  "camera_angle": "Wide Shot (멀리서 경복궁의 전체적인 실루엣을 잡아, 하늘과 궁궐의 대비를 강조함)",
  "camera_movement": "Pull Back (카메라는 서서히 뒤로 물러나며, 경복궁의 전경을 넓게 보여줌)",
  "composition": "Lower Third (경복궁이 화면의 하단에 위치하고, 하늘이 넓게 펼쳐져 있어 경복궁의 역사적 깊이를 느끼게 함)",
  "image_url": "https://example.com/scene5.jpg",
  "created_at": "2024-03-30T11:15:00.000",
  "updated_at": "2024-03-30T11:30:00.000"
};
