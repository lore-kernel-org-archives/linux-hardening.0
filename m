Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9A01428F3
	for <linux-hardening@vger.kernel.org>; Sun, 10 Nov 2024 21:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731272814; cv=none; b=ncTK93bQlDIX1f9IkHu/NqdGjBMGRJCjplFhayLboJsdH3h33J/pNXIxOjSkYE/vopWa90EmPR1s8bQlagy70KcwVkRhDuIOxY5VX7w0kvKPXcqHQkuNtWXZnd/ZDckM7rpZTTWL5euqps/HxfE2nE1g8vl8UWhK7mA7zpxdoRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731272814; c=relaxed/simple;
	bh=RoImXjp7MGcwr2e4G5suORPS+HAf6mNHd56YA4Mr25Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p4bZwFnbp0GzzM9R0FKjczSu9OufHlOZXxVlMlmniqMdhW4pxgMJSM3jq/2lfXtFCwOEbceHGTbUIICODVuO+pBFlfLvhjqM25jEEVzdwmFIXCnAJlP9M5+DaKwI3qa1TKEVeuxuEbOizvtssztAOtKZoE8P3mnGcHKx8ermvIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=NAy9tZrN; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="NAy9tZrN"
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTPS
	id 9oJ1tuFU8VpzpAF8wtCU5i; Sun, 10 Nov 2024 21:06:46 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id AF8vt0dRGCgT6AF8wt9ppO; Sun, 10 Nov 2024 21:06:46 +0000
X-Authority-Analysis: v=2.4 cv=XvwxOkF9 c=1 sm=1 tr=0 ts=67312066
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=GtNDhlRIH4u8wNL3EA3KcA==:17
 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=7T7KSl7uo7wA:10
 a=-Klr6mLr8pg6UDE4wXQA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=o0adg+1j4txtlNvaOHyqcPDOTVdpAEqtR1MV+0wO+Sw=; b=NAy9tZrNaniaQh4hyIvSgpyzDD
	V0XirQl0MX+kQO9HdMzmjwyDcuYiVYhWWBm7H0zgEbRnZhkSnVMu62462gQ5QXUpeFJiV+Y/xEdh6
	Bp6h2z+SUg1wBOadFIbo/gwBlbVEXo27RyB2RCRQlZ2fnytt0VhMYHo6zjX6ZgupvjBL8U1CPYeOr
	dxOJZu94C5VPzZAui9oiek7Jev3VBlRjoV8eKk0oPN4UCvDpwCb0pE+e702ndeRHq32NL9uVVvigE
	bKjVpDI0N62+j4AS/937s73ndjDHobyxriVuAsR2XLP8k3C9rdGpN0qrUU6DpGMYB30QW5yxRYSFZ
	VqUsM5sQ==;
Received: from [177.238.21.80] (port=43976 helo=[192.168.0.21])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tAF8v-0045Jd-02;
	Sun, 10 Nov 2024 15:06:45 -0600
Message-ID: <8bc69322-f630-4235-9ee0-501e02623dd7@embeddedor.com>
Date: Sun, 10 Nov 2024 15:06:35 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: Replace zero-length array with flexible array
 member
To: Thorsten Blum <thorsten.blum@linux.dev>, Lee Duncan <lduncan@suse.com>,
 Chris Leech <cleech@redhat.com>, Mike Christie
 <michael.christie@oracle.com>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-hardening@vger.kernel.org,
 open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241110151749.3311-2-thorsten.blum@linux.dev>
 <202411110336.IDRXgcR4-lkp@intel.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202411110336.IDRXgcR4-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.21.80
X-Source-L: No
X-Exim-ID: 1tAF8v-0045Jd-02
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.21]) [177.238.21.80]:43976
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCqvvZm+GM5STJJqx8MlajxoOOVzP/0EZB1aHkRCz/KnSAP59FYNwDauPm8lvfeHLDWdV09FGIT06tLhywqTZio1oO3MhzFYjOwOt65ElnnwX6+w4Xi5
 MN1JRGKW7X/NQSbi3fB1XBZ1JGm8Sw3sDkAl5JknGEmPHE/iM7YVINThxhoo+pcdAzwP1eZg2AhsBkzNGqBJ//RwGny/FgYHBqFfBjWbamrQFPG2wo9K9x8M



>     In file included from drivers/scsi/scsi_transport_iscsi.c:23:
>>> include/scsi/scsi_bsg_iscsi.h:62:18: error: flexible array member in a struct with no named members
>        62 |         uint32_t vendor_rsp[];
>           |                  ^~~~~~~~~~

This won't be an issue in the near future, but for now just use DECLARE_FLEX_ARRAY().

Thanks
--
Gustavo

