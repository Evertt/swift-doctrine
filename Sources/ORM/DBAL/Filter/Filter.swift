public indirect enum Filter {
    case not(Filter)
    case any([Filter])
    case all([Filter])
    
    case match(TableColumn, Match)
    case subset(TableColumn, in: [NodeRepresentable])
    case compare(TableColumn, is: Comparison, NodeRepresentable)
}
