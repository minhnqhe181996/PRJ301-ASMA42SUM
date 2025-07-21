package tags;

import jakarta.servlet.jsp.tagext.TagSupport;
import jakarta.servlet.jsp.JspWriter;
import jakarta.servlet.jsp.JspException;
import java.io.IOException;

public class UrlResolverTag extends TagSupport {
    private String target;

    public void setTarget(String target) {
        this.target = target;
    }

    @Override
    public int doStartTag() throws JspException {
        try {
            String contextPath = pageContext.getServletContext().getContextPath();
            JspWriter out = pageContext.getOut();
            out.print(contextPath + "/" + target);
        } catch (IOException e) {
            throw new JspException("Error in UrlResolverTag", e);
        }
        return SKIP_BODY;
    }
}
