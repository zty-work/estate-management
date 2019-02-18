# 设备支出总览，输入月份，返回维修总费用,默认2018年
def viewCost():
    tk = getTK()
    l1 = Tkinter.Label(tk, text="请输入查看月份：")
    l1.pack()
    rID_text = Tkinter.StringVar()
    rID = Tkinter.Entry(tk, textvariable=rID_text)
    rID_text.set("")
    rID.pack()

    def mClick():
        m = rID_text.get()
        cost = str(getTotalFCost(2018, m))
        tempString = str("2018年%s月维修设备总共花费了：%s " % (m, cost))
        tkMessageBox.showinfo(title='设备维修费用汇总', message=tempString)

    Tkinter.Button(tk, text="提交", command=mClick).pack()


# 设备状态总览，显示该月份每个设备保修次数
def viewF():
    tk = getTK()
    l1 = Tkinter.Label(tk, text="请输入查看月份：")
    l1.pack()
    rID_text = Tkinter.StringVar()
    rID = Tkinter.Entry(tk, textvariable=rID_text)
    rID_text.set("")
    rID.pack()

    def mClick():
        m = rID_text.get()
        times = str(getRF(2018, m))
        tempString = str("2018年%s月g各个设备报修次数：%s " % (m, times))
        tkMessageBox.showinfo(title='设备报修统计汇总', message=tempString)

    Tkinter.Button(tk, text="提交", command=mClick).pack()


# 投诉意见总览，显示该每户人家该月份报修次数
def viewC():
    tk = getTK()
    l1 = Tkinter.Label(tk, text="请输入查看月份：")
    l1.pack()
    rID_text = Tkinter.StringVar()
    rID = Tkinter.Entry(tk, textvariable=rID_text)
    rID_text.set("")
    rID.pack()

    def mClick():
        m = rID_text.get()
        times = str(getHouseComplain(2018, m))
        tempString = str("2018年%s月各个住户报修次数：%s " % (m, times))
        tkMessageBox.showinfo(title='住户报修统计汇总', message=tempString)

    Tkinter.Button(tk, text="提交", command=mClick).pack()


# xx年xx季度维修设备总费用
def getTotalFCost(year, month):
    checkSql = "SELECT SUM(chargesAmount) FROM charges WHERE community='" + community + "' AND chargesType='repair' AND YEAR(chargesDate)=" + str(
        year) + " AND MONTH(chargesDate)=" + month
    print(checkSql)
    cur.execute(checkSql)
    sum = cur.fetchone()
    return (str(sum[0]) + "元")


# 2018年xx月各个设备报修次数
def getRF(year, month):
    checkSql = "SELECT facilityID,COUNT(*)  FROM facility_complaint WHERE YEAR(facilityComplaintTime)=2018 AND MONTH(facilityComplaintTime)=" + month + " GROUP BY facilityID"
    print(checkSql)
    cur.execute(checkSql)
    rec = cur.fetchall()
    print(rec)
    allFSql = "SELECT facilityID FROM facility"
    cur.execute(allFSql)
    recF = cur.fetchall()
    tempS = ""
    for row in recF:
        flag = -1
        for i in range(0, len(rec)):
            if int(row[0]) == int(rec[i][0]):
                flag = i
                break
        if (flag == -1):
            tempS = tempS + "\n" + str(row[0]) + "号" + getFName(row[0]) + "报修了" + "0次"
        else:
            tempS = tempS + "\n" + str(row[0]) + "号" + getFName(row[0]) + "报修了" + str(rec[flag][1]) + "次"
    return tempS


def getFName(id):
    sql = "SELECT facilityName FROM facility WHERE facilityID=" + str(id)
    cur.execute(sql)
    rec = cur.fetchone()
    return rec[0]


# 2018年xx月每户投诉次数总结
def getHouseComplain(year, month):
    checkSql = "SELECT houseID,count(*) FROM facilityComplaintIncident WHERE facilityComplaintID IN (SELECT facilityComplaintID FROM facility_complaint WHERE YEAR(facilityComplaintTime)=2018 AND MONTH(facilityComplaintTime)=" + str(
        month) + ") GROUP BY houseID"
    print(checkSql)
    cur.execute(checkSql)
    rec = cur.fetchall()
    print(rec)
    allFSql = "SELECT houseID FROM house"
    cur.execute(allFSql)
    recF = cur.fetchall()
    tempS = ""
    for row in recF:
        flag = -1
        for i in range(0, len(rec)):
            if int(row[0]) == int(rec[i][0]):
                flag = i
                break
        if (flag == -1):
            tempS = tempS + "\n" + getHouseStr(row[0]) + "报修了" + "0次"
        else:
            tempS = tempS + "\n" + getHouseStr(row[0]) + "报修了" + str(rec[flag][1]) + "次"
    return tempS


# 根据小区、楼号、单元号、房间号查id
def getHouseId(houseString):
    nums = houseString.split(",", 2)
    building = nums[0]
    unit = nums[1]
    room = nums[2]
    checkSql = "SELECT houseID FROM house WHERE community='" + community + "'AND buildingNumber='" + building + "'AND unitNumber='" + unit + "'AND roomNumber='" + room + "'"
    print(checkSql)
    cur.execute(checkSql)
    id = cur.fetchone()
    return int(id[0])


# 根据id得到楼号、单元号、房间号
def getHouseStr(id):
    checkSql = "SELECT buildingNumber,unitNumber,roomNumber FROM house WHERE houseID=" + str(id)
    cur.execute(checkSql)
    rec = cur.fetchall()
    tmpStr = ""
    for row in rec:
        tmpStr = row[0] + "号" + row[1] + "单元" + row[2] + "室"
    return tmpStr
