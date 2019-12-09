package com.houserss.vo;

import java.util.List;

public class PageInfoVo<T> {
    // 列表信息
    List<T> data;
    // 总页数
    private int sumPage;
    // 当前页
    private int curPage;
    // 每页显示条数
    private int pageSize;
    public List<T> getData() {
        return data;
    }
    public void setData(List<T> data) {
        this.data = data;
    }
    public int getSumPage() {
        return sumPage;
    }
    public void setSumPage(int sumPage) {
        this.sumPage = sumPage;
    }
    public int getCurPage() {
        return curPage;
    }
    public void setCurPage(int curPage) {
        this.curPage = curPage;
    }
    public int getPageSize() {
        return pageSize;
    }
    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }
    public PageInfoVo(List<T> data, int sumPage, int curPage, int pageSize) {
        super();
        this.data = data;
        this.sumPage = sumPage;
        this.curPage = curPage;
        this.pageSize = pageSize;
    }
    public PageInfoVo() {
        super();
        // TODO Auto-generated constructor stub
    }
    
}
