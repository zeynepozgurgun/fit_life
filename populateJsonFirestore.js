const { initializeApp } = require('firebase/app');
const { getFirestore, doc, setDoc, addDoc, collection } = require('firebase/firestore');
const fs = require('fs');
const path = require('path');

// Initialize Firebase
const firebaseConfig = {
  apiKey: "AIzaSyAoztHV-fO3p_37znhdstZWfTVXSYJRqBQ",
  authDomain: "fitlife-4a351.firebaseapp.com",
  projectId: "fitlife-4a351"
};

const app = initializeApp(firebaseConfig);
const db = getFirestore(app);

class PopulateJsonFireStore {
  constructor() {
    console.time("Time taken");
    const [, , filepath, type, collectionname] = process.argv;

    this.absolutepath = path.resolve(process.cwd(), filepath);
    this.type = type;
    this.collectionname = collectionname;

    if (this.type !== 'set' && this.type !== 'add') {
      console.error(`Wrong method type ${this.type}`);
      console.log('Accepted methods are: set or add');
      this.exit(1);
    }

    if (!this.absolutepath) {
      console.error(`Make sure you have file path assigned ${this.absolutepath}`);
      this.exit(1);
    }

    if (!this.collectionname) {
      console.error(`Make sure to specify firestore collection ${this.collectionname}`);
      this.exit(1);
    }

    console.log(`ABS: FILE PATH ${this.absolutepath}`);
    console.log(`Type: method is ${this.type}`);
  }

  async populate() {
    let data = [];

    try {
      data = JSON.parse(fs.readFileSync(this.absolutepath, 'utf8'));
    } catch (e) {
      console.error(e.message);
      this.exit(1);
    }

    if (data.length < 1) {
      console.error('Make sure file contains items.');
      this.exit(1);
    }

    let i = 0;  // Declare the `i` variable here
    for (const item of data) {
      if (!item.id) {
        console.error('Each item must have an id field.');
        this.exit(1);
      }
      
      console.log(item);
      try {
        this.type === 'set' ? await this.set(item) : await this.add(item);
      } catch (e) {
        console.log(e.message);
        this.exit(1);
      }

      if (data.length - 1 === i) {
        console.log(`**************************\n****SUCCESS UPLOAD*****\n**************************`);
        console.timeEnd("Time taken");
        this.exit(0);
      }

      i++;
    }
  }

  async add(item) {
    console.log(`Adding item with id ${item.id}`);
    try {
      await addDoc(collection(db, this.collectionname), item);
      return true;
    } catch (e) {
      console.error(e.message);
    }
  }

  async set(item) {
    console.log(`Setting item with id ${item.id}`);
    try {
      await setDoc(doc(db, this.collectionname, item.id), item);
      return true;
    } catch (e) {
      console.error(e.message);
    }
  }

  exit(code) {
    process.exit(code);
  }
}

const populateFireStore = new PopulateJsonFireStore();
populateFireStore.populate();
