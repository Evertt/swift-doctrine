//import Node
//
//extension Query: CustomStringConvertible {
//    public var description: String {
//        switch action {
//        case .fetch:
//            var query = "SELECT * FROM `\(table)`"
//            
//            if let filter = filter {
//                query += " WHERE \(filter)"
//            }
//            
//            if !sortBy.isEmpty {
//                let sorts = sortBy.map{"\($0)"}.joined(separator: ", ")
//                query += " ORDER BY \(sorts)"
//            }
//            
//            if let limit = limit {
//                query += " \(limit)"
//            }
//            
//            return query
//            
//        case .insert:
//            guard let data = data else { return "" }
//            
//            let array = data.nodeArray ?? [Node(data.nodeObject!)]
//            
//            let keys = array[0].nodeObject!.keys
//                .map{"`\($0)`"}.joined(separator: ", ")
//            
//            let values = array.map{
//                $0.nodeObject!.values
//                    .map{$0.sql!}
//                    .joined(separator: ", ")
//            }.joined(separator: "), (")
//            
//            return "INSERT INTO `\(table)` (\(keys)) VALUES (\(values))"
//            
//        case .update:
//            let data = self.data!.nodeObject!
//                .map{"`\($0)` = \($1.sql!)"}
//                .joined(separator: ", ")
//            
//            var query = "UPDATE `\(table)` SET \(data)"
//            
//            if let filter = filter {
//                query += " WHERE \(filter)"
//            }
//            
//            return query
//            
//        case .delete:
//            var query = "DELETE FROM `\(table)`"
//            
//            if let filter = filter {
//                query += " WHERE \(filter)"
//            }
//            
//            if let limit = limit {
//                query += " \(limit)"
//            }
//            
//            return query
//        }
//    }
//    
//    public var queryAndValues: (String, [NodeRepresentable]) {
//        switch action {
//        case .fetch:
//            let values: [NodeRepresentable]
//            var query = "SELECT * FROM `\(table)`"
//            
//            if let filter = filter {
//                let fqv = filter.queryAndValues
//                
//                query  += " WHERE \(fqv.0)"
//                values = fqv.1
//            } else {
//                values = []
//            }
//            
//            if !sortBy.isEmpty {
//                let sorts = sortBy.map{"\($0)"}.joined(separator: ", ")
//                query += " ORDER BY \(sorts)"
//            }
//            
//            if let limit = limit {
//                query += " \(limit)"
//            }
//            
//            return (query, values)
//            
//        case .insert:
//            guard let data = data else { return ("", []) }
//            
//            let array = data.nodeArray ?? [Node(data.nodeObject!)]
//            
//            let keys = array[0].nodeObject!.keys
//                .map{"`\($0)`"}.joined(separator: ", ")
//            
//            let count  = array.count * array[0].nodeObject!.keys.count
//            let marks  = Array(repeating: "?", count: count).joined(separator: ", ")
//            let values = array.flatMap { $0.nodeObject!.values }
//            
//            return ("INSERT INTO `\(table)` (\(keys)) VALUES (\(marks))", values)
//            
//        case .update:
//            let marks = data!.nodeObject!
//                .map{ "`\($0)` = ?" }
//                .joined(separator: ", ")
//            
//            var values = data!.nodeObject!
//                .map { $1 as NodeRepresentable }
//            
//            var query = "UPDATE `\(table)` SET \(marks)"
//            
//            if let filter = filter {
//                let qv = filter.queryAndValues
//                
//                query  += " WHERE \(qv.0)"
//                values += qv.1
//            }
//            
//            return (query, values)
//            
//        case .delete:
//            let values: [NodeRepresentable]
//            var query = "DELETE FROM `\(table)`"
//            
//            if let filter = filter {
//                let fqv = filter.queryAndValues
//                
//                query  += " WHERE \(fqv.0)"
//                values = fqv.1
//            } else {
//                values = []
//            }
//            
//            if let limit = limit {
//                query += " \(limit)"
//            }
//            
//            return (query, values)
//        }
//    }
//}
