# speedmath

## Usage
```bash
./speedmath.sh [difficulty] [time] [count] [operation_types...]
```

## Parameters
- **difficulty**: 0-5 (Beginner to Killer level)
- **time**: Time limit per question in seconds (or "inf" for unlimited)
- **count**: Number of questions (1-1000 or "inf")
- **operations**: --add, --sub, --mul, --div, --per, --pow, --seq, --all

## Examples
```bash
./speedmath.sh 2 30 10 --add --sub    # Medium difficulty, 30s limit, 10 questions, addition & subtraction
./speedmath.sh 4 inf 5 --all          # Extreme difficulty, unlimited time, 5 questions, all operations
```

Use `./speedmath.sh --help` for complete documentation.
