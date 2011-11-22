/*
 * Created on Aug 17, 2007
 *
 */
package com.kirunews.rpha.struts;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kirunews.rpha.util.Configuration;
import com.kirunews.rpha.util.ConfigurationException;

/**
 * Init Web application by reading configuration files, start scheduler, etc
 * 
 * @author Robert Kiraly, Tesuji srl
 *
 */
public class InitializerServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
     * Constructor of the object.
     */
    public InitializerServlet() {
        super();
    }


    /**
     * The doGet method of the servlet. <br>
     *
     * This method is called when a form has its tag value method equals to get.
     * 
     * @param request the request send by the client to the server
     * @param response the response send by the server to the client
     * @throws ServletException if an error occurred
     * @throws IOException if an error occurred
     */
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_FORBIDDEN);
    }

    /**
     * The doPost method of the servlet. <br>
     *
     * This method is called when a form has its tag value method equals to post.
     * 
     * @param request the request send by the client to the server
     * @param response the response send by the server to the client
     * @throws ServletException if an error occurred
     * @throws IOException if an error occurred
     */
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.sendError(HttpServletResponse.SC_FORBIDDEN);
    }

    /**
     * Initialization of the servlet. <br>
     *
     * @throws ServletException if an error occure
     */
    public void init(ServletConfig cfg) throws ServletException {
        super.init(cfg);

        System.out.println("Initializer Servlet loaded, initializing ...");
        log("Initializer Servlet loaded, initializing ...");
        
        try {
			Configuration.init();
		} catch (ConfigurationException e) {
			log("Configuration error occured:" + e.getMessage());
			System.out.println("Configuration error occured:" + e.getMessage());
		}
		
    }

    /**
     * Destruction of the servlet. <br>
     */
    public void destroy() {
        super.destroy(); // Just puts "destroy" string in log
        
        //close scheduler, etc.
        try {
			Configuration.destroy();
		} catch (ConfigurationException e) {
			log("Configuration error occured:" + e.getMessage());
		}
    }
}
