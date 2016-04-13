
res = try(source("F:/Data/temp/R files/SetUpWorkEnvironment.R")) 
require(rCharts)

function(file.name, folder.override = NULL, 
         file.directory = "F:Data/temp/", returnAsTs = TRUE){
  
  if (!is.null(folder.override)) {
    new.folder = folder.override
  } else {
    new.folder = substr(Sys.time(),1,10)
  }
  
  folder.path = paste(file.directory, new.folder, sep = "")
  if (!file.exists(folder.path)) print("Folder does not exist")
  
  file.path = paste(folder.path, "/", file.name, ".csv", sep ="")
  
  mat = read.csv(file = file.path)
  
  if (returnAsTs == TRUE) mat = timeSeries(data = mat[,2:ncol(mat)], timeDate(mat[,1]))
  
  return(mat)
}

xtsData  = LoadFromCSVs("eq.index.HIST_CALL_IMP_VOL", folder.override = "2016-04-08", file.directory = "F:Data/temp/", returnAsTs = TRUE)
xtsData  = xtsData[,"S.P.500"]
xts.new  = as.data.frame.table(xtsData)
xts.new = xts.new[,c(1,3)]
colnames(xts.new) = c("date", "price")
  


#########
m2 <- mPlot(x = 'date', y = 'price', type = 'Line', data = xts.new)
m2$set(pointSize = 0, lineWidth = 1)
m2


#########

m1 <- hPlot(x = 'date', y = 'price', type = 'Line', data = xts.new)

m1$xAxis(type = "datetime")
m1$chart(zoomType = "x")

m1$plotOptions(
  line = list(marker = list(enabled = F))
)

m1$print("chart5")
m1


m1

