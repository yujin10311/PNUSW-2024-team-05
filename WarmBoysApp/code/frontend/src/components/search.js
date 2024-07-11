import React ,{useState} from "react";

const Search = () =>{
    const[searching_Word,set_searching_Word] = useState("");
    
    const onChange = (e) =>{
        set_searching_Word(e.target.value);
    }

    return(
        <div>
            <form>
                <input type="text" onChange={onChange}/>
                <p>{searching_Word}</p>
            </form>
        </div>
    )
}

export default Search;