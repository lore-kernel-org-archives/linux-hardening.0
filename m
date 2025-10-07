Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56F434BA33
	for <linux-hardening@vger.kernel.org>; Wed,  8 Oct 2025 01:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759886139; cv=none; b=c7/Dzy7GqSFEztGn5hhxCIU4EY/E9Gce7feE1NssI3DstCG9uVW8XV2ZWTTY5QiNLpb+ecAhyps3ryMw9ZMjWKugiBieAL6xoO+R62GzRDBI4JFaVBxOzfN1FZJJ5+AOgEacyobyPT51s6ZHQ5D2SbnxeKHnq4H3yyIOXTr19V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759886139; c=relaxed/simple;
	bh=cdt7ydO+dUgKG2KYyZ4WNjjRsfskQQuzfo9YuP87z9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qDizXoj7EyTpMrxYa8fRdwK/Id41C4C1JWEcUoxseM0NBUbMc52ttY4r+a4oYmqoXiD5p0zMGQ6fMQjAqAPW4zNXCFIRoDS/x3aItszATs/UYRKKZQlolOivCbznHUl8Fl2eFECxqBqpTBqgIIw2anE6VJKHjDlJAOCtMRuSeHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=xf6OrKI5; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="xf6OrKI5"
Received: from eig-obgw-5004b.ext.cloudfilter.net ([10.0.29.208])
	by cmsmtp with ESMTPS
	id 6Bc2vCtxseNqi6ImHvBGDL; Wed, 08 Oct 2025 01:15:37 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 6ImGvVS1sBc9y6ImGvxoSs; Wed, 08 Oct 2025 01:15:36 +0000
X-Authority-Analysis: v=2.4 cv=ZcMdNtVA c=1 sm=1 tr=0 ts=68e5bb38
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=4oHATN8Nx7vVUZJYxp75bA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=10s5MOYLZ7ui8ktsyOcA:9 a=QEXdDO2ut3YA:10 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aqsW+NffsBgefKI+Dz5Fto8mtaX/RlzjncBWta8l+dA=; b=xf6OrKI5XBSIW+IWtzu+gFVTak
	2u98wFgC9698uLi4K3y+m0nzSwpuc/AXbq9adOg6nfQMqJmpGvKSvd/+auE0W2vkmFINJck+lHyom
	8ErKslUFGLk87K5fXkQP1c93bSWN+Xp1EagRMjh3LuPmITX+ilxqh2OhRiOvWVmMcp8YweroGLLFb
	X5VQ3OyqLWT6fZEkloi0R88nIWZzEqG6HiDfGLEnLShAjBcVuChaLI8wyGZZniYDNX9Hf0o+Uir3Z
	x3ydBwtkkjnb1/es74H0dhqc++b9Xs57ePZf93BIYV0nhDphFJp2Z4SuXbtjZOt84FC+aDij03zZD
	mP4jOCFQ==;
Received: from [185.134.146.81] (port=53914 helo=[10.21.53.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1v65A3-00000000KC2-2aWi;
	Tue, 07 Oct 2025 05:43:15 -0500
Message-ID: <3a80fd1d-5a05-4db3-9dda-3ad38bedfb38@embeddedor.com>
Date: Tue, 7 Oct 2025 11:43:04 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] scsi: megaraid_sas: Avoid a couple
 -Wflex-array-member-not-at-end warnings
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Kashyap Desai <kashyap.desai@broadcom.com>,
 Sumit Saxena <sumit.saxena@broadcom.com>,
 Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
 Chandrakanth patil <chandrakanth.patil@broadcom.com>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <aM1E7Xa8qYdZ598N@kspp>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <aM1E7Xa8qYdZ598N@kspp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 185.134.146.81
X-Source-L: No
X-Exim-ID: 1v65A3-00000000KC2-2aWi
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([10.21.53.44]) [185.134.146.81]:53914
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDRh3HgUABN68QJymOgPv7Kk0s9t8fjqZG81MM/pf1A1wBDr05eD5+cXOwNMpAyN0OvCUxox8RMqANjv/EQoYNaEQpibaRiYM6DOboLE1e4WbYhV+ueh
 SbokyfMHH6BBCA6Zt0rgbRmHWbULegicvXKHSw1CM9W8h9lJwpPdYGU0ktrgk9mNeTN4qJSN+hCRcHlyN6di+rEPw1Oisgv0YABTzaSscaD9VntepDJLmZxz

Hi all,

Friendly ping: who can take this, please?

Thanks!
-Gustavo

On 9/19/25 12:56, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the new TRAILING_OVERLAP() helper to fix the following warnings:
> 
> drivers/scsi/megaraid/megaraid_sas_fusion.h:1153:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/scsi/megaraid/megaraid_sas_fusion.h:1198:32: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> This helper creates a union between a flexible-array member (FAM)
> and a set of MEMBERS that would otherwise follow it --in this case
> `struct MR_LD_SPAN_MAP ldSpanMap[MAX_LOGICAL_DRIVES_DYN]` and
> `struct MR_LD_SPAN_MAP ldSpanMap[MAX_LOGICAL_DRIVES]` in the
> corresponding structures.
> 
> This overlays the trailing members onto the FAM (struct MR_LD_SPAN_MAP
> ldSpanMap[];) while keeping the FAM and the start of MEMBERS aligned.
> 
> The static_assert() ensures this alignment remains, and it's intentionally
> placed inmediately after the corresponding structures --no blank line in
> between.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>   - Update changelog text --remove reference to unrelated structure.
> 
> v1:
>   - Link: https://lore.kernel.org/linux-hardening/aM1D4nPVH96DglfT@kspp/
> 
>   drivers/scsi/megaraid/megaraid_sas_fusion.h | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.h b/drivers/scsi/megaraid/megaraid_sas_fusion.h
> index b677d80e5874..ddeea0ee2834 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_fusion.h
> +++ b/drivers/scsi/megaraid/megaraid_sas_fusion.h
> @@ -1150,9 +1150,13 @@ typedef struct LOG_BLOCK_SPAN_INFO {
>   } LD_SPAN_INFO, *PLD_SPAN_INFO;
>   
>   struct MR_FW_RAID_MAP_ALL {
> -	struct MR_FW_RAID_MAP raidMap;
> -	struct MR_LD_SPAN_MAP ldSpanMap[MAX_LOGICAL_DRIVES];
> +	/* Must be last --ends in a flexible-array member. */
> +	TRAILING_OVERLAP(struct MR_FW_RAID_MAP, raidMap, ldSpanMap,
> +		struct MR_LD_SPAN_MAP ldSpanMap[MAX_LOGICAL_DRIVES];
> +	);
>   } __attribute__ ((packed));
> +static_assert(offsetof(struct MR_FW_RAID_MAP_ALL, raidMap.ldSpanMap) ==
> +	      offsetof(struct MR_FW_RAID_MAP_ALL, ldSpanMap));
>   
>   struct MR_DRV_RAID_MAP {
>   	/* total size of this structure, including this field.
> @@ -1194,10 +1198,13 @@ struct MR_DRV_RAID_MAP {
>    * And it is mainly for code re-use purpose.
>    */
>   struct MR_DRV_RAID_MAP_ALL {
> -
> -	struct MR_DRV_RAID_MAP raidMap;
> -	struct MR_LD_SPAN_MAP ldSpanMap[MAX_LOGICAL_DRIVES_DYN];
> +	/* Must be last --ends in a flexible-array member. */
> +	TRAILING_OVERLAP(struct MR_DRV_RAID_MAP, raidMap, ldSpanMap,
> +		struct MR_LD_SPAN_MAP ldSpanMap[MAX_LOGICAL_DRIVES_DYN];
> +	);
>   } __packed;
> +static_assert(offsetof(struct MR_DRV_RAID_MAP_ALL, raidMap.ldSpanMap) ==
> +	      offsetof(struct MR_DRV_RAID_MAP_ALL, ldSpanMap));
>   
>   
>   

