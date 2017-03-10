
export function findConTag(name, startParent) {
     find = (parent) => {
       if (parent.root.localName !== name) {
         return find(parent.parent);
       }
       return parent;
     }
     return find(startParent);
  }
