module Spreader
    using DataFrames

    function spread!(df, column)
        function zero(dummy)
            return 0
        end
        
        columns = unique(select(dropmissing(df), Symbol(column)))[:, :1]     
        
        for col in columns
            ucol = replace(col,"-" => "_")
            transform!(df, column => zero => Symbol(ucol))
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