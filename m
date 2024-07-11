Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8DF14C5A4
	for <linux-hardening@vger.kernel.org>; Thu, 11 Jul 2024 18:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720721905; cv=none; b=qXQBRrjt4mx1TOgJqTbFZgcIRU0eenR7rlc1d/YB2Q2Zsdex+EFAHDjO75rDdfG9BOhBtFb2N/+7Bvq2398f4z04pQ4O1inuYDPV0a6+8Fg5nfY3AL6gePHN5B5hrV0N2SfK/CqdvJQTXYyUYA4jMWNvexRqv4rux5Np8zsp8Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720721905; c=relaxed/simple;
	bh=KqeU2aIPm1dA2sswWK0djOAQxAKPybiK3vkpWTjFZ6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZx/jv3XVJSXkFhPQR5DJ5RoMH6fs55GMRoUyYzOoK2G7txpohDOXEwPswkfgSYOfKtI6z88pZmM8trPCU2861qLaIdXlqyGk3ReezUB1NeaX3YI1nyrb/Bxb5lropM8mC+dndA7locRb3PSwiWEKN75EeUbvd1/ZvWKWr0+CsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=qf3D+XIC; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="qf3D+XIC"
Received: from eig-obgw-5007a.ext.cloudfilter.net ([10.0.29.141])
	by cmsmtp with ESMTPS
	id RvrasoUYOg2lzRyN5sLJpI; Thu, 11 Jul 2024 18:18:23 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id RyN4swqGUTnvcRyN5sssaI; Thu, 11 Jul 2024 18:18:23 +0000
X-Authority-Analysis: v=2.4 cv=c9StQw9l c=1 sm=1 tr=0 ts=669021ef
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=Q-fNiiVtAAAA:8 a=3O__t03nxoAqBYxMqfAA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=Fp8MccfUoT0GBdDC_Lng:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wuymeF+oGQKWG040Kc2x5n4TaYvuSS/2oSL6WIWLSvU=; b=qf3D+XICkmTRpAHLWTv2lwfeEz
	+JQsZ+HdEVwzvmS9AV9mr1UsOGxGEE605H0BmFXRk1nY+Ytw27whf7nfDdHrIqlFb0uosyRLgIZLE
	kDbB5J+VcQKd69AalTNmGc6tM4tkZj70gl2/isJr/w+5GePmbhrFmFFTBC2vduFuOnaqqCiQxMEy/
	q1uFn4Xlnk5vpyk/0vTijSdE4KWnSIE+Xe1r0Y4r4jO2oyeL+t/3+VCUFGX7UzsBQ/OawhBZ1M+N3
	56D8txdJwirWIeBb7JqL9zpsPBD5pjTbf81iq6kw0bwxN9k6BzEfWPElmcJdeTkY6yi4+G9EXi09d
	qDEuvQ5w==;
Received: from [201.172.173.139] (port=42650 helo=[192.168.15.4])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sRyN4-002MAo-0c;
	Thu, 11 Jul 2024 13:18:22 -0500
Message-ID: <a26cda3e-af6b-4a63-8334-2ffdc7b5a1e3@embeddedor.com>
Date: Thu, 11 Jul 2024 12:18:20 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] scsi: message: fusion: struct _CONFIG_PAGE_IOC_3:
 Replace 1-element array with flexible array
To: Kees Cook <kees@kernel.org>, Sathya Prakash <sathya.prakash@broadcom.com>
Cc: Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
 Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240711172432.work.523-kees@kernel.org>
 <20240711172821.123936-5-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240711172821.123936-5-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1sRyN4-002MAo-0c
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.4]) [201.172.173.139]:42650
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 53
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEaIF6hztMqkmV/6/m8iISX/645X9KpfDZgTCe6Sj0fXi5APE7vQmH1llirhneD5Du+EPC2JZJcGoJg/w3Fk5iD/b0BL0q7/9z7irW9jttCYDSg0pPUb
 gU+I2xceJOK/V0Vjjy2zfTM/EqtFHyBcAeGBtwd30J5XvAUxPOXxYK7z83TLCHQhTB+l5YQpxAbHMWHjoqMqi5rN7SNytN8WW/OdnPdnSFMGHZjiXQhyzw0i



On 11/07/24 11:28, Kees Cook wrote:
> Replace the deprecated[1] use of a 1-element array in
> struct _CONFIG_PAGE_IOC_3 with a modern flexible array.
> 
> Additionally add __counted_by annotation since PhysDisk is only ever
> accessed via a loops bounded by NumPhysDisks:
> 
> lsi/mpi_cnfg.h:    IOC_3_PHYS_DISK             PhysDisk[] __counted_by(NumPhysDisks); /* 08h */
> mptscsih.c:	for (i = 0; i < ioc->raid_data.pIocPg3->NumPhysDisks; i++) {
> mptscsih.c:		if ((id == ioc->raid_data.pIocPg3->PhysDisk[i].PhysDiskID) &&
> mptscsih.c:		    (channel == ioc->raid_data.pIocPg3->PhysDisk[i].PhysDiskBus)) {
> mptscsih.c:	for (i = 0; i < ioc->raid_data.pIocPg3->NumPhysDisks; i++) {
> mptscsih.c:		    ioc->raid_data.pIocPg3->PhysDisk[i].PhysDiskNum);
> mptscsih.c:		    ioc->raid_data.pIocPg3->PhysDisk[i].PhysDiskNum,
> mptscsih.c:	for (i = 0; i < ioc->raid_data.pIocPg3->NumPhysDisks; i++) {
> mptscsih.c:		if ((id == ioc->raid_data.pIocPg3->PhysDisk[i].PhysDiskID) &&
> mptscsih.c:		    (channel == ioc->raid_data.pIocPg3->PhysDisk[i].PhysDiskBus)) {
> mptscsih.c:			rc = ioc->raid_data.pIocPg3->PhysDisk[i].PhysDiskNum;
> mptscsih.c:	for (i = 0; i < ioc->raid_data.pIocPg3->NumPhysDisks; i++) {
> mptscsih.c:		    ioc->raid_data.pIocPg3->PhysDisk[i].PhysDiskNum);
> mptscsih.c:		    ioc->raid_data.pIocPg3->PhysDisk[i].PhysDiskNum,
> 
> No binary differences are present after this conversion.
> 
> Link: https://github.com/KSPP/linux/issues/79 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
> Cc: Sathya Prakash <sathya.prakash@broadcom.com>
> Cc: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
> Cc: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: MPT-FusionLinux.pdl@broadcom.com
> Cc: linux-scsi@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> ---
>   drivers/message/fusion/lsi/mpi_cnfg.h | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/message/fusion/lsi/mpi_cnfg.h b/drivers/message/fusion/lsi/mpi_cnfg.h
> index 7713c74e515b..bac49c162165 100644
> --- a/drivers/message/fusion/lsi/mpi_cnfg.h
> +++ b/drivers/message/fusion/lsi/mpi_cnfg.h
> @@ -1056,21 +1056,13 @@ typedef struct _IOC_3_PHYS_DISK
>   } IOC_3_PHYS_DISK, MPI_POINTER PTR_IOC_3_PHYS_DISK,
>     Ioc3PhysDisk_t, MPI_POINTER pIoc3PhysDisk_t;
>   
> -/*
> - * Host code (drivers, BIOS, utilities, etc.) should leave this define set to
> - * one and check Header.PageLength at runtime.
> - */
> -#ifndef MPI_IOC_PAGE_3_PHYSDISK_MAX
> -#define MPI_IOC_PAGE_3_PHYSDISK_MAX         (1)
> -#endif
> -
>   typedef struct _CONFIG_PAGE_IOC_3
>   {
>       CONFIG_PAGE_HEADER          Header;                                /* 00h */
>       U8                          NumPhysDisks;                          /* 04h */
>       U8                          Reserved1;                             /* 05h */
>       U16                         Reserved2;                             /* 06h */
> -    IOC_3_PHYS_DISK             PhysDisk[MPI_IOC_PAGE_3_PHYSDISK_MAX]; /* 08h */
> +    IOC_3_PHYS_DISK             PhysDisk[] __counted_by(NumPhysDisks); /* 08h */
>   } CONFIG_PAGE_IOC_3, MPI_POINTER PTR_CONFIG_PAGE_IOC_3,
>     IOCPage3_t, MPI_POINTER pIOCPage3_t;
>   
