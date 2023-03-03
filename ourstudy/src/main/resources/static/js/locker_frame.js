    window.onload=function(){
        let canvas = document.getElementById('canvas'); 
        if(canvas.getContext){
            let context = canvas.getContext('2d');

            canvas.width = 1100;
            canvas.height = 650;
/*=======================================================
                       Frame
  ========================================================*/           
        context.beginPath();         
        context.moveTo(50,50);       
        context.lineTo(650,50);      //위
        context.moveTo(50,50); 
        context.lineTo(50,600);      //왼쪽
        context.lineTo(650,600);     //아래
        
        context.moveTo(815,50);      //위
        context.lineTo(1050,50);
        context.lineTo(1050,600);     //오른쪽2
        context.lineTo(815,600);

/*=======================================================
                         INFO
  ========================================================*/ 
        context.moveTo(50,270);     //위
        context.lineTo(215,270);
        context.lineTo(300,355);          

        context.moveTo(355,433);    //오른쪽
        context.lineTo(355,600);
/*=======================================================
                         RENT
  ========================================================*/

        context.moveTo(620,600);    //오른쪽
        context.lineTo(620,270);

        context.moveTo(620,270);    //위
        context.lineTo(533,270);

/*========================================================
                         END
=========================================================*/

           context.closePath();         
                                        
        
           context.stroke();            
        }else{                  
            alert('브라우저가 캔버스를 지원하지 않습니다.');
        }
    }