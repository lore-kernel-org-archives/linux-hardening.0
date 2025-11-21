Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EA83093DD
	for <linux-hardening@vger.kernel.org>; Fri, 21 Nov 2025 10:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763720424; cv=none; b=q/O5EYd63OqivrHw+UbfX0YJLD7Xuw5nyNV2Xm/Ih8RcF5mPfYJ+/akWqWjy+4Gj9apFx7YscmiUoTIWlEYO0/dvYLSk3ziugv/g0X9EeGUoXUcNAHfFGbM4qi+RYoW+pFCcYusa2miQv7HbAqDMS/L9UybS3zltPo3FOTFuD+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763720424; c=relaxed/simple;
	bh=Hc4tJ+sIxxpJNyjCE5vy0Ac+UC4RZ/t+r0ry7v3C8XE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tUVULRdg30yxXMQ3H4YK5sEtbh1huBzqWqpX6nY52EvjEvzGmPglKlEWnvuIVo/xZOXza63H23dXLx7ZtfkhZ2Vfz0v50AGDJ2wGLQsgai0ZTUlrW9v49zhhEICX6/T9O2za+Mak8Ecbh9JKpp8vLe0oEumaF8jOmd6e1JmT4qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=J5dU9Vq3; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="J5dU9Vq3"
Received: from eig-obgw-6003b.ext.cloudfilter.net ([10.0.30.175])
	by cmsmtp with ESMTPS
	id MNFFv7i7paPqLMOFTvskot; Fri, 21 Nov 2025 10:20:15 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id MOFSvGFF4hoT4MOFSv4RXz; Fri, 21 Nov 2025 10:20:15 +0000
X-Authority-Analysis: v=2.4 cv=XZyJzJ55 c=1 sm=1 tr=0 ts=69203cdf
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=4DtsFWJC70/ZxGj2xnZlig==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=7T7KSl7uo7wA:10
 a=jEDRzRcZQiSlmEJ3nGUA:9 a=QEXdDO2ut3YA:10 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1Zi2Rlboat3s++N0jwAAqz4jayQmv+NQPH4dP3X9BSc=; b=J5dU9Vq3+n7f5C0n2POtZJxyy0
	R5gtKKTbywE65sO1O6dGyL/ngu7LcW4Rtr6EqXCDcE5q+ZxN1zQ2c4U6fp5OM25mW+TzDOa8HXAk8
	08RGss8lgeCj4C8ejbkslJfQmgK+/f7zUkAKlBbx9H4a8Sga2iWiw/wSN9+VtPYBy8vAuqXo/82aG
	9fa7nA9FhMETn9uS4tNDWxNOn9l1cg7nvAXrMFnjC8X7o2/dS0/McPsS7zDs4R+j9yFe8If17h0qp
	tMHlWIS39endc8yhiYU+CjhBdM3WkWAE780zOROBIgv6xkuvVpsg4LKNF8rCAI06PNe/6DT26V0qT
	bts9O/2A==;
Received: from softbank126126126075.bbtec.net ([126.126.126.75]:57704 helo=[10.221.86.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vMOFR-00000001W4P-1mUC;
	Fri, 21 Nov 2025 04:20:14 -0600
Message-ID: <ff184c0e-17f2-445f-9339-f4db9943db86@embeddedor.com>
Date: Fri, 21 Nov 2025 19:19:54 +0900
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] wifi: rtl8xxxu: Avoid
 -Wflex-array-member-not-at-end warnings
To: Zenm Chen <zenmchen@gmail.com>, gustavoars@kernel.org
Cc: Jes.Sorensen@gmail.com, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 pkshih@realtek.com, rtl8821cerfe2@gmail.com
References: <aR2I9Sere0W-4VZz@kspp> <20251121100654.9125-1-zenmchen@gmail.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20251121100654.9125-1-zenmchen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 126.126.126.75
X-Source-L: No
X-Exim-ID: 1vMOFR-00000001W4P-1mUC
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: softbank126126126075.bbtec.net ([10.221.86.44]) [126.126.126.75]:57704
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOqQUevsv//AfLhfwJZUYOHwjHtHAXBIWbVDHFZLDWI7QEiDhOns0GKA0HPRl1p2nTF8bNDBXAoNUFXnOrEGHYv8cz+d12/ffNK2Li7qPE4DDpKepcZh
 117QKmcewlK8eFOV2JGKPHaBnpk6aC+JJLwu7x8ltoZRTIMtvgK4W22SweDk+aAXJQw4OxoR2CtGoBZbXg7Pw77BbfUQjDWfmCRRQcqvPm4uAYNhqQgQGxOq

Hi,

On 11/21/25 19:06, Zenm Chen wrote:
> Dear maintainers,
> 
> With this patch applied, my system always freezes right after the rtl8xxxu
> driver is loaded. is it normal?

I don't think so... It probably means that struct urb urb; cannot really be
moved to the end of struct rtl8xxxu_rx_urb or struct rtl8xxxu_tx_urb?

It'd be great if you could share a log.

Thanks for the report!
-Gustavo

> 
> OS: Arch Linux
> kernel: 6.17.8-arch1-1
> test devices: RTL8192{CU,EU,FU}
> 

