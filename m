Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E309C1C69D
	for <linux-hardening@vger.kernel.org>; Mon, 16 Feb 2026 18:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771267374; cv=none; b=MGgs8jpD8zDHgsgkjyguGnzCkz1zQyS6Zy8lpQiDXewB9XFlKQBtxrmVyu5glq+4MDJndCNV+k7BDFh1lQMneqYn3xZEdtdac/lihciGJD0iWVmszBh1bileUGk40VNMlRWegCHr9oALA09fzJOWxqz5DEGiVr4VioW6ypQL0/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771267374; c=relaxed/simple;
	bh=767Uj0QkOhaOIrALMDpxXKc40OdZwmuLlgYRVGoVtEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TDHwkpn4SO0ZnXWXd8WMlM1TwXt1ZaRz2IInxhclA+QKI10OkOwi6wDeOsN1X01FU41cxaGJ3ocmSnmjI+96It2uq8R0slyRUuh4uXB++pwd0i5NaQ4mADqw7H1Ot2WkmIW/8lEuwzVyJ/jn2nv+nGkc9VUObCN+gfDPu31+544=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=a4breAF5; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="a4breAF5"
Received: from eig-obgw-6003b.ext.cloudfilter.net ([10.0.30.175])
	by cmsmtp with ESMTPS
	id rm1zvtStKSkcfs3YUvxgUu; Mon, 16 Feb 2026 18:42:46 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id s3YTvUj4JhoT4s3YTvD85e; Mon, 16 Feb 2026 18:42:45 +0000
X-Authority-Analysis: v=2.4 cv=XZyJzJ55 c=1 sm=1 tr=0 ts=69936526
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=k5Y5iPg+dmTXVWgYE/XtfQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=7T7KSl7uo7wA:10
 a=GjgvrKyk6xp7FOdauVAA:9 a=QEXdDO2ut3YA:10 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=767Uj0QkOhaOIrALMDpxXKc40OdZwmuLlgYRVGoVtEg=; b=a4breAF5KXEkbYLpt6EPqnmqeC
	Bq1EWp6uX3n8NUV5URIAR3KF61FqfRNitEr1YIttlc7q1tcj8JWVFojz+vfwQEq2BGPecEQR6ALSG
	IlFxysXIV8zR0U+LMJtj2XesB9nI5TFaF025Y9gvAxtIqBSpJdUYr0uTTPKOTAIFgnWyoCtMUS0EW
	01rwLnBOC0ePDCzZQThtrRT6TB/dI57cPU7ydEZ2nWi74z/osSUZsPELvzqcyf6yf9+0oSmX7sFUP
	xll2atuJly7UczoFK4NE1IjfUGhZxaG2Uj4JyzxBqPg+tp+IIxATl6C3G5HoY7jhSOIBRGtHph+11
	62XT/vzg==;
Received: from [177.238.16.13] (port=43702 helo=[192.168.0.21])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vs3YS-00000002BcX-0mQj;
	Mon, 16 Feb 2026 12:42:44 -0600
Message-ID: <baaa1b4f-7150-48a8-9b63-42f124c8655e@embeddedor.com>
Date: Mon, 16 Feb 2026 12:42:03 +0900
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] iwlegacy: Avoid multiple
 -Wflex-array-member-not-at-end warnings
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <aYlkt2WP2oQ1TgeH@kspp> <202602091212.743C6B9B7C@keescook>
 <4bf43164-b130-4643-9f4f-761f49bd0dc9@embeddedor.com>
 <20260216184033.GB10063@wp.pl>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20260216184033.GB10063@wp.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.16.13
X-Source-L: No
X-Exim-ID: 1vs3YS-00000002BcX-0mQj
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.21]) [177.238.16.13]:43702
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJ7i6UNqkBIF+HdmLlD4yzYswvFkckwGRndBlatvm49KsUtSLMVKxEuiYSvKi9eoMXQno2oWVdigdDFbkmMxL8VagMzTwYvbXd+aW9XfiF55nRK1HmG8
 fZr0TV7j/lrq8LXW/LuTRJnIslD0+VgWZSsNwYKfwISAY14UnWoY5BpYGoiyvLiwFumYZ8Ah72RtOMfLj93joIoNr3Av4XKy36F3JwzBpKS3gfhhCcp4q773


> When you will repost, please use 'wifi: iwlegacy:' prefix in the title.

Sure thing.

Thanks for the feedback
-Gustavo
