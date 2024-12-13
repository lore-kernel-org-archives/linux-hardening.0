Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E381AA7B9;
	Fri, 13 Dec 2024 09:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734081575; cv=none; b=pXbDe0rvXQtHwd0EuRNbnUZSvBXVQzUqE66eLGZjAlViRIhEBkO/aBuUrs8QeVOg9OJs3YCam0nxblbM2kmYdpMNE64a7r9Ui1TA2aB3cwbY+3boeouscZNdrg3uPUaqzekJc3gKO5JzSf4iSgLmSNCLgfWQi8BSsHwX53aAVww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734081575; c=relaxed/simple;
	bh=HJwZhAsdqAtQU3pNeQq+jqO3tZRihScMLYcZzE9U++o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I3yq42/N8n0+ZDq+yTn184D022NBT9QIF/SYlX+E3iSpIeccgTAA54XekiQ7xxubyPgCJ5nuh4EyvNowi5yZcvIkEr6smDLcix3z3ZiNnyhHgy75X/jTafyc6t0EHfoBB+kXSNMKiOXsfXP6LVfCzdpZ01Hi3AU63F0a1xgn2rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m3CmhQwM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m3CmhQwM"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD85doi011048;
	Fri, 13 Dec 2024 09:19:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+J5GaM
	qKzyLyQBirAmisjXQFKMe2D+YSxRNjolKojfM=; b=m3CmhQwMYq4apHKqZnV6Ug
	P7p58h6oeom59iw9N0a+6dLqDN0CkkqW07BECPRwm53TJnamJ+LEs9nmA8BVHuu9
	CntJxG+J310WzAAANb/ITFcEvdzDxFsbPD4Rb8b/aFPe27wOvTkqMqUaQYC43B2H
	sUtwIvT57TOAw7sc6Y1OSfz1TGyFfKBr0Pn1GLJtn3cu620Nx56nGLJXftnZ6mK1
	4Wi/ur5vqnMLi3IchaeLqGMcmAAHQIalofQRX8nnZTzqisJbP5cOIsqK7KJYii+I
	MYCW7N3XyffROGSdCBtuuIo/uKxp12xOrjFoNjhfYyfFxEamu9npb55e7xURcbEA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43gh438a9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 09:19:27 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BD9JNr4004642;
	Fri, 13 Dec 2024 09:19:26 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43gh438a9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 09:19:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD6iPjf023018;
	Fri, 13 Dec 2024 09:19:26 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d2wkctg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 09:19:26 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BD9JOTF15467074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 09:19:25 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCFB35805E;
	Fri, 13 Dec 2024 09:19:24 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0904358051;
	Fri, 13 Dec 2024 09:19:22 +0000 (GMT)
Received: from [9.109.198.241] (unknown [9.109.198.241])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Dec 2024 09:19:21 +0000 (GMT)
Message-ID: <3fa35755-f822-4a54-b8fb-4fdc16579c2f@linux.ibm.com>
Date: Fri, 13 Dec 2024 14:49:20 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fortify: Hide run-time copy size from value range
 tracking
To: Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Yury Norov <yury.norov@gmail.com>, Qing Zhao <qing.zhao@oracle.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        "gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>
References: <20241213020929.work.498-kees@kernel.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20241213020929.work.498-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: p6T3n0U-T58tzS-Cfqy8DlLzXMzakNsg
X-Proofpoint-GUID: -mgW8VF92n96Y3WMb0saSC1PQTOY1McB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130061



On 12/13/24 07:39, Kees Cook wrote:
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
> (Note that this warning started appearing since bitmap functions were
> recently marked __always_inline, which allowed GCC to gain visibility
> into the variables as they passed through the FORTIFY implementation.)
> 
> In order to silence this false positive but keep deterministic
> compile-time warnings intact, hide the length variable from GCC with
> OPTIMIZE_HIDE_VAR() before calling the builtin memcpy.
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
> ---
>  include/linux/fortify-string.h | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> index 0d99bf11d260..cab419f3a05f 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -630,7 +630,16 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
>  		  __fortify_size,					\
>  		  "field \"" #p "\" at " FILE_LINE,			\
>  		  __p_size_field);					\
> -	__underlying_##op(p, q, __fortify_size);			\
> +	if (__builtin_constant_p(__fortify_size)) {			\
> +		/* Pass through compile-time value for real warnings. */\
> +		__underlying_##op(p, q, __fortify_size);		\
> +	} else {							\
> +		/* Hide the run-time size from compile-time value */	\
> +		/* range tracking to silence false positives. */	\
> +		size_t ___fortify_size = __fortify_size;		\
> +		OPTIMIZER_HIDE_VAR(___fortify_size);			\
> +		__underlying_##op(p, q, ___fortify_size);		\
> +	}								\
>  })
>  
>  /*

Thank you for the patch and explanation!

I just applied your patch now I see following error while building latest upstream 
kernel using GCC 13.x (I tested it on x86-64 and PowerPC):

In file included from ./include/linux/string.h:389,
                 from ./arch/powerpc/include/asm/paca.h:16,
                 from ./arch/powerpc/include/asm/current.h:13,
                 from ./include/linux/thread_info.h:23,
                 from ./include/asm-generic/preempt.h:5,
                 from ./arch/powerpc/include/generated/asm/preempt.h:1,
                 from ./include/linux/preempt.h:79,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/wait.h:9,
                 from ./include/linux/wait_bit.h:8,
                 from ./include/linux/fs.h:6,
                 from ./include/uapi/linux/aio_abi.h:31,
                 from ./include/linux/syscalls.h:83,
                 from fs/d_path.c:2:
fs/d_path.c: In function ‘dynamic_dname’:
./include/linux/fortify-string.h:620:63: error: void value not ignored as it ought to be
  620 |                              p_size_field, q_size_field, op) ({         \
      |                                                              ~^~~~~~~~~~~
  621 |         const size_t __fortify_size = (size_t)(size);                   \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  622 |         const size_t __p_size = (p_size);                               \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  623 |         const size_t __q_size = (q_size);                               \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  624 |         const size_t __p_size_field = (p_size_field);                   \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  625 |         const size_t __q_size_field = (q_size_field);                   \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  626 |         fortify_warn_once(fortify_memcpy_chk(__fortify_size, __p_size,  \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  627 |                                      __q_size, __p_size_field,          \
      |                                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  628 |                                      __q_size_field, FORTIFY_FUNC_ ##op), \
      |                                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  629 |                   #op ": detected field-spanning write (size %zu) of single %s (size %zu)\n", \
      |                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  630 |                   __fortify_size,                                       \
      |                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  631 |                   "field \"" #p "\" at " FILE_LINE,                     \
      |                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  632 |                   __p_size_field);                                      \
      |                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  633 |         if (__builtin_constant_p(__fortify_size)) {                     \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  634 |                 /* Pass through compile-time value for real warnings. */\
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  635 |                 __underlying_##op(p, q, __fortify_size);                \
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  636 |         } else {                                                        \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  637 |                 /* Hide the run-time size from compile-time value */    \
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  638 |                 /* range tracking to silence false positives. */        \
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  639 |                 size_t ___fortify_size = __fortify_size;                \
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  640 |                 OPTIMIZER_HIDE_VAR(___fortify_size);                    \
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  641 |                 __underlying_##op(p, q, ___fortify_size);               \
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  642 |         }                                                               \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  643 | })
      | ~~                                                             
./include/linux/fortify-string.h:687:26: note: in expansion of macro ‘__fortify_memcpy_chk’
  687 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
      |                          ^~~~~~~~~~~~~~~~~~~~
fs/d_path.c:315:16: note: in expansion of macro ‘memcpy’
  315 |         return memcpy(buffer, temp, sz);
      |                ^~~~~~
fs/d_path.c:316:1: error: control reaches end of non-void function [-Werror=return-type]
  316 | }
      | ^
cc1: all warnings being treated as errors
make[3]: *** [scripts/Makefile.build:194: fs/d_path.o] Error 1
make[3]: *** Waiting for unfinished jobs....



THERE ARE many such more such instances of the error (as I am building in parallel 
and before build stops, I also see few more errors):

In file included from ./include/linux/build_bug.h:5,
                 from ./include/linux/bits.h:22,
                 from ./include/linux/gfp_types.h:5,
                 from ./include/linux/gfp.h:5,
                 from ./include/linux/slab.h:16,
                 from kernel/fork.c:16:
kernel/fork.c: In function ‘vm_area_dup’:
./include/linux/compiler.h:212:21: error: variable or field ‘__v’ declared void
  212 |         __auto_type __v = (expr);                                       \
      |                     ^~~
kernel/fork.c:498:9: note: in expansion of macro ‘data_race’
  498 |         data_race(memcpy(new, orig, sizeof(*new)));
      |         ^~~~~~~~~
./include/linux/compiler.h:212:27: error: void value not ignored as it ought to be
  212 |         __auto_type __v = (expr);                                       \
      |                           ^
kernel/fork.c:498:9: note: in expansion of macro ‘data_race’
  498 |         data_race(memcpy(new, orig, sizeof(*new)));
      |         ^~~~~~~~~
  CC      security/keys/key.o
certs/blacklist.c: In function ‘get_raw_hash’:
certs/blacklist.c:169:11: error: void value not ignored as it ought to be
  169 |         p = memcpy(buffer, type_prefix, type_len);
      |           ^
make[3]: *** [scripts/Makefile.build:194: certs/blacklist.o] Error 1
make[2]: *** [scripts/Makefile.build:440: certs] Error 2
make[2]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:194: kernel/fork.o] Error 1
make[2]: *** [scripts/Makefile.build:440: kernel] Error 2


Please let me know if you need more information.

Thanks,
--Nilay
