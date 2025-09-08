Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AD24A2D
	for <linux-hardening@vger.kernel.org>; Mon,  8 Sep 2025 18:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757356277; cv=none; b=Ie/vHjW1/muDMsVPFuV7zhLPxIIwtuM7u9cXtYURQP1T7M/TlgYKWLhrpFmUH67w9/JeJK9F+qMHdMTEm6s/yerylSdStIibb5zBsT0N41eQwHfEQDfRUBwqTEXUr42LqBFFGwFqWLMG5OAR4sDWCvjPGYTOQ15aIYUpnTxesFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757356277; c=relaxed/simple;
	bh=wX9+IS0vJCWpzgflmJfrK2PcQPvegoFGe02wuEOQJSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jwivpc9sBMofN8I06dOBqG6Hhabn5Q7CHZ7hNBBMIsvMj0qq7UQwSX6YMvDaYofR4T1LquI/XsnIl5S35RilkSGncRDcHQ0ysgvXqlH/fVYXClv8eCkjYWerAkqITFA+CFZwoT/CrWIfVrj3A/7WLirkMOxAZhA3ZkNJ/tDIBKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=xtdIxK5w; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="xtdIxK5w"
Received: from eig-obgw-6003b.ext.cloudfilter.net ([10.0.30.175])
	by cmsmtp with ESMTPS
	id vaJ0u2ZPKLIlMvgdwuL3MK; Mon, 08 Sep 2025 18:31:08 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id vgdvuEBSahJZ2vgdvuGHDS; Mon, 08 Sep 2025 18:31:07 +0000
X-Authority-Analysis: v=2.4 cv=F/BXdrhN c=1 sm=1 tr=0 ts=68bf20eb
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=3MMl4rzW2iVmjiC4vQKzZA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=DahiFt0k3YZEWpF1MlMA:9 a=QEXdDO2ut3YA:10
 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SYa6hIJu3DY3TfnACEOnPdfbIxpdF/KfJFBTzkY9dx8=; b=xtdIxK5wsVqVSyqv6rAfYyyZ5v
	tHcMo9tds+hMG5WI2blz/uL2oX1M6sb0tfnn0TOUeZmlb6KUAuc5FsNE3L8Mk+0beC87Dr5Y00amO
	JIqruWo5s3dHw4Yep5g6K7FE3biTCW65VQIOpRcvFt21yqP9Wom+DrsOExDjziN+gItNVF2gX5WhU
	laH0LXoigohmw8h/T9VLpIEMz23GBzp36rMzTbDoGch+fQM7DJzhmMLAlX0tiDDigQGDwXi52ghWF
	79bNQOYkmvYFM6uipNgUhT+pDdIMeuGyAeLgfRxapBjiYgiCkYE3hsrjXCAdByOf7ajcmAMIGMffh
	jxKueYDg==;
Received: from 250-136.dsl.iskon.hr ([89.164.250.136]:49258 helo=[172.30.86.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1uvgdu-00000001s8F-1vKZ;
	Mon, 08 Sep 2025 13:31:06 -0500
Message-ID: <bcbbdc13-9b04-45b3-a1fc-20a4bf589850@embeddedor.com>
Date: Mon, 8 Sep 2025 20:30:58 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] scsi: pm80xx: Avoid
 -Wflex-array-member-not-at-end warnings
To: John Garry <john.g.garry@oracle.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Jack Wang <jinpu.wang@cloud.ionos.com>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <aLmoE8CznVPres5r@kspp>
 <47624b76-3b19-4805-b48a-040e943c7f2a@oracle.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <47624b76-3b19-4805-b48a-040e943c7f2a@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 89.164.250.136
X-Source-L: No
X-Exim-ID: 1uvgdu-00000001s8F-1vKZ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 250-136.dsl.iskon.hr ([172.30.86.44]) [89.164.250.136]:49258
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJi1Ik828mA1sPbqvnF8wRUO8SwG3uh+60csLfbkEu3bmZdMXs6fmo8P68sE0VRy3fdgvz2MABsd2sM/fnlIA2WHln8GuMCeA4WlXKSxlO0Ktje4Dl9p
 SUFqC7t/usiKb5xxbU21NH9HN7ZijnTB2P0ypVKFtLcpM90T1xUNrremqyJpv/cyXLU+Np0eA8RYfk2LZwXf4ia6959WvF9fcLK7jYxvXGg92Xt1A3d022Zi



On 9/5/25 09:05, John Garry wrote:
> On 04/09/2025 15:54, Gustavo A. R. Silva wrote:
>> Remove unused field residual_count in a couple of structures,
>> and with this, fix the following -Wflex-array-member-not-at-end
>> warnings:
>>
>> drivers/scsi/pm8001/pm8001_hwi.h:342:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member- 
>> not-at-end]
>> drivers/scsi/pm8001/pm80xx_hwi.h:561:32: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member- 
>> not-at-end]
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Personally I think that it would be better to comment-out the residual_count member, so that future developers can know about this field and why it is not there.

I agree. I'll send v3.

> 
> Anyway,
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>

Thanks!
-Gustavo

