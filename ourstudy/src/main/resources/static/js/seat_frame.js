    window.onload=function(){
        let canvas = document.getElementById('canvas'); 
        if(canvas.getContext){
            let context = canvas.getContext('2d');

            canvas.width = 1100;
            canvas.height = 650;
/*=======================================================
                       Frame / LINE COLOR
  ========================================================*/    
        context.beginPath();         
        
        context.strokeStyle = "#f4f3ef" ;		//라인 컬런
        
        context.moveTo(50,50);       
        context.lineTo(660,50);      			//위
        context.moveTo(50,50); 
        context.lineTo(50,600);     			//왼쪽
        context.lineTo(1050,600);     			//아래
        
        context.moveTo(730,50);      			//위
        context.lineTo(1050,50);
        context.lineTo(1050,288);     			//오른쪽2
        context.moveTo(1050,372);
        context.lineTo(1050,600);

/*=======================================================
                         Section A,B
  ========================================================*/ 
        context.moveTo(215,600);
        context.lineTo(215,415);          
/*=======================================================
                         Section C,D
  ========================================================*/

  /*-----------------전체 틀--------------------*/
        context.moveTo(215,50);
        context.lineTo(215,325);
        context.lineTo(280,325);

        context.moveTo(432,325);
        context.lineTo(654,325);
        context.lineTo(654,50)

    /*--------------개인실-----------------------*/
    //X=75(40) 간격 Y=105고정값
        context.moveTo(215,105);        //첫번째 개인실
        context.lineTo(255,105);

        context.moveTo(285,50);         //두번째 개인실
        context.lineTo(285,105);
        context.lineTo(325,105);

        context.moveTo(355,50);         //세번째 개인실
        context.lineTo(355,105);
        context.lineTo(395,105);

        context.moveTo(430,50);         //중간 벽
        context.lineTo(430,105);

        context.moveTo(508,50);         //네번째 개인실
        context.lineTo(508,105);        
        context.lineTo(465,105);    

        context.moveTo(578,50);         //다섯번째 개인실
        context.lineTo(578,105);
        context.lineTo(535,105);

        context.moveTo(610,105);        //여섯번째 개인실
        context.lineTo(655,105);

/*=======================================================
                         Section E,F
  ========================================================*/
        context.moveTo(540,600);
        context.lineTo(540,414);

        context.moveTo(814,600);    
        context.lineTo(814,414);

/*=======================================================
                         Section  G
  ========================================================*/
        context.moveTo(750,50);         //화장실 쪽 벽
        context.lineTo(750,168);

        context.moveTo(780,218);
        context.lineTo(814,254); 
        context.lineTo(814,305); 

        context.moveTo(814,254);        //락커 쪽 벽
        context.lineTo(1050, 254);


/*=======================================================
                         INFO
  ========================================================*/
        context.moveTo(924,600);
        context.lineTo(924,528);

        context.moveTo(960,492);
        context.lineTo(924,528);

        context.moveTo(1050,492);
        context.lineTo(1050,492);

/*=======================================================
                         RENT
  =======================================================*/
        context.moveTo(1050,396);
        context.lineTo(924,396);
        context.moveTo(924,420);
        context.lineTo(924,396);
/*========================================================
                         END
=========================================================*/

           context.closePath();         
                                        
        
           context.stroke();            
        }else{                  
            alert('브라우저가 캔버스를 지원하지 않습니다.');
        }
    }