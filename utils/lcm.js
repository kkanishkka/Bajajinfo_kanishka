const calculateGCD = (a, b) => {
  while (b !== 0) {
    let temp = b;
    b = a % b;
    a = temp;
  }
  return a;
};

const calculateLCM = (numbers) => {
  if (numbers.length === 0) return 1;
  if (numbers.length === 1) return numbers[0];
  
  let lcm = numbers[0];
  for (let i = 1; i < numbers.length; i++) {
    const gcd = calculateGCD(lcm, numbers[i]);
    lcm = (lcm * numbers[i]) / gcd;
  }
  
  return lcm;
};

module.exports = { calculateLCM };

