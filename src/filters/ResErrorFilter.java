package filters;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.vendor.model.VendorVO;

/**
 * Servlet Filter implementation class ResErrorFilter
 */
@WebFilter("/ResErrorFilter")
public class ResErrorFilter implements Filter {

    /**
     * Default constructor. 
     */
    public ResErrorFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {		
		System.out.println("1 ======================================");
		System.out.println("Filter" + ((HttpServletResponse)res).getStatus());
		
//		if (((HttpServletResponse)res).getStatus() != HttpServletResponse.SC_OK ) {
//			((HttpServletResponse)res).sendRedirect(((HttpServletRequest)req).getContextPath() + "/front-end/V_FrontPage.jsp");
//		}
		if (((HttpServletRequest)req).getSession().getAttribute("vVO") == null || 
				((VendorVO)((HttpServletRequest)req).getSession().getAttribute("vVO")).getVendor_no() == null ) {
			((HttpServletResponse)res).sendRedirect(((HttpServletRequest)req).getContextPath() + "/front-end/V_FrontPage.jsp");
		} else {
			chain.doFilter(req, res);
		}
		

		System.out.println("2 ======================================");
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
