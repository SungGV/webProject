package sukang.domain;

public class Isu {
    private int needCreditForRequirement;             //전필필요학점
    private int needCreditForSelective;               //전선필요학점
    private int needCreditForBasic;                   //기초필요학점
    private int needCreditForGraduation;              //필요총학점
    private int comMajorCredit;
    private int comSelecionCredit;
    private int comBasicCredit;
    private int comTotalCredit;
    private int remainedReq;
    private int remainedSelect;
    private int remainedBasic;
    private int remainedTotal;
    
    
    
    public int getRemainedReq() {
        return remainedReq;
    }
    public void setRemainedReq(int remainedReq) {
        this.remainedReq = remainedReq;
    }
    public int getRemainedSelect() {
        return remainedSelect;
    }
    public void setRemainedSelect(int remainedSelect) {
        this.remainedSelect = remainedSelect;
    }
    public int getRemainedBasic() {
        return remainedBasic;
    }
    public void setRemainedBasic(int remainedBasic) {
        this.remainedBasic = remainedBasic;
    }
    public int getRemainedTotal() {
        return remainedTotal;
    }
    public void setRemainedTotal(int remainedTotal) {
        this.remainedTotal = remainedTotal;
    }
    public int getNeedCreditForRequirement() {
        return needCreditForRequirement;
    }
    public void setNeedCreditForRequirement(int needCreditForRequirement) {
        this.needCreditForRequirement = needCreditForRequirement;
    }
    public int getNeedCreditForSelective() {
        return needCreditForSelective;
    }
    public void setNeedCreditForSelective(int needCreditForSelective) {
        this.needCreditForSelective = needCreditForSelective;
    }
    public int getNeedCreditForBasic() {
        return needCreditForBasic;
    }
    public void setNeedCreditForBasic(int needCreditForBasic) {
        this.needCreditForBasic = needCreditForBasic;
    }
    public int getNeedCreditForGraduation() {
        return needCreditForGraduation;
    }
    public void setNeedCreditForGraduation(int needCreditForGraduation) {
        this.needCreditForGraduation = needCreditForGraduation;
    }
    public int getComMajorCredit() {
        return comMajorCredit;
    }
    public void setComMajorCredit(int comMajorCredit) {
        this.comMajorCredit = comMajorCredit;
    }
    public int getComSelecionCredit() {
        return comSelecionCredit;
    }
    public void setComSelecionCredit(int comSelecionCredit) {
        this.comSelecionCredit = comSelecionCredit;
    }
    public int getComBasicCredit() {
        return comBasicCredit;
    }
    public void setComBasicCredit(int comBasicCredit) {
        this.comBasicCredit = comBasicCredit;
    }
    public int getComTotalCredit() {
        return comTotalCredit;
    }
    public void setComTotalCredit(int comTotalCredit) {
        this.comTotalCredit = comTotalCredit;
    }  
}
