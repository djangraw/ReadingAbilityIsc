#!/usr/local/apps/R/3.5/3.5.2/bin/Rscript
# 3dLME_2Grps_comprehensionMedSplit_n60.R
#
# Created 5/18/18 by DJ based on 3dLME_2Grps_gstpMedSplit_n22.R from EF.
# Updated 5/22/18 by DJ - IscResults_d2 directory
# Updated 5/23/18 by DJ - removed 3 high-motion subjects
# Updated 12/11/18 by DJ - _d3, including inputs to accommodate Vis & Aud versions
# Updated 3/4/19 by DJ - a182_v2 version with 69 ok subjects
# Updated 4/2/19 by DJ - comments
# Updated 8/21/19 by DJ - removed h1161, who saw 2nd run twice, renamed to _n68
# Updated 6/14/23 by DJ - comprehension split (TODO: update subj lists!)

# get inputs
args <- commandArgs(trailingOnly=TRUE)

# list labels for Group 1 - comprehension <= MEDIAN(comprehension)
G1Subj <- c('h1154','h1054','h1087','h1004','h1059','h1168','h1057','h1153','h1120','h1095','h1035','h1176','h1187','h1142','h1088','h1106','h1022','h1034','h1058','h1174','h1024','h1038','h1096','h1097','h1046','h1098','h1011','h1146','h1082','h1076','h1179')

# list labels for Group 2 - comprehension > MEDIAN(comprehension)
G2Subj <- c('h1129','h1163','h1083','h1186','h1003','h1061','h1185','h1012','h1013','h1118','h1180','h1002','h1048','h1014','h1016','h1018','h1029','h1074','h1152','h1073','h1093','h1189','h1031','h1036','h1043','h1010','h1028','h1157','h1167','h1169')

# move to results directory
setwd("/Users/djangraw/Documents/Research/HaskinsReadingIsc/Data/IscResults/Pairwise")
# setwd("../../Data/IscResults/Pairwise")
# File that contains all the input files of correlation values (without Z-transformation)
# in a three column format: the first 2 columns for the pair labels, and the 3rd for input filenames
# input & output files given as arguments:
if (length(args)>1) {
  # input table of filenames
  inFile = args[1]
  # Output file name
  outFile = args[2]

} else { # no arguments given, so use defaults
  # input table of filenames
  inFile <- 'StoryPairwiseIscTable.txt'
  # inFile <- 'StoryPairwiseIscTable_aud.txt'
  # inFile <- 'StoryPairwiseIscTable_vis.txt'

  # Output file name
  outFile <- '3dLME_2Grps_comprehensionMedSplit_n60_Automask'

}
print(paste("input:",inFile))
print(paste("output:",outFile))

# mask file to exclude the voxels outside of the brain
mask <- NULL # or 'myMask+tlrc'
# mask <- '/data/finnes/story_task/isc_analysis/grp_mask_n23_70perc+tlrc.HEAD'

# number of CPUs for parallel computation
nNodes <- 16

####################################################

first.in.path <- function(file) {
   ff <- paste(strsplit(Sys.getenv('PATH'),':')[[1]],'/', file, sep='')
   ff<-ff[lapply(ff,file.exists)==TRUE];
   #cat('Using ', ff[1],'\n');
   return(gsub('//','/',ff[1], fixed=TRUE))
}
source(first.in.path('AFNIio.R'))

allFiles <- read.table(inFile, header=T)
# allFiles <- read.csv(inFile, header=T)
allFiles$InputFile <- as.character(allFiles$InputFile)

#G1Files <- allFiles[(allFiles$Subj %in% G1Subj) & (allFiles$Subj2 %in% G1Subj),]
#G2Files <- allFiles[(allFiles$Subj %in% G2Subj) & (allFiles$Subj2 %in% G2Subj),]
#G1Files$InputFile <- as.character(G1Files$InputFile)
#G2Files$InputFile <- as.character(G2Files$InputFile)

# verify
#for (ii in G1Subj)
#   print(c(ii, '=', sum(G1Files$Subj==ii) + sum(G1Files$Subj2==ii)))
#
#for (ii in G2Subj)
#   print(c(ii, '=', sum(G2Files$Subj==ii) + sum(G2Files$Subj2==ii)))

# read in mask
if(!is.null(mask)) {
   if(is.null(mm <- read.AFNI(mask, forcedset = TRUE))) {
      warning("Failed to read mask", immediate.=TRUE)
      return(NULL)
   }
   maskData <- mm$brk[,,,1]
}
#if(is.null(mm <- read.AFNI('mask_TT_N27+tlrc', forcedset = TRUE))) {
#   warning("Failed to read mask", immediate.=TRUE)
#   return(NULL)
#}
#maskData <- mm$brk[,,,1]

inData <- read.AFNI(as.character(allFiles$InputFile)[1], forcedset = TRUE)
dimx <- inData$dim[1]
dimy <- inData$dim[2]
dimz <- inData$dim[3]
# for writing output purpose
head <- inData

allSubj <- c(G1Subj, G2Subj)
n1 <- length(G1Subj)
n2 <- length(G2Subj)
N1 <- n1*(n1-1)/2
N2 <- n2*(n2-1)/2
N12 <- n1*n2
nSubj <- length(allSubj)
nFile <- nSubj*(nSubj-1)/2
allData <- array(0, dim=c(dimx, dimy, dimz, nFile))
r2z <- function(r) 0.5*(log(1+r)-log(1-r))
z2r <- function(z) (exp(2*z)-1)/(exp(2*z)+1)

# make sure to read the files in a proper order to form the correlation matrix: upper triangle
ll <- 0
for(ii in 1:(nSubj-1))
   for(jj in (ii+1):nSubj) {
      ll <- ll+1
      allData[,,,ll] <- read.AFNI(allFiles[(allFiles$Subj == allSubj[ii] | allFiles$Subj == allSubj[jj]) &
         (allFiles$Subj2 == allSubj[ii] | allFiles$Subj2 == allSubj[jj]), 'InputFile'], forcedset = TRUE)$brk
}
cat('Reading input files: Done!\n\n')

tolL <- 1e-16 # bottom tolerance for avoiding division by 0 and for avioding analyzing data with most 0's
allData <- r2z(allData)

genLab <- function(nSubj, mydat, n1) {
   tmp0 <- vector('character', nSubj*(nSubj-1))
   tmp1 <- vector('character', nSubj*(nSubj-1))
   grp  <- vector('character', nSubj*(nSubj-1))
   tmp2 <- vector('numeric', nSubj*(nSubj-1))
   ll <- 0
   for(ii in 1:nSubj)
   for(jj in 1:nSubj) {
      if(jj!=ii) {
         ll    <- ll+1
         tmp0[ll] <- paste('s', ii, sep='')
         tmp1[ll] <- paste('s', jj, sep='')
         if(ii <= n1 & jj <= n1) grp[ll] <- 'G1' else if(ii > n1 & jj > n1)
            grp[ll] <- 'G2' else grp[ll] <- 'G12'
         tmp2[ll] <- mydat[ii, jj]
      }
   }
   aa <- data.frame(Subj=tmp0, Subj2=tmp1, G=grp, beta=tmp2)
   return(aa)
}

#require(lme4)
#fm <- lme(beta0 ~ 1, random=list(Subj=~1, Subj2=~1), data=myDatN)

mylme <- function(myDat, n1, n2, NN1, NN2, NN12) {
   if (!all(abs(myDat) < 10e-8)) {
      corM  <- matrix(NA, n1+n2, n1+n2)
      corM[lower.tri(corM)] <- myDat
      # flip it to get the upper triangle
      corM[upper.tri(corM)] <- t(corM)[upper.tri(t(corM))]
      tmp <- genLab(n1+n2, corM, n1)

      # Be careful about the contrast setting: default is contr.treatment, and the baseline
      # level seems to be the first level (not the first alphabetically) in a data.frame
      fm <- summary(lmer(beta~0+G+(1|Subj)+(1|Subj2), data=tmp)) # G1 as reference level
      cc <- fm$coefficients
      # later on move the 7 C* outside
      ww <- matrix(c(1,0,0,    # G1
                     0,0,1,    # G2
                     0,1,0,    # G12
                    -1,0,1, # G2 - G1
                     1,-1,0, # G1 - G12
                     0,-1,1, # G2 - G12
                     0.5,-1,0.5), # (G1+G2)/2 - G12
                   nrow = 7, ncol = 3, byrow = TRUE)
      vv <- t(ww%*%coef(fm)[,1])
      se <- rep(1e8, 7)
      for(ii in 1:7) se[ii] <- as.numeric(sqrt(t(ww[ii,]) %*% vcov(fm) %*% ww[ii,]))
      tt <- vv/se
      #tN1 <- (cc[3,1]*0.5-cc[2,1])*sqrt((NN1+NN2)-2)/(sqrt((cc[3,2])^2*0.25+(cc[2,2])^2)*sqrt(2*(NN1+NN2)-2))  # (G1+G2)/2 - G12
      #tN1 <- cc[2,1]*sqrt((NN1+NN2)-2)/(cc[2,2]*sqrt(2*(NN1+NN2)-2))  # new t-value
      # 2-sided p
      #pval <- 2*pt(abs(tN1), n1+n2-2, lower.tail = FALSE)
      zeta2 <- fm$varcor$Subj[1,1]
      eta2  <- attr(fm$varcor, 'sc')^2
      rho   <- zeta2/(2*zeta2+eta2)
      return(c(c(rbind(vv,tt)), zeta2, eta2, rho))
    } else return(rep(0, 17))
}
# mylme(allData[40,40,40,], n1, n2, N1, N2, N12)

# Initialization
NoBrick <- 17
out <- array(0, dim=c(dimx, dimy, dimz, NoBrick))

if (nNodes>1) {
   library(snow)
   cl <- makeCluster(nNodes, type = "SOCK")
   clusterExport(cl, c('genLab', 'z2r'), envir=environment())
   clusterEvalQ(cl, library(lme4))
   for (kk in 1:dimz) {
      out[,,kk,] <- aperm(parApply(cl, allData[,,kk,], c(1,2), mylme, n1, n2, N1, N2, N12), c(2,3,1))
      cat("Z slice ", kk, "done: ", format(Sys.time(), "%D %H:%M:%OS3"), "\n")
   }
   stopCluster(cl)
}

brickNames <- c('G1', 'G1 t',
                'G2', 'G2 t',
                'G12', 'G12 t',
                'G2-G1', 'G2-G1 t',
                'G1-G12', 'G1-G12 t',
                'G2-G12', 'G2-G12 t',
                'Ave-G12', 'Ave-G12 t', 'zeta2', 'eta2', 'rho')
statsym    <- list(list(sb=1, typ="fitt", par=n1-1), list(sb=3, typ="fitt", par=n2-1),
                   list(sb=5, typ="fitt", par=n1+n2-2), list(sb=7, typ="fitt", par=n1+n2-2),
                   list(sb=9, typ="fitt", par=n1+n2-2), list(sb=11, typ="fitt", par=n1+n2-2),
                   list(sb=13, typ="fitt", par=n1+n2-2))
write.AFNI(outFile, out, brickNames, defhead=head, idcode=newid.AFNI(), com_hist='', statsym=statsym, addFDR=1, type='MRI_short')
