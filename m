Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB4D3148CD
	for <linux-hardening@vger.kernel.org>; Thu, 25 Sep 2025 18:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758826652; cv=none; b=NLpHuyYI9A/KxWHl1ADp1883Wtaat1xhDG0EzEyrVALaE5Yq2ghgQvn60hFz5vX4dQZWJpVCn40ArR7EGCijjvu/77d5816oj+awfWuWEbapaWY8wgqU+/Nz7CRwnslTB8Z/76jr9w67TiJ1ENDPPVm26gPuAcxaqkxZ9hdoofE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758826652; c=relaxed/simple;
	bh=IT1T/CNTfmVdSh+PUFKd5FSqcVyO0aW3BPVmNwmdlxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FyZlxecfrQ6dGZfpkVHOKqmYueqCRljxumNlEI6M2YiB+/ZEua6s/Nq/cficJA4thXZBwlyK8ztjaKLegdANr3CdXKjOfG/n9+OxA+L4MHuGM1OV/KgDOuMEAvJDQF4g6mu327TkK0NSPEZWDDMBv/xVURStqu/ntviroW2OWlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=i5HQtdbH; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="i5HQtdbH"
Received: from eig-obgw-5004b.ext.cloudfilter.net ([10.0.29.208])
	by cmsmtp with ESMTPS
	id 1bHAv5TcMZx2i1r9mvw0aN; Thu, 25 Sep 2025 18:57:30 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 1r9kvH0boBc9y1r9kv1lXe; Thu, 25 Sep 2025 18:57:28 +0000
X-Authority-Analysis: v=2.4 cv=ZcMdNtVA c=1 sm=1 tr=0 ts=68d59098
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=kbmabLdzh3uUJaiPGAIkPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=EiXV_-hVxRXBCySLXD0A:9 a=QEXdDO2ut3YA:10
 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JyfJbOr4FPBdl+V+aO2gF9yBV+nlou8/xVouFbJmoYo=; b=i5HQtdbHdtH3vcVpqbjjn2ie8U
	AWcvRl2YSGLCnC8cV6XqBsEJdnlpnAvjUrFErksi/KCc8KNonWXPxEwobhD9e8T2RlVjVMRT79lHk
	oR4v5EqdjbxbONQge8+Xd3FNFf9UuKPvKu48QrCExjMQdSI8yeKRYYopGwUSnbjEH/fqqa1hPBEJB
	dsb5oCZV8T/k9uBRwisgb3wSqr7jJKjhOgoouzJul35rNGpQSZb88dRjAIISc4dMVWGrp/SJBR6gp
	h6IdV2vh7T6/zgTsGmZpy900iL7eBZkP2XOgLTyfiRpRm74h6iowDE6XmhlSMEv0Cbw146oLujSpt
	P6+8+VBQ==;
Received: from [83.214.221.223] (port=45832 helo=[192.168.1.104])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1v1r9g-00000000TKO-01Gd;
	Thu, 25 Sep 2025 13:57:24 -0500
Message-ID: <7b1342ce-0f30-4481-bf3b-ef3c92b9bcf8@embeddedor.com>
Date: Thu, 25 Sep 2025 20:57:07 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "scsi: qla2xxx: Fix memcpy() field-spanning write
 issue"
To: John Meneghini <jmeneghi@redhat.com>, bgurney@redhat.com,
 martin.petersen@oracle.com
Cc: axboe@kernel.dk, emilne@redhat.com, gustavoars@kernel.org, hare@suse.de,
 hch@lst.de, james.smart@broadcom.com, kbusch@kernel.org, kees@kernel.org,
 linux-hardening@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, njavali@marvell.com, sagi@grimberg.me
References: <yq1zfajqpec.fsf@ca-mkp.ca.oracle.com>
 <20250925130729.776904-1-jmeneghi@redhat.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20250925130729.776904-1-jmeneghi@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 83.214.221.223
X-Source-L: No
X-Exim-ID: 1v1r9g-00000000TKO-01Gd
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.104]) [83.214.221.223]:45832
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 21
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAO/2aVS6lYRQ5IqiTRG4QuASx97C5NerD7sbH8lgNpRL+w0HEvwSpU7AsveQVvMQwA6d+suOapJVHI6w+c9bXfXQSUK+Tx1vQpjmpj6z7g2aqdOe9Jg
 ORxXxMqThC2kCSrPSEGxfxz5qb2lZTggxFp4hidLuKgbV8l8ONpi2cFc4Mxl6bz4aMjmNSNDZvejV6iztlMd8tusJgZV3mlciHMRAxNNt241t1wjZVuqo8q3



On 9/25/25 15:07, John Meneghini wrote:
> This reverts commit 6f4b10226b6b1e7d1ff3cdb006cf0f6da6eed71e.
> 
> We've been testing this patch and it turns out there is a significant
> bug here. This leaks memory and causes a driver hang.
> 
> Link:
> https://lore.kernel.org/linux-scsi/yq1zfajqpec.fsf@ca-mkp.ca.oracle.com/
> 
> Signed-off-by: John Meneghini <jmeneghi@redhat.com>

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-Gustavo

