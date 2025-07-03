function post (){
  const form = document.getElementById("form");
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    const formData = new FormData(form);
    const XHR = new XMLHttpRequest();
    XHR.open("POST", "/posts", true);
    XHR.responseType = "json";

    const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
    XHR.setRequestHeader("X-CSRF-Token", token);
    
    XHR.send(formData);
  });
};

window.addEventListener('turbo:load', post);