Tkinter.Button(tk, text="收支总览", command=viewFee).pack()


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

