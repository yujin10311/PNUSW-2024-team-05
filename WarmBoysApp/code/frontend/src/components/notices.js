import React, { useState } from "react";

const Notices = () => {
    const NoticeTable = ({noticeData})=>{
        return(
            <tr>
                <td>{noticeData.title}</td>
                <td>{noticeData.sender}</td>
                <td>{noticeData.detail}</td>
            </tr>
        );
    };
    const notice = [
        {
            title: '새로운 채팅이 있습니다.',
            sender: '동네할모니',
            detail: '9시에 만나자구?? 좋네'
        },
        {
            title: '새로운 알람이 있습니다.',
            sender: 'system',
            detail: '비밀번호 변경 후 6개월이 경과하였습니다.'
        },
        {
            title: '새로운 챗튕이 있습니다.',
            sender: '옆집',
            detail: '층간소음에 주의해주세요.'
        }
    ]
    const [notices, set_notices] = useState(notice);

    return (
        <table>
            <thead>
                <tr>
                    <th>제목</th>
                    <th>발송자</th>
                    <th>내용</th>
                </tr>
            </thead>
            <tbody>
                {notices.map(n => <NoticeTable noticeData={n} />)}
            </tbody>
        </table>
    )
}

export default Notices;