Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730B22C2356
	for <linux-hardening@vger.kernel.org>; Thu, 13 Nov 2025 04:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763007878; cv=none; b=EjNn3zeKxUFGKGheS/j3y6vSk4BlSN1nbdE8K7CPmviTRk41Xd9z9u0YlsX6+Hw0EobQrg1OSmI8HexTfLxXOYvBBth5uVum8YnfVzotFuetbF6sR5EnauWj4rLUb5cSTz+FQIzg65/BpJRon8M3/rF34a/LG1WkzQSXQaB73Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763007878; c=relaxed/simple;
	bh=cz9fUZd9C+zcNxpFo+3ei8tZ/Fv8mnTUymh+Lr7UieA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GOfWKfo+M/mHSKWZUJQAoGRuVgPs57jylkBySp7NuyYpx1aj3Kur0nOcCXpHifYqsZAtdsydCB6/tsk01JBmnNtesk23ST18iGtuRM7bQQeL1fG/REsDnySqiY9A5X6lU7H2Yt88ntUHbTfbeVQ4d0EWyHO63IeIyjyS/5RQIuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=hOE5YBNL; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="hOE5YBNL"
Received: from eig-obgw-6005b.ext.cloudfilter.net ([10.0.30.162])
	by cmsmtp with ESMTPS
	id JLUBvr6V2Zx2iJOspvk1Sw; Thu, 13 Nov 2025 04:24:31 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id JOsovWCpOUBPCJOsoviFO3; Thu, 13 Nov 2025 04:24:30 +0000
X-Authority-Analysis: v=2.4 cv=bspMBFai c=1 sm=1 tr=0 ts=69155d7e
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=7/VZz1X9DKOdr39w8NKiLQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=7T7KSl7uo7wA:10
 a=nZAuQRfsK3Kgxp-xzsIA:9 a=QEXdDO2ut3YA:10 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cz9fUZd9C+zcNxpFo+3ei8tZ/Fv8mnTUymh+Lr7UieA=; b=hOE5YBNLv9Pzty45Ab6fzepcbk
	+7it13+t4mlR59HDxIYkjcTzKHD8tR7ydlw67jIpoXxOwVozG1VnHNBwSna83QIiBWLkc1xgUrv1W
	u1zbSAWzG9DPc2L5oNImWpprHNn62rX7+qrH2/ACpnvBlx4AN2/5Vd1zpRhiacHA4z3sxnnLJ6Ans
	fg1XsBSTG0DufErH/18xmbPoGSkRTallPxQ4E8dmO1VUAzFlVjQNmi8/G9S3dGRAVTXsUq2/FDCvV
	carmSg/7h/iRf/f3ETsZx4ZM6agFsK2N4nwoL1XGHu8JzTYV7jx/kPFyRMebhOFHPaAkTV9WjxzlX
	jP0aO8zQ==;
Received: from [61.251.99.134] (port=3385 helo=[10.28.115.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vJOsn-00000003FES-3msd;
	Wed, 12 Nov 2025 22:24:30 -0600
Message-ID: <fbef561c-c470-47d0-9bc0-c565e10b2856@embeddedor.com>
Date: Thu, 13 Nov 2025 13:24:09 +0900
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] bcache: Avoid -Wflex-array-member-not-at-end
 warning
To: Coly Li <colyli@fnnas.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-bcache@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <aRHFchrO3BmVMH5c@kspp>
 <7g2dkwi2nzxe2luykodsknobzr5bkl23d5mbahkyo7adhg55oy@6uisoc7jzgy6>
 <a956504a-55af-4c2c-95a0-15663435624a@embeddedor.com>
 <7zweggwc6mkksyhxzbdsphachjj5pzlaebli6xitryfl4yiqdj@eziyaibeuhza>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <7zweggwc6mkksyhxzbdsphachjj5pzlaebli6xitryfl4yiqdj@eziyaibeuhza>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 61.251.99.134
X-Source-L: No
X-Exim-ID: 1vJOsn-00000003FES-3msd
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([10.28.115.44]) [61.251.99.134]:3385
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIKBYBXqNN9GguEm3fRZdhtMj4JtDbqkdt5CQDbTxmu1wpTb07XJJ3RKxRzDH26GaPiKd6mIrCgROytSf/nfBG754BYKzw6o8dM6ZCPHPDEdS1e/OSDq
 qfx4rGlYDnMEMt5lxsfWoV+81xMnIUVAVvQNFTqLVtDMgyZif0bBGPIg/+vCJrjlMO+YMOKgmoIZ4WABVBpHbw/OuQdxjsBBmvCjl0RNpZl1bp6Os2XytQ04


> I see. I take this patch, with the above complain...

Thanks, Coly.

-Gustavo
