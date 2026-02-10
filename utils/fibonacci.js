const generateFibonacci = (n) => {
  if (n === 0) return [0];
  if (n === 1) return [0, 1];
  
  const fib = [0, 1];
  for (let i = 2; i <= n; i++) {
    fib.push(fib[i - 1] + fib[i - 2]);
  }
  
  return fib;
};

module.exports = { generateFibonacci };

