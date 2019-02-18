# coding=utf-8
import MySQLdb
import csv
import sqlite3
import Tkinter
import tkMessageBox

conn = MySQLdb.connect(host="localhost", port=3306, user="root", passwd="123456", db="project1")
cur = conn.cursor()

global tempDate

tempDate = "2019-1-5"
community = "communityA"


def getTK():
    tk = Tkinter.Tk()
    header = "房屋管理系统"
    tk.title(header)
    tk.geometry('400x400')
    return tk


def get_Page1():
    tk = getTK()
    Tkinter.Button(tk, text="小区A", command=choose_communityA).pack()
    Tkinter.Button(tk, text="小区B", command=choose_communityB).pack()
    Tkinter.Button(tk, text="小区C", command=choose_communityC).pack()
    return tk


def get_Page2():
    tk = getTK()
    # Tkinter.Button(tk, text="停车管理问题",
    #               command=parking_choice).pack()  # grid(row=1,column=1)
    # Tkinter.Button(tk, text="房屋问题", command=house_choice).pack()  # grid(row=2,column=1)
    Tkinter.Button(tk, text="添加设备", command=addFacility).pack()
    Tkinter.Button(tk, text="设备检查", command=checkF).pack()
    Tkinter.Button(tk, text="设备投诉和破损设备处理", command=dealFacility).pack()
    Tkinter.Button(tk, text="设备投诉登记", command=comF).pack()
    Tkinter.Button(tk, text="设备状态总览", command=viewF).pack()
    Tkinter.Button(tk, text="设备支出总览", command=viewCost).pack()
    Tkinter.Button(tk, text="投诉意见登记", command=comC).pack()
    Tkinter.Button(tk, text="投诉意见处理", command=dealC).pack()
    Tkinter.Button(tk, text="投诉意见总览", command=viewC).pack()
    Tkinter.Button(tk, text="收支总览", command=viewFee).pack()
    display.destroy()
    return tk


def choose_communityA():
    global community
    community = "communityA"
    display = get_Page2()


def choose_communityB():
    global community
    community = "communityB"
    display = get_Page2()


def choose_communityC():
    global community
    community = "communityC"
    display = get_Page2()


# 显示2018年xx月收支
def viewFee():
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
        cost2 = str(getTotalFCost(2018, m))
        cost3 = str(getTotalLCost(2018, m))
        cost4 = str(getTotalPCost(2018, m))
        cost5 = str(getTotalMCost(2018, m))
        tempString = str("2018年%s月维修设备总共花费了：%s " % (m, cost)) + '\n' + str(
            "2018年%s月维修临时停车收入：%s " % (m, cost2)) + '\n' + str("2018年%s月租赁车位收入：%s " % (m, cost3)) + '\n' + str(
            "2018年%s月购买车位收入：%s " % (m, cost4)) + '\n' + str("2018年%s月物业费收入：%s " % (m, cost5))
        tkMessageBox.showinfo(title='设备维修费用汇总', message=tempString)

    Tkinter.Button(tk, text="提交", command=mClick).pack()


# 临时停车收入
def getTotalTCost():
    checkSql = "SELECT SUM(chargesAmount) FROM charges WHERE community='" + community + "' AND chargesType='temp_parking' AND YEAR(chargesDate)=" + str(
        year) + " AND MONTH(chargesDate)=" + month
    print(checkSql)
    cur.execute(checkSql)
    sum = cur.fetchone()
    return (str(sum[0]) + "元")


# 租赁停车收入
def getTotalLCost(year, month):
    checkSql = "SELECT SUM(chargesAmount) FROM charges WHERE community='" + community + "' AND chargesType='lease_parkingSpace' AND YEAR(chargesDate)=" + str(
        year) + " AND MONTH(chargesDate)=" + month
    print(checkSql)
    cur.execute(checkSql)
    sum = cur.fetchone()
    return (str(sum[0]) + "元")


# 购买车位收入
def getTotalPCost(year, month):
    checkSql = "SELECT SUM(chargesAmount) FROM charges WHERE community='" + community + "' AND chargesType='buy_parkingSpace' AND YEAR(chargesDate)=" + str(
        year) + " AND MONTH(chargesDate)=" + month
    print(checkSql)
    cur.execute(checkSql)
    sum = cur.fetchone()
    return (str(sum[0]) + "元")


# 物业费收入
def getTotalMCost(year, month):
    checkSql = "SELECT SUM(chargesAmount) FROM charges WHERE community='" + community + "' AND chargesType='proverityFee' AND YEAR(chargesDate)=" + str(
        year) + " AND MONTH(chargesDate)=" + month
    print(checkSql)
    cur.execute(checkSql)
    sum = cur.fetchone()
    return (str(sum[0]) + "元")


# 显示所有需要检查的设备
def showCheck():
    # fetchall
    sql = "SELECT facilityId,facilityName FROM facility WHERE DateDiff('" + tempDate + "',latestCheck)>30 AND (community='" + community + "')"
    print(sql)
    cur.execute(sql)
    rec = cur.fetchall()
    ids = []
    names = []
    for row in rec:
        ids.append(row[0])
        names.append(row[1])
    return ids, names


# 添加设备
def addFacility():
    tk = getTK()
    l1 = Tkinter.Label(tk, text="请输入设备名称：")
    l1.pack()
    facilityName_text = Tkinter.StringVar()
    facilityName = Tkinter.Entry(tk, textvariable=facilityName_text)
    facilityName_text.set("")
    facilityName.pack()

    def addFacilityClick():
        name = facilityName_text.get()
        insertNewFacility(name, "fine")
        tkMessageBox.showinfo(title='添加设备', message='添加成功')

    Tkinter.Button(tk, text="提交", command=addFacilityClick).pack()


# 设备检查
def checkF():
    tk = getTK()
    ll = Tkinter.Label(tk, text="设备编号、名称：")
    ll.pack()
    l = []
    ids, names = showCheck()
    for i in range(0, len(ids)):
        tempString = str(ids[i]) + names[i]
        l.append(Tkinter.Label(tk, text=tempString))
        l[i].pack()
    l1 = Tkinter.Label(tk, text="请输入检查设备编号：")
    l1.pack()
    facilityID_text = Tkinter.StringVar()
    facilityID = Tkinter.Entry(tk, textvariable=facilityID_text)
    facilityID_text.set("")
    facilityID.pack()
    l2 = Tkinter.Label(tk, text="请输入检查设备状态（fine/bad）：")
    l2.pack()
    facilityState_text = Tkinter.StringVar()
    facilityState = Tkinter.Entry(tk, textvariable=facilityState_text)
    facilityState_text.set("")
    facilityState.pack()

    def checkClick():
        facilityID1 = facilityID_text.get()
        facilityStatus = facilityState_text.get()
        checkId = updateCheck(facilityID1, facilityStatus)
        if facilityStatus == "bad":
            startRepair(1, checkId)
        tkMessageBox.showinfo(title='检查设备', message='检查完毕')

    Tkinter.Button(tk, text="提交", command=checkClick).pack()


# 设备投诉和破损设备处理
def dealFacility():
    tk = getTK()
    ll = Tkinter.Label(tk, text="维修编号、设备名称：")
    ll.pack()
    l = []
    ids, names = showAllUndoneRepair()
    print(ids)
    print(names)
    for i in range(0, len(ids)):
        tempStr = str(ids[i]) + names[i]
        l.append(Tkinter.Label(tk, text=tempStr))
        l[i].pack()
    l1 = Tkinter.Label(tk, text="请输入处理维修编号：")
    l1.pack()
    rID_text = Tkinter.StringVar()
    rID = Tkinter.Entry(tk, textvariable=rID_text)
    rID_text.set("")
    rID.pack()
    l2 = Tkinter.Label(tk, text="若未完全解决，请在此处输入过程和花费，用.隔开：")
    l2.pack()
    inProcess_text = Tkinter.StringVar()
    inProcess = Tkinter.Entry(tk, textvariable=inProcess_text)
    inProcess_text.set("")
    inProcess.pack()
    l3 = Tkinter.Label(tk, text="若已经完全解决，请在此处输入过程和花费，用.隔开：")
    l3.pack()
    comprocess_text = Tkinter.StringVar()
    comprocess = Tkinter.Entry(tk, textvariable=comprocess_text)
    comprocess_text.set("")
    comprocess.pack()
    l4 = Tkinter.Label(tk, text="若已经完全解决，请在此处输入结果：")
    l4.pack()
    comresult_text = Tkinter.StringVar()
    comresult = Tkinter.Entry(tk, textvariable=comresult_text)
    comresult_text.set("")
    comresult.pack()

    def incompleteClick():
        rID1 = rID_text.get()
        tmp = inProcess_text.get()
        rprocess = tmp.split(".")[0]
        money = tmp.split(".")[1]
        rep(rID1, rprocess, money)
        tkMessageBox.showinfo(title='维修设备', message='处理提交完毕')

    def completeClick():
        rID1 = rID_text.get()
        tmp = comprocess_text.get()
        rprocess = tmp.split(".")[0]
        money = tmp.split(".")[1]
        rresult = comresult_text.get()
        repair(rID1, rprocess, rresult, money)
        tkMessageBox.showinfo(title='维修设备', message='处理完毕')

    Tkinter.Button(tk, text="未完成处理提交", command=incompleteClick).pack()
    Tkinter.Button(tk, text="完成处理提交", command=completeClick).pack()


# 设备投诉登记
def comF():
    tk = getTK()
    l1 = Tkinter.Label(tk, text="请输入投诉设备编号：")
    l1.pack()
    facilityID_text = Tkinter.StringVar()
    facilityID = Tkinter.Entry(tk, textvariable=facilityID_text)
    facilityID_text.set("")
    facilityID.pack()
    l2 = Tkinter.Label(tk, text="请输入投诉原因：")
    l2.pack()
    facilityState_text = Tkinter.StringVar()
    facilityState = Tkinter.Entry(tk, textvariable=facilityState_text)
    facilityState_text.set("")
    facilityState.pack()
    l3 = Tkinter.Label(tk, text="请输入投诉住户1楼号、单元号、房间号，用逗号隔开：")
    l3.pack()
    hID_text = Tkinter.StringVar()
    hID = Tkinter.Entry(tk, textvariable=hID_text)
    hID_text.set("")
    hID.pack()
    l4 = Tkinter.Label(tk, text="请输入投诉住户2楼号、单元号、房间号，用逗号隔开：")
    l4.pack()
    hID2_text = Tkinter.StringVar()
    hID2 = Tkinter.Entry(tk, textvariable=hID2_text)
    hID2_text.set("")
    hID2.pack()
    l5 = Tkinter.Label(tk, text="请输入投诉住户3楼号、单元号、房间号，用逗号隔开：")
    l5.pack()
    hID3_text = Tkinter.StringVar()
    hID3 = Tkinter.Entry(tk, textvariable=hID3_text)
    hID3_text.set("")
    hID3.pack()

    def comClick():
        facilityID1 = facilityID_text.get()
        facilityStatus = facilityState_text.get()
        h1 = hID_text.get()
        h2 = hID2_text.get()
        h3 = hID3_text.get()
        tempId = insertFacilityComplaint(facilityStatus, facilityID1)
        startRepair(2, tempId)
        tkMessageBox.showinfo(title='投诉设备', message='投诉完毕')
        i1 = getHouseId(h1)
        insertFCIncident(tempId, i1)
        if h2 != "":
            i2 = getHouseId(h2)
            insertFCIncident(tempId, i2)
        if h3 != "":
            i3 = getHouseId(h3)
            insertFCIncident(tempId, i3)

    Tkinter.Button(tk, text="提交", command=comClick).pack()


# 投诉意见登记
def comC():
    tk = getTK()
    l2 = Tkinter.Label(tk, text="请输入投诉原因：")
    l2.pack()
    facilityState_text = Tkinter.StringVar()
    facilityState = Tkinter.Entry(tk, textvariable=facilityState_text)
    facilityState_text.set("")
    facilityState.pack()
    l3 = Tkinter.Label(tk, text="请输入投诉住户1楼号、单元号、房间号，用逗号隔开：")
    l3.pack()
    hID_text = Tkinter.StringVar()
    hID = Tkinter.Entry(tk, textvariable=hID_text)
    hID_text.set("")
    hID.pack()
    l4 = Tkinter.Label(tk, text="请输入投诉住户2楼号、单元号、房间号，用逗号隔开：")
    l4.pack()
    hID2_text = Tkinter.StringVar()
    hID2 = Tkinter.Entry(tk, textvariable=hID2_text)
    hID2_text.set("")
    hID2.pack()
    l5 = Tkinter.Label(tk, text="请输入投诉住户3楼号、单元号、房间号，用逗号隔开：")
    l5.pack()
    hID3_text = Tkinter.StringVar()
    hID3 = Tkinter.Entry(tk, textvariable=hID3_text)
    hID3_text.set("")
    hID3.pack()

    def comCClick():
        facilityStatus = facilityState_text.get()
        h1 = hID_text.get()
        h2 = hID2_text.get()
        h3 = hID3_text.get()
        tempId = insertCommonComplaint(facilityStatus)
        tkMessageBox.showinfo(title='投诉', message='投诉完毕')
        i1 = getHouseId(h1)
        insertCCIncident(tempId, i1)
        if h2 != "":
            i2 = getHouseId(h2)
            insertCCIncident(tempId, i2)
        if h3 != "":
            i3 = getHouseId(i3)
            insertCCIncident(tempId, i3)

    Tkinter.Button(tk, text="提交", command=comCClick).pack()


# 投诉意见处理
def dealC():
    tk = getTK()
    ll = Tkinter.Label(tk, text="投诉编号、投诉原因：")
    ll.pack()
    l = []
    ids, reasons = showAllUndoneCC()
    for i in range(0, len(ids)):
        tmp = str(ids[i]) + reasons[i]
        l.append(Tkinter.Label(tk, text=tmp))
        l[i].pack()
    l1 = Tkinter.Label(tk, text="请输入处理投诉编号：")
    l1.pack()
    rID_text = Tkinter.StringVar()
    rID = Tkinter.Entry(tk, textvariable=rID_text)
    rID_text.set("")
    rID.pack()
    l2 = Tkinter.Label(tk, text="若未完全解决，请在此处输入过程：")
    l2.pack()
    inProcess_text = Tkinter.StringVar()
    inProcess = Tkinter.Entry(tk, textvariable=inProcess_text)
    inProcess_text.set("")
    inProcess.pack()
    l3 = Tkinter.Label(tk, text="若已经完全解决，请在此处输入过程：")
    l3.pack()
    comprocess_text = Tkinter.StringVar()
    comprocess = Tkinter.Entry(tk, textvariable=comprocess_text)
    comprocess_text.set("")
    comprocess.pack()
    l4 = Tkinter.Label(tk, text="若已经完全解决，请在此处输入结果：")
    l4.pack()
    comresult_text = Tkinter.StringVar()
    comresult = Tkinter.Entry(tk, textvariable=comresult_text)
    comresult_text.set("")
    comresult.pack()

    def incompleteCClick():
        rID1 = rID_text.get()
        rprocess = inProcess_text.get()
        updateCommonCom(rID1, rprocess)
        tkMessageBox.showinfo(title='处理投诉', message='处理提交完毕')

    def completeCClick():
        rID1 = rID_text.get()
        rprocess = comprocess_text.get()
        rresult = comresult_text.get()
        updateCommonComplaint(rID1, rprocess, rresult)
        tkMessageBox.showinfo(title='处理投诉', message='处理完毕')

    Tkinter.Button(tk, text="未完成处理提交", command=incompleteCClick).pack()
    Tkinter.Button(tk, text="完成处理提交", command=completeCClick).pack()


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


# 插入新的设备
def insertNewFacility(name, status):
    checkSql = "SELECT MAX(facilityID) FROM facility"
    cur.execute(checkSql)
    max = cur.fetchone()
    maxId = int(max[0]) + 1
    sql = "INSERT INTO  facility(facilityID,facilityName,latestCheck,facilityState,community) VALUES(" + str(
        maxId) + ",'" + name + "','" + tempDate + "','" + status + "','" + community + "')"
    # print(sql)
    cur.execute(sql)
    conn.commit()


# 显示所有没有维修完成的设备
def showAllUndoneRepair():
    sql = "SELECT repairRecordID FROM repair_record WHERE(repairTime IS NULL) AND (checkFacilityID IN (SELECT checkFacilityID FROM check_facility WHERE facilityID IN (SELECT facilityID FROM facility WHERE community='" + community + "')))"
    print(sql)
    cur.execute(sql)
    id = cur.fetchall()
    ids = []
    for row in id:
        ids.append(row[0])
    sqlr = "SELECT repairRecordID FROM repair_record WHERE(repairTime IS NULL) AND (facilityComplaintID IN (SELECT facilityComplaintID FROM facility_complaint WHERE facilityID IN (SELECT facilityID FROM facility WHERE community='" + community + "')))"
    cur.execute(sqlr)
    idr = cur.fetchall()
    for row in idr:
        ids.append(row[0])
    sql2 = "SELECT repairProcess FROM repair_record WHERE(repairTime IS NULL) AND (checkFacilityID IN (SELECT checkFacilityID FROM check_facility WHERE facilityID IN (SELECT facilityID FROM facility WHERE community='" + community + "')))"
    # print(sql2)
    cur.execute(sql2)
    name = cur.fetchall()
    names = []
    for row in name:
        names.append(row[0])
    sql2r = "SELECT repairProcess FROM repair_record WHERE(repairTime IS NULL) AND (facilityComplaintID IN (SELECT facilityComplaintID FROM facility_complaint WHERE facilityID IN (SELECT facilityID FROM facility WHERE community='" + community + "')))"
    cur.execute(sql2r)
    namer = cur.fetchall()
    for row in namer:
        names.append(row[0])
    # print(names)
    return ids, names


# 显示所有没有处理的投诉
def showAllUndoneCC():
    sql = "SELECT commonComplaintID,commonComplaintReason FROM common_complaint WHERE(commonComplaintResult IS NULL) AND (commonComplaintID IN (SELECT commonComplaintID FROM complaintIncident WHERE houseID IN (SELECT houseID FROM house WHERE community='" + community + "')))"
    # print(sql)
    cur.execute(sql)
    id = cur.fetchall()
    ids = []
    names = []
    for row in id:
        ids.append(row[0])
        names.append(row[1])
    print(ids)
    print(names)
    return ids, names


def updateCheck(id, status):
    sql = "UPDATE facility SET latestCheck='" + tempDate + "' WHERE facilityID=" + id
    cur.execute(sql)
    conn.commit()
    sql = "UPDATE facility SET facilityState='" + status + "' WHERE facilityID=" + id
    cur.execute(sql)
    conn.commit()
    checkSql = "SELECT MAX(checkFacilityID) FROM check_facility"
    cur.execute(checkSql)
    max = cur.fetchone()
    maxId = int(max[0]) + 1
    sql = "INSERT INTO  check_facility(checkFacilityID,checkResult,facilityID,checkTime) VALUES(" + str(
        maxId) + ",'" + status + "'," + id + ",'" + tempDate + "')"
    cur.execute(sql)
    conn.commit()
    return maxId


# 维修设备1:check 2:complain
def startRepair(type, ccId):
    checkSql = "SELECT MAX(repairRecordID) FROM repair_record"
    cur.execute(checkSql)
    max = cur.fetchone()
    maxId = int(max[0]) + 1
    if type == 1:
        nameSql = "SELECT facilityName FROM facility WHERE facilityID IN (SELECT facilityID FROM check_facility WHERE checkFacilityID=" + str(
            ccId) + ")"
        cur.execute(nameSql)
        name = cur.fetchone()
        print(name)
        sql = "INSERT INTO repair_record(repairRecordID,checkFacilityID,repairProcess) VALUES(" + str(
            maxId) + "," + str(ccId) + ",'todo" + str(name[0]) + "')"
    if type == 2:
        nameSql = "SELECT facilityName FROM facility WHERE facilityID IN (SELECT facilityID FROM facility_complaint WHERE facilityComplaintID=" + str(
            ccId) + ")"
        cur.execute(nameSql)
        name = cur.fetchone()
        sql = "INSERT INTO repair_record(repairRecordID,facilityComplaintID,repairProcess) VALUES(" + str(
            maxId) + "," + str(ccId) + ",'todo" + str(name[0]) + "')"
    cur.execute(sql)
    conn.commit()


# incomplete
def rep(id, process, money):
    sql = "UPDATE repair_record SET repairProcess='" + process + "' WHERE repairRecordID=" + id
    print(sql)
    cur.execute(sql)
    conn.commit()
    newChargesRelate("维修", money, id)


# complete
def repair(id, process, result, money):
    sql = "UPDATE repair_record SET repairProcess='" + process + "' ,repairResult='" + result + "' ,repairTime='" + tempDate + "'WHERE repairRecordID=" + id
    print(sql)
    cur.execute(sql)
    conn.commit()
    '''sql2=""
    if type == 1:
        sql2 = "UPDATE facility SET latestCheck=" + tempDate + "WHERE facilityID=(SELECT facilityID FROM check_facility WHERE checkFacilityID =(SELECT checkFacilityID FROM repair_record WHERE repairRecordID=" + id + "))"
    if type == 2:
        sql2 = "UPDATE facility SET latestCheck=" + tempDate + "WHERE facilityID=(SELECT facilityID FROM facility_complaint WHERE facilityComplaintID =(SELECT facilityComplaintID FROM repair_record WHERE repairRecordID=" + id + "))"
    cur.execute(sql2)
    conn.commit()'''
    newChargesRelate("维修", money, id)


def insertFacilityComplaint(reason, id):
    checkSql = "SELECT MAX(facilityComplaintID) FROM facility_complaint"
    cur.execute(checkSql)
    max = cur.fetchone()
    maxId = int(max[0]) + 1
    sql = "INSERT INTO facility_complaint(facilityComplaintID,facilityComplaintTime,facilityComplaintReason,facilityID) VALUES (" + str(
        maxId) + ",'" + tempDate + "','" + reason + "'," + id + ")"
    print(sql)
    cur.execute(sql)
    conn.commit()
    fSql = "UPDATE facility SET facilityState='bad' WHERE facilityID=" + id
    cur.execute(fSql)
    conn.commit()
    return maxId


def insertFCIncident(id, houseID):
    sql2 = "INSERT INTO facilityComplaintIncident(houseID,facilityComplaintID) VALUES (" + str(houseID) + "," + str(
        id) + ")"
    print(sql2)
    cur.execute(sql2)
    conn.commit()


def insertCommonComplaint(reason):
    checkSql = "SELECT MAX(commonComplaintID) FROM common_complaint"
    cur.execute(checkSql)
    max = cur.fetchone()
    maxId = int(max[0]) + 1
    sql = "INSERT INTO common_complaint(commonComplaintID,commonComplaintReason,commonComplaintTime) VALUES (" + str(
        maxId) + ",'" + reason + "','" + tempDate + "')"
    cur.execute(sql)
    conn.commit()
    return maxId


def insertCCIncident(id, houseID):
    sql2 = "INSERT INTO complaintIncident(houseID,commonComplaintID) VALUES (" + str(houseID) + "," + str(id) + ")"
    cur.execute(sql2)
    conn.commit()


# incomplete
def updateCommonCom(id, process):
    sql = "UPDATE common_complaint SET commonComplaintProcess='" + process + "' WHERE commonComplaintID=" + id
    cur.execute(sql)
    conn.commit()


# complete
def updateCommonComplaint(id, process, result):
    sql = "UPDATE common_complaint SET commonComplaintProcess='" + process + "' ,commonComplaintResult='" + result + "' WHERE commonComplaintID=" + id
    cur.execute(sql)
    conn.commit()


def showTodoCommonComplaint():
    sql = "SELECT commonComplaintID,commonComplaintReason FROM common_complaint WHERE ((commonComplaintResult IS NULL) AND (commonComplaintID IN (SELECT commonComplaintID FROM complaintIncident WHERE houseID IN (SELECT houseID FROM house WHERE communityID=" + communityID + " ))))"
    cur.execute(sql)
    rec = cur.fetchall()
    ids = []
    reasons = []
    for row in rec:
        ids.append(row[0])
        reasons.append(row[1])
    return ids, reasons


def newChargesRelate(type, amount, repId):
    checkSql = "SELECT MAX(chargesID) FROM charges"
    cur.execute(checkSql)
    max = cur.fetchone()
    maxId = int(max[0]) + 1
    sql = "INSERT INTO charges(chargesID,chargesType,chargesAmount,chargesDate,repairRecordID,community) VALUES (" + str(
        maxId) + ",'" + type + "'," + str(amount) + ",'" + tempDate + "'," + str(repId) + ",'" + community + "')"
    print(sql)
    cur.execute(sql)
    conn.commit()


display = get_Page1()
display.mainloop()
