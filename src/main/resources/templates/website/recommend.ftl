<!DOCTYPE html>
<html>

<#include "common/head.ftl">

<body>

<#include "common/header.ftl">


<div class="content content-nav-base buytoday-content">


<div class="content">

         <#include "common/main-nav.ftl">

   <#--<div class="category-con">
       <div class="category-banner">
            <div class="w1200">
                <img src="/static/images/website/banner.jpg" style="width: 1200px;px; height:400px;">
            </div>
        </div>
   </div>-->


    <div class="content content-nav-base buytoday-content">
        <div id="list-cont">

           <#-- <div class="banner-box">
                <div class="banner"></div>
            </div>-->

            <div class="product-list-box">
                <div class="product-list w1200">
                    <div class="tab-title">
                        <a href="javascript:;" class="active tuang" data-content="tuangou">课程推荐</a>
                        <a href="javascript:;" data-content="yukao">名师推荐</a>
                    </div>

                    <div class="list-cont" cont = 'tuangou'>
                        <div class="item-box layui-clear">

                            <#list courseList! as item>
                            <div class="item">
                                <a href="/website/course/courseDetail/${item.id}" target="_blank">
                                <img style="width: 290px;px; height:200px;"
                                     src="${item.picture!}">
                                </a>
                                <div class="text-box">
                                    <p class="title">${item.name!}</p>
                                    <p class="plic">
                                         <#if item.free=0>
                                             <span class="ciur-pic" style="font-size: 16px;color: red">￥${item.price!}/块钱</span>
                                         <#else >
                                             <span class="ciur-pic" style="font-size: 16px;color: red">免费</span>
                                         </#if>
                                        <span class="Ori-pic">课时${item.time!}分钟 &nbsp</span>
                                        <span class="discount">
                                            <i class="layui-icon" style="font-size: 12px">&#xe770;</i>&nbsp 在学${item.studyCount!}
                                        </span>
                                    </p>
                                </div>
                            </div>
                            </#list>

                        </div>
                    </div>


                    <div class="list-cont layui-hide" cont = 'yukao'>
                    <div class="item-box layui-clear">
                            <div class="item">
                                <a href="javascript:;">
                                <img style="width: 290px;px; height:200px;"
                                     src="http://szimg.mukewang.com/58f57d200001461105400300-360-202.jpg">
                                </a>
                                <div class="text-box">
                                    <p class="title">宝宝专用硅胶环保饭碗四套+调羹+筷子自助学吃饭套装</p>
                                    <p class="plic">
                                        <span class="ciur-pic">￥100.00</span>
                                        <span class="Ori-pic">￥208.00</span>
                                        <span class="discount">5折</span>
                                    </p>
                                </div>
                            </div>
                            <div class="item">
                                <img style="width: 290px;px; height:200px;"src="http://szimg.mukewang.com/58f57d200001461105400300-360-202.jpg">
                                <div class="text-box">
                                    <p class="title">宝宝专用硅胶环保饭碗四套+调羹+筷子自助学吃饭套装</p>
                                    <p class="plic">
                                        <span class="ciur-pic">￥100.00</span>
                                        <span class="Ori-pic">￥208.00</span>
                                        <span class="discount">5折</span>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

        </div>
    </div>




<#include "common/footer.ftl">

    <script type="text/javascript">
        $(function () {
            $("#recommend").addClass("active");
        })

        layui.config({
            base: '/static/js/website/' //你存放新模块的目录，注意，不是layui的模块目录
        }).use(['mm','laypage','jquery'],function(){
            var laypage = layui.laypage,$ = layui.$;
            mm = layui.mm;
            laypage.render({
                elem: 'demo0'
                ,count: 100 //数据总数
            });


            $('body').on('click','*[data-content]',function(){
                $(this).addClass('active').siblings().removeClass('active')
                var dataConte = $(this).attr('data-content');
                $('*[cont]').each(function(i,item){
                    var itemCont = $(item).attr('cont');
                    console.log(item)
                    if(dataConte === itemCont){
                        $(item).removeClass('layui-hide');
                    }else{
                        $(item).addClass('layui-hide');
                    }
                })
            })

        });
    </script>


</body>
</html>