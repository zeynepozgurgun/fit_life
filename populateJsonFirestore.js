const { initializeApp } = require('firebase/app');
const { getFirestore, collection, addDoc, setDoc, doc } = require('firebase/firestore');
const fs = require('fs');
const { resolve } = require('path');

// Your Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyAoztHV-fO3p_37znhdstZWfTVXSYJRqBQ",
  authDomain: "fitlife-4a351.firebaseapp.com",
  projectId: "fitlife-4a351"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const db = getFirestore(app);

/**
 * Tutorial on how to upload json data to firestore
 * Using JavaScript
 * RUN: node json-to-firestore/populateJsonFirestore.js [RELATIVE PATH TO FILE] [FIRESTORE METHOD] [COLLECTION NAME]
 */
class PopulateJsonFireStore {
  // class constructor
  constructor() {
    console.time("Time taken");

    // Obtain the relative path, method type, collection name arguments provided through
    const [, , filepath, type, collectionname] = process.argv;

    // Obtain the absolute path for the given relative
    this.absolutepath = resolve(process.cwd(), filepath);

    // Obtain the firestore method type
    this.type = type;

    // Obtain the firestore method type
    this.collectionname = collectionname;

    // Lets make sure the right firestore method is used.
    if (this.type !== 'set' && this.type !== 'add') {
      console.error(`Wrong method type ${this.type}`)
      console.log('Accepted methods are: set or add');
      this.exit(1);
    }

    // If file path is missing
    if (this.absolutepath == null || this.absolutepath.length < 1){
      console.error(`Make sure you have file path assigned ${this.absolutepath}`)
      this.exit(1);
    }

    // If collection name not set
    if (this.collectionname == null || this.collectionname.length < 1){
      console.error(`Make sure to specify firestore collection ${this.collectionname}`)
      this.exit(1);
    }

    console.log(`ABS: FILE PATH ${this.absolutepath}`);
    console.log(`Type: method is ${this.type}`);
  }

  // The populate function
  // uploads the json data to firestore
  async populate() {
    // initialize our data array
    let data = [];

    // Get data from json file using fs
    try {
      data = JSON.parse(fs.readFileSync(this.absolutepath, 'utf8'));
    } catch (e) {
      console.error(e.message);
    }

    // Make sure file has at least one item.
    if (data.length < 1) {
      console.error('Make sure file contains items.');
      this.exit(1);
    }

    for (let i = 0; i < data.length; i++) {
      const item = data[i];
      console.log(item);
      try {
        this.type === 'set' ? await this.set(item) : await this.add(item);
      } catch (e) {
        console.error(e.message);
        this.exit(1);
      }

      // Successfully got to end of data;
      // print success message
      if (data.length - 1 === i) {
        console.log(`**************************\n****SUCCESS UPLOAD*****\n**************************`);
        console.timeEnd("Time taken");
        this.exit(0);
      }
    }
  }

  // Sets data to firestore database
  // Firestore auto generated IDS
  async add(item) {
    console.log(`Adding item with id ${item.id}`);
    try {
      await addDoc(collection(db, this.collectionname), item);
    } catch (e) {
      console.error(e.message);
    }
  }

  // Set data with specified ID
  // Custom Generated IDS
  async set(item) {
    console.log(`Setting item with id ${item.id}`);
    try {
      await setDoc(doc(db, this.collectionname, item.id), item);
    } catch (e) {
      console.error(e.message);
    }
  }

  // Exit nodejs console
  exit(code) {
    return process.exit(code);
  }
}

// Create instance of class
// Run populate function
const populateFireStore = new PopulateJsonFireStore();
populateFireStore.populate();
