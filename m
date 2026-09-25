Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778CE396585;
	Fri, 25 Sep 2026 06:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790317167; cv=none; b=Oh6iAyxpUaoWvqrQPrMLg7eibdiVFJTC9SI4ks4nXZYA/kxbviGNa5ZqjzAPNbvSbMBWf/cGNsdss04RJ7Mx5H/qPmA/6U+3bMS3QwYIMwXabs4mSA0s4CHPUKn0uSxSM3iSfzw6m27W1Hi0RPBJNyalT1H2kJhIVdiNUmNmCc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790317167; c=relaxed/simple;
	bh=hzyKINgYV+02Ombguje7nNnSMiMEPjCZCNaKplEhEbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iBWccdoLAOwUTv4Zp3n456z6/ufLtEmMpzy8aK2HEO0kDMbbMPq1aVy/H3tFtNd7ElYk+dkAOxzQfj/fxp0Q+7igoElhw69hzPrfMDpdGmrWSkdDB3hM74zj8E3ghK1poKv28wBG/7NPFYWf+pvNmK/0eh9RP7OoPiV1pxoDFTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Kev/huUu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Kev/huUu"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4ZpJG074220;
	Fri, 25 Sep 2026 06:19:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JwZgfB
	U2cREjbDtpwGI4XkkI+d3E0FjVL1IG8XF+KY8=; b=Kev/huUuCocM9Y8+dm6Plc
	WK3+phbVO1WP1AL9J+59CnklWTXSEXvLiHQlDE5R8x6DLB7Pt8tRfHFJXkEJgh2F
	UuL8DvzyXM4F5sto/fJ9Vhro4Nz/2IN3CB03dR5LtECUW5z7EfEW4XHsqzaBPCkM
	O/0Bpz+mKOD9Udqc/gdBHRavWiXNYL50Ia2z6d6J8H0RZo20DKNPZIdOz0OS67Xb
	niLJsAT0T+fIBM3pdxS/aZXyVHiyR55gyt4HsteJA0/5F5KnMvRjUtHYIG1dVpjj
	uSRTgEktYVlJWUljOcy8yj6xLwc/4CHmzeNHtlI9RYv54IGkJgV2KycDSGAbakMg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2wm2s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 06:19:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4lbPb1959571;
	Fri, 25 Sep 2026 06:19:11 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvu7edhjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 06:19:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68P6J8rC49873336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 06:19:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 098C620080;
	Fri, 25 Sep 2026 06:19:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7E8620082;
	Fri, 25 Sep 2026 06:19:05 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 06:19:05 +0000 (GMT)
Message-ID: <7d99725f-9c90-48ca-bee1-30e2e6c06617@linux.ibm.com>
Date: Fri, 25 Sep 2026 11:49:04 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/kexec: Annotate umem_info members with
 __counted_by_ptr
To: Thorsten Blum <thorsten.blum@linux.dev>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Aditya Gupta <adityag@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20260730130248.597249-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260730130248.597249-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: mNbLq6I6mXD6iqo2GJL9pRkCfLgKik4w
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab61261 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=6Q4QNdrZViBaKdIFhXcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAyNCBTYWx0ZWRfX3pd6JQ3v9BR9
 r1ocZx/kvamcpOyDn/bssgBItZDhkD/HFeIRqiR7qXvGYF+qE8+vufsBWeZHQXzjcvhXlu8xIHC
 XkD2neREomXhXk2+0rH5bsPdR8vTGM0mKInnSqyeTA1sz/p2LHpqLt1017ceNrXM6G+GD7G5RvZ
 dxnVmhI5GtotzfudNlF5dDzfKejqxxdEaWSJgidvTmTTd/bH6xpljPtpFWdJAt/aqfNRfProREw
 PFn02yTIi4TgifYdzEGYfdXucvfP6vKOinTSNJN3/jzPgTot3M4IIeN80i/THXijyNA77io/YqD
 X0gB2GFJeeGPQ2vEzJRgo/H2pDrMoTeAyKKFX+kVi962G8Cqe1A+f6Kdnfa1D0+2WAhcLzMoGYi
 qsmLlIvpqjkhPLB77qrr5fYvWlo5cF67Jt4Tw+Cj+8pwKBD3Jx5Xfwz9BX0G+ojT9OknDmpYlAO
 jggUU0OSP4RC1i+oq3g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAyNCBTYWx0ZWRfX084viY8Lz2/K
 T4uWXOy72gkyuegNCY7fXDBrqa8w8DeBwjAzMNU1du80L3/DsknGpNlQtrPYRYiMuZk4LHlNQqB
 cADmyjMT/pulHxUrB5ueKg4JBnWIfco=
X-Proofpoint-GUID: B7-TwWXS-zTQGGCuxC_rk4Lc6jcddlNN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250024



On 30/07/26 18:32, Thorsten Blum wrote:
> Add __counted_by_ptr() to umem_info::buf and umem_info::ranges to
> improve access bounds checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
>
> Set the count fields before assigning the corresponding pointers, return
> early on krealloc() failure, and use sizeof(*buf) when deriving
> max_entries from the allocation size.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   arch/powerpc/kexec/file_load_64.c | 22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
> index 8c72e12ea44e..6424b668f0e9 100644
> --- a/arch/powerpc/kexec/file_load_64.c
> +++ b/arch/powerpc/kexec/file_load_64.c
> @@ -34,14 +34,15 @@
>   #include <asm/cputhreads.h>
>   
>   struct umem_info {
> -	__be64 *buf;		/* data buffer for usable-memory property */
> +	/* data buffer for usable-memory property */
> +	__be64 *buf __counted_by_ptr(max_entries);
>   	u32 size;		/* size allocated for the data buffer */
>   	u32 max_entries;	/* maximum no. of entries */
>   	u32 idx;		/* index of current entry */
>   
>   	/* usable memory ranges to look up */
>   	unsigned int nr_ranges;
> -	const struct range *ranges;
> +	const struct range *ranges __counted_by_ptr(nr_ranges);
>   };
[...]
>   
>   const struct kexec_file_ops * const kexec_file_loaders[] = {
> @@ -83,11 +84,12 @@ static __be64 *check_realloc_usable_mem(struct umem_info *um_info, int cnt)
>   
>   	new_size = um_info->size + MEM_RANGE_CHUNK_SZ;
>   	tbuf = krealloc(um_info->buf, new_size, GFP_KERNEL);
> -	if (tbuf) {
> -		um_info->buf = tbuf;
> -		um_info->size = new_size;
> -		um_info->max_entries = (um_info->size / sizeof(u64));
> -	}
> +	if (!tbuf)
> +		return NULL;
> +
> +	um_info->size = new_size;
> +	um_info->max_entries = um_info->size / sizeof(*um_info->buf);
> +	um_info->buf = tbuf;


Could you please explain why size and max_entries are updated before the 
buffer itself?

- Sourabh Jain


>   
>   	return tbuf;
>   }
> @@ -288,13 +290,13 @@ static int update_usable_mem_fdt(void *fdt, struct crash_mem *usable_mem)
>   		return -EINVAL;
>   	}
>   
> -	um_info.buf  = NULL;
>   	um_info.size = 0;
>   	um_info.max_entries = 0;
> -	um_info.idx  = 0;
> +	um_info.buf = NULL;
> +	um_info.idx = 0;
>   	/* Memory ranges to look up */
> -	um_info.ranges = &(usable_mem->ranges[0]);
>   	um_info.nr_ranges = usable_mem->nr_ranges;
> +	um_info.ranges = usable_mem->ranges;
>   
>   	dn = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
>   	if (dn) {
>

