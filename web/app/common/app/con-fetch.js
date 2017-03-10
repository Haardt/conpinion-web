
export default function jsonFetch(resource) {

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
