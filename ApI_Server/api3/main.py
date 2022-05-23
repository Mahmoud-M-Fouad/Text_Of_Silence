from fastapi import  FastAPI, File, UploadFile
import shutil
app = FastAPI()
import uvicorn



@app.post("/video")
async def create_upload_file(video_path: UploadFile):
    try :
        with open(f'{video_path.filename}', "wb") as buffer:
            shutil.copyfileobj(video_path.file, buffer)
        #return {"result": predice_image(video_path.filename)}
    finally:
        video_path.file.close()   
    return {"result": video_path.filename}


    #        uvicorn main:app --reload
if __name__ == '__main__':
    uvicorn.run(app, host='0.0.0.0', port=8000)







    """
    import requests

url = 'http://127.0.0.1:8000/upload'
file = {'file': open('images/1.png', 'rb')}
resp = requests.post(url=url, files=file) 
print(resp.json())


    """