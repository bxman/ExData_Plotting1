plot2 = function() {
        ## outputs plot data interesting datses 2007-02-01 and 2007-02-02
        ## 
        
        ## library(data.table)
        ## Warnings suppressed due to RStudio noisy output.
        suppressWarnings(library(data.table))
        
        get_data = function() {
                # download and extract data if needed
                if (!file.exists("household_power_consumption.txt")) {
                        URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
                        zip_file="pwconsump.zip"
                        download.file(URL, destfile=zip_file, method="curl")
                        unzip(zip_file)
                }
        }
        
        extract_data = function() {
                ## returns a data table of the usage data for the specified dates
                ## 2007-02-01 and 2007-02-02
                data <- read.table("household_power_consumption.txt", header = TRUE, sep =';', na.strings = "?")
                sub_data <- data[data$Date %in% c("1/2/2007","2/2/2007"),]
                rm(data) ## free up memory
                ## Reformat Date and merge with time
                Date_time <- strptime(paste(sub_data$Date, sub_data$Time, sep=" "),"%d/%m/%Y %H:%M:%S")
                sub_data <- cbind(Date_time, sub_data)
                return(sub_data)
        }
        
        get_data()
        result <- extract_data()
        ## plots data and saves plot in working directory
        plot(result$Date_time, result$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)", col="blue")
        dev.copy(png, file="plot2.png", width=480, height=480)
        dev.off()
        }