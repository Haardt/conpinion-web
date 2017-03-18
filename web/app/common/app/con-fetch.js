
export default function getJson(resource) {

  let headers = new Headers({
    "Content-Type": "application/json",
    "Accept": "application/json"
  });

  let myInit = {
    method: 'GET',
    headers: headers,
    cache: 'default'
  };

  let myRequest = new Request(resource, myInit);

  return fetch(myRequest).then((response) => response.text());
};

export function postJson(resource) {

  let headers = new Headers({
    "Content-Type": "application/json",
    "Accept": "application/json"
  });

  let myInit = {
    method: 'GET',
    headers: headers,
    cache: 'default'
  };

  let myRequest = new Request(resource, myInit);

  return fetch(myRequest).then((response) => response.json());
};

export function putJson(resource, data) {

  let headers = new Headers({
    "Content-Type": "application/json",
    "Accept": "application/json"
  });

  let myInit = {
    method: 'PUT',
    headers: headers,
    cache: 'default',
    body: JSON.stringify(data)
  };

  let myRequest = new Request(resource, myInit);
  return fetch(myRequest).then((response) => {
    console.log("Response:", response.ok);
    if (!response.ok) {
        throw {
          response: response,
        }
    }
    return response.json();
    }
  );
}
