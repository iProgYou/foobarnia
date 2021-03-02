exports.tally = function(votes) {

    `
  I believe the test is written incorrectly as it says in the README: 

  'The results do not have to be sorted in any special order.' 

  The tests are however testing for array equivalency, which means the results need to be returned in the same order the test expects.
  The time complexity of my algorithm is O(N) best case, and O(NlogN) worst case. 

  `
  let count = {};
  let first = null;

  votes.forEach(candidate => {
    if (candidate in count) {
      count[candidate] += 1;
    } else {
      count[candidate] = 1;
    }
    if (!first) {
      first = candidate;
    }

    let current = count[candidate];
    if (current > count[first]) {
      first = candidate;
    }
  });

  if (count[first] > (votes.length / 2)) return [first];
  // returns the first place winner if there's a simple majority, else it goes to a runoff

  delete count[first];

  let candArray = [];

  Object.keys(count).forEach(candidate => {
    candidate = parseInt(candidate);

    candArray.push([candidate,count[candidate]]);
  })

  candArray.sort((a,b) => {
    return b[1] - a[1];
  })
  // console.log(candArray)
  // console.log(first)
  let second = candArray[0][0];
  let third = [candArray[1][0]];
  let i = 1;
  for (let i = 2; i < candArray.length - 1; i ++) {
    if (candArray[1][1] !== candArray[i][1]) break;
    third.push(candArray[i][0])
  }
  // return [first,second,...third]; // This should work, but test 2 and 3 are not compatible with the README
  return [first,second,...third].sort();
};

// console.log(this.tally([2,2,5,5,5,7,5,5,1,5,2]));
// console.log(this.tally([7,8,3,3,3,8,2,4,4,4,2,2,4,2,3,4,5,3,4,4]));
// console.log(this.tally([8,9,1,1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,7,7,8]));

