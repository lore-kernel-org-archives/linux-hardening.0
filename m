Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D6D1C5F06
	for <linux-hardening@vger.kernel.org>; Mon,  7 Apr 2025 19:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055035; cv=none; b=Maket0h0IP936dFDHCdt/U6PEyZoX195MSpjPxxut7g+U5HHWWT8S4u1l2//aXnWKmi3yChR9RVHUUIJJ4zOpdXAPujhFomxB1vz45UTxkKz/wtOjKj4sntJG/Aba6uKDLFOyMFml256oSxKHljeOj9PpgWWc7li/LgiV0qraAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055035; c=relaxed/simple;
	bh=y4/Sh+IxWge2qh7GivBoh7q/Q8aAv9vu8Lz20RMeV0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yn0Ar1rLRtRRxKcnyCryVYbvh11ebFhnlNsKbdziDIgQB0v8o/2D30xOr1znCFPqYi5hohJ9zQh3uZ/6hKdvz/Yx1cn3AaWQuBMvoAM9erzB30CeUW6RUnrzLzNmswhm0kg2bLVmZzZN8VSJhXFWHRzhwoZtWdZR1YT0QcmljeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=RLg7DO7p; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="RLg7DO7p"
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
	by cmsmtp with ESMTPS
	id 1kWJu8fLfzZPa1sMLuv21e; Mon, 07 Apr 2025 19:42:17 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 1sMKuBvNi1vNy1sMLu2Y74; Mon, 07 Apr 2025 19:42:17 +0000
X-Authority-Analysis: v=2.4 cv=VMQWnMPX c=1 sm=1 tr=0 ts=67f42a99
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=B3fuDwYyW55wTQKIj88FGw==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=7T7KSl7uo7wA:10
 a=MRTGISs1mr4pDFNIwogA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=U95o1UiCLtOlksLs3gBeL5btxbXT5Fuwem2XPOf2NPo=; b=RLg7DO7ppTrGyuj+n9kox89h9K
	nGbLuQOL7ya07snGngHtrPSXmKLHDTkUJOahJH73gWsmqMdTYPnWGGdd0YEZRejsuJ8CHqK3Hna3w
	qa8IiyI1Nvvps6NRDVnp4QddDF1XtDNhtpzhuVwfpJaJcCtbwbgGw7AYvP6aDp9gfrX38KXU0i6UM
	MXdR53cc8Arf9JhPt38oiOPkOHMdKdrtQPQ1grYYHwn/GZlJU9USC9NJmY6QV7Gh/4JN7mk28i/7v
	WnQu6J5FQW5D3yzHU3Id3th75cjfUD1WnYKmeLzTO0VvOqoWZqoFJgLTUFBO2vkezdbu2XuxzesFw
	V8no09zg==;
Received: from [201.172.174.147] (port=35230 helo=[192.168.15.6])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1u1sMI-00000000Vbh-2wy2;
	Mon, 07 Apr 2025 14:42:15 -0500
Message-ID: <e8114ca6-d092-482b-9d6b-db7ea1c15cbc@embeddedor.com>
Date: Mon, 7 Apr 2025 13:42:07 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] watchdog: cros-ec: Avoid
 -Wflex-array-member-not-at-end warning
To: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Lukasz Majczak <lma@chromium.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Benson Leung <bleung@chromium.org>,
 Tzung-Bi Shih <tzungbi@kernel.org>, chrome-platform@lists.linux.dev,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <Z-WG6_uhWsy_FCq3@kspp> <202504071212.D6CBE6740C@keescook>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202504071212.D6CBE6740C@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.174.147
X-Source-L: No
X-Exim-ID: 1u1sMI-00000000Vbh-2wy2
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.6]) [201.172.174.147]:35230
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 19
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCYtStO4osSRNTIjcrNsksokh0cAYfJ0HKw8SSO5/Rg5qFG+hBwVzRxu+g/O8+DV7Fh57RB2URkg7GwDlhnPoF3vu7gWvKndehCsb5wDtwTwxsek31ZJ
 m8PIDwfwPfE1aIvYHGRnewuAwYv25MsRj5NppTwGk+Sbk9LM5iYQH8uWKuK4hYVjDpnou8oJxJOAZ8hTh4eeDGF4AHNUFE3fz/bxIk2vzjvcEpmOBjueG5UD


> 
>> +	msg->command = EC_CMD_HANG_DETECT;
>> +	msg->insize  = (arg->req.command == EC_HANG_DETECT_CMD_GET_STATUS) ?
>> +		   sizeof(struct ec_response_hang_detect) :
>> +		   0;
>> +	msg->outsize = sizeof(struct ec_params_hang_detect);
>> +	*(struct ec_params_hang_detect *)msg->data = arg->req;
>> +
>> +	ret = cros_ec_cmd_xfer_status(cros_ec, msg);
>>   	if (ret < 0)
>>   		return ret;
>>   
>> -	arg->resp = buf.data.resp;
>> +	arg->resp = *(struct ec_response_hang_detect *)msg->data;
> 
> msg->data used twice and a "sizeof()" earlier... might be nicer to have
> an explicit pointer?

Those are two different pointers:

*(struct ec_params_hang_detect *)msg->data = arg->req;
arg->resp = *(struct ec_response_hang_detect *)msg->data;

--
Gustavo
