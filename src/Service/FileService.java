package Service;

import DAO.FileDAO;
import DTO.File;
import utils.pageHelper;

import java.util.List;

public class FileService {
    private FileDAO fileDAO = new FileDAO();

    // 增加文件
    public int saveFile(File file) {
        int i = fileDAO.insertFile(file);
        return i;
    }

    // 删除文件记录并清理文件系统
    public void deleteFile(int fileId, String contextPath) {
        // 先查询文件信息以获取路径
        File file = fileDAO.selectFileById(fileId);
        if (file == null) {
            return; // 文件不存在，直接返回
        }

        // 删除数据库记录
        int rows = fileDAO.deleteFile(fileId);
        if (rows == 0) {
            throw new RuntimeException("删除数据库记录失败: fileId=" + fileId);
        }

        // 删除文件系统中的文件
        String fileDownloadLink = file.getFileDownloadLink();
        if (fileDownloadLink != null && !fileDownloadLink.isEmpty()) {
            String filePath = contextPath + "/" + fileDownloadLink;
            java.io.File fileToDelete = new java.io.File(filePath);
            if (fileToDelete.exists()) {
                fileToDelete.delete();
            }

            // 删除父目录（如果为空）
            java.io.File parentDir = fileToDelete.getParentFile();
            if (parentDir.exists() && parentDir.isDirectory() && parentDir.list().length == 0) {
                parentDir.delete();
            }
        }

        // 删除描述图片（media_urls 中的文件）
        String mediaUrls = file.getMediaUrls();
        if (mediaUrls != null && !mediaUrls.isEmpty()) {
            try {
                com.fasterxml.jackson.databind.ObjectMapper mapper = new com.fasterxml.jackson.databind.ObjectMapper();
                List<String> urls = mapper.readValue(mediaUrls, mapper.getTypeFactory().constructCollectionType(List.class, String.class));
                for (String url : urls) {
                    String imagePath = contextPath + "/" + url;
                    java.io.File imageFile = new java.io.File(imagePath);
                    if (imageFile.exists()) {
                        imageFile.delete();
                    }
                    // 删除描述图片目录（如果为空）
                    java.io.File imageDir = imageFile.getParentFile();
                    if (imageDir.exists() && imageDir.isDirectory() && imageDir.list().length == 0) {
                        imageDir.delete();
                    }
                }
            } catch (Exception e) {
                e.printStackTrace(); // 建议使用日志记录
            }
        }
    }

    // 更新文件
    public int updateFile(File file) {
        int i = fileDAO.updateFile(file);
        return i;
    }

    // 根据文件id查询文件,可得到发布该文件的用户信息
    public File checkFile(int fileId) {
        File file = fileDAO.selectFileById(fileId);
        return file;
    }

    // 根据文件名模糊查询文件
    public List<File> fuzzyQueryFileByFileName(String fileName) {
        List<File> fileList = fileDAO.fuzzyQueryFileByFileName(fileName);
        return fileList;
    }

    // 互动：点赞收藏下载
    public int interact(File file) {
        int i = fileDAO.interact(file);
        return i;
    }

    // 查找所有文件信息
    public List<File> listFile() {
        List<File> fileList = fileDAO.listFile();
        return fileList;
    }

    // 分页查找所有文件信息
    public pageHelper<File> listAllFilesByPage(int pageNum, int pageSize) {
        // 和File_ClubService的listFile_ClubByPage操作相同，后期可优化简化，创造接口
        // 1.查询所有文件的信息
        int start = (pageNum - 1) * pageSize;
        int limit = pageSize;
        // 第一页是0 5 第二页是5 5 第三页是10 5
        List<File> fileAll = fileDAO.listAllFilesByPage(start, limit);
        // 2.算出所有文件对应的总页数
        int count = fileDAO.listFile().size();
        int pageCount = (count + pageSize - 1) / pageSize;
        if (pageCount == 0) {
            pageCount = 1;
        }
        // 3.将所有数据放入pageHelper对象中
        pageHelper<File> filePageHelper = new pageHelper<File>(fileAll, pageNum, pageCount);
        return filePageHelper;
    }
}
