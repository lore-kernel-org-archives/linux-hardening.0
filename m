Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E1E63C;
	Sat, 14 Dec 2024 13:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734184079; cv=none; b=G8+K5gN4PA39AA4xLqEK6qqKg6M9za7LJYpr/jZsUvg+MxIM+fdvBaULlDcvLnvka6H7efKc2R6OPOhYtvyvHkcPAzE66acE0gkyG1JN8+7BK/mw6QefDNmOobMWW3Ntlm+UfPh2my4z/Q5fKLIZBYM7rpF6jO1Foz/6/XiyBBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734184079; c=relaxed/simple;
	bh=LZbbw4TdedVXgjVnhKWy7MwsYwaZutoJjxlCq10noos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VCkhku9IK8rG9iL0RlmiR7GexLd1Bd9NZQbIspuN9qPWOjf/kmPkN7nMQtrF6YhFGUJeEFBueAZW1FXRcpAKmffAzub88/rkRL37OOoZWf5LB26Fi8KRyqYvzQ/C1V0fGbeCPMclY6K2f+ShYstQY3n8HP2G6aRfCNf8bLhCiGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A0qvZWgd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A0qvZWgd"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BECbxRr013247;
	Sat, 14 Dec 2024 13:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ceGrUj
	5LnvzZBejGcSiZq6IYs/Q4pb3RJuVhfxeWn/k=; b=A0qvZWgd0A3KRCM47S/4+i
	9qrBuTL29ttdljKr1Oz79nkNFupBOE5JxoDXslAjKztmp8eFDjp7ve3D2gZ/+VMq
	brxueZx5Il/lTJf1Urw99jVps9DaX4ehhAzxGyR0X+WeWG6Lx4SDpv6vj2NHQ5/A
	UxaPuvbV80a7TzaFsJeSiH24NL/54B+rWBAaG/M0VdAdj0YTGwfwepUuBJ7UNtp4
	0xcd1taOSn4lXCcbjsX3zq9sk8cF2w9y+35M7VZ+Jy6QrsoEHWjjuHXO0cdr6MWd
	+Wo6uUODXU+/IsCcUbZCfLSgqrO6jx3ts5VLLT5Hoyo3JsV31wVrF2ZgbEt74RQQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43gyenj6r5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 14 Dec 2024 13:47:45 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BEDiquK003253;
	Sat, 14 Dec 2024 13:47:45 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43gyenj6r3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 14 Dec 2024 13:47:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BEDJ42b016919;
	Sat, 14 Dec 2024 13:47:44 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d12yubmb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 14 Dec 2024 13:47:44 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BEDlheU38077106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Dec 2024 13:47:44 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A14825805A;
	Sat, 14 Dec 2024 13:47:43 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D59358051;
	Sat, 14 Dec 2024 13:47:41 +0000 (GMT)
Received: from [9.171.51.66] (unknown [9.171.51.66])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 14 Dec 2024 13:47:40 +0000 (GMT)
Message-ID: <2d752cd6-f861-40f4-8011-5571b84cbd64@linux.ibm.com>
Date: Sat, 14 Dec 2024 19:17:39 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fortify: Hide run-time copy size from value range
 tracking
To: Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Yury Norov <yury.norov@gmail.com>, Qing Zhao <qing.zhao@oracle.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        "gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>
References: <20241214013600.it.020-kees@kernel.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20241214013600.it.020-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -AykmngdXZMh8kIxqi36jIW0Vu4ruFZh
X-Proofpoint-GUID: KITAfpi-Q_XPFEnAdIXJwh4ApvKOWOzz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412140111



On 12/14/24 07:06, Kees Cook wrote:
> GCC performs value range tracking for variables as a way to provide better
> diagnostics. One place this is regularly seen is with warnings associated
> with bounds-checking, e.g. -Wstringop-overflow, -Wstringop-overread,
> -Warray-bounds, etc. In order to keep the signal-to-noise ratio high,
> warnings aren't emitted when a value range spans the entire value range
> representable by a given variable. For example:
> 
> 	unsigned int len;
> 	char dst[8];
> 	...
> 	memcpy(dst, src, len);
> 
> If len's value is unknown, it has the full "unsigned int" range of [0,
> UINT_MAX], and bounds checks against memcpy() will be ignored. However,
> when a code path has been able to narrow the range:
> 
> 	if (len > 16)
> 		return;
> 	memcpy(dst, src, len);
> 
> Then a range will be updated for the execution path. Above, len is now
> [0, 16], so we might see a -Wstringop-overflow warning like:
> 
> 	error: '__builtin_memcpy' writing between 9 and 16 bytes from to region of size 8 [-Werror=stringop-overflow]
> 
> When building with CONFIG_FORTIFY_SOURCE, the run-time bounds checking
> can appear to narrow value ranges for lengths for memcpy(), depending on
> how the compile constructs the execution paths during optimization
> passes, due to the checks on the size. For example:
> 
> 	if (p_size_field != SIZE_MAX &&
> 	    p_size != p_size_field && p_size_field < size)
> 
> As intentionally designed, these checks only affect the kernel warnings
> emitted at run-time and do not block the potentially overflowing memcpy(),
> so GCC thinks it needs to produce a warning about the resulting value
> range that might be reaching the memcpy().
> 
> We have seen this manifest a few times now, with the most recent being
> with cpumasks:
> 
> In function ‘bitmap_copy’,
>     inlined from ‘cpumask_copy’ at ./include/linux/cpumask.h:839:2,
>     inlined from ‘__padata_set_cpumasks’ at kernel/padata.c:730:2:
> ./include/linux/fortify-string.h:114:33: error: ‘__builtin_memcpy’ reading between 257 and 536870904 bytes from a region of size 256 [-Werror=stringop-overread]
>   114 | #define __underlying_memcpy     __builtin_memcpy
>       |                                 ^
> ./include/linux/fortify-string.h:633:9: note: in expansion of macro ‘__underlying_memcpy’
>   633 |         __underlying_##op(p, q, __fortify_size);                        \
>       |         ^~~~~~~~~~~~~
> ./include/linux/fortify-string.h:678:26: note: in expansion of macro ‘__fortify_memcpy_chk’
>   678 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>       |                          ^~~~~~~~~~~~~~~~~~~~
> ./include/linux/bitmap.h:259:17: note: in expansion of macro ‘memcpy’
>   259 |                 memcpy(dst, src, len);
>       |                 ^~~~~~
> kernel/padata.c: In function ‘__padata_set_cpumasks’:
> kernel/padata.c:713:48: note: source object ‘pcpumask’ of size [0, 256]
>   713 |                                  cpumask_var_t pcpumask,
>       |                                  ~~~~~~~~~~~~~~^~~~~~~~
> 
> This warning is _not_ emitted when CONFIG_FORTIFY_SOURCE is disabled,
> and with the recent -fdiagnostics-details we can confirm the origin of
> the warning is due to the FORTIFY range checking:
> 
> ../include/linux/bitmap.h:259:17: note: in expansion of macro 'memcpy'
>   259 |                 memcpy(dst, src, len);
>       |                 ^~~~~~
>   '__padata_set_cpumasks': events 1-2
> ../include/linux/fortify-string.h:613:36:
>   612 |         if (p_size_field != SIZE_MAX &&
>       |             ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   613 |             p_size != p_size_field && p_size_field < size)
>       |             ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
>       |                                    |
>       |                                    (1) when the condition is evaluated to false
>       |                                    (2) when the condition is evaluated to true
>   '__padata_set_cpumasks': event 3
>   114 | #define __underlying_memcpy     __builtin_memcpy
>       |                                 ^
>       |                                 |
>       |                                 (3) out of array bounds here
> 
> Note that this warning started appearing since bitmap functions were
> recently marked __always_inline in commit ed8cd2b3bd9f ("bitmap: Switch
> from inline to __always_inline"), which allowed GCC to gain visibility
> into the variables as they passed through the FORTIFY implementation.
> 
> In order to silence this false positive but keep deterministic
> compile-time warnings intact, hide the length variable from GCC with
> OPTIMIZE_HIDE_VAR() before calling the builtin memcpy.
> 
> Additionally add a comment about why all the macro args have copies with
> const storage.
> 
> Reported-by: "Thomas Weißschuh" <linux@weissschuh.net>
> Closes: https://lore.kernel.org/all/db7190c8-d17f-4a0d-bc2f-5903c79f36c2@t-8ch.de/
> Reported-by: Nilay Shroff <nilay@linux.ibm.com>
> Closes: https://lore.kernel.org/all/20241112124127.1666300-1-nilay@linux.ibm.com/
> Acked-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: "Qing Zhao" <qing.zhao@oracle.com>
> Cc: linux-hardening@vger.kernel.org
> 
>  v2: Make sure the expression statement ends with a single statement
>  v1: https://lore.kernel.org/all/20241213020929.work.498-kees@kernel.org/
> ---
>  include/linux/fortify-string.h | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> index 0d99bf11d260..1eef0119671c 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -616,6 +616,12 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
>  	return false;
>  }
>  
> +/*
> + * To work around what seems to be an optimizer bug, the macro arguments
> + * need to have const copies or the values end up changed by the time they
> + * reach fortify_warn_once(). See commit 6f7630b1b5bc ("fortify: Capture
> + * __bos() results in const temp vars") for more details.
> + */
>  #define __fortify_memcpy_chk(p, q, size, p_size, q_size,		\
>  			     p_size_field, q_size_field, op) ({		\
>  	const size_t __fortify_size = (size_t)(size);			\
> @@ -623,6 +629,8 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
>  	const size_t __q_size = (q_size);				\
>  	const size_t __p_size_field = (p_size_field);			\
>  	const size_t __q_size_field = (q_size_field);			\
> +	/* Keep a mutable version of the size for the final copy. */	\
> +	size_t __copy_size = __fortify_size;				\
>  	fortify_warn_once(fortify_memcpy_chk(__fortify_size, __p_size,	\
>  				     __q_size, __p_size_field,		\
>  				     __q_size_field, FORTIFY_FUNC_ ##op), \
> @@ -630,7 +638,11 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
>  		  __fortify_size,					\
>  		  "field \"" #p "\" at " FILE_LINE,			\
>  		  __p_size_field);					\
> -	__underlying_##op(p, q, __fortify_size);			\
> +	/* Hide only the run-time size from value range tracking to */	\
> +	/* silence compile-time false positive bounds warnings. */	\
> +	if (!__builtin_constant_p(__fortify_size))			\
> +		OPTIMIZER_HIDE_VAR(__copy_size);			\
> +	__underlying_##op(p, q, __copy_size);				\
>  })
>  
>  /*This patch works for me. I tested it on PowerPC and x86-64 using GCC 13.X,
CONFIG_FORTIFY_SOURCE=Y and CONFIG_NR_CPUS=2048. So,

Tested-By: nilay@linux.ibm.com
