package pageobjects;

import java.util.List;

import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;

import com.provar.core.testapi.annotations.*;

@Page( title="google"                                
     , summary=""
     , relativeUrl=""
     , connection="google"
     )             
public class google {

	@TextType()
	@FindBy(xpath = "//textarea[@id='APjFqb']")
	public WebElement search12;
			
}
