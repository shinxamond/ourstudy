$(function(){
	console.log(todaysQuotes.quote);
	console.log(todaysQuotes.author);

	quote();
});


function quote(){
	let quotes = [
	{
		quote:"가장 유능한 사람은 스스로 유능하다고 생각하는 사람이다.",
		author:"프랭클린 D. 루스벨트"
	},{
		quote:"지식에 대한 투자가 가장 많은 이윤을 남긴다.",
		author:"벤자민 프랭클린"
	},{
		quote:"매일매일 반복된 작은 노력이 모여 성공을 이룬다.",
		author:"로버트 콜리어"
	},{
		quote:"갈만한 가치가 있는 곳은 지름길이 없다.",
		author:"베버리 실즈"
	},{
		quote:"끝까지 해보기 전까지는 늘 불가능해 보인다.",
		author:"넬슨 만델라"
	},
];
	let mainQuote = $('#first-child').text();
	let mainAuthor = $('#last-child').text();
	let todaysQuotes = quotes[Math.floor(Math.random()*quotes.length)];
	mainQuote = todaysQuotes.quote;
	mainAuthor = todaysQuotes.author;
}



