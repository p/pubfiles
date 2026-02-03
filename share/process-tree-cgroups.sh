#!/bin/bash
# process-tree-cgroups.sh - Show complete process hierarchy with cgroups

# Parse command line options
NO_KERNEL=0
while [[ $# -gt 0 ]]; do
    case $1 in
        -k|--no-kernel)
            NO_KERNEL=1
            shift
            ;;
        -h|--help)
            echo "Usage: $0 [OPTIONS]"
            echo "Show process hierarchy with cgroup information"
            echo ""
            echo "Options:"
            echo "  -k, --no-kernel    Exclude kernel threads"
            echo "  -h, --help         Show this help message"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use -h or --help for usage information"
            exit 1
            ;;
    esac
done

# Color codes (optional, remove if you want plain output)
RESET='\033[0m'
DIM='\033[2m'
BOLD='\033[1m'

# Check if process is a kernel thread
is_kernel_thread() {
    local pid=$1
    # Kernel threads have empty cmdline (must read content, not use -s)
    [ "$(wc -c < /proc/$pid/cmdline 2>/dev/null || echo 0)" -eq 0 ]
}

# Get cgroup for a process (extract from cgroup file)
get_cgroup() {
    local pid=$1
    if [ -f "/proc/$pid/cgroup" ]; then
        # For cgroup v2, line starts with "0::"
        local cg=$(grep "^0::" /proc/$pid/cgroup 2>/dev/null | cut -d: -f3)
        if [ -z "$cg" ]; then
            # Fallback for cgroup v1 or mixed
            cg=$(head -1 /proc/$pid/cgroup 2>/dev/null | cut -d: -f3)
        fi
        echo "${cg:-/}"
    else
        echo "?"
    fi
}

# Print process tree recursively
print_tree() {
    local pid=$1
    local indent=$2
    local prefix=$3

    # Check if process still exists
    if [ ! -d "/proc/$pid" ]; then
        return
    fi

    # Skip kernel threads if requested
    if [ $NO_KERNEL -eq 1 ] && is_kernel_thread "$pid"; then
        return
    fi

    # Get process info
    local comm=$(cat /proc/$pid/comm 2>/dev/null || echo "?")
    local cgroup=$(get_cgroup "$pid")

    # Print current process
    printf "%s%s[%5d] %-20s %s\n" "$indent" "$prefix" "$pid" "$comm" "$cgroup"

    # Get children PIDs
    local children=$(ps -o pid= --ppid $pid 2>/dev/null | sort -n)

    if [ -n "$children" ]; then
        local child_array=($children)
        local last_idx=$((${#child_array[@]} - 1))

        for i in "${!child_array[@]}"; do
            local child=${child_array[$i]}
            if [ $i -eq $last_idx ]; then
                # Last child
                print_tree "$child" "$indent  " "└─"
            else
                # Not last child
                print_tree "$child" "$indent  " "├─"
            fi
        done
    fi
}

# Find all root processes (no parent or parent is 0)
find_roots() {
    # PID 1 is always a root
    echo "1"

    # Find any other orphaned processes (kthreadd children, etc)
    # Skip kernel threads if requested
    ps -eo pid,ppid | awk '$2 == 0 && $1 != 1 {print $1}' | sort -n | while read pid; do
        if [ $NO_KERNEL -eq 0 ] || ! is_kernel_thread "$pid"; then
            echo "$pid"
        fi
    done
}

# Main execution
main() {
    echo "Process Hierarchy with Cgroups"
    if [ $NO_KERNEL -eq 1 ]; then
        echo "=============================== (excluding kernel threads)"
    else
        echo "==============================="
    fi
    echo ""

    # Get all root processes
    local roots=$(find_roots)

    for root in $roots; do
        if [ -d "/proc/$root" ]; then
            print_tree "$root" "" ""
            echo ""
        fi
    done
}

# Run main function
main
