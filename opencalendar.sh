# Populates a new directory with default
# directory structure and templated README
mkdir "day_$1"
mkdir "day_$1/puzzle_01"
mkdir "day_$1/puzzle_02"

cat > ./day_$1/README.md <<- EOM
# Day $1 -

## Puzzle 01

### Puzzle:

### Solution Requirements:

#### Input

#### Output

#### Answer

### Result:

## Puzzle 02

### Puzzle:

### Solution Requirements:

#### Input

#### Output

#### Answer

### Result:

EOM