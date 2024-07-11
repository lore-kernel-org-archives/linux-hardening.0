Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EE28F72
	for <linux-hardening@vger.kernel.org>; Thu, 11 Jul 2024 16:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720714698; cv=none; b=F+ygWPX00EOiImfG4pEmy8wmXDpoqzCrOGW3MDBiqX0xbdIGI7IyKujVOdl3IKZCU3xIUT0BzHNZQNsyPM/ZYVm7TLF5FhzxmIuZa4ZQcczApGIjEtgMZB5Do1hjsRmwkSRAos2Tg0AH0o+WcrrGpP0CjjtbW9dWL6DvluXLQjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720714698; c=relaxed/simple;
	bh=N3rDyLx52pO2BwM167/qhJZ+hV8rtvMa1SuTipsLRA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fitma59JGyOyWDzYKa4XhEJOKdLc1Ly+z0qgiBqgGnjx1cX3P9TEuV3tC34pk8UsCdUtk9b/0BySPM8W4OolJRV+QN60OlsbYPQ4T1WuGaLOeU5w12RNas9q4R4U/HCd6XRf0F5trStBEExPfcLBItBGnYlKv1j/ZZ1UwGZiH6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=uMKW2xnU; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="uMKW2xnU"
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
	by cmsmtp with ESMTPS
	id RtNRsQ2OniA19RwUos4ED8; Thu, 11 Jul 2024 16:18:14 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id RwUnsyZiH0vWTRwUnsoVLU; Thu, 11 Jul 2024 16:18:14 +0000
X-Authority-Analysis: v=2.4 cv=ffZmyFQF c=1 sm=1 tr=0 ts=669005c6
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=Q-fNiiVtAAAA:8 a=bLk-5xynAAAA:8 a=yPCof4ZbAAAA:8
 a=ieX9XyvoytEcL3Xr2ukA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=Fp8MccfUoT0GBdDC_Lng:22 a=zSyb8xVVt2t83sZkrLMb:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=I2NUgmT42oAokrukvToywtMJ4UZZ7x+Khfv2d+jZ0j4=; b=uMKW2xnUjWsLRpU7vB9fRKVvlz
	Ekz0mXvpOAVZN/aZcVWXOv/weU77Dh6vYK2wk13zNyvS/SbNtaDlwQt+W3t8L1TN5mTKMF/KP1UFM
	oBQ6L5ca8e/2jnwBbJE/Hw/SLFVi5J44w92Bmoy9jgK+u5CXUFQJoGhOkLfrjL26kDg4bhPcKQ8k8
	DuO3kJSRieGnxAtL8dVBY6VbONJ/pvawhsiJu1MJFUpf+6TlnzJxSUoyNWCg0ixZdmEc/WoMFS7v3
	3iqj5RGpWHlTezo8rXgh+JfU+stIp/EM9U0fuHkJnDzeIyhH5C2tfv3zTmDNLHRo54ASOe1IwopsT
	INEW+76Q==;
Received: from [201.172.173.139] (port=51936 helo=[192.168.15.4])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sRwUm-004JcF-04;
	Thu, 11 Jul 2024 11:18:12 -0500
Message-ID: <67e48181-611d-498c-abba-634b8f63ef25@embeddedor.com>
Date: Thu, 11 Jul 2024 10:18:10 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] scsi: mpi3mr: struct mpi3_sas_io_unit_page0: Replace
 1-element array with flexible array
To: Kees Cook <kees@kernel.org>,
 Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>,
 Sumit Saxena <sumit.saxena@broadcom.com>,
 Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Ranjan Kumar <ranjan.kumar@broadcom.com>, mpi3mr-linuxdrv.pdl@broadcom.com,
 linux-scsi@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240711155446.work.681-kees@kernel.org>
 <20240711155637.3757036-3-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240711155637.3757036-3-kees@kernel.org>
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
X-Exim-ID: 1sRwUm-004JcF-04
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.4]) [201.172.173.139]:51936
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 29
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPJHkLheJu7Fkpppvj8u4vwoiUsxAw6x3WuOdYVt6myWh8irb5gnzAuEEucAQd0Ktb2ls3SK1/Nm/N7lcYjEQRVx72Ss+MeNfOxVmQMOCFgnwlnP31d4
 bUNb41TFaPSOdLO52AFQyqT4eusyuasnOjT7qUUWEY+X/UnMkOQzqADToo/genTAC40fdplUckNxr9UoK9BQ6tTKLi598uemuGHmHPISlGQ5cXDr0irf2CqJ



On 11/07/24 09:56, Kees Cook wrote:
> Replace the deprecated[1] use of a 1-element array in
> struct mpi3_sas_io_unit_page0 with a modern flexible array.
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
> Cc: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
> Cc: Kashyap Desai <kashyap.desai@broadcom.com>
> Cc: Sumit Saxena <sumit.saxena@broadcom.com>
> Cc: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: Ranjan Kumar <ranjan.kumar@broadcom.com>
> Cc: mpi3mr-linuxdrv.pdl@broadcom.com
> Cc: linux-scsi@vger.kernel.org
> ---
>   drivers/scsi/mpi3mr/mpi/mpi30_cnfg.h | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/scsi/mpi3mr/mpi/mpi30_cnfg.h b/drivers/scsi/mpi3mr/mpi/mpi30_cnfg.h
> index 6a19e17eb1a7..66cca35d8e52 100644
> --- a/drivers/scsi/mpi3mr/mpi/mpi30_cnfg.h
> +++ b/drivers/scsi/mpi3mr/mpi/mpi30_cnfg.h
> @@ -1565,16 +1565,13 @@ struct mpi3_sas_io_unit0_phy_data {
>   	__le32             reserved10;
>   };
>   
> -#ifndef MPI3_SAS_IO_UNIT0_PHY_MAX
> -#define MPI3_SAS_IO_UNIT0_PHY_MAX           (1)
> -#endif
>   struct mpi3_sas_io_unit_page0 {
>   	struct mpi3_config_page_header         header;
>   	__le32                             reserved08;
>   	u8                                 num_phys;
>   	u8                                 init_status;
>   	__le16                             reserved0e;
> -	struct mpi3_sas_io_unit0_phy_data      phy_data[MPI3_SAS_IO_UNIT0_PHY_MAX];
> +	struct mpi3_sas_io_unit0_phy_data      phy_data[];
>   };
>   
>   #define MPI3_SASIOUNIT0_PAGEVERSION                          (0x00)
