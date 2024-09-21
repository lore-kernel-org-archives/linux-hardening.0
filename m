Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C1038F9C
	for <linux-hardening@vger.kernel.org>; Sat, 21 Sep 2024 07:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726902667; cv=none; b=IzbJKArmrOggmL8jiBMOzPnTztQ0XDwiXj7XRyTeH/k9TI4tIL5rzLwkEQeIgnTjECbMnTyA0ATE1utfX2DWoxB1886pV4EHla+qNU7hCuXvDudTLglNo5vtqRonJjVM+UQiY0zyGqnAxLABDV7ycmci6qIqn5SWLoMA4vNXM9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726902667; c=relaxed/simple;
	bh=DMlGP6ct0IH1qx8vqHfaTOyWWm50xIjfA9N450Ezz9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=toGl7qu8j6kHkNC2bLxH2K/xZeFUyphuAwqpZcvf4cbtdQy8TL54TlmGlG+0uqu4BzytlNQGrgU+6uHJvW4HKMyRriCZRHY3f0ZTdVW0uThEgREk2OayE3BU8muODr3xj4flQpAeK3U+kOFGEgnGQ3KpZzjqEsvVa3/RSOwMAMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=TahuJR0Y; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="TahuJR0Y"
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
	by cmsmtp with ESMTPS
	id rgitsUcL6iA19ruGdsY2CX; Sat, 21 Sep 2024 07:10:55 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id ruGcsQnUUX56wruGcseDq4; Sat, 21 Sep 2024 07:10:55 +0000
X-Authority-Analysis: v=2.4 cv=MY6nuI/f c=1 sm=1 tr=0 ts=66ee717f
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=rpUMG24A1zG+UrzXDtAMsg==:17
 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=7T7KSl7uo7wA:10
 a=xnsc8VFwjPLOpbu4I2gA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Nbgl6M84206J7M/XAIDyHrWvBSZDOMkNiCL75T6st4Q=; b=TahuJR0YiwExrDWPtwZsvcXg3F
	vrINqNwH71GmcneULDT+KqtKFOnu3DG+z8Eqq0gYb1PdXGOGL+JZ5SvcOzZNe2mtrfVRTu60v2nao
	InNTz+gMgo2viUkgQVcCieJG6I0UIkXEtdtzB4ZrskJCki5cpPacA6PVqJcqNU/QaD8p1o3Obx1SB
	U63t//f9zDUmFu2/ABa26y4q7trMfJYnGOwcBcTPpF+YI6PRFUsyJb4i6+AqRPWLBOaGtJa/HLIf1
	tNptJ+KxwDmkz38aWk5ILw6T2H0kscI41oG/5XQ3XbBU/nsjg7/KbnYbnvvbf8QaZl66ULt5LIZL8
	NXbZrZhQ==;
Received: from [185.44.53.103] (port=43922 helo=[192.168.1.187])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sruGc-0029ro-0U;
	Sat, 21 Sep 2024 02:10:54 -0500
Message-ID: <426c0507-be04-4b87-8595-0a6a740d4dfe@embeddedor.com>
Date: Sat, 21 Sep 2024 09:10:50 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] container_of: add container_first() macro
To: Greg KH <gregkh@linuxfoundation.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <Zu1vekikKNR5oUoM@elsanto>
 <694a8a87-cc98-4c04-8228-d399133fdd39@suswa.mountain>
 <2024092149-stove-babied-e7cc@gregkh>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <2024092149-stove-babied-e7cc@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 185.44.53.103
X-Source-L: No
X-Exim-ID: 1sruGc-0029ro-0U
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.187]) [185.44.53.103]:43922
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLYfxIAb0IR8AlB568a0fHzjfrtg9h5oVsvpi2VR3Na7/l0F4JFqOKrxkYB5ILArcxj3pLbqIgB2NlRh+ychrQS8R7InxzOTw3/4rm7yddV+zGOCO3oX
 x0OuMeuMJGBaPBJ45mjEtzYO6rYyGA3BL3gaUiKvx9ls3yK7vLWOxNPOOX0hqY5mTAx7WSKpmUnpWHS9qnAdDhEbXVPGdchfT9iPdMFUsLGP0juQeXgYrcby



On 21/09/24 07:52, Greg KH wrote:
> On Sat, Sep 21, 2024 at 08:45:28AM +0300, Dan Carpenter wrote:
>> On Fri, Sep 20, 2024 at 02:50:02PM +0200, Gustavo A. R. Silva wrote:
>>> This is like container_of() but it has an assert to ensure that it's
>>> using the first struct member.
>>>
>>
>> I just remembered that Greg wanted this based on container_of_const().
> 
> Yes, that would be best.

Okay, I'll change that.

--
Gustavo

> 
>> Really container_of_const() should be renamed to container_of() and
>> container_of() should be renamed to container_of_helper() and we
>> would add a #define container_of_const container_of for the transition.
> 
> I agree, but I wonder if it's safe to just do that already and how many
> build warnings would happen.  Last I checked it was a lot.
> 
> thanks,
> 
> greg k-h
> 
