package com.example.chat2

object QuestionData {

    fun getQuestion(): ArrayList<Question>{

        val queList: ArrayList<Question> = arrayListOf()

        val q1 = Question(
            1,
            "기분이 가라앉거나, 우울하거나, 희망이 없다고 느꼈다. ",
            "없음",
            "2-6일",
            "7-12일",
            "거의 매일",
            2
        )

        val q2 = Question(
            1,
            "평소 하던 일에 대한 흥미가 없어지거나 즐거움을 느끼지 못했다. ",
            "없음",
            "2-6일",
            "7-12일",
            "거의 매일",
            2
        )

        val q3 = Question(
            1,
            "잠들기가 어렵거나 자주 깼다/혹은 너무 많이 잤다. ",
            "없음",
            "2-6일",
            "7-12일",
            "거의 매일",
            2
        )

        val q4 = Question(
            1,
            "평소보다 식욕이 줄었다/혹은 평소보다 많이 먹었다. ",
            "없음",
            "2-6일",
            "7-12일",
            "거의 매일",
            2
        )

        val q5 = Question(
            1,
            "다른 사람들이 눈치 챌 정도로 평소보다 말과 행동이 느려졌다/\n" +
                    "혹은 너무 안절부절 못해서 가만히 앉아 있을 수 없었다. ",
            "없음",
            "2-6일",
            "7-12일",
            "거의 매일",
            2
        )

        val q6 = Question(
            1,
            "피곤하고 기운이 없었다. ",
            "없음",
            "2-6일",
            "7-12일",
            "거의 매일",
            2
        )

        val q7 = Question(
            1,
            "내가 잘못 했거나, 실패했다는 생각이 들었다/혹은 자신과 가족을 실망시켰다고 생각했다. ",
            "없음",
            "2-6일",
            "7-12일",
            "거의 매일",
            2
        )

        val q8 = Question(
            1,
            "신문을 읽거나 TV를 보는 것과 같은 일상적인 일에도 집중 할 수가 없었다. ",
            "없음",
            "2-6일",
            "7-12일",
            "거의 매일",
            2
        )

        val q9 = Question(
            1,
            "차라리 죽는 것이 더 낫겠다고 생각했다./혹은 자해할 생각을 했다. ",
            "없음",
            "2-6일",
            "7-12일",
            "거의 매일",
            2
        )

        queList.add(q1)
        queList.add(q2)
        queList.add(q3)
        queList.add(q4)
        queList.add(q5)
        queList.add(q6)
        queList.add(q7)
        queList.add(q8)
        queList.add(q9)

        return queList

    }
}