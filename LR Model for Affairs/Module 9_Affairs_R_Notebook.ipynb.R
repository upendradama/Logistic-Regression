{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Logistic Regression\n",
    "\n",
    "### Problem Statement:- \n",
    "    - Whether married man has any extra marital affairs or not."
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Loading the dataset"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [],
   "source": [
    "affairs <- read.csv(\"~/desktop/Digi 360/Module 9/Affairs.csv\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table>\n",
       "<caption>A data.frame: 6 × 19</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>X</th><th scope=col>naffairs</th><th scope=col>kids</th><th scope=col>vryunhap</th><th scope=col>unhap</th><th scope=col>avgmarr</th><th scope=col>hapavg</th><th scope=col>vryhap</th><th scope=col>antirel</th><th scope=col>notrel</th><th scope=col>slghtrel</th><th scope=col>smerel</th><th scope=col>vryrel</th><th scope=col>yrsmarr1</th><th scope=col>yrsmarr2</th><th scope=col>yrsmarr3</th><th scope=col>yrsmarr4</th><th scope=col>yrsmarr5</th><th scope=col>yrsmarr6</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>2</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>3</td><td>3</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>4</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>5</td><td>3</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>6</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 19\n",
       "\\begin{tabular}{r|lllllllllllllllllll}\n",
       "  & X & naffairs & kids & vryunhap & unhap & avgmarr & hapavg & vryhap & antirel & notrel & slghtrel & smerel & vryrel & yrsmarr1 & yrsmarr2 & yrsmarr3 & yrsmarr4 & yrsmarr5 & yrsmarr6\\\\\n",
       "  & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int>\\\\\n",
       "\\hline\n",
       "\t1 & 1 & 0 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 0 & 0 & 0 & 1 & 0\\\\\n",
       "\t2 & 2 & 0 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 0\\\\\n",
       "\t3 & 3 & 3 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 0\\\\\n",
       "\t4 & 4 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 1 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 1\\\\\n",
       "\t5 & 5 & 3 & 1 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 1 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0\\\\\n",
       "\t6 & 6 & 0 & 1 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 0 & 0 & 1\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 19\n",
       "\n",
       "| <!--/--> | X &lt;int&gt; | naffairs &lt;int&gt; | kids &lt;int&gt; | vryunhap &lt;int&gt; | unhap &lt;int&gt; | avgmarr &lt;int&gt; | hapavg &lt;int&gt; | vryhap &lt;int&gt; | antirel &lt;int&gt; | notrel &lt;int&gt; | slghtrel &lt;int&gt; | smerel &lt;int&gt; | vryrel &lt;int&gt; | yrsmarr1 &lt;int&gt; | yrsmarr2 &lt;int&gt; | yrsmarr3 &lt;int&gt; | yrsmarr4 &lt;int&gt; | yrsmarr5 &lt;int&gt; | yrsmarr6 &lt;int&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 1 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 |\n",
       "| 2 | 2 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 1 | 0 | 0 | 0 |\n",
       "| 3 | 3 | 3 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 |\n",
       "| 4 | 4 | 0 | 1 | 0 | 0 | 0 | 1 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 |\n",
       "| 5 | 5 | 3 | 1 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 |\n",
       "| 6 | 6 | 0 | 1 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 1 |\n",
       "\n"
      ],
      "text/plain": [
       "  X naffairs kids vryunhap unhap avgmarr hapavg vryhap antirel notrel slghtrel\n",
       "1 1 0        0    0        0     0       1      0      0       0      1       \n",
       "2 2 0        0    0        0     0       1      0      0       0      0       \n",
       "3 3 3        0    0        0     0       1      0      0       0      1       \n",
       "4 4 0        1    0        0     0       1      0      1       0      0       \n",
       "5 5 3        1    0        0     0       0      1      0       0      1       \n",
       "6 6 0        1    0        0     0       0      1      0       0      0       \n",
       "  smerel vryrel yrsmarr1 yrsmarr2 yrsmarr3 yrsmarr4 yrsmarr5 yrsmarr6\n",
       "1 0      0      0        0        0        0        1        0       \n",
       "2 1      0      0        0        1        0        0        0       \n",
       "3 0      0      0        1        0        0        0        0       \n",
       "4 0      0      0        0        0        0        0        1       \n",
       "5 0      0      0        0        1        0        0        0       \n",
       "6 0      1      0        0        0        0        0        1       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "head(affairs)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "### Data Cleaning and Processing"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "0"
      ],
      "text/latex": [
       "0"
      ],
      "text/markdown": [
       "0"
      ],
      "text/plain": [
       "[1] 0"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Finding the NULL values\n",
    "sum(is.na(affairs))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table>\n",
       "<caption>A data.frame: 6 × 18</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>naffairs</th><th scope=col>kids</th><th scope=col>vryunhap</th><th scope=col>unhap</th><th scope=col>avgmarr</th><th scope=col>hapavg</th><th scope=col>vryhap</th><th scope=col>antirel</th><th scope=col>notrel</th><th scope=col>slghtrel</th><th scope=col>smerel</th><th scope=col>vryrel</th><th scope=col>yrsmarr1</th><th scope=col>yrsmarr2</th><th scope=col>yrsmarr3</th><th scope=col>yrsmarr4</th><th scope=col>yrsmarr5</th><th scope=col>yrsmarr6</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>3</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>3</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 18\n",
       "\\begin{tabular}{r|llllllllllllllllll}\n",
       "  & naffairs & kids & vryunhap & unhap & avgmarr & hapavg & vryhap & antirel & notrel & slghtrel & smerel & vryrel & yrsmarr1 & yrsmarr2 & yrsmarr3 & yrsmarr4 & yrsmarr5 & yrsmarr6\\\\\n",
       "  & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int>\\\\\n",
       "\\hline\n",
       "\t1 & 0 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 0 & 0 & 0 & 1 & 0\\\\\n",
       "\t2 & 0 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 0\\\\\n",
       "\t3 & 3 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 0\\\\\n",
       "\t4 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 1 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 1\\\\\n",
       "\t5 & 3 & 1 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 1 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0\\\\\n",
       "\t6 & 0 & 1 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 0 & 0 & 1\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 18\n",
       "\n",
       "| <!--/--> | naffairs &lt;int&gt; | kids &lt;int&gt; | vryunhap &lt;int&gt; | unhap &lt;int&gt; | avgmarr &lt;int&gt; | hapavg &lt;int&gt; | vryhap &lt;int&gt; | antirel &lt;int&gt; | notrel &lt;int&gt; | slghtrel &lt;int&gt; | smerel &lt;int&gt; | vryrel &lt;int&gt; | yrsmarr1 &lt;int&gt; | yrsmarr2 &lt;int&gt; | yrsmarr3 &lt;int&gt; | yrsmarr4 &lt;int&gt; | yrsmarr5 &lt;int&gt; | yrsmarr6 &lt;int&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 |\n",
       "| 2 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 1 | 0 | 0 | 0 |\n",
       "| 3 | 3 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 |\n",
       "| 4 | 0 | 1 | 0 | 0 | 0 | 1 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 |\n",
       "| 5 | 3 | 1 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 |\n",
       "| 6 | 0 | 1 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 1 |\n",
       "\n"
      ],
      "text/plain": [
       "  naffairs kids vryunhap unhap avgmarr hapavg vryhap antirel notrel slghtrel\n",
       "1 0        0    0        0     0       1      0      0       0      1       \n",
       "2 0        0    0        0     0       1      0      0       0      0       \n",
       "3 3        0    0        0     0       1      0      0       0      1       \n",
       "4 0        1    0        0     0       1      0      1       0      0       \n",
       "5 3        1    0        0     0       0      1      0       0      1       \n",
       "6 0        1    0        0     0       0      1      0       0      0       \n",
       "  smerel vryrel yrsmarr1 yrsmarr2 yrsmarr3 yrsmarr4 yrsmarr5 yrsmarr6\n",
       "1 0      0      0        0        0        0        1        0       \n",
       "2 1      0      0        0        1        0        0        0       \n",
       "3 0      0      0        1        0        0        0        0       \n",
       "4 0      0      0        0        0        0        0        1       \n",
       "5 0      0      0        0        1        0        0        0       \n",
       "6 0      1      0        0        0        0        0        1       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "#Let's remove the first column since it is just a serial number\n",
    "affairs <- affairs[,-1]\n",
    "head(affairs)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table>\n",
       "<caption>A data.frame: 6 × 18</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>naffairs</th><th scope=col>kids</th><th scope=col>vryunhap</th><th scope=col>unhap</th><th scope=col>avgmarr</th><th scope=col>hapavg</th><th scope=col>vryhap</th><th scope=col>antirel</th><th scope=col>notrel</th><th scope=col>slghtrel</th><th scope=col>smerel</th><th scope=col>vryrel</th><th scope=col>yrsmarr1</th><th scope=col>yrsmarr2</th><th scope=col>yrsmarr3</th><th scope=col>yrsmarr4</th><th scope=col>yrsmarr5</th><th scope=col>yrsmarr6</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 18\n",
       "\\begin{tabular}{r|llllllllllllllllll}\n",
       "  & naffairs & kids & vryunhap & unhap & avgmarr & hapavg & vryhap & antirel & notrel & slghtrel & smerel & vryrel & yrsmarr1 & yrsmarr2 & yrsmarr3 & yrsmarr4 & yrsmarr5 & yrsmarr6\\\\\n",
       "  & <dbl> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int>\\\\\n",
       "\\hline\n",
       "\t1 & 0 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 0 & 0 & 0 & 1 & 0\\\\\n",
       "\t2 & 0 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 0\\\\\n",
       "\t3 & 1 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 0\\\\\n",
       "\t4 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 1 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 1\\\\\n",
       "\t5 & 1 & 1 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 1 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0\\\\\n",
       "\t6 & 0 & 1 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 0 & 0 & 1\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 18\n",
       "\n",
       "| <!--/--> | naffairs &lt;dbl&gt; | kids &lt;int&gt; | vryunhap &lt;int&gt; | unhap &lt;int&gt; | avgmarr &lt;int&gt; | hapavg &lt;int&gt; | vryhap &lt;int&gt; | antirel &lt;int&gt; | notrel &lt;int&gt; | slghtrel &lt;int&gt; | smerel &lt;int&gt; | vryrel &lt;int&gt; | yrsmarr1 &lt;int&gt; | yrsmarr2 &lt;int&gt; | yrsmarr3 &lt;int&gt; | yrsmarr4 &lt;int&gt; | yrsmarr5 &lt;int&gt; | yrsmarr6 &lt;int&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 |\n",
       "| 2 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 1 | 0 | 0 | 0 |\n",
       "| 3 | 1 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 |\n",
       "| 4 | 0 | 1 | 0 | 0 | 0 | 1 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 |\n",
       "| 5 | 1 | 1 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 |\n",
       "| 6 | 0 | 1 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 1 |\n",
       "\n"
      ],
      "text/plain": [
       "  naffairs kids vryunhap unhap avgmarr hapavg vryhap antirel notrel slghtrel\n",
       "1 0        0    0        0     0       1      0      0       0      1       \n",
       "2 0        0    0        0     0       1      0      0       0      0       \n",
       "3 1        0    0        0     0       1      0      0       0      1       \n",
       "4 0        1    0        0     0       1      0      1       0      0       \n",
       "5 1        1    0        0     0       0      1      0       0      1       \n",
       "6 0        1    0        0     0       0      1      0       0      0       \n",
       "  smerel vryrel yrsmarr1 yrsmarr2 yrsmarr3 yrsmarr4 yrsmarr5 yrsmarr6\n",
       "1 0      0      0        0        0        0        1        0       \n",
       "2 1      0      0        0        1        0        0        0       \n",
       "3 0      0      0        1        0        0        0        0       \n",
       "4 0      0      0        0        0        0        0        1       \n",
       "5 0      0      0        0        1        0        0        0       \n",
       "6 0      1      0        0        0        0        0        1       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "#converting output varibale to binary\n",
    "affairs$naffairs <- ifelse(affairs$naffairs > 1,1,0)\n",
    "head(affairs)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "    naffairs          kids           vryunhap           unhap       \n",
       " Min.   :0.000   Min.   :0.0000   Min.   :0.00000   Min.   :0.0000  \n",
       " 1st Qu.:0.000   1st Qu.:0.0000   1st Qu.:0.00000   1st Qu.:0.0000  \n",
       " Median :0.000   Median :1.0000   Median :0.00000   Median :0.0000  \n",
       " Mean   :0.193   Mean   :0.7155   Mean   :0.02662   Mean   :0.1098  \n",
       " 3rd Qu.:0.000   3rd Qu.:1.0000   3rd Qu.:0.00000   3rd Qu.:0.0000  \n",
       " Max.   :1.000   Max.   :1.0000   Max.   :1.00000   Max.   :1.0000  \n",
       "    avgmarr           hapavg           vryhap         antirel       \n",
       " Min.   :0.0000   Min.   :0.0000   Min.   :0.000   Min.   :0.00000  \n",
       " 1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.000   1st Qu.:0.00000  \n",
       " Median :0.0000   Median :0.0000   Median :0.000   Median :0.00000  \n",
       " Mean   :0.1547   Mean   :0.3228   Mean   :0.386   Mean   :0.07987  \n",
       " 3rd Qu.:0.0000   3rd Qu.:1.0000   3rd Qu.:1.000   3rd Qu.:0.00000  \n",
       " Max.   :1.0000   Max.   :1.0000   Max.   :1.000   Max.   :1.00000  \n",
       "     notrel          slghtrel          smerel           vryrel      \n",
       " Min.   :0.0000   Min.   :0.0000   Min.   :0.0000   Min.   :0.0000  \n",
       " 1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.0000  \n",
       " Median :0.0000   Median :0.0000   Median :0.0000   Median :0.0000  \n",
       " Mean   :0.2729   Mean   :0.2146   Mean   :0.3161   Mean   :0.1165  \n",
       " 3rd Qu.:1.0000   3rd Qu.:0.0000   3rd Qu.:1.0000   3rd Qu.:0.0000  \n",
       " Max.   :1.0000   Max.   :1.0000   Max.   :1.0000   Max.   :1.0000  \n",
       "    yrsmarr1          yrsmarr2         yrsmarr3         yrsmarr4     \n",
       " Min.   :0.00000   Min.   :0.0000   Min.   :0.0000   Min.   :0.0000  \n",
       " 1st Qu.:0.00000   1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.0000  \n",
       " Median :0.00000   Median :0.0000   Median :0.0000   Median :0.0000  \n",
       " Mean   :0.08652   Mean   :0.1464   Mean   :0.1747   Mean   :0.1364  \n",
       " 3rd Qu.:0.00000   3rd Qu.:0.0000   3rd Qu.:0.0000   3rd Qu.:0.0000  \n",
       " Max.   :1.00000   Max.   :1.0000   Max.   :1.0000   Max.   :1.0000  \n",
       "    yrsmarr5         yrsmarr6     \n",
       " Min.   :0.0000   Min.   :0.0000  \n",
       " 1st Qu.:0.0000   1st Qu.:0.0000  \n",
       " Median :0.0000   Median :0.0000  \n",
       " Mean   :0.1165   Mean   :0.3394  \n",
       " 3rd Qu.:0.0000   3rd Qu.:1.0000  \n",
       " Max.   :1.0000   Max.   :1.0000  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "#Let's check the summary of the dataset\n",
    "summary(affairs)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "From above summary we can see that there are no outliers and the range is also good so no scaling is required."
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "### Traning and Splitting"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "metadata": {},
   "outputs": [],
   "source": [
    "library('caTools') \n",
    "set.seed(123) \n",
    "split = sample.split(affairs, SplitRatio = 0.7) \n",
    "train = subset(affairs, split == TRUE)\n",
    "test = subset(affairs, split == FALSE) "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table>\n",
       "<caption>A data.frame: 6 × 18</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>naffairs</th><th scope=col>kids</th><th scope=col>vryunhap</th><th scope=col>unhap</th><th scope=col>avgmarr</th><th scope=col>hapavg</th><th scope=col>vryhap</th><th scope=col>antirel</th><th scope=col>notrel</th><th scope=col>slghtrel</th><th scope=col>smerel</th><th scope=col>vryrel</th><th scope=col>yrsmarr1</th><th scope=col>yrsmarr2</th><th scope=col>yrsmarr3</th><th scope=col>yrsmarr4</th><th scope=col>yrsmarr5</th><th scope=col>yrsmarr6</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td></tr>\n",
       "\t<tr><th scope=row>7</th><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>9</th><td>1</td><td>1</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td></tr>\n",
       "\t<tr><th scope=row>10</th><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 18\n",
       "\\begin{tabular}{r|llllllllllllllllll}\n",
       "  & naffairs & kids & vryunhap & unhap & avgmarr & hapavg & vryhap & antirel & notrel & slghtrel & smerel & vryrel & yrsmarr1 & yrsmarr2 & yrsmarr3 & yrsmarr4 & yrsmarr5 & yrsmarr6\\\\\n",
       "  & <dbl> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int>\\\\\n",
       "\\hline\n",
       "\t1 & 0 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 0 & 0 & 0 & 1 & 0\\\\\n",
       "\t3 & 1 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 0\\\\\n",
       "\t6 & 0 & 1 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 0 & 0 & 1\\\\\n",
       "\t7 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 0 & 0\\\\\n",
       "\t9 & 1 & 1 & 0 & 1 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 0 & 0 & 1\\\\\n",
       "\t10 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 0 & 0\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 18\n",
       "\n",
       "| <!--/--> | naffairs &lt;dbl&gt; | kids &lt;int&gt; | vryunhap &lt;int&gt; | unhap &lt;int&gt; | avgmarr &lt;int&gt; | hapavg &lt;int&gt; | vryhap &lt;int&gt; | antirel &lt;int&gt; | notrel &lt;int&gt; | slghtrel &lt;int&gt; | smerel &lt;int&gt; | vryrel &lt;int&gt; | yrsmarr1 &lt;int&gt; | yrsmarr2 &lt;int&gt; | yrsmarr3 &lt;int&gt; | yrsmarr4 &lt;int&gt; | yrsmarr5 &lt;int&gt; | yrsmarr6 &lt;int&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 |\n",
       "| 3 | 1 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 |\n",
       "| 6 | 0 | 1 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 1 |\n",
       "| 7 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 |\n",
       "| 9 | 1 | 1 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 1 |\n",
       "| 10 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 |\n",
       "\n"
      ],
      "text/plain": [
       "   naffairs kids vryunhap unhap avgmarr hapavg vryhap antirel notrel slghtrel\n",
       "1  0        0    0        0     0       1      0      0       0      1       \n",
       "3  1        0    0        0     0       1      0      0       0      1       \n",
       "6  0        1    0        0     0       0      1      0       0      0       \n",
       "7  0        0    0        0     1       0      0      0       1      0       \n",
       "9  1        1    0        1     0       0      0      0       0      0       \n",
       "10 0        0    0        0     1       0      0      0       1      0       \n",
       "   smerel vryrel yrsmarr1 yrsmarr2 yrsmarr3 yrsmarr4 yrsmarr5 yrsmarr6\n",
       "1  0      0      0        0        0        0        1        0       \n",
       "3  0      0      0        1        0        0        0        0       \n",
       "6  0      1      0        0        0        0        0        1       \n",
       "7  0      0      1        0        0        0        0        0       \n",
       "9  0      1      0        0        0        0        0        1       \n",
       "10 0      0      1        0        0        0        0        0       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "#Let's view train set\n",
    "head(train)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 9,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "\n",
       "Call:\n",
       "glm(formula = naffairs ~ ., family = \"binomial\", data = train)\n",
       "\n",
       "Deviance Residuals: \n",
       "    Min       1Q   Median       3Q      Max  \n",
       "-1.4533  -0.6154  -0.3700  -0.1743   2.4992  \n",
       "\n",
       "Coefficients: (3 not defined because of singularities)\n",
       "            Estimate Std. Error z value Pr(>|z|)    \n",
       "(Intercept) -2.89215    0.70769  -4.087 4.37e-05 ***\n",
       "kids         0.24479    0.48439   0.505  0.61331    \n",
       "vryunhap     2.18718    0.73108   2.992  0.00277 ** \n",
       "unhap        2.42998    0.48324   5.029 4.94e-07 ***\n",
       "avgmarr      1.13492    0.49439   2.296  0.02170 *  \n",
       "hapavg       1.25005    0.41444   3.016  0.00256 ** \n",
       "vryhap            NA         NA      NA       NA    \n",
       "antirel      1.69471    0.64925   2.610  0.00905 ** \n",
       "notrel       0.84588    0.50502   1.675  0.09394 .  \n",
       "slghtrel     0.79779    0.51880   1.538  0.12410    \n",
       "smerel      -0.19388    0.51160  -0.379  0.70471    \n",
       "vryrel            NA         NA      NA       NA    \n",
       "yrsmarr1    -2.41128    1.10088  -2.190  0.02850 *  \n",
       "yrsmarr2    -1.21307    0.72681  -1.669  0.09511 .  \n",
       "yrsmarr3    -0.38248    0.44070  -0.868  0.38546    \n",
       "yrsmarr4    -0.73601    0.45599  -1.614  0.10651    \n",
       "yrsmarr5    -0.04399    0.43626  -0.101  0.91968    \n",
       "yrsmarr6          NA         NA      NA       NA    \n",
       "---\n",
       "Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1\n",
       "\n",
       "(Dispersion parameter for binomial family taken to be 1)\n",
       "\n",
       "    Null deviance: 391.86  on 399  degrees of freedom\n",
       "Residual deviance: 317.39  on 385  degrees of freedom\n",
       "AIC: 347.39\n",
       "\n",
       "Number of Fisher Scoring iterations: 6\n"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "### Building the First Model\n",
    "\n",
    "#Building the First Training model\n",
    "logm1 <- glm(naffairs~.,data=train, family='binomial')\n",
    "summary(logm1)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Let's drop the features that are high p value. Let's drop `kids`,`vryrel`, `yrsmarr6` and `smerel`"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 10,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table>\n",
       "<caption>A data.frame: 6 × 13</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>naffairs</th><th scope=col>vryunhap</th><th scope=col>unhap</th><th scope=col>avgmarr</th><th scope=col>hapavg</th><th scope=col>antirel</th><th scope=col>notrel</th><th scope=col>slghtrel</th><th scope=col>yrsmarr1</th><th scope=col>yrsmarr2</th><th scope=col>yrsmarr3</th><th scope=col>yrsmarr4</th><th scope=col>yrsmarr5</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>1</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>7</th><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>1</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>9</th><td>1</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>10</th><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>1</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 13\n",
       "\\begin{tabular}{r|lllllllllllll}\n",
       "  & naffairs & vryunhap & unhap & avgmarr & hapavg & antirel & notrel & slghtrel & yrsmarr1 & yrsmarr2 & yrsmarr3 & yrsmarr4 & yrsmarr5\\\\\n",
       "  & <dbl> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int>\\\\\n",
       "\\hline\n",
       "\t1 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 1 & 0 & 0 & 0 & 0 & 1\\\\\n",
       "\t3 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 1 & 0 & 1 & 0 & 0 & 0\\\\\n",
       "\t6 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0\\\\\n",
       "\t7 & 0 & 0 & 0 & 1 & 0 & 0 & 1 & 0 & 1 & 0 & 0 & 0 & 0\\\\\n",
       "\t9 & 1 & 0 & 1 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0\\\\\n",
       "\t10 & 0 & 0 & 0 & 1 & 0 & 0 & 1 & 0 & 1 & 0 & 0 & 0 & 0\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 13\n",
       "\n",
       "| <!--/--> | naffairs &lt;dbl&gt; | vryunhap &lt;int&gt; | unhap &lt;int&gt; | avgmarr &lt;int&gt; | hapavg &lt;int&gt; | antirel &lt;int&gt; | notrel &lt;int&gt; | slghtrel &lt;int&gt; | yrsmarr1 &lt;int&gt; | yrsmarr2 &lt;int&gt; | yrsmarr3 &lt;int&gt; | yrsmarr4 &lt;int&gt; | yrsmarr5 &lt;int&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 1 |\n",
       "| 3 | 1 | 0 | 0 | 0 | 1 | 0 | 0 | 1 | 0 | 1 | 0 | 0 | 0 |\n",
       "| 6 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |\n",
       "| 7 | 0 | 0 | 0 | 1 | 0 | 0 | 1 | 0 | 1 | 0 | 0 | 0 | 0 |\n",
       "| 9 | 1 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |\n",
       "| 10 | 0 | 0 | 0 | 1 | 0 | 0 | 1 | 0 | 1 | 0 | 0 | 0 | 0 |\n",
       "\n"
      ],
      "text/plain": [
       "   naffairs vryunhap unhap avgmarr hapavg antirel notrel slghtrel yrsmarr1\n",
       "1  0        0        0     0       1      0       0      1        0       \n",
       "3  1        0        0     0       1      0       0      1        0       \n",
       "6  0        0        0     0       0      0       0      0        0       \n",
       "7  0        0        0     1       0      0       1      0        1       \n",
       "9  1        0        1     0       0      0       0      0        0       \n",
       "10 0        0        0     1       0      0       1      0        1       \n",
       "   yrsmarr2 yrsmarr3 yrsmarr4 yrsmarr5\n",
       "1  0        0        0        1       \n",
       "3  1        0        0        0       \n",
       "6  0        0        0        0       \n",
       "7  0        0        0        0       \n",
       "9  0        0        0        0       \n",
       "10 0        0        0        0       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "train <- train[,-c(2,7, 11,12,18)]\n",
    "head(train)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 11,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "\n",
       "Call:\n",
       "glm(formula = naffairs ~ ., family = \"binomial\", data = train)\n",
       "\n",
       "Deviance Residuals: \n",
       "    Min       1Q   Median       3Q      Max  \n",
       "-1.4597  -0.6266  -0.3458  -0.1754   2.5614  \n",
       "\n",
       "Coefficients:\n",
       "            Estimate Std. Error z value Pr(>|z|)    \n",
       "(Intercept) -2.78663    0.43094  -6.466 1.00e-10 ***\n",
       "vryunhap     2.16924    0.73082   2.968 0.002995 ** \n",
       "unhap        2.45162    0.48115   5.095 3.48e-07 ***\n",
       "avgmarr      1.14321    0.49342   2.317 0.020507 *  \n",
       "hapavg       1.25849    0.41408   3.039 0.002372 ** \n",
       "antirel      1.83253    0.54275   3.376 0.000734 ***\n",
       "notrel       0.97779    0.35851   2.727 0.006384 ** \n",
       "slghtrel     0.93795    0.38412   2.442 0.014614 *  \n",
       "yrsmarr1    -2.57631    1.05946  -2.432 0.015028 *  \n",
       "yrsmarr2    -1.37981    0.66048  -2.089 0.036699 *  \n",
       "yrsmarr3    -0.47229    0.41544  -1.137 0.255603    \n",
       "yrsmarr4    -0.76902    0.45039  -1.707 0.087735 .  \n",
       "yrsmarr5    -0.07995    0.43296  -0.185 0.853490    \n",
       "---\n",
       "Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1\n",
       "\n",
       "(Dispersion parameter for binomial family taken to be 1)\n",
       "\n",
       "    Null deviance: 391.86  on 399  degrees of freedom\n",
       "Residual deviance: 317.81  on 387  degrees of freedom\n",
       "AIC: 343.81\n",
       "\n",
       "Number of Fisher Scoring iterations: 6\n"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "#Let's rebuild the model again with reduced features\n",
    "logm2 <- glm(naffairs~.,data=train, family='binomial')\n",
    "summary(logm2)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Let's remove `yrsmarr5` since it has high p value"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 12,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table>\n",
       "<caption>A data.frame: 6 × 12</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>naffairs</th><th scope=col>vryunhap</th><th scope=col>unhap</th><th scope=col>avgmarr</th><th scope=col>hapavg</th><th scope=col>antirel</th><th scope=col>notrel</th><th scope=col>slghtrel</th><th scope=col>yrsmarr1</th><th scope=col>yrsmarr2</th><th scope=col>yrsmarr3</th><th scope=col>yrsmarr4</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>1</td><td>0</td><td>1</td><td>0</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>7</th><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>1</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>9</th><td>1</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>10</th><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>1</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 12\n",
       "\\begin{tabular}{r|llllllllllll}\n",
       "  & naffairs & vryunhap & unhap & avgmarr & hapavg & antirel & notrel & slghtrel & yrsmarr1 & yrsmarr2 & yrsmarr3 & yrsmarr4\\\\\n",
       "  & <dbl> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int>\\\\\n",
       "\\hline\n",
       "\t1 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 1 & 0 & 0 & 0 & 0\\\\\n",
       "\t3 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 1 & 0 & 1 & 0 & 0\\\\\n",
       "\t6 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0\\\\\n",
       "\t7 & 0 & 0 & 0 & 1 & 0 & 0 & 1 & 0 & 1 & 0 & 0 & 0\\\\\n",
       "\t9 & 1 & 0 & 1 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0\\\\\n",
       "\t10 & 0 & 0 & 0 & 1 & 0 & 0 & 1 & 0 & 1 & 0 & 0 & 0\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 12\n",
       "\n",
       "| <!--/--> | naffairs &lt;dbl&gt; | vryunhap &lt;int&gt; | unhap &lt;int&gt; | avgmarr &lt;int&gt; | hapavg &lt;int&gt; | antirel &lt;int&gt; | notrel &lt;int&gt; | slghtrel &lt;int&gt; | yrsmarr1 &lt;int&gt; | yrsmarr2 &lt;int&gt; | yrsmarr3 &lt;int&gt; | yrsmarr4 &lt;int&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 1 | 0 | 0 | 0 | 0 |\n",
       "| 3 | 1 | 0 | 0 | 0 | 1 | 0 | 0 | 1 | 0 | 1 | 0 | 0 |\n",
       "| 6 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |\n",
       "| 7 | 0 | 0 | 0 | 1 | 0 | 0 | 1 | 0 | 1 | 0 | 0 | 0 |\n",
       "| 9 | 1 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |\n",
       "| 10 | 0 | 0 | 0 | 1 | 0 | 0 | 1 | 0 | 1 | 0 | 0 | 0 |\n",
       "\n"
      ],
      "text/plain": [
       "   naffairs vryunhap unhap avgmarr hapavg antirel notrel slghtrel yrsmarr1\n",
       "1  0        0        0     0       1      0       0      1        0       \n",
       "3  1        0        0     0       1      0       0      1        0       \n",
       "6  0        0        0     0       0      0       0      0        0       \n",
       "7  0        0        0     1       0      0       1      0        1       \n",
       "9  1        0        1     0       0      0       0      0        0       \n",
       "10 0        0        0     1       0      0       1      0        1       \n",
       "   yrsmarr2 yrsmarr3 yrsmarr4\n",
       "1  0        0        0       \n",
       "3  1        0        0       \n",
       "6  0        0        0       \n",
       "7  0        0        0       \n",
       "9  0        0        0       \n",
       "10 0        0        0       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "train <- train[,-c(13)]\n",
    "head(train)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 13,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "\n",
       "Call:\n",
       "glm(formula = naffairs ~ ., family = \"binomial\", data = train)\n",
       "\n",
       "Deviance Residuals: \n",
       "    Min       1Q   Median       3Q      Max  \n",
       "-1.4501  -0.6212  -0.3421  -0.1757   2.5623  \n",
       "\n",
       "Coefficients:\n",
       "            Estimate Std. Error z value Pr(>|z|)    \n",
       "(Intercept)  -2.8090     0.4139  -6.786 1.15e-11 ***\n",
       "vryunhap      2.1913     0.7213   3.038 0.002380 ** \n",
       "unhap         2.4649     0.4759   5.180 2.22e-07 ***\n",
       "avgmarr       1.1506     0.4917   2.340 0.019272 *  \n",
       "hapavg        1.2618     0.4135   3.051 0.002278 ** \n",
       "antirel       1.8298     0.5428   3.371 0.000748 ***\n",
       "notrel        0.9654     0.3520   2.742 0.006100 ** \n",
       "slghtrel      0.9308     0.3819   2.437 0.014792 *  \n",
       "yrsmarr1     -2.5515     1.0511  -2.427 0.015206 *  \n",
       "yrsmarr2     -1.3542     0.6459  -2.097 0.036022 *  \n",
       "yrsmarr3     -0.4488     0.3960  -1.133 0.257030    \n",
       "yrsmarr4     -0.7474     0.4352  -1.717 0.085928 .  \n",
       "---\n",
       "Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1\n",
       "\n",
       "(Dispersion parameter for binomial family taken to be 1)\n",
       "\n",
       "    Null deviance: 391.86  on 399  degrees of freedom\n",
       "Residual deviance: 317.84  on 388  degrees of freedom\n",
       "AIC: 341.84\n",
       "\n",
       "Number of Fisher Scoring iterations: 6\n"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "#Let's rebuild the model again with reduced features\n",
    "logm3 <- glm(naffairs~.,data=train, family='binomial')\n",
    "summary(logm3)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Let's remove `yrsmarr3` and `yrsmarr4` since they have high p value."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 14,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table>\n",
       "<caption>A data.frame: 6 × 10</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>naffairs</th><th scope=col>vryunhap</th><th scope=col>unhap</th><th scope=col>avgmarr</th><th scope=col>hapavg</th><th scope=col>antirel</th><th scope=col>notrel</th><th scope=col>slghtrel</th><th scope=col>yrsmarr1</th><th scope=col>yrsmarr2</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>1</td><td>0</td><td>1</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>7</th><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>1</td><td>0</td><td>1</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>9</th><td>1</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>10</th><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>1</td><td>0</td><td>1</td><td>0</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 10\n",
       "\\begin{tabular}{r|llllllllll}\n",
       "  & naffairs & vryunhap & unhap & avgmarr & hapavg & antirel & notrel & slghtrel & yrsmarr1 & yrsmarr2\\\\\n",
       "  & <dbl> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int>\\\\\n",
       "\\hline\n",
       "\t1 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 1 & 0 & 0\\\\\n",
       "\t3 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 1 & 0 & 1\\\\\n",
       "\t6 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0\\\\\n",
       "\t7 & 0 & 0 & 0 & 1 & 0 & 0 & 1 & 0 & 1 & 0\\\\\n",
       "\t9 & 1 & 0 & 1 & 0 & 0 & 0 & 0 & 0 & 0 & 0\\\\\n",
       "\t10 & 0 & 0 & 0 & 1 & 0 & 0 & 1 & 0 & 1 & 0\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 10\n",
       "\n",
       "| <!--/--> | naffairs &lt;dbl&gt; | vryunhap &lt;int&gt; | unhap &lt;int&gt; | avgmarr &lt;int&gt; | hapavg &lt;int&gt; | antirel &lt;int&gt; | notrel &lt;int&gt; | slghtrel &lt;int&gt; | yrsmarr1 &lt;int&gt; | yrsmarr2 &lt;int&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 1 | 0 | 0 |\n",
       "| 3 | 1 | 0 | 0 | 0 | 1 | 0 | 0 | 1 | 0 | 1 |\n",
       "| 6 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |\n",
       "| 7 | 0 | 0 | 0 | 1 | 0 | 0 | 1 | 0 | 1 | 0 |\n",
       "| 9 | 1 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |\n",
       "| 10 | 0 | 0 | 0 | 1 | 0 | 0 | 1 | 0 | 1 | 0 |\n",
       "\n"
      ],
      "text/plain": [
       "   naffairs vryunhap unhap avgmarr hapavg antirel notrel slghtrel yrsmarr1\n",
       "1  0        0        0     0       1      0       0      1        0       \n",
       "3  1        0        0     0       1      0       0      1        0       \n",
       "6  0        0        0     0       0      0       0      0        0       \n",
       "7  0        0        0     1       0      0       1      0        1       \n",
       "9  1        0        1     0       0      0       0      0        0       \n",
       "10 0        0        0     1       0      0       1      0        1       \n",
       "   yrsmarr2\n",
       "1  0       \n",
       "3  1       \n",
       "6  0       \n",
       "7  0       \n",
       "9  0       \n",
       "10 0       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "train <- train[,-c(11,12)]\n",
    "head(train)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 15,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "\n",
       "Call:\n",
       "glm(formula = naffairs ~ ., family = \"binomial\", data = train)\n",
       "\n",
       "Deviance Residuals: \n",
       "    Min       1Q   Median       3Q      Max  \n",
       "-1.3256  -0.5842  -0.3428  -0.1818   2.5667  \n",
       "\n",
       "Coefficients:\n",
       "            Estimate Std. Error z value Pr(>|z|)    \n",
       "(Intercept)  -2.9719     0.4029  -7.376 1.63e-13 ***\n",
       "vryunhap      2.3205     0.7205   3.221  0.00128 ** \n",
       "unhap         2.4338     0.4640   5.245 1.56e-07 ***\n",
       "avgmarr       1.1370     0.4882   2.329  0.01987 *  \n",
       "hapavg        1.2902     0.4083   3.160  0.00158 ** \n",
       "antirel       1.6034     0.5140   3.120  0.00181 ** \n",
       "notrel        0.8801     0.3463   2.542  0.01103 *  \n",
       "slghtrel      0.8695     0.3730   2.331  0.01974 *  \n",
       "yrsmarr1     -2.3012     1.0397  -2.213  0.02688 *  \n",
       "yrsmarr2     -1.1228     0.6320  -1.777  0.07563 .  \n",
       "---\n",
       "Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1\n",
       "\n",
       "(Dispersion parameter for binomial family taken to be 1)\n",
       "\n",
       "    Null deviance: 391.86  on 399  degrees of freedom\n",
       "Residual deviance: 321.56  on 390  degrees of freedom\n",
       "AIC: 341.56\n",
       "\n",
       "Number of Fisher Scoring iterations: 6\n"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "#Let's rebuild the model again with reduced features\n",
    "logm4 <- glm(naffairs~.,data=train, family='binomial')\n",
    "summary(logm4)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Let's remove `yrsmarr2` since it has high p value"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 18,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table>\n",
       "<caption>A data.frame: 6 × 9</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>naffairs</th><th scope=col>vryunhap</th><th scope=col>unhap</th><th scope=col>avgmarr</th><th scope=col>hapavg</th><th scope=col>antirel</th><th scope=col>notrel</th><th scope=col>slghtrel</th><th scope=col>yrsmarr1</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>1</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>1</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>7</th><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>1</td><td>0</td><td>1</td></tr>\n",
       "\t<tr><th scope=row>9</th><td>1</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>10</th><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>1</td><td>0</td><td>1</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 9\n",
       "\\begin{tabular}{r|lllllllll}\n",
       "  & naffairs & vryunhap & unhap & avgmarr & hapavg & antirel & notrel & slghtrel & yrsmarr1\\\\\n",
       "  & <dbl> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int>\\\\\n",
       "\\hline\n",
       "\t1 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 1 & 0\\\\\n",
       "\t3 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 1 & 0\\\\\n",
       "\t6 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0\\\\\n",
       "\t7 & 0 & 0 & 0 & 1 & 0 & 0 & 1 & 0 & 1\\\\\n",
       "\t9 & 1 & 0 & 1 & 0 & 0 & 0 & 0 & 0 & 0\\\\\n",
       "\t10 & 0 & 0 & 0 & 1 & 0 & 0 & 1 & 0 & 1\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 9\n",
       "\n",
       "| <!--/--> | naffairs &lt;dbl&gt; | vryunhap &lt;int&gt; | unhap &lt;int&gt; | avgmarr &lt;int&gt; | hapavg &lt;int&gt; | antirel &lt;int&gt; | notrel &lt;int&gt; | slghtrel &lt;int&gt; | yrsmarr1 &lt;int&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 1 | 0 |\n",
       "| 3 | 1 | 0 | 0 | 0 | 1 | 0 | 0 | 1 | 0 |\n",
       "| 6 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |\n",
       "| 7 | 0 | 0 | 0 | 1 | 0 | 0 | 1 | 0 | 1 |\n",
       "| 9 | 1 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 |\n",
       "| 10 | 0 | 0 | 0 | 1 | 0 | 0 | 1 | 0 | 1 |\n",
       "\n"
      ],
      "text/plain": [
       "   naffairs vryunhap unhap avgmarr hapavg antirel notrel slghtrel yrsmarr1\n",
       "1  0        0        0     0       1      0       0      1        0       \n",
       "3  1        0        0     0       1      0       0      1        0       \n",
       "6  0        0        0     0       0      0       0      0        0       \n",
       "7  0        0        0     1       0      0       1      0        1       \n",
       "9  1        0        1     0       0      0       0      0        0       \n",
       "10 0        0        0     1       0      0       1      0        1       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "train <- train[,-c(10)]\n",
    "head(train)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 19,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "\n",
       "Call:\n",
       "glm(formula = naffairs ~ ., family = \"binomial\", data = train)\n",
       "\n",
       "Deviance Residuals: \n",
       "    Min       1Q   Median       3Q      Max  \n",
       "-1.3043  -0.5796  -0.4265  -0.1960   2.5682  \n",
       "\n",
       "Coefficients:\n",
       "            Estimate Std. Error z value Pr(>|z|)    \n",
       "(Intercept)  -3.2097     0.3984  -8.056 7.89e-16 ***\n",
       "vryunhap      2.5643     0.7153   3.585 0.000337 ***\n",
       "unhap         2.6452     0.4557   5.805 6.45e-09 ***\n",
       "avgmarr       1.2956     0.4828   2.683 0.007290 ** \n",
       "hapavg        1.4707     0.4016   3.662 0.000250 ***\n",
       "antirel       1.6283     0.5123   3.179 0.001480 ** \n",
       "notrel        0.8580     0.3443   2.492 0.012699 *  \n",
       "slghtrel      0.8507     0.3715   2.290 0.022017 *  \n",
       "yrsmarr1     -2.2042     1.0407  -2.118 0.034173 *  \n",
       "---\n",
       "Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1\n",
       "\n",
       "(Dispersion parameter for binomial family taken to be 1)\n",
       "\n",
       "    Null deviance: 391.86  on 399  degrees of freedom\n",
       "Residual deviance: 325.58  on 391  degrees of freedom\n",
       "AIC: 343.58\n",
       "\n",
       "Number of Fisher Scoring iterations: 6\n"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "#Let's rebuild the model again with reduced features\n",
    "logm5 <- glm(naffairs~.,data=train, family='binomial')\n",
    "summary(logm5)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "### Checking the VIF"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 20,
   "metadata": {},
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Registered S3 methods overwritten by 'fmsb':\n",
      "  method    from\n",
      "  print.roc pROC\n",
      "  plot.roc  pROC\n",
      "\n"
     ]
    }
   ],
   "source": [
    "library(fmsb)\n",
    "\n",
    "vif_func<-function(in_frame,thresh=10,trace=T,...){\n",
    "  \n",
    "  require(fmsb)\n",
    "  \n",
    "  if(class(in_frame) != 'data.frame') in_frame<-data.frame(in_frame)\n",
    "  \n",
    "  #get initial vif value for all comparisons of variables\n",
    "  vif_init<-NULL\n",
    "  var_names <- names(in_frame)\n",
    "  for(val in var_names){\n",
    "    regressors <- var_names[-which(var_names == val)]\n",
    "    form <- paste(regressors, collapse = '+')\n",
    "    form_in <- formula(paste(val, '~', form))\n",
    "    vif_init<-rbind(vif_init, c(val, VIF(lm(form_in, data = in_frame, ...))))\n",
    "  }\n",
    "  vif_max<-max(as.numeric(vif_init[,2]), na.rm = TRUE)\n",
    "  \n",
    "  if(vif_max < thresh){\n",
    "    if(trace==T){ #print output of each iteration\n",
    "      prmatrix(vif_init,collab=c('var','vif'),rowlab=rep('',nrow(vif_init)),quote=F)\n",
    "      cat('\\n')\n",
    "      cat(paste('All variables have VIF < ', thresh,', max VIF ',round(vif_max,2), sep=''),'\\n\\n')\n",
    "    }\n",
    "    return(var_names)\n",
    "  }\n",
    "  else{\n",
    "    \n",
    "    in_dat<-in_frame\n",
    "    \n",
    "    #backwards selection of explanatory variables, stops when all VIF values are below 'thresh'\n",
    "    while(vif_max >= thresh){\n",
    "      \n",
    "      vif_vals<-NULL\n",
    "      var_names <- names(in_dat)\n",
    "      \n",
    "      for(val in var_names){\n",
    "        regressors <- var_names[-which(var_names == val)]\n",
    "        form <- paste(regressors, collapse = '+')\n",
    "        form_in <- formula(paste(val, '~', form))\n",
    "        vif_add<-VIF(lm(form_in, data = in_dat, ...))\n",
    "        vif_vals<-rbind(vif_vals,c(val,vif_add))\n",
    "      }\n",
    "      max_row<-which(vif_vals[,2] == max(as.numeric(vif_vals[,2]), na.rm = TRUE))[1]\n",
    "      \n",
    "      vif_max<-as.numeric(vif_vals[max_row,2])\n",
    "      \n",
    "      if(vif_max<thresh) break\n",
    "      \n",
    "      if(trace==T){ #print output of each iteration\n",
    "        prmatrix(vif_vals,collab=c('var','vif'),rowlab=rep('',nrow(vif_vals)),quote=F)\n",
    "        cat('\\n')\n",
    "        cat('removed: ',vif_vals[max_row,1],vif_max,'\\n\\n')\n",
    "        flush.console()\n",
    "      }\n",
    "      \n",
    "      in_dat<-in_dat[,!names(in_dat) %in% vif_vals[max_row,1]]\n",
    "      \n",
    "    }\n",
    "    \n",
    "    return(names(in_dat))\n",
    "    \n",
    "  }\n",
    "  \n",
    "}"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 21,
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      " var      vif             \n",
      " naffairs 1.18599250439301\n",
      " vryunhap 1.07613498901296\n",
      " unhap    1.31157891879919\n",
      " avgmarr  1.20497695526068\n",
      " hapavg   1.28517524736619\n",
      " antirel  1.10670922646449\n",
      " notrel   1.19172534098914\n",
      " slghtrel 1.16706413648418\n",
      " yrsmarr1 1.02946794669083\n",
      "\n",
      "All variables have VIF < 5, max VIF 1.31 \n",
      "\n"
     ]
    }
   ],
   "source": [
    "col<- vif_func(in_frame=train,thresh=5,trace=T)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Let's stop building the model since VFI is less than 5 for all remaining features."
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "### Predictions on train set"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 22,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table>\n",
       "<caption>A data.frame: 6 × 1</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>naffairs</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>0</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>0</td></tr>\n",
       "\t<tr><th scope=row>7</th><td>0</td></tr>\n",
       "\t<tr><th scope=row>9</th><td>1</td></tr>\n",
       "\t<tr><th scope=row>10</th><td>0</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 1\n",
       "\\begin{tabular}{r|l}\n",
       "  & naffairs\\\\\n",
       "  & <dbl>\\\\\n",
       "\\hline\n",
       "\t1 & 0\\\\\n",
       "\t3 & 1\\\\\n",
       "\t6 & 0\\\\\n",
       "\t7 & 0\\\\\n",
       "\t9 & 1\\\\\n",
       "\t10 & 0\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 1\n",
       "\n",
       "| <!--/--> | naffairs &lt;dbl&gt; |\n",
       "|---|---|\n",
       "| 1 | 0 |\n",
       "| 3 | 1 |\n",
       "| 6 | 0 |\n",
       "| 7 | 0 |\n",
       "| 9 | 1 |\n",
       "| 10 | 0 |\n",
       "\n"
      ],
      "text/plain": [
       "   naffairs\n",
       "1  0       \n",
       "3  1       \n",
       "6  0       \n",
       "7  0       \n",
       "9  1       \n",
       "10 0       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "train_pred <- train[, c(\"naffairs\"), drop=FALSE]\n",
    "head(train_pred)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 23,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table>\n",
       "<caption>A data.frame: 6 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>naffairs</th><th scope=col>prob</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>0</td><td>0.29145399</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1</td><td>0.29145399</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>0</td><td>0.03880111</td></tr>\n",
       "\t<tr><th scope=row>7</th><td>0</td><td>0.03696020</td></tr>\n",
       "\t<tr><th scope=row>9</th><td>1</td><td>0.36249359</td></tr>\n",
       "\t<tr><th scope=row>10</th><td>0</td><td>0.03696020</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 2\n",
       "\\begin{tabular}{r|ll}\n",
       "  & naffairs & prob\\\\\n",
       "  & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t1 & 0 & 0.29145399\\\\\n",
       "\t3 & 1 & 0.29145399\\\\\n",
       "\t6 & 0 & 0.03880111\\\\\n",
       "\t7 & 0 & 0.03696020\\\\\n",
       "\t9 & 1 & 0.36249359\\\\\n",
       "\t10 & 0 & 0.03696020\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 2\n",
       "\n",
       "| <!--/--> | naffairs &lt;dbl&gt; | prob &lt;dbl&gt; |\n",
       "|---|---|---|\n",
       "| 1 | 0 | 0.29145399 |\n",
       "| 3 | 1 | 0.29145399 |\n",
       "| 6 | 0 | 0.03880111 |\n",
       "| 7 | 0 | 0.03696020 |\n",
       "| 9 | 1 | 0.36249359 |\n",
       "| 10 | 0 | 0.03696020 |\n",
       "\n"
      ],
      "text/plain": [
       "   naffairs prob      \n",
       "1  0        0.29145399\n",
       "3  1        0.29145399\n",
       "6  0        0.03880111\n",
       "7  0        0.03696020\n",
       "9  1        0.36249359\n",
       "10 0        0.03696020"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "train_pred$prob <- predict(logm5,train,type=\"response\")\n",
    "head(train_pred)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 24,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table>\n",
       "<caption>A data.frame: 6 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>naffairs</th><th scope=col>prob</th><th scope=col>pred_values</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>0</td><td>0.29145399</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1</td><td>0.29145399</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>0</td><td>0.03880111</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>7</th><td>0</td><td>0.03696020</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>9</th><td>1</td><td>0.36249359</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>10</th><td>0</td><td>0.03696020</td><td>0</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 3\n",
       "\\begin{tabular}{r|lll}\n",
       "  & naffairs & prob & pred\\_values\\\\\n",
       "  & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t1 & 0 & 0.29145399 & 0\\\\\n",
       "\t3 & 1 & 0.29145399 & 0\\\\\n",
       "\t6 & 0 & 0.03880111 & 0\\\\\n",
       "\t7 & 0 & 0.03696020 & 0\\\\\n",
       "\t9 & 1 & 0.36249359 & 0\\\\\n",
       "\t10 & 0 & 0.03696020 & 0\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 3\n",
       "\n",
       "| <!--/--> | naffairs &lt;dbl&gt; | prob &lt;dbl&gt; | pred_values &lt;dbl&gt; |\n",
       "|---|---|---|---|\n",
       "| 1 | 0 | 0.29145399 | 0 |\n",
       "| 3 | 1 | 0.29145399 | 0 |\n",
       "| 6 | 0 | 0.03880111 | 0 |\n",
       "| 7 | 0 | 0.03696020 | 0 |\n",
       "| 9 | 1 | 0.36249359 | 0 |\n",
       "| 10 | 0 | 0.03696020 | 0 |\n",
       "\n"
      ],
      "text/plain": [
       "   naffairs prob       pred_values\n",
       "1  0        0.29145399 0          \n",
       "3  1        0.29145399 0          \n",
       "6  0        0.03880111 0          \n",
       "7  0        0.03696020 0          \n",
       "9  1        0.36249359 0          \n",
       "10 0        0.03696020 0          "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "train_pred$pred_values <- ifelse(train_pred$prob>0.5,1,0)\n",
    "head(train_pred)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 25,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "\n",
       "  0   1 \n",
       "368  32 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "table(train_pred$pred_values)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "### Confusion Matrix"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 26,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "       \n",
       "          0   1\n",
       "  FALSE 308  60\n",
       "  TRUE   15  17"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "confusion<-table(train_pred$prob>0.5,train_pred$naffairs)\n",
    "confusion"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "### Finding the Accuracy"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 28,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "0.8125"
      ],
      "text/latex": [
       "0.8125"
      ],
      "text/markdown": [
       "0.8125"
      ],
      "text/plain": [
       "[1] 0.8125"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "Accuracy<-sum(diag(confusion)/sum(confusion))\n",
    "Accuracy "
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "### ROC Curve"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 30,
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Formal class 'performance' [package \"ROCR\"] with 6 slots\n",
      "  ..@ x.name      : chr \"False positive rate\"\n",
      "  ..@ y.name      : chr \"True positive rate\"\n",
      "  ..@ alpha.name  : chr \"Cutoff\"\n",
      "  ..@ x.values    :List of 1\n",
      "  .. ..$ : num [1:32] 0 0 0 0.031 0.0372 ...\n",
      "  ..@ y.values    :List of 1\n",
      "  .. ..$ : num [1:32] 0 0.013 0.026 0.117 0.208 ...\n",
      "  ..@ alpha.values:List of 1\n",
      "  .. ..$ : num [1:32] Inf 0.743 0.728 0.573 0.571 ...\n"
     ]
    },
    {
     "data": {
      "image/png": "iVBORw0KGgoAAAANSUhEUgAAA0gAAANICAYAAAD958/bAAAEGWlDQ1BrQ0dDb2xvclNwYWNl\nR2VuZXJpY1JHQgAAOI2NVV1oHFUUPrtzZyMkzlNsNIV0qD8NJQ2TVjShtLp/3d02bpZJNtoi\n6GT27s6Yyc44M7v9oU9FUHwx6psUxL+3gCAo9Q/bPrQvlQol2tQgKD60+INQ6Ium65k7M5lp\nurHeZe58853vnnvuuWfvBei5qliWkRQBFpquLRcy4nOHj4g9K5CEh6AXBqFXUR0rXalMAjZP\nC3e1W99Dwntf2dXd/p+tt0YdFSBxH2Kz5qgLiI8B8KdVy3YBevqRHz/qWh72Yui3MUDEL3q4\n4WPXw3M+fo1pZuQs4tOIBVVTaoiXEI/MxfhGDPsxsNZfoE1q66ro5aJim3XdoLFw72H+n23B\naIXzbcOnz5mfPoTvYVz7KzUl5+FRxEuqkp9G/Ajia219thzg25abkRE/BpDc3pqvphHvRFys\n2weqvp+krbWKIX7nhDbzLOItiM8358pTwdirqpPFnMF2xLc1WvLyOwTAibpbmvHHcvttU57y\n5+XqNZrLe3lE/Pq8eUj2fXKfOe3pfOjzhJYtB/yll5SDFcSDiH+hRkH25+L+sdxKEAMZahrl\nSX8ukqMOWy/jXW2m6M9LDBc31B9LFuv6gVKg/0Szi3KAr1kGq1GMjU/aLbnq6/lRxc4XfJ98\nhTargX++DbMJBSiYMIe9Ck1YAxFkKEAG3xbYaKmDDgYyFK0UGYpfoWYXG+fAPPI6tJnNwb7C\nlP7IyF+D+bjOtCpkhz6CFrIa/I6sFtNl8auFXGMTP34sNwI/JhkgEtmDz14ySfaRcTIBInmK\nPE32kxyyE2Tv+thKbEVePDfW/byMM1Kmm0XdObS7oGD/MypMXFPXrCwOtoYjyyn7BV29/MZf\nsVzpLDdRtuIZnbpXzvlf+ev8MvYr/Gqk4H/kV/G3csdazLuyTMPsbFhzd1UabQbjFvDRmcWJ\nxR3zcfHkVw9GfpbJmeev9F08WW8uDkaslwX6avlWGU6NRKz0g/SHtCy9J30o/ca9zX3Kfc19\nzn3BXQKRO8ud477hLnAfc1/G9mrzGlrfexZ5GLdn6ZZrrEohI2wVHhZywjbhUWEy8icMCGNC\nUdiBlq3r+xafL549HQ5jH+an+1y+LlYBifuxAvRN/lVVVOlwlCkdVm9NOL5BE4wkQ2SMlDZU\n97hX86EilU/lUmkQUztTE6mx1EEPh7OmdqBtAvv8HdWpbrJS6tJj3n0CWdM6busNzRV3S9KT\nYhqvNiqWmuroiKgYhshMjmhTh9ptWhsF7970j/SbMrsPE1suR5z7DMC+P/Hs+y7ijrQAlhyA\ngccjbhjPygfeBTjzhNqy28EdkUh8C+DU9+z2v/oyeH791OncxHOs5y2AtTc7nb/f73TWPkD/\nqwBnjX8BoJ98VQNcC+8AAAA4ZVhJZk1NACoAAAAIAAGHaQAEAAAAAQAAABoAAAAAAAKgAgAE\nAAAAAQAAA0igAwAEAAAAAQAAA0gAAAAA3+vLGQAAQABJREFUeAHs3QecZFWZ9/FzbnX3dM8M\nE5kZZgYmAUqcIbkoklwEVyWKyCrCgMCQlDWsYXUXYQXXALLuShQkg6IghlddRUUUMZIkCkxi\nAkOYHDvUff9PddVMdXVVd1d3hXtv/c7Hh666VXXvOd9qe+qpk5yjIIAAAggggAACCCCAAAII\nIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAAC\nCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAA\nAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCA\nAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggg\ngAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAII\nIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAAC\nCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAA\nAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCA\nAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggg\ngAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAII\nIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAAC\nCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAA\nAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCA\nAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggg\ngAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAII\nIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAAC\nCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAA\nAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCA\nAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggg\ngAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAII\nIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAAC\nCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAA\nAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCA\nAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggg\ngAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAII\nIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAAC\nCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAA\n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\ngAACCCCAAAIIIIAAArUEaCDV0uE1BBBAAAEEEEAAAQQQSJUADaRUVTeFRQABBBBAAAEEEEAA\ngVoCNJBq6fAaAggggAACCCCAAAIIpEqABlKqqpvCIoAAAggggAACCCCAQC0BGki1dHgNAQQQ\nQAABBBBAAAEEUiWQxmm+o1zBtshWp1N/py/A+RFAAAEEEEAAAQQiJTDa4dx04zNsh4vw1Olp\nID1l0cut4Jd2Wy8zwbURQAABBBBAAAEEEGhBYKSF90bmrV5kckJGjhdBp3t3LtU1piuWK0jp\nE7igWOTl6Ss6JZbABUWF5cVHHtIlcEGxuMvTVWxKWxS4oPi4vPjIQ7oELlBxtysuVXQyWePo\nD528QLfOTQ9St6TrX+f39Q9p+Yi1xTN8puUzcYI4CjyX+o9jtbUtz9R/2yhjeSLqP5bV1rZM\nU/9to4zliYL6vzWWue9BppmkoQfoXBIBBBBAAAEEEEAAAQSiKUADKZr1Qq4QQAABBBBAAAEE\nEECgBwI0kHqAziURQAABBBBAAAEEEEAgmgI0kKJZL+QKAQQQQAABBBBAAAEEeiBAA6kH6FwS\nAQQQQAABBBBAAAEEoilAAyma9UKuEEAAAQQQQAABBBBAoAcCNJB6gM4lEUAAAQQQQAABBBBA\nIJoCNJCiWS/kCgEEEEAAAQQQQAABBHogQAOpB+hcEgEEEEAAAQQQQAABBKIp0BfNbJGrDgmM\ndOi8nDYeAtR/POqpU7mk/jslG4/zUv/xqKdO5ZL675RsPM5L/cejnshljwRm67oWpHQKUP/p\nrPeg1NR/IJHOR+o/nfUelJr6DyTS+Uj9p7PeKTUCCCCAAAIIIIAAAggggAACCCCAAAIIIIAA\nAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCA\nAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggg\ngAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAII\nIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAAC\ncRDIxiGT5LGugNXjSYoTFGOKTYpm0356w6kKe9ygGFWQ4iHQjvo/SEW136EjikXeGI+ik0sJ\n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\n0rRET+yP547Sndp+fXG/zVhjDSr7R/M2hXXhH6sgRVeg1fr/ZxXNfifsA5INswiLN2s/KZoC\nrdZ/WKloIIWpRHNfO+r/fBXNehLsvyNvUbxIca3C/l34oIIUXYFW699T0Wz0gNX1txSvVbxY\n8VmF7btFQQ+SEGKSajWQ+PwXk0okm+0VsOF131fYf+TsHzUL+0dvgaI0VfsDsWNses9NiuD9\ntv0mBSn6Aq3Uv/UQBnVe7fHj0SdIdQ5bqf8wOBpIYSrR3deO+n+JiveIIvg3YI22/11hH6BJ\n0RZotf6nqXjWEB5WBPU/ou1PKWwkCSk+Ai9XVq0Ow3qQ+PwXn3okpx0QsFmpbDhEZcOo0UvZ\nfwwPVhypGGz0TRwXGYFW6z8yBSEjkxKg/ifFlpg3taP+7b8dhyVGJF0FabX++4p1f4Qe+9NF\nR2klwOc/fg0QQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQ\nQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEE\nEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAAB\nBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAA\nAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBA\nAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQ\nQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEE\nEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAAB\nBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAA\nAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAIEUCngpLDNFRgABBOIq\ncIYyPr1O5p/U6zfVOSbs5edo53zFtxS5sAMSvG8vle10xcOKO2qUs9HjapyClxBAAAEEEEAA\n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\ngzrSPkQPNfCOqTpmQ/H4y/VojZTXKmwigx0K+1AcNCS0OWGa79O0zxolqxRXKF6seLfCehts\nSNazFEH6vDYsX79U2DWsoXCNwvbdoKiX7B4kO9aGq31KYQ0ga8Q9rnhMsVARJGtk2DAzuzfq\nEsULFW9X2Mx2FtaoClKjZbBGil3frh2k52vD9lkP2b8pnqYIO067x9P5+mnHW7xlfE/5j0P1\n1Mwt/klhwxT/QWGeY4rKBp92lSUrt537I2V7CxNXNFPPzy+ep7RcdspW82fnICGAAAIIIIAA\nAggg0FWBZhpIlrGTFcF77MO1fRD/tmJx8dEaQPsqLN2osGOm2JNissbOSoXtt7AGzD2KExWl\nyUYjvFNhjZbSY20a8QWKeiloIL1BB65T2DmGFT9SLFFUpqXa8XtFcC3rzfqx4lhFZWqkDGEN\nnz6d6CuKUYVd5y8VYcdp93iapp82zNAaQDa0MCwdpp3WW2TuQd6tAXq+ol6q1kCy9zVTz2Hl\nCq7dSv6Cc/CIAAIIIIAAAggggECkBazxslhhDY0hRbPJ3r+fwhofMxp48/46xnpxGjk2ON31\n2rAGwxyFp7DejGDCBW1WTXaNJQq7f6lWarYMpeeyBuM+pTvasG29e8coDlBUDkuc7Ombreda\n5epE/iZbLt6HAAIIIIAAAggggEDqBEobSKkrPAVGAAEEEIiWgH3jREIAAQQQQAABBBBAAAEE\nEJAADSR+DRBAAAEEei1g9/nYxAs2zI6EAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCA\nAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggg\ngAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAII\nIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAAC\nCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAA\nAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCA\nAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggg\ngAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAII\nIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggMBkBf4/J4qsf5IYLdAAAAAA\nSUVORK5CYII=",
      "text/plain": [
       "plot without title"
      ]
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      },
      "text/plain": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "library(ROCR)\n",
    "rocrpred<-prediction(train_pred$prob,train_pred$naffairs)\n",
    "rocrperf<-performance(rocrpred,'tpr','fpr')\n",
    "\n",
    "str(rocrperf)\n",
    "\n",
    "plot(rocrperf,colorize=T,text.adj=c(-0.2,1.7))"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "### Area Under the Curve"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 31,
   "metadata": {},
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Type 'citation(\"pROC\")' for a citation.\n",
      "\n",
      "\n",
      "Attaching package: ‘pROC’\n",
      "\n",
      "\n",
      "The following object is masked from ‘package:fmsb’:\n",
      "\n",
      "    roc\n",
      "\n",
      "\n",
      "The following objects are masked from ‘package:stats’:\n",
      "\n",
      "    cov, smooth, var\n",
      "\n",
      "\n",
      "Setting levels: control = 0, case = 1\n",
      "\n",
      "Setting direction: controls < cases\n",
      "\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "0.787262273330385"
      ],
      "text/latex": [
       "0.787262273330385"
      ],
      "text/markdown": [
       "0.787262273330385"
      ],
      "text/plain": [
       "Area under the curve: 0.7873"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "library(pROC)\n",
    "roccurve=roc(train_pred$naffairs, train_pred$prob) #real outcome and predicted score is plotted\n",
    "auc(roccurve)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "### Finding the optimal cut-off using Precision and Recall"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 32,
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Formal class 'performance' [package \"ROCR\"] with 6 slots\n",
      "  ..@ x.name      : chr \"False positive rate\"\n",
      "  ..@ y.name      : chr \"True positive rate\"\n",
      "  ..@ alpha.name  : chr \"Cutoff\"\n",
      "  ..@ x.values    :List of 1\n",
      "  .. ..$ : num [1:32] 0 0 0 0.031 0.0372 ...\n",
      "  ..@ y.values    :List of 1\n",
      "  .. ..$ : num [1:32] 0 0.013 0.026 0.117 0.208 ...\n",
      "  ..@ alpha.values:List of 1\n",
      "  .. ..$ : num [1:32] Inf 0.743 0.728 0.573 0.571 ...\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<table>\n",
       "<caption>A data.frame: 6 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>cut_off</th><th scope=col>FPR</th><th scope=col>TPR</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>      Inf</td><td>0.00000000</td><td>0.00000000</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>0.7434059</td><td>0.00000000</td><td>0.01298701</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>0.7276806</td><td>0.00000000</td><td>0.02597403</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>0.5728468</td><td>0.03095975</td><td>0.11688312</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>0.5710469</td><td>0.03715170</td><td>0.20779221</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>0.5529545</td><td>0.04334365</td><td>0.20779221</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 3\n",
       "\\begin{tabular}{r|lll}\n",
       "  & cut\\_off & FPR & TPR\\\\\n",
       "  & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t1 &       Inf & 0.00000000 & 0.00000000\\\\\n",
       "\t2 & 0.7434059 & 0.00000000 & 0.01298701\\\\\n",
       "\t3 & 0.7276806 & 0.00000000 & 0.02597403\\\\\n",
       "\t4 & 0.5728468 & 0.03095975 & 0.11688312\\\\\n",
       "\t5 & 0.5710469 & 0.03715170 & 0.20779221\\\\\n",
       "\t6 & 0.5529545 & 0.04334365 & 0.20779221\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 3\n",
       "\n",
       "| <!--/--> | cut_off &lt;dbl&gt; | FPR &lt;dbl&gt; | TPR &lt;dbl&gt; |\n",
       "|---|---|---|---|\n",
       "| 1 |       Inf | 0.00000000 | 0.00000000 |\n",
       "| 2 | 0.7434059 | 0.00000000 | 0.01298701 |\n",
       "| 3 | 0.7276806 | 0.00000000 | 0.02597403 |\n",
       "| 4 | 0.5728468 | 0.03095975 | 0.11688312 |\n",
       "| 5 | 0.5710469 | 0.03715170 | 0.20779221 |\n",
       "| 6 | 0.5529545 | 0.04334365 | 0.20779221 |\n",
       "\n"
      ],
      "text/plain": [
       "  cut_off   FPR        TPR       \n",
       "1       Inf 0.00000000 0.00000000\n",
       "2 0.7434059 0.00000000 0.01298701\n",
       "3 0.7276806 0.00000000 0.02597403\n",
       "4 0.5728468 0.03095975 0.11688312\n",
       "5 0.5710469 0.03715170 0.20779221\n",
       "6 0.5529545 0.04334365 0.20779221"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "str(rocrperf)\n",
    "rocr_cutoff <- data.frame(cut_off = rocrperf@alpha.values[[1]],fpr=rocrperf@x.values,tpr=rocrperf@y.values)\n",
    "colnames(rocr_cutoff) <- c(\"cut_off\",\"FPR\",\"TPR\")\n",
    "head(rocr_cutoff)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 33,
   "metadata": {},
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\n",
      "Attaching package: ‘dplyr’\n",
      "\n",
      "\n",
      "The following objects are masked from ‘package:stats’:\n",
      "\n",
      "    filter, lag\n",
      "\n",
      "\n",
      "The following objects are masked from ‘package:base’:\n",
      "\n",
      "    intersect, setdiff, setequal, union\n",
      "\n",
      "\n"
     ]
    }
   ],
   "source": [
    "library(dplyr)\n",
    "rocr_cutoff$cut_off <- round(rocr_cutoff$cut_off,6)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 34,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table>\n",
       "<caption>A data.frame: 6 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>cut_off</th><th scope=col>FPR</th><th scope=col>TPR</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>0.036960</td><td>0.9226006</td><td>1</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>0.022192</td><td>0.9256966</td><td>1</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>0.019018</td><td>0.9473684</td><td>1</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>0.016012</td><td>0.9504644</td><td>1</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>0.010396</td><td>0.9628483</td><td>1</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>0.010321</td><td>0.9783282</td><td>1</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 3\n",
       "\\begin{tabular}{r|lll}\n",
       "  & cut\\_off & FPR & TPR\\\\\n",
       "  & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t1 & 0.036960 & 0.9226006 & 1\\\\\n",
       "\t2 & 0.022192 & 0.9256966 & 1\\\\\n",
       "\t3 & 0.019018 & 0.9473684 & 1\\\\\n",
       "\t4 & 0.016012 & 0.9504644 & 1\\\\\n",
       "\t5 & 0.010396 & 0.9628483 & 1\\\\\n",
       "\t6 & 0.010321 & 0.9783282 & 1\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 3\n",
       "\n",
       "| <!--/--> | cut_off &lt;dbl&gt; | FPR &lt;dbl&gt; | TPR &lt;dbl&gt; |\n",
       "|---|---|---|---|\n",
       "| 1 | 0.036960 | 0.9226006 | 1 |\n",
       "| 2 | 0.022192 | 0.9256966 | 1 |\n",
       "| 3 | 0.019018 | 0.9473684 | 1 |\n",
       "| 4 | 0.016012 | 0.9504644 | 1 |\n",
       "| 5 | 0.010396 | 0.9628483 | 1 |\n",
       "| 6 | 0.010321 | 0.9783282 | 1 |\n",
       "\n"
      ],
      "text/plain": [
       "  cut_off  FPR       TPR\n",
       "1 0.036960 0.9226006 1  \n",
       "2 0.022192 0.9256966 1  \n",
       "3 0.019018 0.9473684 1  \n",
       "4 0.016012 0.9504644 1  \n",
       "5 0.010396 0.9628483 1  \n",
       "6 0.010321 0.9783282 1  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Sorting data frame with respect to tpr in decreasing order \n",
    "rocr_cutoff <- arrange(rocr_cutoff,desc(TPR))\n",
    "head(rocr_cutoff)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 35,
   "metadata": {},
   "outputs": [],
   "source": [
    "# Get the cutoff for the best accuracy\n",
    "cutoff_data=data.frame(cutoff=0,TP=0,FP=0,FN=0,TN=0)\n",
    "cutoffs=seq(0,1,length=100)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 36,
   "metadata": {},
   "outputs": [],
   "source": [
    "\n",
    "for (i in cutoffs){\n",
    "  predicted=as.numeric(train_pred$prob>i)\n",
    "  \n",
    "  TP=sum(predicted==1 & train_pred$naffairs==1)\n",
    "  FP=sum(predicted==1 & train_pred$naffairs==0)\n",
    "  FN=sum(predicted==0 & train_pred$naffairs==1)\n",
    "  TN=sum(predicted==0 & train_pred$naffairs==0)\n",
    "  cutoff_data=rbind(cutoff_data,c(i,TP,FP,FN,TN))\n",
    "}"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 37,
   "metadata": {},
   "outputs": [],
   "source": [
    "# lets remove the dummy data cotaining top row in data frame cutoff_data\n",
    "cutoff_data=cutoff_data[-1,]"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 38,
   "metadata": {},
   "outputs": [],
   "source": [
    "#Let's calculate Sensitivity, Specificity, Precision and Recall\n",
    "\n",
    "cutoff_data=cutoff_data %>%\n",
    "  mutate(P=FN+TP,N=TN+FP, #total positives and negatives\n",
    "         Sn=TP/P, #sensitivity\n",
    "         Sp=TN/N, #specificity\n",
    "         KS=abs((TP/P)-(FP/N)),\n",
    "         Accuracy=(TP+TN)/(P+N),\n",
    "         Lift=(TP/P)/((TP+FP)/(P+N)),\n",
    "         Precision=TP/(TP+FP), #Precision\n",
    "         Recall=TP/P #Recall\n",
    "  ) %>% \n",
    "  select(-P,-N)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 39,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "0.151515151515152"
      ],
      "text/latex": [
       "0.151515151515152"
      ],
      "text/markdown": [
       "0.151515151515152"
      ],
      "text/plain": [
       "[1] 0.1515152"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "#Finding the cutoff\n",
    "\n",
    "KS_cutoff=cutoff_data$cutoff[which.max(cutoff_data$KS)]\n",
    "KS_cutoff"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "### Predict on test data using Optimal Cut-Off"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 40,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table>\n",
       "<caption>A data.frame: 6 × 1</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>naffairs</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>2</th><td>0</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>0</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1</td></tr>\n",
       "\t<tr><th scope=row>8</th><td>0</td></tr>\n",
       "\t<tr><th scope=row>11</th><td>0</td></tr>\n",
       "\t<tr><th scope=row>16</th><td>0</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 1\n",
       "\\begin{tabular}{r|l}\n",
       "  & naffairs\\\\\n",
       "  & <dbl>\\\\\n",
       "\\hline\n",
       "\t2 & 0\\\\\n",
       "\t4 & 0\\\\\n",
       "\t5 & 1\\\\\n",
       "\t8 & 0\\\\\n",
       "\t11 & 0\\\\\n",
       "\t16 & 0\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 1\n",
       "\n",
       "| <!--/--> | naffairs &lt;dbl&gt; |\n",
       "|---|---|\n",
       "| 2 | 0 |\n",
       "| 4 | 0 |\n",
       "| 5 | 1 |\n",
       "| 8 | 0 |\n",
       "| 11 | 0 |\n",
       "| 16 | 0 |\n",
       "\n"
      ],
      "text/plain": [
       "   naffairs\n",
       "2  0       \n",
       "4  0       \n",
       "5  1       \n",
       "8  0       \n",
       "11 0       \n",
       "16 0       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "test_pred <- test[, c(\"naffairs\"), drop=FALSE]\n",
    "head(test_pred)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 41,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table>\n",
       "<caption>A data.frame: 6 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>naffairs</th><th scope=col>prob</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>2</th><td>0</td><td>0.14943819</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>0</td><td>0.47235072</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1</td><td>0.08634904</td></tr>\n",
       "\t<tr><th scope=row>8</th><td>0</td><td>0.08693081</td></tr>\n",
       "\t<tr><th scope=row>11</th><td>0</td><td>0.29297454</td></tr>\n",
       "\t<tr><th scope=row>16</th><td>0</td><td>0.14943819</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 2\n",
       "\\begin{tabular}{r|ll}\n",
       "  & naffairs & prob\\\\\n",
       "  & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t2 & 0 & 0.14943819\\\\\n",
       "\t4 & 0 & 0.47235072\\\\\n",
       "\t5 & 1 & 0.08634904\\\\\n",
       "\t8 & 0 & 0.08693081\\\\\n",
       "\t11 & 0 & 0.29297454\\\\\n",
       "\t16 & 0 & 0.14943819\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 2\n",
       "\n",
       "| <!--/--> | naffairs &lt;dbl&gt; | prob &lt;dbl&gt; |\n",
       "|---|---|---|\n",
       "| 2 | 0 | 0.14943819 |\n",
       "| 4 | 0 | 0.47235072 |\n",
       "| 5 | 1 | 0.08634904 |\n",
       "| 8 | 0 | 0.08693081 |\n",
       "| 11 | 0 | 0.29297454 |\n",
       "| 16 | 0 | 0.14943819 |\n",
       "\n"
      ],
      "text/plain": [
       "   naffairs prob      \n",
       "2  0        0.14943819\n",
       "4  0        0.47235072\n",
       "5  1        0.08634904\n",
       "8  0        0.08693081\n",
       "11 0        0.29297454\n",
       "16 0        0.14943819"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "test_pred$prob <- predict(logm5,test,type=\"response\")\n",
    "head(test_pred)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 42,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table>\n",
       "<caption>A data.frame: 6 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>naffairs</th><th scope=col>prob</th><th scope=col>pred_values</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>2</th><td>0</td><td>0.14943819</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>0</td><td>0.47235072</td><td>1</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1</td><td>0.08634904</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>8</th><td>0</td><td>0.08693081</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>11</th><td>0</td><td>0.29297454</td><td>1</td></tr>\n",
       "\t<tr><th scope=row>16</th><td>0</td><td>0.14943819</td><td>0</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 3\n",
       "\\begin{tabular}{r|lll}\n",
       "  & naffairs & prob & pred\\_values\\\\\n",
       "  & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t2 & 0 & 0.14943819 & 0\\\\\n",
       "\t4 & 0 & 0.47235072 & 1\\\\\n",
       "\t5 & 1 & 0.08634904 & 0\\\\\n",
       "\t8 & 0 & 0.08693081 & 0\\\\\n",
       "\t11 & 0 & 0.29297454 & 1\\\\\n",
       "\t16 & 0 & 0.14943819 & 0\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 3\n",
       "\n",
       "| <!--/--> | naffairs &lt;dbl&gt; | prob &lt;dbl&gt; | pred_values &lt;dbl&gt; |\n",
       "|---|---|---|---|\n",
       "| 2 | 0 | 0.14943819 | 0 |\n",
       "| 4 | 0 | 0.47235072 | 1 |\n",
       "| 5 | 1 | 0.08634904 | 0 |\n",
       "| 8 | 0 | 0.08693081 | 0 |\n",
       "| 11 | 0 | 0.29297454 | 1 |\n",
       "| 16 | 0 | 0.14943819 | 0 |\n",
       "\n"
      ],
      "text/plain": [
       "   naffairs prob       pred_values\n",
       "2  0        0.14943819 0          \n",
       "4  0        0.47235072 1          \n",
       "5  1        0.08634904 0          \n",
       "8  0        0.08693081 0          \n",
       "11 0        0.29297454 1          \n",
       "16 0        0.14943819 0          "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "test_pred$pred_values <- ifelse(test_pred$prob>0.15152,1,0)\n",
    "head(test_pred)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 44,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "\n",
       "  0   1 \n",
       "116  85 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "table(test_pred$pred_values)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "### Confusion Matrix"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 46,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "       \n",
       "          0   1\n",
       "  FALSE 102  14\n",
       "  TRUE   60  25"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "confusion<-table(test_pred$prob>0.15152,test_pred$naffairs)\n",
    "confusion"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "### Finding the Accuracy"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 47,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "0.631840796019901"
      ],
      "text/latex": [
       "0.631840796019901"
      ],
      "text/markdown": [
       "0.631840796019901"
      ],
      "text/plain": [
       "[1] 0.6318408"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "Accuracy<-sum(diag(confusion)/sum(confusion))\n",
    "Accuracy"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "### ROC Curve with optimal cut-off"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 49,
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Formal class 'performance' [package \"ROCR\"] with 6 slots\n",
      "  ..@ x.name      : chr \"False positive rate\"\n",
      "  ..@ y.name      : chr \"True positive rate\"\n",
      "  ..@ alpha.name  : chr \"Cutoff\"\n",
      "  ..@ x.values    :List of 1\n",
      "  .. ..$ : num [1:25] 0 0 0.0247 0.0556 0.0679 ...\n",
      "  ..@ y.values    :List of 1\n",
      "  .. ..$ : num [1:25] 0 0.0513 0.1026 0.1538 0.1795 ...\n",
      "  ..@ alpha.values:List of 1\n",
      "  .. ..$ : num [1:25] Inf 0.743 0.573 0.571 0.553 ...\n"
     ]
    },
    {
     "data": {
      "image/png": "iVBORw0KGgoAAAANSUhEUgAAA0gAAANICAYAAAD958/bAAAEGWlDQ1BrQ0dDb2xvclNwYWNl\nR2VuZXJpY1JHQgAAOI2NVV1oHFUUPrtzZyMkzlNsNIV0qD8NJQ2TVjShtLp/3d02bpZJNtoi\n6GT27s6Yyc44M7v9oU9FUHwx6psUxL+3gCAo9Q/bPrQvlQol2tQgKD60+INQ6Ium65k7M5lp\nurHeZe58853vnnvuuWfvBei5qliWkRQBFpquLRcy4nOHj4g9K5CEh6AXBqFXUR0rXalMAjZP\nC3e1W99Dwntf2dXd/p+tt0YdFSBxH2Kz5qgLiI8B8KdVy3YBevqRHz/qWh72Yui3MUDEL3q4\n4WPXw3M+fo1pZuQs4tOIBVVTaoiXEI/MxfhGDPsxsNZfoE1q66ro5aJim3XdoLFw72H+n23B\naIXzbcOnz5mfPoTvYVz7KzUl5+FRxEuqkp9G/Ajia219thzg25abkRE/BpDc3pqvphHvRFys\n2weqvp+krbWKIX7nhDbzLOItiM8358pTwdirqpPFnMF2xLc1WvLyOwTAibpbmvHHcvttU57y\n5+XqNZrLe3lE/Pq8eUj2fXKfOe3pfOjzhJYtB/yll5SDFcSDiH+hRkH25+L+sdxKEAMZahrl\nSX8ukqMOWy/jXW2m6M9LDBc31B9LFuv6gVKg/0Szi3KAr1kGq1GMjU/aLbnq6/lRxc4XfJ98\nhTargX++DbMJBSiYMIe9Ck1YAxFkKEAG3xbYaKmDDgYyFK0UGYpfoWYXG+fAPPI6tJnNwb7C\nlP7IyF+D+bjOtCpkhz6CFrIa/I6sFtNl8auFXGMTP34sNwI/JhkgEtmDz14ySfaRcTIBInmK\nPE32kxyyE2Tv+thKbEVePDfW/byMM1Kmm0XdObS7oGD/MypMXFPXrCwOtoYjyyn7BV29/MZf\nsVzpLDdRtuIZnbpXzvlf+ev8MvYr/Gqk4H/kV/G3csdazLuyTMPsbFhzd1UabQbjFvDRmcWJ\nxR3zcfHkVw9GfpbJmeev9F08WW8uDkaslwX6avlWGU6NRKz0g/SHtCy9J30o/ca9zX3Kfc19\nzn3BXQKRO8ud477hLnAfc1/G9mrzGlrfexZ5GLdn6ZZrrEohI2wVHhZywjbhUWEy8icMCGNC\nUdiBlq3r+xafL549HQ5jH+an+1y+LlYBifuxAvRN/lVVVOlwlCkdVm9NOL5BE4wkQ2SMlDZU\n97hX86EilU/lUmkQUztTE6mx1EEPh7OmdqBtAvv8HdWpbrJS6tJj3n0CWdM6busNzRV3S9KT\nYhqvNiqWmuroiKgYhshMjmhTh9ptWhsF7970j/SbMrsPE1suR5z7DMC+P/Hs+y7ijrQAlhyA\ngccjbhjPygfeBTjzhNqy28EdkUh8C+DU9+z2v/oyeH791OncxHOs5y2AtTc7nb/f73TWPkD/\nqwBnjX8BoJ98VQNcC+8AAAA4ZVhJZk1NACoAAAAIAAGHaQAEAAAAAQAAABoAAAAAAAKgAgAE\nAAAAAQAAA0igAwAEAAAAAQAAA0gAAAAA3+vLGQAAQABJREFUeAHs3QmcnEWd//Gqp+cKuQm5\nucEDCQQUREFAFkQRCaCCf3EBkcML8FxddVdRYdeVS5ErgHKIqCgIosgqKHIuckNAEUg4kpAE\nQhKSkGSOrv/319MNPT3dM9MzfT1Pf+rlj55++unnqXo/Y6Z/XfVUOUdBAAEEEEAAAQQQQAAB\nBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAA\nAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBA\nAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQ\nQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEE\nEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAAB\nBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAA\nAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBA\nAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQ\nQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEE\nEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAAB\nBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAA\nAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBA\nAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQ\nQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEE\nEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAAB\nBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAA\nAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBA\nAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQ\nQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEE\nEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAAB\nBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAA\nAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBA\nAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQ\nQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEE\nEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAAB\nBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAA\nAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBA\n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\nBBBAAAEEEIimAA2kaNYLuUIAAQQQQAABBBBAAIE2CNBAagM6l0QAAQQQQAABBBBAAIFoCnRF\nM1vkqkkCg006L6eNhwD1H496alYuqf9mycbjvNR/POqpWbmk/pslG4/zUv/xqCdy2SaBabqu\nBakzBaj/zqz3oNTUfyDRmY/Uf2fWe1Bq6j+Q6MxH6r8z651SI4AAAggggAACCCCAAAIIIIAA\nAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCA\nAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggg\ngAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAII\nIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAAC\nCCCAAAIIIBAHgXQcMkkexxSwejxc8VTFsGK9otY0T294tsIeH1YMKUjxEGhE/e+totrP0P75\nIq+LR9HJpQQaUf+FkM/RkzmKFYU72Y6sQCPqv1ulO1DxDEWfYq3CV5CiL9CI+t9LxTxC8XjF\nDsUmBSl+Ai9Rlu3n4ZEas87nvxrBODweAvsqm/cr7D9mQdyn7T0V1abzdaA1iIL3D2v7nGrf\nzHFtFai3/mcr999VBHUfPP5C+6zRRIq2QL31X1q652uH/Qz8uPQFnkdSoBH1/0KVbIMi+N23\nx78o7NykaAvUW/8TVLwvKrKKoP5t+/OKXgUpPgKnKqtWh2fXmGU+/9UIxuHxEPCUzV8rNite\no9hHYb8k2xXLFZMUY6VjdYD9Ut2kWKywXqhbFbbvHQpSdAXqrf+UivZLhdX1NxXHK56tuFZh\n/5H8m4L/SAohoqne+i8t1kztWKOwnwcaSKU60XveiPo/QcWy3/W/Kl6qsP8GXKWwL8lsX7eC\nFE2BRtT/JSqa/b7/UGGfBY5W/EBh+y5TkOIh8GJlc1Bh9VZLA4nPf/GoX3I5DoHT9R77hXhL\nyXtPLbO/5DA3UTuWKlYqrFs2SD3asP0rFIX7g9d5jIZAvfX/bBXDfn5uDylO8B/JE0NeY1c0\nBOqt/9JS3KwdNrzWfiZoIJXqRO95I+r/zyqWfcG2b0nxvqnn9nNwZMl+nkZHoN76twaW1f0W\nxdSCYk3O7+/XY1fBfjajJzBdWbpeYb+rA/nHahtIfP4TGCm5An9U0eyXYteSIk7Rc/vjZv/x\nq5SO14v2i3VhyEFL8q+9IOQ1dkVDoN76f72KsVTx5pDivFL77GfjIyGvsSsaAvXWf2EpTtMT\nq28bw26P1otMirZAvfX/bBXP6vp9IcW0IdrWm7B7yGvsioZAvfW/i4phPYV3hhTHRqbYzwb1\nH4IToV32M2D1dKPidfntahtIx+eP5/OfIEjJEuhWcexmynvLFOsu7bcuVzuuXPqIXrBfrpeF\nHGBdtvaaHUOKnkAj6r9Sqc7Vi1b/NnSTFD2BRtb/vireVsUVChtSafVOA0kIEU6NqP93qXxW\n1wfly2m9CDZJgw21JEVboBH1byX8jcJ+BhbZk3x6nB4ziruDHTxGVuBK5eyYfO5epEery2ob\nSB/JH8/nvzxg6YPdg0CKp8BuyrYNhSs329h6vWZ/RCv9x26WXrcUdg57v6W5uQf+jZhAI+q/\nXJFm6IWzFJsVPyt3EPvbKtCo+rchNDcoVirOaWuJuHgtAo2o/3n5C27Q4y0K+5v/W4UNs/y2\nYrqCFE2BRtS/lextCrvX9A+K6xV2/6k1jJYqTlWQoi1g9Tfe/0bz+W+MurX/OJLiKTAln+1H\ny2Q/aOBUmqih0jmqeX+ZS7O7BQKV6s4uP976s5+X7yuskfRmxRoFKXoCjap/+xZxseLpiu0K\n60EiRV+gEfUffPlljSG719SGWW5VnKywb5VnK45Q2LfSpGgJNKL+rUT3Kb6iuEjxakWQPq2N\nO4InPCZSoNLP0Pp8iSt9fkwkSmGhaCAVasRreyCf3XK9gPYfPEvWVV4uVTpHNe8vd172N1+g\nUt3Z1cdTf9Yo+p7iMMVlCvs2kRRNgUbUvzWK3q/4mOLP0SwmuSoj0Ij6Dz4gWaP4IEVwzm9q\n2+5BeabiJIU9J0VLIKirev77byNQfqk4WPEuhfUkW3qV4kLFkYoXKLYpSMkTqPQzNJ7PD4kT\nKvfLlbiCJrBA9s2+fbM3rUzZgv2byrxuu1fnXwuOLTw02Ffp/YXHs91agUbUf2GOH6cnv1cc\nrliieKeCFF2Beut/sopmQ2ruVVyimFgQ2hxpYNs++xBFip5AvfVvJXooX6zP6TH4sJTf5b6R\n37C/B6ToCTSi/o9Ssax+P66wvwEP5+OzevyQ4tmK4xSkZArw+W+MeqWBNAZQhF8eVt7sD1rQ\nkCnNqu23ITMbS18oeF7NL8iqguPZjI5AI+o/KM0B2viNYoHiNMUHFaRoC9Rb/zasbqHCHu1L\nEPuW2GKdwtIxCntuw29I0ROot/6tRCvzxVobUryf5ffNDHmNXe0XaET9vzBfjO+GFOd/8/tO\nCHmNXckQ4PPfGPXIELsxgCL+8v3K3xEKGxpVeC+S/UftiQrrEag0xM7eb8m+KfrOyNbOf2yf\npT/lHvg3ggL11r8V6RDFjxXdChtO8RMFKR4C9dS//cfx8pBi2n8TTlc8qLhZcaeCFE2Beurf\nShT8/T9I28EH4qCkc/IbDL0MRKL3WG/92wLBlnbPPRT925N/Fgy1KnqRJ4kQCH7/+fyXiOqk\nEKUCL9MOX3FOyQvvy+//r5L9YU/v1U4bahGMR7djpiqsC/8uBY1oIUQ01Vv/fSrXUoUNr2Eo\nTUQruUK26q3/sFP3aqf9Tbk17EX2RUqg3vq3D8HWELZRAsGEDUEBv6UN+zmw+1NI0RSot/5P\nVLGsjq1xXDqa6OL8a6fqkRQPgRcpm1afZ9eQ3Xt1LJ//agDj0PgI2B+1vyusl+hjimMUF+Sf\n36THwrRIT+yX557Cndo+Ob/fZqyxBpX90bxTYV34BylI0RWot/4/qqLZz4R9QLJhFmHxZu0n\nRVOg3voPKxUNpDCVaO5rRP2/XkWzngT778hbFccpblDY34WLFKToCtRb/56KZqMHrK6/p3iF\n4nmKLyps3+0KepCEEJNUqYHE57+YVCLZbKyADa/7kcL+I2d/1Czsj95sRWEq9wtix9j0nusV\nwftt+00KUvQF6ql/6yEM6rzc46XRJ+joHNZT/2FwNJDCVKK7rxH1/3wVb7ki+BuwWtufUtgH\naFK0Beqt/0kqnjWEdyiC+h/U9ucUNpKEFB+BFymrVodhPUh8/otPPZLTJgjYrFQ2HKK0YVTt\npew/hvsonqSYUO2bOC4yAvXWf2QKQkbGJUD9j4stMW9qRP3bfzv2S4xIZxWk3vrvytf9/nrs\n7iw6SisBPv/xY4AAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAII\nIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAAC\nCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAA\nAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCA\nAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggg\ngAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAII\nIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAAC\nCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAA\nAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCA\nAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCHSggNeBZabICCCA\nQFwFjlXGdxkj8xv0+i/HOCbs5adr5yzF9xSZsAMSvG+yynaM4gHFPRXKWe1xFU7BSwgggAAC\nCCCAAAIIINAogX/rRP4Y8ZdxXuzW/Hn7xvn+OL/tSfmyf66gEN3afo/iFQX7wo4reDkWm2Hl\nikXGySQCCCDQKoGuVl2I6yCAAAIINEzgNJ1psMzZ1pXZz+7yAlv10g8Ufys45CRtf0rx5oJ9\nYccVvByLzbByxSLjZBIBBBBolQANpFZJcx0EEECgcQJf1akGGne6jj/Tcgm8sAqFao+r4lQc\nggACCCAQVQEaSFGtGfKFAAIINE7gGTrVgYp9FOsV/1LcrBirkWX3qT5P8TSF3fv0D8WvFPb+\n0mT/PXmBwq4zQXG34hZFv2KsdKQOsPufvqk4WvEshd1LZb06NqwwLNlwN7sna75iqeLXCrtm\naaqmDLvqTS9WWPn+qHhmPvTg7N6sYcV3FClF4XFH6rld3yw3KgrTRD05UbFC8YuCF/bV9nMU\nT1AsU/xSca9irDRdB1gj7ncKqws7912KHym2KSyNVc/lyrU59/aRf8ebv4JTsIkAAggggAAC\nCCCAQGsEgnuQequ83FQdd6PC7lvKKh7Jb9vzfyr2UATpVm3Y/uAepG5t24dv22cNhLX57R16\nfLuiMO2tJ9awsGM3KR7Nb/9dj4sUY6WbdIC95xJFkLcN+e1r9FiaPqMdlicr0+r8o00sYfsL\n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\nredK5WpG/sZbLt6HAAIIIIAAAggggEDHCRQ2kDqu8BQYAQQQQCBaAvaNEwkBBBBAAAEEEEAA\nAQQQQEACNJD4MUAAAQQQaLeA3edjEy/YMDsSAggggAACCCCAAAIIIIAAAggggAACCCCAAAII\nIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAAC\nCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAA\nAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCA\nAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggg\ngAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAII\nIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAAC\nCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAA\nAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAALjFfh/3a1OOo2raAwA\nAAAASUVORK5CYII=",
      "text/plain": [
       "plot without title"
      ]
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      },
      "text/plain": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "rocrpred<-prediction(test_pred$prob,test_pred$naffairs)\n",
    "rocrperf<-performance(rocrpred,'tpr','fpr')\n",
    "\n",
    "str(rocrperf)\n",
    "\n",
    "plot(rocrperf,colorize=T,text.adj=c(-0.2,1.7))"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "### Area Under the curve"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 51,
   "metadata": {},
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Setting levels: control = 0, case = 1\n",
      "\n",
      "Setting direction: controls < cases\n",
      "\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "0.665163026274137"
      ],
      "text/latex": [
       "0.665163026274137"
      ],
      "text/markdown": [
       "0.665163026274137"
      ],
      "text/plain": [
       "Area under the curve: 0.6652"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "roccurve=roc(test_pred$naffairs, test_pred$prob) #real outcome and predicted score is plotted\n",
    "auc(roccurve)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "### Conclusion"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Hence, the no. of married people who has extra marital affairs are predicted successfully using logistic regression model with an accuracy of 67% approximately."
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "R",
   "language": "R",
   "name": "ir"
  },
  "language_info": {
   "codemirror_mode": "r",
   "file_extension": ".r",
   "mimetype": "text/x-r-source",
   "name": "R",
   "pygments_lexer": "r",
   "version": "3.6.1"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 4
}
