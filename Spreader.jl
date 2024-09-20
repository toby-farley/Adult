module Spreader
    using DataFrames
    zero = (x) -> return 0

    function spread!(df, column)
        columns = unique(select(dropmissing(df), Symbol(column)))[:, :1]     
        
        for col in columns
            ucol = replace(col,"-" => "_")
            transform!(df, column => ((x) -> return 0) => Symbol(ucol))
        end
        
        for row in eachrow(df)
            for col in columns
                if !ismissing(row[column])
                    if row[column] == col
                        ucol = replace(col,"-" => "_")
                        row[Symbol(ucol)] = 1
                    end
                end
            end
        end
        return df
    end

    function spread(df, column)
        
        df2 = copy(df)

        spread!(df2, column)

        return df2
    end

    export spread, spread!
    
end 