<!DOCTYPE html>
<html>

<#include "common/head.ftl">

<body>

<#include "common/header.ftl">


<div class="content content-nav-base buytoday-content">


<div class="content">

         <#include "common/main-nav.ftl">

  <#-- <div class="category-con">
       <div class="category-banner">
            <div class="w1200">
                <img src="/static/images/website/banner.jpg" style="width: 1200px;px; height:400px;">
            </div>
        </div>
   </div>-->

    <div class="layui-carousel" id="xo">
        <div carousel-item>
            <div> <img src="/static/images/website/banner.jpg" style="width: 100%;height: 100%"></div>
            <div> <img src="/static/images/website/bg.jpg" style="width: 100%;height: 100%"></div>
            <div> <img src="/static/images/website/banner.jpg" style="width: 100%;height: 100%"></div>
            <div> <img src="/static/images/website/bg.jpg" style="width: 100%;height: 100%"></div>
            <div> <img src="/static/images/website/banner.jpg" style="width: 100%;height: 100%"></div>
        </div>
    </div>


    <div class="floors">
            <div class="sk">
                <div class="sk_inner w1200">

                    <div class="sk_hd">
                        <a href="javascript:;">
                            <img src="/static/images/website/s_img1.png">
                        </a>
                    </div>

                    <div class="sk_bd">
                        <div class="layui-carousel" id="test1">
                            <div carousel-item>

                                <div class="item-box">
                                    <#list freeCourse1 as free>
                                    <div class="item">
                                        <a href="/website/course/courseDetail/${free.id}" target="_blank">
                                            <img src="${free.picture!}">
                                        </a>
                                        <div class="title">${free.name!}</div>
                                        <div class="price">
                                            <span style="font-size: 16px;float:left"><i class="layui-icon">&#xe770;</i>
                                                ${free.column1!}在学
                                            </span>
                                            <span class="nub" style="font-size: 14px;float:right">免费</span>
                                        </div>
                                    </div>
                                    </#list>
                                </div>

                                <div class="item-box">
                                    <#list freeCourse1 as free>
                                        <div class="item">
                                            <a href="javascript:;">
                                                <img src="${free.picture!}">
                                            </a>
                                            <div class="title">${free.name!}</div>
                                            <div class="price">
                                                <span style="font-size: 16px;float:left"><i class="layui-icon">&#xe770;</i>
                                                    ${free.column1!}在学
                                                </span>
                                                <span class="nub" style="font-size: 14px;float:right">免费</span>
                                            </div>
                                        </div>
                                    </#list>
                                </div>


                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


    <div class="floors">
        <div class="sk">
            <div class="sk_inner w1200">

                <div class="sk_hd">
                    <a href="javascript:;">
                        <img src="/static/images/website/s_img2.png">
                    </a>
                </div>

                <div class="sk_bd">
                    <div class="layui-carousel" id="test2">
                        <div carousel-item>

                            <div class="item-box">
                                    <#list moneyCourseList1 as money >
                                        <div class="item">
                                            <a href="/website/course/courseDetail/${money.id}" target="_blank">
                                                <img src="${money.picture!}">
                                            </a>
                                            <div class="title">${money.name!}</div>
                                            <div class="price">
                                                <span style="font-size: 18px"><i class="layui-icon">&#xe770;</i>
                                                    ${money.column1!}在学
                                                </span>
                                                <span class="nub" style="font-size: 12px;float:right">￥150/毛</span>
                                            </div>
                                        </div>
                                    </#list>
                            </div>

                            <div class="item-box">
                                    <#list moneyCourseList1 as money>
                                        <div class="item">
                                            <a href="javascript:;">
                                                <img src="${money.picture!}">
                                            </a>
                                            <div class="title">${money.name!}</div>
                                            <div class="price">
                                                <span style="font-size: 18px"><i class="layui-icon">&#xe770;</i>
                                                    ${money.column1!}在学
                                                </span>
                                                <span class="nub" style="font-size: 12px;float:right">￥150/毛</span>
                                            </div>
                                        </div>
                                    </#list>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

        <div class="product-list-box" id="product-list-box">
            <div class="product-list-cont w1200">
                <h4>系统推荐</h4>

                <div class="product-item-box layui-clear">

                <#list systemCourseList1 as sys>
                    <div class="list-item">
                        <a href="/website/course/courseDetail/${sys.id}" target="_blank">
                            <img style="width: 160px;px; height:160px;"src="${sys.picture!}">
                        </a>
                        <p>课程名称：${sys.name!}</p>
                        <span>在学人数:${sys.studyCount!}</span>
                    </div>
                </#list>

                </div>
            </div>
        </div>
    </div>


<#include "common/footer.ftl">

    <script type="text/javascript">
        $(function () {
            $("#index").addClass("active");
        })

        layui.config({
            base: '/static/js/website/' //你存放新模块的目录，注意，不是layui的模块目录
        }).use(['mm','carousel'],function(){
            var carousel = layui.carousel,
                    mm = layui.mm;
            var option = {
                elem: '#test1'
                ,width: '100%' //设置容器宽度
                ,arrow: 'always'
                ,height:'298'
                ,indicator:'none'
            }
            carousel.render(option);
            // 模版引擎导入
            // var ins = carousel.render(option);
            // var html = demo.innerHTML;
            // var listCont = document.getElementById('list-cont');
            // // console.log(layui.router("#/about.html"))
            //  mm.request({
            //    url: '../json/index.json',
            //    success : function(res){
            //      console.log(res)
            //      listCont.innerHTML = mm.renderHtml(html,res)
            //      ins.reload(option);
            //    },
            //    error: function(res){
            //      console.log(res);
            //    }
            //  })


        });

        layui.config({
            base: '/static/js/website/' //你存放新模块的目录，注意，不是layui的模块目录
        }).use(['mm','carousel'],function(){
            var carousel = layui.carousel,
                    mm = layui.mm;
            var option = {
                elem: '#test2'
                ,width: '100%' //设置容器宽度
                ,arrow: 'always'
                ,height:'298'
                ,indicator:'none'
            }
            carousel.render(option);

        });


        layui.use('carousel', function(){
            var carousel = layui.carousel;
            //建造实例
            carousel.render({
                elem: '#xo'
                ,width: '100%' //设置容器宽度
                ,arrow: 'always' //始终显示箭头
                ,height:'450'
                //,anim: 'updown' //切换动画方式
            });
        });
    </script>
</body>
</html>