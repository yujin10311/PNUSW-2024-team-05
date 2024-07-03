import React, { useState } from "react";

const Home = () => {
    const onClick = (e, offerData) => {
        const content = offerData.content;
        alert(content);
    }

    const OfferTable = ({ offerData }) => {
        return (
            <div onClick={(e)=>{onClick(e,offerData)}}>
                <h3><strong>{offerData.title}</strong></h3>
                <span>{offerData.writer}</span>
                <hr/>
            </div>
        )
    };

    const TakerTable = ({ takerData }) => {
        return (
            <div onClick={(e)=>{onClick(e,takerData)}}>
                <h3><strong>{takerData.title}</strong></h3>
                <span>{takerData.writer}</span>
                <hr/>
            </div>
        )
    };

    const offer = [
        {
            title: '이번 주말에 공원에서 피크닉 어때요?',
            writer: '학생1',
            content: '할머니, 할아버지, 이번 주말에 공원에서 피크닉 어때요? 저희랑 같이 크리스마스 장식 만들래요? 할머니, 할아버지, 이번에 동네 축제 같이 가실래요?'
        },
        {
            title: '함께 하면 더 즐거울 것 같아요',
            writer: '나비야',
            content: '할머니, 할아버지와 함께 하면 더 즐거울 것 같아요. 같이 시간을 보내주시면 정말 감사할 것 같아요. 할머니, 할아버지 덕분에 행복해요. 이번에는 저희랑 함께 시간을 보내주실래요?'
        }
    ]

    const taker = [
        {
            title: '같이 음료 한잔할 젊은이 구합니다..',
            writer: '동네할모니',
            content: '7월 8일 9시~12사이에 부산 엑스포 주변카페에서 구합니다.'
        },
        {
            title: '우리 같이 쿠키 구워보자',
            writer: '할아버징',
            content: '우리 같이 쿠키 구워보자. 재미있을 거야! 그림 그리는 거 좋아하니? 같이 그려볼까? 퍼즐 맞추기 좋아해? 할아버지랑 같이 해보자.'
        },
        {
            title: '이번 주말에 공원에서 피크닉 하자',
            writer: '메리',
            content: '이번 주말에 공원에서 피크닉 하자. 준비 다 했어! 크리스마스 장식 만들래? 할머니 할아버지랑 같이 하자. 동네 축제 같이 가자. 재밌는 거 많이 있을 거야!'
        }
    ]

    const [offers, set_offers] = useState(offer);
    const [takers, set_takers] = useState(taker);

    return (
        <div>
            <h2>구인공고</h2>
            {offers.map(d => <OfferTable offerData={d} />)}
            <br />
            <br />
            <br />
            <h2>구직공고</h2>
            {takers.map(d => <TakerTable takerData={d} />)}
        </div>
    )
}

export default Home;