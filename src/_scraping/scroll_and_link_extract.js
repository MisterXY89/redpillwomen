// -------------------- VARS -------------------- //
let postUrls = [];
let numberPosts = 0;
const limitPosts = 100;


// -------------------- HELPER -------------------- //
function simulateKeyPress(keyCode) {
    let event = new KeyboardEvent('keydown', {
        keyCode: keyCode,
        which: keyCode
    });
    document.dispatchEvent(event);
}

function simulateESCKeyPress() {
    simulateKeyPress(27); 
}

function extract(post) {
    post.click();
    let tmpPostUrl = window.location.href;
    if (!postUrls.includes(tmpPostUrl)) {
        postUrls.push(tmpPostUrl);
    }
    simulateESCKeyPress();
}

function getPosts() {
    let clickablePostDivs = Array.from(
        document.getElementsByClassName("Post")
    );

    // extract the urls from the clickablePostDivs
    clickablePostDivs.forEach(extract);
    console.log(clickablePostDivs.length);

    // in chunks of 100 log the stringified urls
    let chunkSize = 100;
    for (i = 0; i < postUrls.length; i += chunkSize) {
        chunk = postUrls.slice(i, i + chunkSize);        
        console.log(JSON.stringify(chunk));
    }
}


let scrollTimes = 200
let scrollTimesCounter = 0
let scrollIntervall = setInterval(function () {
    window.scrollBy(0, 2000);
    scrollTimesCounter++;
    if (scrollTimesCounter >= scrollTimes) {
        clearInterval(scrollIntervall);
        getPosts();
    }
}, 2500); 

