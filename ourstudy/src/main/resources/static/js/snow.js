const Min_time = 10;

const body = document.querySelector("body");

function makeSnow(){
	const snowflake = document.createElement("div");
	
	const delay = Math.random() * 10;
	const initialOpacity = Math.random();
	const duration = Math.random() * 20 + Min_time;
	
	
	snowflake.classList.add("snowflake");
	snowflake.style.left = `${Math.random() * window.screen.width}px`;
	snowflake.style.animationDelay = `${delay}s`;
	snowflake.style.opacity = initialOpacity;
	snowflake.style.animation = `fall ${duration}s linear`;
	
	body.appendChild(snowflake);
	
	setTimeout(() => {
	body.removeChild(snowflake);
	
}, (duration + delay) *1000);
}
function makeSnow2(){
	const snowflake2 = document.createElement("div");
	
	const delay = Math.random() * 10;
	const initialOpacity = Math.random();
	const duration = Math.random() * 20 + Min_time;
	
	
	snowflake2.classList.add("snowflake2");
	snowflake2.style.left = `${Math.random() * window.screen.width}px`;
	snowflake2.style.animationDelay = `${delay}s`;
	snowflake2.style.opacity = initialOpacity;
	snowflake2.style.animation = `fall ${duration}s linear`;
	
	body.appendChild(snowflake2);
	
	setTimeout(() => {
	body.removeChild(snowflake2);
	
}, (duration + delay) *1000);
}
makeSnow();
makeSnow2();
for(let a = 0; a<30; a++){
	setTimeout(makeSnow, 500*a);
}
for(let a = 0; a<30; a++){
	setTimeout(makeSnow2, 500*a);
}


