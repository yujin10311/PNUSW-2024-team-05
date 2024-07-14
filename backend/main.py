from fastapi import FastAPI, HTTPException, Request
from pydantic import BaseModel
# from fastapi.responses import HTMLResponse
# from fastapi.templating import Jinja2Templates
import google.generativeai as genai

app = FastAPI()

# templates = Jinja2Templates(directory="templates")

class ChatRequest(BaseModel):
    message: str

@app.post("/chat/")
async def chat(request: ChatRequest):
    try:
        genai.configure(api_key='AIzaSyBhVWcXFyqZJ_fozSr3kRzG88GuHki1C_M')
        model = genai.GenerativeModel('gemini-pro')
        response = model.generate_content(request.message + '위 내용처럼 생각하는 사람을 심리상담해줘')
        return response.to_dict()['candidates'][0]['content']['parts'][0]['text']
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/")
async def root():
    return {"message": "Welcome to the FastAPI and Gemini integration example!"}