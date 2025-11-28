# Book Recommender 8086
<p align="center">
  <img src="https://img.shields.io/badge/8086-Assembly-blue" />
  <img src="https://img.shields.io/badge/Tools-GUI%20Turbo%20Assembler-brightgreen" />
  <img src="https://img.shields.io/badge/Platform-DOSBox-orange" />
</p>

**A smart book recommendation system written in pure 8086 Assembly Language**  
FCIS – Mansoura University • November 2025

### Group Members
- Yasmin Yaser  
- Menna Khaled  
- Mirna Magdy  

### Features
- 5 genres × 5 books (25 books total)
- No repetition of last 3 suggestions (smart history buffer)
- True random selection using system timer (`INT 1Ah`)
- Clean interactive UI with full session loop
- Developed & tested using **GUI Turbo Assembler**

### Tools
- GUI Turbo Assembler (latest version)
- DOSBox 0.74-3

### How to Run (GUI Turbo Assembler – Recommended)
1. Open GUI Turbo Assembler  
2. File → Load → `Fpro.asm`  
3. Run → Assemble (F9)  
4. Run → Go (F5)

Or using DOSBox:
```bash
tasm Fpro.asm
tlink Fpro.obj
Fpro
