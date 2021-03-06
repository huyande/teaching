package com.teaching.web.controller.user;

import com.teaching.dto.CourseSectionVO;
import com.teaching.enums.CourseCommentStatus;
import com.teaching.enums.UserBehaviorStatus;
import com.teaching.mapper.*;
import com.teaching.pojo.*;
import com.teaching.service.CourseSectionService;
import com.teaching.service.CourseService;
import com.teaching.service.UserCourseSectionService;
import com.teaching.utils.UtilFuns;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import tk.mybatis.mapper.entity.Example;

import java.util.List;

/**
 * @Author： XO
 * @Description：
 * @Date： 2020/3/14 18:13
 */
@Controller
public class UserLearnController {


    @Autowired
    private CourseSectionService courseSectionService;
    @Autowired
    private CourseService courseService;
    @Autowired
    private UserCourseSectionService userCourseSectionService;

    @Autowired
    private CourseCommentMapper courseCommentMapper;
    @Autowired
    private CourseMapper courseMapper;
    @Autowired
    private CourseSectionMapper courseSectionMapper;
    @Autowired
    private  UserCourseSectionMapper userCourseSectionMapper;
    @Autowired
    private UserBehaviorMapper userBehaviorMapper;


    /**
     * 用户首次学习，点击“开始学习”按钮
     * @param courseId
     * @return
     */
    @Transactional
    @GetMapping(value="/user/course/learn/first/{courseId}")
    public String firstLearn( @PathVariable("courseId") Integer courseId){

        //1、获取当前登录的用户
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        AuthUser authUser= (AuthUser) auth.getPrincipal();
        //2、添加用户学习记录，获取课程的第一章节，进入学习
        CourseSection courseSection=courseSectionService.findFirstCourseSectionByCourseId(courseId);
        if(UtilFuns.isNull(courseSection)){
           return "redirect:/website/course/courseDetail/"+courseId;
        }
        userCourseSectionService.addUserCourseSection(authUser.getId(),courseSection.getId());
       /* UserCourseSection userCourseSection=new UserCourseSection();
        userCourseSection.setCourseId(courseId);
        userCourseSection.setUserId(authUser.getId());
        userCourseSection.setRate(10);
        userCourseSection.setSectionId(courseSection.getId());
        userCourseSectionMapper.insertSelective(userCourseSection);*/
        //3、更新课程表学习人数+1
        courseService.updateStudyCountById(courseId);
        //4、添加一条用户行为记录
        UserBehavior userBehavior=new UserBehavior();
        userBehavior.setCourseId(courseId);
        userBehavior.setUserId(authUser.getId());
        userBehavior.setType(UserBehaviorStatus.TYPE_BROWSE.getValue());
        userBehaviorMapper.insertSelective(userBehavior);
        return "redirect:/user/course/learn/"+courseSection.getId();
    }

    /**
     * 1、用户直接点击学习的视频进入学习
     * 2、或者点击继续学习按钮进入学习（记录了上次学习的地方）
     * @param model
     * @param sectionId
     * @return
     */
    @Transactional
    @GetMapping(value="/user/course/learn/{sectionId}")
    public String learn(Model model, @PathVariable("sectionId") Integer sectionId){

        if(null == sectionId)
            return "404";
        CourseSection courseSection = courseSectionMapper.selectByPrimaryKey(new CourseSection(Integer.valueOf(sectionId)));
        if(null == courseSection)
            return "404";
        Course course=courseMapper.selectByPrimaryKey(new Course(courseSection.getCourseId()));
        if(course.getOnsale()==0||course.getDel()==1)//未上架,已经删除
            return "404";
        model.addAttribute("courseSection", courseSection);

        //1、获取当前登录的用户
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        AuthUser authUser= (AuthUser) auth.getPrincipal();
        //2、设置用户学习记录
        userCourseSectionService.addUserCourseSection(authUser.getId(),sectionId);
        //3、获取课程章节
        List<CourseSectionVO> chaptSections = courseSectionService.queryCourseSection(courseSection.getCourseId());
        model.addAttribute("chaptSections", chaptSections);
        //4、获取章节评论
        Example example=new Example(CourseComment.class);
        example.orderBy("createTime").desc();
        example.createCriteria().andEqualTo("courseId",courseSection.getCourseId())
                .andEqualTo("type",CourseCommentStatus.TYPE_COMMENT.getValue())
                .andEqualTo("sectionId",sectionId);
        List<CourseComment> courseCommentList=courseCommentMapper.selectByExample(example);
        model.addAttribute("courseCommentList",courseCommentList);

        return "website/course-learn";
    }

    /**
     * 用户评论
     * @param content
     * @return
     */
    @GetMapping(value="/user/course/comment")
    public String comment(@RequestParam("content") String content, @RequestParam("sectionId") Integer sectionId){
        //查询章节
        CourseSection courseSection=courseSectionMapper.selectByPrimaryKey(new CourseSection(sectionId));
        //获取当前登录的用户
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        AuthUser authUser= (AuthUser) auth.getPrincipal();
        //封装插入
        CourseComment courseComment=new CourseComment();
        courseComment.setUsername(authUser.getRealname());
        courseComment.setContent(content);
        courseComment.setCourseId(courseSection.getCourseId());
        courseComment.setSectionId(courseSection.getId());
        courseComment.setSectionTitle(courseSection.getName());
        courseComment.setType(CourseCommentStatus.TYPE_COMMENT.getValue());
        courseCommentMapper.insertSelective(courseComment);
        //重定向到原来的学习页面
        return "redirect:/user/course/learn/"+sectionId;
    }

}
