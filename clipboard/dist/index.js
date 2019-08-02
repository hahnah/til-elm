const app = Elm.Main.init({
    node: document.getElementById('elm-node')
});

app.ports.copyInput.subscribe((id) => {
    document.querySelector(id).select();
    document.execCommand('copy');
});

app.ports.copyString.subscribe((str) => {
    var tempDiv = document.createElement('div');
    var tempPre = document.createElement('pre');
    tempDiv.appendChild(tempPre).textContent = str;
    tempDiv.style.position = 'fixed';
    tempDiv.style.right = '200%';
    document.body.appendChild(tempDiv);
    document.getSelection().selectAllChildren(tempDiv)
    document.execCommand('copy');
    document.body.removeChild(tempDiv);
});