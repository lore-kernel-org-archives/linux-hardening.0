Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792740095;
	b=AEBWUj4Cz+2KTG8nlgNHZmaunv+4E/qg4dUfZOVVyqDhmeIdel7csnJfy/65od5YdIVF
	 xcjR6YZB7ILNneuRcMB+jAlt5i9xAZJ7A7X7L55Eov5ZK+HnhbSis+xybrEyb6ZKT6Iyk
	 F/wWUdvnC2rYe1UCNE2PffcDJlMQUglhRU/gfDVeI21rn0vxkryId+EDAR2t8jJKcZoh/
	 WNwM/DVliSJesHMCC8qIk0Jcumfhvv7W6n0UBRBQiFXHpIwaWkIPVOZvYTY+J47Em9ShS
	 GAkMiWPYEKG7A8C7ROXrNgQlvWGhL+H6hmA99Xrg5GNZ5T93VUrpazcvdNBE8nrRIJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792740095;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=WDR6ooeVIotixrIvIkb6JgGwf+BRY25SqpGfYwvLI0w=;
	b=psociUV+UXmqkGneGIpBiJf7T3UiWYPDAKPAK2ljRDsd1bA9xvEpEaNmlOxbnJeFOgS1
	 jlmva4o0O0e4Sv1z8GT759vu4AWdmLYWWWZcVHjP/dYAPkQbBd53S7yDjgCSDSiImW0EA
	 7iQbbU7A7Et+XG+JmC3QfufamMYdDjXXeWAsJa72VIeigX+pntHh1jZ792rLBfP32Nc8p
	 2kpWOhWorUHRWpjyFg8qZylzQAq+0D8T0Rhni63x79vXEOwyz/OmKFTXfw90nWtH9ybdw
	 20yI5fZI3CoDiOTHAbCSszy8bTF/GYbn4XwDmwFI5TEH6kWfXJV9J9wxxDCOL/WT6qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YM3Uz6JK;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4E4606A31D;
	Fri, 23 Oct 2026 07:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B4E4606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YM3Uz6JK
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7EYUC2353677;
	Fri, 23 Oct 2026 07:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WDR6oo
	eVIotixrIvIkb6JgGwf+BRY25SqpGfYwvLI0w=; b=YM3Uz6JKVmYd7A+JX/jLsX
	6PJJd49hAFT6u6G26itEf8S6MdVHqodWTs7xWMVbbwk/WYfbhvQIC8/zn21PVN7v
	cPwCNNSJSr546JddSWw7H7fw3+ZVckFsb5nCBkCG/o83NlycIN+NOr5qjLvzJ4I8
	VrjLU1gLooI5DnwWiF1lYLIfL7QOrDDiQOcERsRxBHPEqZY3G5+2aNSs3sXkeIJm
	EXdJdgQh146JrC15EQzOt1+gdUVFRobq3vuPWJVwALSPI5ex+dvfz7jEL61Y1C2M
	/wfDd38PPMVorvKqgPlJ8PLUvTnwRCy/X/95SGqpjC8KZ+SAx8JohHkGnyksy1Aw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw593tbd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 07:21:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7Js9L1759232;
	Fri, 23 Oct 2026 07:21:17 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hfj1x42ke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 07:21:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69N7LDrJ49283334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 07:21:13 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8ADBB20040;
	Fri, 23 Oct 2026 07:21:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBECC20043;
	Fri, 23 Oct 2026 07:21:10 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 07:21:10 +0000 (GMT)
Message-ID: <84309e06-83ef-4ce7-9072-2aeaa164d4a6@linux.ibm.com>
Date: Fri, 23 Oct 2026 12:51:09 +0530
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] powerpc/kexec: Annotate umem_info members with
 __counted_by_ptr()
To: Thorsten Blum <blum@kernel.org>,
        Madhavan Srinivasan
 <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20261020114029.200922-2-blum@kernel.org>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20261020114029.200922-2-blum@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: xswN8Vdk8p243iJ3MfEE7FinnZ-DD0I1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAyOCBTYWx0ZWRfX/9fnSKfqsczf
 T/34aentEg4lk8wFX8GDEe+vlEfFpbnMY3gRwJpEVzGWWWBu72D1UdL7PirlVb6sLTMU1M1UOOX
 O40WxZmSOnIV1rUyiQ+dHTvnI3nQYfc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAyOCBTYWx0ZWRfXzMhhaP/uYvMT
 h55nzxVGeP7uQIHId7eDPePb+ZK8VNG2jj9qNQDLVQIRo37Y9X68DShw5pAUJSFbT8g6nEDhpW8
 /o5pFAf5cYaeY5wGer2KWtlCJMpdryhpueF7eU75Wr3hRNdOelNKbnQALiNr0a5Z2Vla7dsRDM5
 xAFl8DrKStAgO2Dv2NTGpo11qjzWyTX62BGA83wsPtfg+j3CuSTawz/Tr2cht2tnM+togoPmzTe
 BYRNVuwUTutJAfa9Nrxpab1if9xygS8hyWZAAvb4ZqnhRGEPawEtNImkwKeN8mmrBt3w7/LlBqf
 0eNdRQ3vh8YZtsHq+e0VfPYrZ0U+oUt/HivdLiRc6m+ndXry9eFZzQv0RZv72FR+qwaifPg4rUa
 Zs8PSLby3dSy+nvsg01VYDhTRKt22VwLgsbmhkO0/xsgraK0UG+JE6D+3AEbEUkZhycO381jdEI
 MRUVI1iCf7OYn9Zmv0A==
X-Proofpoint-ORIG-GUID: sW66wudK0700NyCyqSmMOoJjZkfR6cGs
X-Authority-Analysis: v=2.4 cv=Ob4NnRTY c=1 sm=1 tr=0 ts=6adb0aee cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=0yJF51GdyllPhlXAo0gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230028



On 20/10/26 17:10, Thorsten Blum wrote:
> Add __counted_by_ptr() to umem_info::buf and umem_info::ranges to
> improve access bounds checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
>
> In check_realloc_usable_mem(), return early on krealloc() failure and
> use sizeof(*buf) when deriving max_entries from the allocation size.
>
> Signed-off-by: Thorsten Blum <blum@kernel.org>
> ---
> Changes in v2:
> - Preserve the original pointer/count assignment order (Sourabh Jain)
> - v1: https://lore.kernel.org/r/20260730130248.597249-2-thorsten.blum@linux.dev/
[...]
> ---
>   arch/powerpc/kexec/file_load_64.c | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
> index bd80c5fb1b1f..7f45493e7c7a 100644
> --- a/arch/powerpc/kexec/file_load_64.c
> +++ b/arch/powerpc/kexec/file_load_64.c
> @@ -34,14 +34,14 @@
>   #include <asm/cputhreads.h>
>   
>   struct umem_info {
> -	__be64 *buf;		/* data buffer for usable-memory property */
> +	__be64 *buf __counted_by_ptr(max_entries); /* data buffer for usable-memory property */
>   	u32 size;		/* size allocated for the data buffer */
>   	u32 max_entries;	/* maximum no. of entries */
>   	u32 idx;		/* index of current entry */
>   
>   	/* usable memory ranges to look up */
>   	unsigned int nr_ranges;
> -	const struct range *ranges;
> +	const struct range *ranges __counted_by_ptr(nr_ranges);
>   };
>   
>   const struct kexec_file_ops * const kexec_file_loaders[] = {
> @@ -83,11 +83,12 @@ static __be64 *check_realloc_usable_mem(struct umem_info *um_info, int cnt)
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
> +	um_info->buf = tbuf;
> +	um_info->size = new_size;
> +	um_info->max_entries = um_info->size / sizeof(*um_info->buf);

Yeah, it is better to maintain the order. The changes look good to me. 
Feel free to add them.
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>

>   
>   	return tbuf;
>   }
> @@ -288,12 +289,12 @@ static int update_usable_mem_fdt(void *fdt, struct crash_mem *usable_mem)
>   		return -EINVAL;
>   	}
>   
> -	um_info.buf  = NULL;
> +	um_info.buf = NULL;
>   	um_info.size = 0;
>   	um_info.max_entries = 0;
> -	um_info.idx  = 0;
> +	um_info.idx = 0;
>   	/* Memory ranges to look up */
> -	um_info.ranges = &(usable_mem->ranges[0]);
> +	um_info.ranges = usable_mem->ranges;
>   	um_info.nr_ranges = usable_mem->nr_ranges;
>   
>   	dn = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");

