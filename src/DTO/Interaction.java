package DTO;

public class Interaction {
    private int interactionId; // 交互ID
    private int type;   // 类型 1-用户和文件赞踩 2-用户和文件收藏 3-用户和评论点赞
    private int uId;    // 用户ID
    private int objectId;   // 对象ID
    private int status; // 状态 -1-踩  0-无  1-文件赞/收藏/评论赞

    public Interaction() {
    }

    public Interaction(int type, int uId, int objectId, int status) {
        this.type = type;
        this.uId = uId;
        this.objectId = objectId;
        this.status = status;
    }

    @Override
    public String toString() {
        return "Interaction{" +
                "interactionId=" + interactionId +
                ", type=" + type +
                ", uId=" + uId +
                ", objectId=" + objectId +
                ", status=" + status +
                '}';
    }

    public int getInteractionId() {
        return interactionId;
    }

    public void setInteractionId(int interactionId) {
        this.interactionId = interactionId;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public int getuId() {
        return uId;
    }

    public void setuId(int uId) {
        this.uId = uId;
    }

    public int getObjectId() {
        return objectId;
    }

    public void setObjectId(int objectId) {
        this.objectId = objectId;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
