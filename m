Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1D629A9FA;
	Thu,  5 Feb 2026 16:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770309613; cv=none; b=ueRfO9JIqb3vFWthfTySHuglmbnzvG1lG6m070mxWbOlBrg6FHBFZ5SZXlcZ8WloH5kOp8RX/zJ1ogrn/sDqwGExejMaBd9Q8m3UeYNVZTpDK90hXZ1AKTAr2cdVq7kp3G7iAQS8A7WzImgpXENVHh7aZkvy7r2K4hoJs0+A/Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770309613; c=relaxed/simple;
	bh=qifjVohAwoQbELn/0XpFtemnQ2ErMQPvwk66pleBzvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xe0KKuf1WzgCnnu7u6rd7/hrT3mqwFAPB7cx/zujz7PPZUiRnpNYRKJJuP8ckT7jj4Jg6VP+dHL5kn7RUzEhE9MQ5RajSPUmrs3/8sjefuJDhnmGDA+f+TaUO5AVPDfXvX8ZMlzvRX6tGwCbpmZMWO4zI5q/zmJPW0JjWyDOUCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aCs015GB; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aCs015GB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770309614; x=1801845614;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qifjVohAwoQbELn/0XpFtemnQ2ErMQPvwk66pleBzvk=;
  b=aCs015GBXaSes8Z70NGIxTZBJHEMl/mCqqEvSG0YqPpQSNJdMINVokS3
   ZeYFdFV50V8P1cv+l3+QCZxpwDBdZ3WYdKautogIyAkvezVCMRsyQacb/
   7E2+p0T4u1xPQg6G+dXNjPzN6Evs74UKV0O1QJE0x4tfqMmEDF2ouZrv5
   +ae4amjPbEenbs3bw/qzplA1gGNuvlJyRDe8VPemCqfEGlg0CkJ9Cz3wx
   NX5BjpEOuVtOa/rfMrZ9yAnCAYud6UsUxXwmYlVExtmcMjBK71qsJFwU9
   UZml65Hd+Kdvl2awwyMlE+b6steL5c+DI0E96DJwDoKFjFMiL6jrnzgs7
   Q==;
X-CSE-ConnectionGUID: 3rL2pewlSgaissCNt4UFFw==
X-CSE-MsgGUID: HLXsoCGNTOaVVR4VIEkM6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="94158743"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="94158743"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 08:40:13 -0800
X-CSE-ConnectionGUID: 57yKVgOzQGefTv4/z/HjLw==
X-CSE-MsgGUID: uhZGgVX5QxS+TXPSN0UFGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="210409824"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.142])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 08:40:10 -0800
Date: Thu, 5 Feb 2026 18:40:08 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Xie Yuanbin <xieyuanbin1@huawei.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, kees@kernel.org, andy@kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, lilinjie8@huawei.com,
	liaohua4@huawei.com
Subject: Re: [PATCH 2/2] powerpc/text-patching: Fix possible
 stringop-overread compilation error
Message-ID: <aYTH6A2rZQ4Ky-PL@smile.fi.intel.com>
References: <20260205100517.292858-1-xieyuanbin1@huawei.com>
 <20260205100517.292858-2-xieyuanbin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260205100517.292858-2-xieyuanbin1@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Feb 05, 2026 at 06:05:17PM +0800, Xie Yuanbin wrote:

First of all, when sending a series, always add a cover letter to explain
dependencies, goal, and how to route the series via the respective tree(s),
et cetera.

> For strnlen(), if the compiler detects that the maxlen argument exceeds
> the valid memory size of the input string object, a compilation error may
> occur.
> 
> For lastest linux-next source, changing ppc_kallsyms_lookup_name() to
> __always_inline,

So, there is no issue in upstream without the mentioned change, right?

> using default ppc64_defconfig, and setting
> CONFIG_EXPERT=y, CONFIG_PPC64_BIG_ENDIAN_ELF_ABI_V2=n,
> CONFIG_CC_OPTIMIZE_FOR_SIZE=y. Then, when using gcc-15 for compilation,
> the following error will be triggered:
> ```log
>   CC      arch/powerpc/kernel/optprobes.o
> In file included from ./arch/powerpc/include/asm/kprobes.h:24,
>                  from ./include/linux/kprobes.h:31,
>                  from arch/powerpc/kernel/optprobes.c:8:
> In function ‘ppc_kallsyms_lookup_name’,
>     inlined from ‘arch_prepare_optimized_kprobe’ at arch/powerpc/kernel/optprobes.c:209:21:
> ./arch/powerpc/include/asm/text-patching.h:232:13: error: ‘strnlen’ specified bound 512 exceeds source size 19 [-Werror=stringop-overread]
>   232 |         if (strnlen(name, KSYM_NAME_LEN) >= KSYM_NAME_LEN)
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In function ‘ppc_kallsyms_lookup_name’,
>     inlined from ‘arch_prepare_optimized_kprobe’ at arch/powerpc/kernel/optprobes.c:210:22:
> ./arch/powerpc/include/asm/text-patching.h:232:13: error: ‘strnlen’ specified bound 512 exceeds source size 13 [-Werror=stringop-overread]
>   232 |         if (strnlen(name, KSYM_NAME_LEN) >= KSYM_NAME_LEN)
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> ```
> 
> Refer to the implementation of fortify's strnlen(). If the string length
> is a compile-time constant, do not call the strnlen() function.

I don't with the first patch this is a correct approach.
But I let others to comment, I assume Kees knows better
what's this and how it can be fixed without exporting
special macros.

-- 
With Best Regards,
Andy Shevchenko


