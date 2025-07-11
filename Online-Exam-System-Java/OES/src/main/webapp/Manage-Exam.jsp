<%@page import="com.helper.*"%>
<%@page import="com.entity.*"%>
<%@page import="jakarta.servlet.http.Part"%>
<%@page import="java.util.List"%>	
<%@page import="java.util.ArrayList"%>
<%
DatabaseClass DAO = new DatabaseClass();
/* String id = (String) session.getAttribute("UserId"); */
String eexam = request.getParameter("eexam");
String eexamid = request.getParameter("eexamid"); 
%>
<%if(session.getAttribute("UserStatus")!=null){
	if(session.getAttribute("UserStatus").equals("1")){ 
		String id = (String) session.getAttribute("UserId");
 		User user1=DAO.getUserDetails(id);
%>
<!-- --------------------------main body ---------------------------------------------->
	<div class="main-body">
		<div class="main-containt">
			<div class="small-containers">
                <div class="dash-board container-padding">
                    <div class="flex-div-center">
                        <span>Exam</span>
                    </div>
                    <a href="">Today is
                        <span id="day">day</span>,
                        <span id="daynum">00</span>
                        <span id="month">month</span>
                        <span id="year">0000</span>
                        <span class="display-time"></span>
                    </a>
                </div>
                <hr>
            </div>
<!-- ==========================================Profile Edit============================ -->
       		<jsp:include page="EditUserProfile.jsp" /> 
<!-- ======================================================================================== -->
			<div class="small-containers">
                <div class="student-cont container-padding ">
                    <div onclick="showexam()">
                    	<i class="fa fa-add" aria-hidden="true"></i>
                        <span>Add Exam</span>
                    </div>
                </div>
                <hr>
            </div>
<!--  /*=============================Delete Exam========================================  */ -->
			<%
			if (request.getParameter("dexam")!=null&&request.getParameter("dexamid")!=null) {
				String dexamid = request.getParameter("dexamid");
				DAO.deleteexam(dexamid);
				DAO.deleteallques(dexamid);
				DAO.deleteenrole(dexamid);
				DAO.deleteres(dexamid);
			}   
			%>
<!-- ==========================================Add Exam============================ -->		
			<div class="addexam1" id="AddExam">
                <div class="addexam ">
                    <div>
                        <span class="stud-head-style flex-div-center">Create New Exam</span>
                        <hr>
                        <br>
                    </div>
                    <div class="addstudent1">
                         <form action="Controller.jsp" method="post" class="signup">
                          	<input type="hidden" name="page" value="createexam">
                    		<input type="hidden" name="addedby" value="<%=id%>">
                            <table>
                                <tr>
                                    <td><label>Exam Title</label></td>
                                    <td>
                                        <input type="text" placeholder="Exam Title" class="text" name="examtitle" 
                                            required>
                                    </td>
                                </tr>
                                <tr>
                                    <td><label>Exam Description</label></td>
                                    <td>
                                        <input type="text" placeholder="Exam Description" class="text" name="examdesc" 
                                            required>
                                    </td>
                                </tr>
                                <tr>
                                    <td><label>Exam Duration</label></td>
                                    <td>
                                        <select  name="examduration"  class="exam-dropdown" id="batch" required>
                                            <% for(int k=5;k<=250;k+=5){%>
                                            	<option value="<%=k%>"><%=k%> Minutes</option>
                                            <%} %>
                                        </select>
                                    </td>
                                </tr>
                              
                                <tr>
                                    <td><label>Marks for Right Answer</label></td>
                                    <td>
                                        <select  name="markright"  class="exam-dropdown" id="batch" required>
                                           
                                            <% for(int i=1;i<=10;i++){%>
                                            <option value="<%=i%>"><%=i%></option>
                                            <%} %>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td><label>Marks for Wrong Answer</label></td>
                                    <td>
                                        <select name="markwrong"  class="exam-dropdown" id="batch" required>
                                          
                                            <% for(int j=0;j>=-10;j--){%>
                                            <option value="<%=j%>"><%=j%></option>
                                            <%} %>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
            
                                    <td colspan="2" style="text-align: center;">
                                       <br><hr> <input type="submit" value="Save">
                                       <input onclick="closeshowbatch()" type="button" value="Cancel" style="background: #f44336;">
                                    </td>
                                </tr>
                            </table>
                        </form>
                    </div>
                </div>
            </div>
<!-- =========================================table==================================== -->
        	<div class="small-containers ">
                <div class="student-containt container-padding ">
                    <div >
                    	<i class="fa fa-list" aria-hidden="true"></i>
                        <span>Exam List</span>
                    </div>
                </div>
                <hr>
                <div class="student-containt-list container-padding">
                    <table>
                        <tr>
                        	<th>Sr no.</th>
                            <th>Exam Title</th>
                            <th>Exam DateTime</th>
                            <th>Exam Duration</th>
                            <th>Total Question</th>
                            <th>Marks for <br> Right Answer</th>
                            <th>Marks for <br> Wrong Answer</th>
                            <th>Add <br> Question</th>
                            <th>Show <br> Question</th>
                            <th>Edit</th>
                            <th>Delete</th>
                        </tr>
                        <%  int j=0;
    						List<Exam> Listexam = DAO.getAllexam(id);
    						for(Exam exam : Listexam) {	
    							ArrayList list=DAO.getQuestions(exam.getExamid());	
						%>
                        <tr>
                            <td><%=j+1 %></td>
                            <td><%=exam.getExamtitle() %></td>
                            <td><%=exam.getExamdesc() %></td>
                            <td><%=exam.getExamduration() %> Minutes</td>
                            <td><%=list.size() %></td>
                            <td><%=exam.getMarkright() %></td>
                            <td><%=exam.getMarkwrong() %></td>
                            <td style="text-align: center;">
                            <!-- =========Add Question ================= -->
                            	<a style="border: black solid 1px; padding: 4px 15px;"
                            	 href="User-Page.jsp?pg=3&AddQues=1&exmid=<%=exam.getExamid()%>">
                            		<i  class="fa fa-add" aria-hidden="true"></i> 
                            		Add
                            	</a> 
                            </td>
                            <td style="text-align: center;">
                            <!-- =========Show Question================= -->
                            	<a style="border: black solid 1px; padding: 4px 15px;" href="User-Page.jsp?pg=4&sexamid=<%=exam.getExamid()%>">
                            		<i  class="fa fa-eye" aria-hidden="true"></i>
                            		Show
                            	</a> 
                            </td>
                            <td>
                            	<!-- =========edit exam================= -->
                            	<a href="User-Page.jsp?pg=3&eexam=1&eexamid=<%=exam.getExamid()%>">
                            		<span class="material-symbols-outlined">edit </span>
                                </a>
                            </td>
                            <td>
                                <a href="User-Page.jsp?pg=3&dexam=1&dexamid=<%=exam.getExamid()%>">
	                                <span style="color: red;" class="material-symbols-outlined">delete_forever</span>
                                </a>
                            </td>
                        </tr>
                        <%
                        j++;
	                       
    					}%>
                        	<tr>
                        		<td colspan="11"> ----------------------------------------------</td>
                        	</tr>
                       
                    </table>
                </div>
                <hr>
            </div> 

<!--===========================================Add Questions ====================================================  -->
		  	<%if(request.getParameter("AddQues")!=null&&request.getParameter("exmid")!=null){ 
			%> 
		    	<jsp:include page="AddQues.jsp" />   
		    	  
		   <%} %> 
            
<!-- ==========================================Edit Exam==================================================== -->		
			<%if(request.getParameter("eexam")!=null&&request.getParameter("eexamid")!=null){ 
			Exam exam1=DAO.getexamDetails(eexamid);
			%>
			<div class=" addexam2 " id="editexam">
                <div class="addexam ">
                    <div>
                        <span class="stud-head-style flex-div-center">Edit Exam Details</span>
                        <hr>
                        <br>
                    </div>
                    <div class="addstudent1">
                         <form action="Controller.jsp" method="post" class="signup">
                          	<input type="hidden" name="page" value="editexam">
                    		<input type="hidden" name="addedby" value="<%=id%>">
                    		<input type="hidden" name="examid" value="<%=exam1.getExamid()%>">
                            <table>
                                <tr>
                                    <td><label>Exam Title</label></td>
                                    <td>
                                        <input type="text" placeholder="Exam Title" class="text" name="examtitle" value="<%=exam1.getExamtitle() %>"
                                            required>
                                    </td>
                                </tr>
                                <tr>
                                    <td><label>Exam Description</label></td>
                                    <td>
                                        <input type="text" placeholder="Exam Title" class="text" name="examdesc" value="<%=exam1.getExamdesc() %>"
                                            required>
                                    </td>
                                </tr>
                                <tr>
                                    <td><label>Exam Duration</label></td>
                                    <td>
                                        <select  name="examduration"  class="exam-dropdown" id="batch" required>
                                            <option value="<%=exam1.getExamduration() %>"><%=exam1.getExamduration() %> Minutes</option>
                                            <% for(int k=5;k<=250;k+=5){%>
                                            	<option value="<%=k%>"><%=k%> Minutes</option>
                                            <%} %>
                                        </select>
                                    </td>
                                </tr>
                              
                                <tr>
                                    <td><label>Marks for Right Answer</label></td>
                                    <td>
                                        <select  name="markright"  class="exam-dropdown" id="batch" required>
                                            <option value="<%=exam1.getMarkright() %>"><%=exam1.getMarkright() %></option>
                                            <% for(int i=1;i<=10;i++){%>
                                            <option value="<%=i%>"><%=i%></option>
                                            <%} %>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td><label>Marks for Wrong Answer</label></td>
                                    <td>
                                        <select name="markwrong"  class="exam-dropdown" id="batch" required>
                                            <option value="<%=exam1.getMarkwrong() %>"><%=exam1.getMarkwrong() %></option>
                                            <% for(int o=0;o>=-10;o--){%>
                                            <option value="<%=o%>"><%=o%></option>
                                            <%} %>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
            
                                    <td colspan="2" style="text-align: center;">
                                       <br><hr> <input type="submit" value="Save">
                                       <input onclick="editexamclose()" type="button" value="Cancel" style="background: #f44336;">
                                    </td>
                                </tr>
                            </table>
                        </form>
                    </div>
                </div>
            </div> 
            <%} %>
		
		
     	</div>
   	</div>
           <%
		}else{
			response.sendRedirect("index.jsp");
		}
	}else{
		response.sendRedirect("index.jsp");
	}
	
	%>