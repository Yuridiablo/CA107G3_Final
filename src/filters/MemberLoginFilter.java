package filters;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class MemberLoginFilter implements Filter {

	private FilterConfig config;

	public void init(FilterConfig config) {
		this.config = config;
	}

	public void destroy() {
		config = null;
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws ServletException, IOException {

		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		// 【取得 session】
		HttpSession session = req.getSession();
		System.out.println("近來拉");
		// 【從 session 判斷此user是否登入過】
		Object mem_no = session.getAttribute("mem_no");
		if (mem_no == null) {
			session.setAttribute("location", req.getRequestURI());
			session.setAttribute("checklogin", "checklogin");
			res.sendRedirect(req.getContextPath() + "/front-end/FrontPage.jsp");
			return;
		} else {
			session.removeAttribute("checklogin");
			chain.doFilter(request, response);
		}
	}
}