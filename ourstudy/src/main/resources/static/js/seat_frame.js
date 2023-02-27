    window.onload=function(){
        let canvas = document.getElementById('canvas'); 
        if(canvas.getContext){
            let context = canvas.getContext('2d');
            
            canvas.width = 950;
            canvas.height = 550;
/*=======================================================
                       Frame
  ========================================================*/           
        context.beginPath();         
        context.moveTo(50,50);       
        context.lineTo(550,50);      //위
        context.moveTo(50,50); 
        context.lineTo(50,500);      //왼쪽
        context.lineTo(900,500);     //아래
        
        context.moveTo(610,50);      //위
        context.lineTo(900,50);
        context.lineTo(900,240);     //오른쪽2
        context.moveTo(900,310);
        context.lineTo(900,500);

/*=======================================================
                         Section A,B
  ========================================================*/ 
        context.moveTo(180,500);
        context.lineTo(180,345);          
/*=======================================================
                         Section C,D
  ========================================================*/

  /*-----------------전체 틀--------------------*/
        context.moveTo(180,50);
        context.lineTo(180,270);
        context.lineTo(280,270);

        context.moveTo(360,270);
        context.lineTo(545,270);
        context.lineTo(545,50)

    /*--------------개인실-----------------------*/
    //X=75(40) 간격 Y=105고정값
        context.moveTo(180,105);        //첫번째 개인실
        context.lineTo(220,105);

        context.moveTo(255,50);         //두번째 개인실
        context.lineTo(255,105);
        context.lineTo(295,105);

        context.moveTo(325,50);         //세번째 개인실
        context.lineTo(325,105);
        context.lineTo(365,105);

        context.moveTo(400,50);         //중간 벽
        context.lineTo(400,105);

        context.moveTo(475,50);         //네번째 개인실
        context.lineTo(475,105);        
        context.lineTo(435,105);    

        context.moveTo(510,105);
        context.lineTo(545,105)
/*=======================================================
                         Section E,F
  ========================================================*/
        context.moveTo(450,500);
        context.lineTo(450,345);

        context.moveTo(670,500);    
        context.lineTo(670,345);

/*=======================================================
                         Section  G
  ========================================================*/
        context.moveTo(625,50);
        context.lineTo(625,140);

        context.moveTo(650,190);
        context.lineTo(670,215);
        context.lineTo(670,255);

        context.moveTo(670,215);
        context.lineTo(900,215)


/*=======================================================
                         INFO
  ========================================================*/
        context.moveTo(770,500);
        context.lineTo(770,440);

        context.moveTo(800,410);
        context.lineTo(770,440);

        context.moveTo(900,410);
        context.lineTo(860,410);

/*=======================================================
                         RENT
  =======================================================*/
        context.moveTo(900,330);
        context.lineTo(770,330);
        context.moveTo(770,350);
        context.lineTo(770,330);
/*========================================================
                         END
=========================================================*/

           context.closePath();         
                                        
        
           context.stroke();            
        }else{                  
            alert('브라우저가 캔버스를 지원하지 않습니다.');
        }
    }