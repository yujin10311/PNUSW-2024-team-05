import React, {useState} from "react";
import { Link } from "react-router-dom";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";

const Profile = () => {
    const isSeller = false;
    const [user, setUser] = useState({
        name: "성수",
        profileImage: "https://via.placeholder.com/150x150",
        email: "tosun1124@naver.com",
        nickname: "보글라면",
        phoneNumber: "010-5583-5429",
      });

    return(
        <div className="user-profile">
        <div className="profile-section">
          <div className="profile-image">
            <img src={user.profileImage} alt="프로필 사진" />
          </div>
          <div className="user-info">
            <h2>{user.name}</h2>	
            <p>{user.nickname}</p> 
            <p>{user.email}</p>
            <p>{user.phoneNumber}</p>
          </div>
        </div>
  
        <div className="profile-btn-container">
          <Link to="/user/edit" className="user-link">
            <button className="edit-profile-btn">
              <span role="img" aria-label="pencil">
                ✏️
              </span>{" "}
              나의 회원정보 수정
              <div className="move-page-icon">
                &gt;
              </div>
            </button>
          </Link>
  
          <Link to="/user/chattingList" className="user-link">
            <button className="chattingList-btn">
              <span role="img" aria-label="conversation">
                💬
              </span>{" "}
              나의 1대1 상담 내역
              <div className="move-page-icon">
                &gt;
              </div>
            </button>
          </Link>
        </div>
  
        <div className="move-seller-page-btn-container">
          {isSeller && (
            <button
              className="move-seller-page-btn"
              onClick={()=>{alert('판매자 페이지로 연결됩니다.')}}
            >
              사장님 페이지 연결
              <div className="move-page-icon">
                &gt;
              </div>
            </button>
          )}
        </div>
  
        <div className="user-logout-btn-container">
          <button className="user-logout-btn" onClick={()=>{alert('로그아웃 되었습니다.')}}>
            로그아웃
            <div className="move-page-icon">
                &gt;
            </div>
          </button>
        </div>
      </div>
    )
}
export default Profile;