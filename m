Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403AB1DE3CA;
	Sat, 24 May 2025 00:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748048034; cv=none; b=LgySteSAeS60aUNuGXnvvOhjH/ovBViAHcAg6N0Mc5L5l63CDPUd9OxdKDIc/N5faXm7NcBpE9xdGRtEoyIvFHCS4DolKlOmwwM+rcIi+joJZXDqjH3NqQ5iwpDMX9+FxUMB2NVvDZsQ1HkiA6LuK2kTmn5O8wXp3RTPQS2RI3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748048034; c=relaxed/simple;
	bh=o4ZCIdstP4akpvLI/xTOh3WGsK9Kd7BBZn+JNNXep3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=symffpKxqeLPilwU5i2CtqjkrUsGXXdaRPmofJe4SJFwDTUKM0TkRLlAWbZdyALU1AHvT+4nQQyzLasqswObKgKGH9WRemTiJqMIb1F+FdTsUqRi/JQIzZRabAzZFaQd6//dVJalepUcIm9//PQ3/AWUKUDGoRcBYnVdZcFDeG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lstcPD7c; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lstcPD7c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748048033; x=1779584033;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o4ZCIdstP4akpvLI/xTOh3WGsK9Kd7BBZn+JNNXep3o=;
  b=lstcPD7cqis68nq1eNzBC1XszvKRBHlih4gXCwod/dx0P6jjII7ilnhY
   1KD39+VPm6ZVxHrdO+bppcKEaCxJfBcUFnSRPWw9j7gkpSz+UxUqVE4W8
   9ZWJ4Z4WMXwj2tCmzveqCu1pdCY/DYzj1lJRsxaB+vFVtKbofDqYK5god
   e6/WiCrPA41BoIUp4R1nCphZ27ancTyplWfOmz3bhV0LhC4muVy65CbY9
   V3RxnhzD2fN/1i8KQPqkBmGQ9XOpT5AtZdtBqR8gSJPtAuaDrJb+ql++6
   OYUtvVy2RHBICp4XvRf6NdQatRPasYVii5x8pg7jTj/eNh4+Tx6sXp/kn
   A==;
X-CSE-ConnectionGUID: dKF3AfeFSwWZIeLyLtA8HA==
X-CSE-MsgGUID: cLIJJYmDRrShhO7CRj4bTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="75508444"
X-IronPort-AV: E=Sophos;i="6.15,310,1739865600"; 
   d="scan'208";a="75508444"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 17:53:52 -0700
X-CSE-ConnectionGUID: 46G+cFMqQ5ykPEn51US7kA==
X-CSE-MsgGUID: tTBhCX0NQPejqe8lvgJDRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,310,1739865600"; 
   d="scan'208";a="178484993"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 23 May 2025 17:53:49 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uId91-000QqG-0n;
	Sat, 24 May 2025 00:53:47 +0000
Date: Sat, 24 May 2025 08:52:58 +0800
From: kernel test robot <lkp@intel.com>
To: Kees Cook <kees@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Kees Cook <kees@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86: string_32.h: Provide basic sanity checks for
 fallback memcpy()
Message-ID: <202505240850.vTrqyqJx-lkp@intel.com>
References: <20250523042635.work.579-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523042635.work.579-kees@kernel.org>

Hi Kees,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/master]
[also build test ERROR on tip/x86/core kees/for-next/pstore kees/for-next/kspp linus/master v6.15-rc7 next-20250523]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kees-Cook/x86-string_32-h-Provide-basic-sanity-checks-for-fallback-memcpy/20250523-122803
base:   tip/master
patch link:    https://lore.kernel.org/r/20250523042635.work.579-kees%40kernel.org
patch subject: [PATCH] x86: string_32.h: Provide basic sanity checks for fallback memcpy()
config: i386-buildonly-randconfig-004-20250524 (https://download.01.org/0day-ci/archive/20250524/202505240850.vTrqyqJx-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250524/202505240850.vTrqyqJx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505240850.vTrqyqJx-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/x86/crypto/serpent_sse2_glue.c: In function 'serpent_decrypt_cbc_xway':
>> arch/x86/crypto/serpent_sse2_glue.c:39:19: error: assignment to 'const u8 *' {aka 'const unsigned char *'} from incompatible pointer type 'u8 (*)[16]' {aka 'unsigned char (*)[16]'} [-Werror=incompatible-pointer-types]
      39 |                 s = memcpy(buf, src, sizeof(buf));
         |                   ^
   cc1: some warnings being treated as errors


vim +39 arch/x86/crypto/serpent_sse2_glue.c

e0f409dcb82e463 Eric Biggers    2018-02-19  32  
9ad58b46f814edd Ard Biesheuvel  2021-01-05  33  static void serpent_decrypt_cbc_xway(const void *ctx, u8 *dst, const u8 *src)
e81792fbc2a6fa4 Jussi Kivilinna 2012-06-18  34  {
9ad58b46f814edd Ard Biesheuvel  2021-01-05  35  	u8 buf[SERPENT_PARALLEL_BLOCKS - 1][SERPENT_BLOCK_SIZE];
9ad58b46f814edd Ard Biesheuvel  2021-01-05  36  	const u8 *s = src;
e81792fbc2a6fa4 Jussi Kivilinna 2012-06-18  37  
9ad58b46f814edd Ard Biesheuvel  2021-01-05  38  	if (dst == src)
9ad58b46f814edd Ard Biesheuvel  2021-01-05 @39  		s = memcpy(buf, src, sizeof(buf));
9ad58b46f814edd Ard Biesheuvel  2021-01-05  40  	serpent_dec_blk_xway(ctx, dst, src);
9ad58b46f814edd Ard Biesheuvel  2021-01-05  41  	crypto_xor(dst + SERPENT_BLOCK_SIZE, s, sizeof(buf));
e81792fbc2a6fa4 Jussi Kivilinna 2012-06-18  42  }
e81792fbc2a6fa4 Jussi Kivilinna 2012-06-18  43  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
