const calculateHCF = (numbers) => {
  if (numbers.length === 0) return 1;
  if (numbers.length === 1) return numbers[0];
  
  let hcf = numbers[0];
  for (let i = 1; i < numbers.length; i++) {
    hcf = calculateGCD(hcf, numbers[i]);
  }
  
  return hcf;
};

const calculateGCD = (a, b) => {
  while (b !== 0) {
    let temp = b;
    b = a % b;
    a = temp;
  }
  return a;
};

module.exports = { calculateHCF };

