package travel.service;

import java.net.*;
import java.util.*;

import org.apache.ibatis.session.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.client.*;

@Component
public class TravelService {
	@Autowired
	SqlSessionFactory fac;
	
}
