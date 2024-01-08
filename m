Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD79D56444
	for <linux-hardening@vger.kernel.org>; Mon,  8 Jan 2024 17:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="jLz2of3V"
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
	by cmsmtp with ESMTPS
	id MkYGrT0CS9gG6MtaJr6tlr; Mon, 08 Jan 2024 17:38:47 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id MtaIr9oWEyxR5MtaIrCx9S; Mon, 08 Jan 2024 17:38:46 +0000
X-Authority-Analysis: v=2.4 cv=JYOvEGGV c=1 sm=1 tr=0 ts=659c3326
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=GfQleyYEO+cc22AUyTT7qQ==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=wYkD_t78qR0A:10
 a=ic43B64CF9VcJqpiiBIA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Co6guZYByp4kdojxfU2irqToohe93bbVbLlOGGL1NZw=; b=jLz2of3VyaBSe/9M9xNFKptdMz
	vt9kIpSMNfwwSo4FKv9LHvj5rHV8HnPms9MeP/+kX4BONZRZEs86nxsACg2DN29U5YWHQAE54BNTO
	6QKmb1vsMg55TD7QOb6fw1YFBVkYGkVuBes2QU7vM7sn/HOQQ/jQ8Ii1cyiKRfjAiQYTT/dvS8Qfl
	lNe2dW+e2u0wit2526MRyTUU4cNXydf7ro0jiqLqsyJ5SHaa9tSwgzglhZOQxhGYATAocsV3mpu66
	dJYmrag6HyUOjmZChxqxl9TUF6ZIpKbkJa/mi+JaV6rAehzqYlJQ/sgBKAdsrgGpGcXQfXt85nVwN
	ZVI7aDJA==;
Received: from 187.184.157.186.cable.dyn.cableonline.com.mx ([187.184.157.186]:17540 helo=[192.168.0.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rMtaH-0032b8-0n;
	Mon, 08 Jan 2024 11:38:45 -0600
Message-ID: <eacdc1fe-df5c-472f-9e83-971bbe36e8b5@embeddedor.com>
Date: Mon, 8 Jan 2024 11:38:41 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] VMCI: Fix memcpy() run-time warning in
 dg_dispatch_as_host()
Content-Language: en-US
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-hardening@vger.kernel.org, keescook@chromium.org,
 error27@gmail.com, gustavoars@kernel.org, Bryan Tan <bryantan@vmware.com>,
 Vishnu Dasa <vdasa@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, vegard.nossum@oracle.com,
 darren.kenny@oracle.com, syzkaller <syzkaller@googlegroups.com>
References: <20240105164001.2129796-1-harshit.m.mogalapalli@oracle.com>
 <20240105164001.2129796-2-harshit.m.mogalapalli@oracle.com>
 <fc132bde-d42d-4aac-ba91-7a939a18091a@moroto.mountain>
 <7826922a-d642-424e-bede-bfc45be9254d@embeddedor.com>
 <c9aff51d-918a-49d7-ae31-395cc6a5881b@oracle.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <c9aff51d-918a-49d7-ae31-395cc6a5881b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.157.186
X-Source-L: No
X-Exim-ID: 1rMtaH-0032b8-0n
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.157.186.cable.dyn.cableonline.com.mx ([192.168.0.10]) [187.184.157.186]:17540
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 28
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfA49JJu85p9cz8g3hofzFWY1ckUDkEZzcZqxxsuP8Kjdg7VA0U815iJGDf7jNClVcifpLft14FpBSKQgW+3Cixd228ln41nyiF/TOmOtyJjOKJL5yllE
 cwITIsSU32gRrUkvacmjhaYhMgL7YQocnAZZI3dqJ6khgs+/BnWoxTQpXV0xdQLRICe809MYZAgBs508oOpY03vvEbT3NUdja0cvC+z7YNyuaDxwgd5kSLAp



On 1/8/24 11:31, Harshit Mogalapalli wrote:

>> BTW, is this _warning_ really causing a crash?
>>
> 
> I think we can say this can cause a crash in a way, WARN_ONCE() is still a WARNING and we can have systems with panic_on_warn set.
> 

Oh yes! thanks for the clarification. :)

--
Gustavo
