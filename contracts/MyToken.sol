// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

contract PandaCoin is IERC20 {
    string public constant name = "PandaCoin";  
    string public constant symbol = "PANDA";    
    uint8 public constant decimals = 18;        
    uint256 private _totalSupply;               

    mapping(address => uint256) private _balances;  
    mapping(address => mapping(address => uint256)) private _allowances;  

    constructor(uint256 initialSupply) {
        _totalSupply = initialSupply * 10 ** uint256(decimals);
        _balances[msg.sender] = _totalSupply;  
    }

    
    function totalSupply() external view override returns (uint256) {
        return _totalSupply;
    }

   
    function balanceOf(address account) external view override returns (uint256) {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) external override returns (bool) {
        require(recipient != address(0), "PandaCoin: transfer to the zero address");
        require(_balances[msg.sender] >= amount, "PandaCoin: insufficient balance");

        _balances[msg.sender] -= amount;
        _balances[recipient] += amount;

        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    // Fungsi untuk menyetujui pengeluaran token oleh alamat lain
    function approve(address spender, uint256 amount) external override returns (bool) {
        require(spender != address(0), "PandaCoin: approve to the zero address");

        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    // Fungsi untuk mendapatkan jumlah yang diizinkan untuk dikeluarkan oleh alamat tertentu
    function allowance(address owner, address spender) external view override returns (uint256) {
        return _allowances[owner][spender];
    }

    // Fungsi untuk mentransfer token dari alamat lain
    function transferFrom(address sender, address recipient, uint256 amount) external override returns (bool) {
        require(sender != address(0), "PandaCoin: transfer from the zero address");
        require(recipient != address(0), "PandaCoin: transfer to the zero address");
        require(_balances[sender] >= amount, "PandaCoin: insufficient balance");
        require(_allowances[sender][msg.sender] >= amount, "PandaCoin: transfer amount exceeds allowance");

        _balances[sender] -= amount;
        _balances[recipient] += amount;
        _allowances[sender][msg.sender] -= amount;

        emit Transfer(sender, recipient, amount);
        return true;
    }

    // Event untuk transfer
    event Transfer(address indexed from, address indexed to, uint256 value);

    // Event untuk approval
    event Approval(address indexed owner, address indexed spender, uint256 value);
}
