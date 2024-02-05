//
//  NewsViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Combine
struct NewsViewModel {
    let navigator: NewsNavigatorType
}

extension NewsViewModel: ViewModel {
    struct Input {
        let selectEventTrigger: Driver<NewsItemViewModel>
    }
    
    final class Output: ObservableObject {
        @Published var news = [
            NewsItemViewModel(id: 1, date: "2023-10-08T19:00:00.000+00:00".convertToDateUS(), title: "Выставка MosBuild (Мосбилд) 2023 где, когда и почему стоит участвовать.", shortContent: "Выставка MosBuild (Мосбилд) 2023 где, когда и почему стоит участвовать.", htmlContent: "<h2>Termo Ромлари учун &nbsp;<br>IMPAK Икки ёкламали очилиш механизми<br>+ ручкаси</h2><h2>Сиз истаган улчамларда!!!<br>Улгуриб колинг, Нархлари Ажойиб ва Хамёнбоп🔊</h2><h3>Барча AKFA Расмий дилерларидан суранг 🤝</h3><h3>+99877 777 73 84 - Abrorxo’ja<br>+99899 941 00 71 - Azamat<br>+99897 414 14 34 - Abdulloh</h3>", imageUrl: "https://picsum.photos/350/200"),
            NewsItemViewModel(id: 2, date: "2023-10-08T19:00:00.000+00:00".convertToDateUS(), title: "Выставка MosBuild (Мосбилд) 2023 где, когда и почему стоит участвовать.", shortContent: "Выставка MosBuild (Мосбилд) 2023 где, когда и почему стоит участвовать.", htmlContent: "<h3>AKFA Plast корхонасида янги турдаги 6500 Penta серияли профиль махсулоти ишлаб чиқарилиши йўлга қўйилди. Профилнинг монтаж қалинлиги 65 мм эга ушбу профилнинг 5 та камера қатлами мавжуд бўлиб, шовқин ва иссиқлик ўтказмаслик хусусияти юқори хисобланади. &nbsp;Ундан эшик ва ромлар ясашда 13 мм АКС системасидаги аксессуарларидан фойдаланилади.</h3><h3>Бугунги кунда корхонада профилларнинг 10 дан ортиқ сериялари ишлаб чиқарилаётган бўлиб, янги маҳсулот унга бўлган талабдан келиб чиқиб, ишлаб чиқарилиши бошланди ҳамда у ҳозирданоқ харидоргир маҳсулотга айланди. Таъкидлаш жоиз, бугунги кунда корхонада эшик ва дераза ромлари ҳамда фасад тизимлари учун зарур турдаги профиллар тайёрланмоқда ва мижозлар талаби асосида такомиллаштирилмоқда.</h3>", imageUrl: "http://84.54.75.248:1030/api/mobile/news/img/240e43d7-1408-4ae2-a669-07eb16d2719c_photo_2023-12-23_12-00-44.jpg"),
            NewsItemViewModel(id: 6, date: "2023-10-08T19:00:00.000+00:00".convertToDateUS(), title: "Выставка MosBuild (Мосбилд) 2023 где, когда и почему стоит участвовать.", shortContent: "Выставка MosBuild (Мосбилд) 2023 где, когда и почему стоит участвовать.", htmlContent: "", imageUrl: "http://84.54.75.248:1030/api/mobile/news/img/240e43d7-1408-4ae2-a669-07eb16d2719c_photo_2023-12-23_12-00-44.jpg"),
            NewsItemViewModel(id: 7, date: "2023-10-08T19:00:00.000+00:00".convertToDateUS(), title: "Выставка MosBuild (Мосбилд) 2023 где, когда и почему стоит участвовать.", shortContent: "Выставка MosBuild (Мосбилд) 2023 где, когда и почему стоит участвовать.", htmlContent: "", imageUrl: "http://84.54.75.248:1030/api/mobile/news/img/240e43d7-1408-4ae2-a669-07eb16d2719c_photo_2023-12-23_12-00-44.jpg"),
            NewsItemViewModel(id: 8, date: "2023-10-08T19:00:00.000+00:00".convertToDateUS(), title: "Выставка MosBuild (Мосбилд) 2023 где, когда и почему стоит участвовать.", shortContent: "Выставка MosBuild (Мосбилд) 2023 где, когда и почему стоит участвовать.", htmlContent: "", imageUrl: "http://84.54.75.248:1030/api/mobile/news/img/240e43d7-1408-4ae2-a669-07eb16d2719c_photo_2023-12-23_12-00-44.jpg"),
            NewsItemViewModel(id: 9, date: "2023-10-08T19:00:00.000+00:00".convertToDateUS(), title: "Выставка MosBuild (Мосбилд) 2023 где, когда и почему стоит участвовать.", shortContent: "Выставка MosBuild (Мосбилд) 2023 где, когда и почему стоит участвовать.", htmlContent: "", imageUrl: "http://84.54.75.248:1030/api/mobile/news/img/240e43d7-1408-4ae2-a669-07eb16d2719c_photo_2023-12-23_12-00-44.jpg"),
            NewsItemViewModel(id: 10, date: "2023-10-08T19:00:00.000+00:00".convertToDateUS(), title: "Выставка MosBuild (Мосбилд) 2023 где, когда и почему стоит участвовать.", shortContent: "Выставка MosBuild (Мосбилд) 2023 где, когда и почему стоит участвовать.", htmlContent: "", imageUrl: "http://84.54.75.248:1030/api/mobile/news/img/240e43d7-1408-4ae2-a669-07eb16d2719c_photo_2023-12-23_12-00-44.jpg"),
        ]
        @Published var isLoading = false
        @Published var isReloading = false
        @Published var isLoadingMore = false
        @Published var alert = AlertMessage()
        @Published var isEmpty = false
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        input.selectEventTrigger
            .sink { item in
                navigator.showDetail(item)
            }
            .store(in: cancelBag)
        
        return output
    }
}
