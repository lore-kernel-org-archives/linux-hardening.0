Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A2D23BCE3;
	Wed, 20 May 2026 00:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779237932; cv=none; b=eGPNzv++LCuwFKE3SGKBhN/h7gzAyOptUJDJAJLGKY2Wf+Ia7VpLzNeXkzTlVaA67W9g3ssG7L4Bqsu4SfVGqAtWCBPaceonsHAU4KORaTx8oreEwc8oySArmnWxq6O7dc5N97lqMvT2MsJReB4xfmbheyxmSbPmGVpHzZgneDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779237932; c=relaxed/simple;
	bh=4PsJnTUON22Goo6tlt1Y6Ak2MmT6eI/0fKJ8ErFBhuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALKactPKufS0/sr8wMH+dOjbRS1kH18to0ydUTIRAdYVAJVZ4n92ySKA/cDLEkZmWmZpIElRmOD+peomwqBJiftNrFFbSAJ7NGn6PaxqarpOorEH7qHSwCA/ck/4qvlMPL5/qilWZrRKlHkzWk+rWxEonFHx7cm+go31+Cu8tH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SxLH695X; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SxLH695X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779237931; x=1810773931;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4PsJnTUON22Goo6tlt1Y6Ak2MmT6eI/0fKJ8ErFBhuE=;
  b=SxLH695XLI1USN5MWy8tt1LeRDAAZ6bt8upBXl6KjgGI87hjNXMbUfK6
   sxpZkHZYkjI17LjG4N7XaFewbWCw4Lq412UHeA2bjsiK9nZOszR2VnjMS
   PVuVMRx0DhDD4z4JdvRyrlSGIYxwr/OWOqnFlq2QLIOihT4mMAPca4pM2
   RxMjeSkjFawGiJJC0x5g1cV6BzqtTVqoDYBUwI/E6myA7s7P2cz33ARRa
   /33qgaX+d9J5D7DcVlLGDhVWuIGNPtUrat13qJHL185ttbLm6rewbrELT
   80pyFfZje7jBWd5FXkrDlwCMHnff75u3cBA0xYKM4LROxs6n40tDld2WH
   A==;
X-CSE-ConnectionGUID: OPUZNeoHTtSoVRa1fPSxaw==
X-CSE-MsgGUID: jBtirn4aTt63muuQ0xSHIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="79979200"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="79979200"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 17:45:29 -0700
X-CSE-ConnectionGUID: ru2WZgRgTHWJ/t+PIDF9fQ==
X-CSE-MsgGUID: xBgstxrHRcuEgw8AFD+H3A==
X-ExtLoop1: 1
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by fmviesa003.fm.intel.com with ESMTP; 19 May 2026 17:45:27 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wPV3s-00000000AOD-2r4h;
	Wed, 20 May 2026 00:45:24 +0000
Date: Wed, 20 May 2026 02:45:02 +0200
From: kernel test robot <lkp@intel.com>
To: Milan Tripkovic <milant2002@gmail.com>, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, kees@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, alex@ghiti.fr, andy@kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, Dusan.Stojkovic@rt-rk.com,
	Milan Tripkovic <Milan.Tripkovic@rt-rk.com>
Subject: Re: [PATCH v5 2/2] lib/string_kunit: extend benchmarks and unit test
 to memcmp()
Message-ID: <202605200211.1iDJR97h-lkp@intel.com>
References: <20260519140029.1190381-3-milant2002@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519140029.1190381-3-milant2002@gmail.com>

Hi Milan,

kernel test robot noticed the following build errors:

[auto build test ERROR on kees/for-next/hardening]
[also build test ERROR on next-20260519]
[cannot apply to linus/master v6.16-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Milan-Tripkovic/riscv-lib-add-memcmp-implementation/20260519-221028
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
patch link:    https://lore.kernel.org/r/20260519140029.1190381-3-milant2002%40gmail.com
patch subject: [PATCH v5 2/2] lib/string_kunit: extend benchmarks and unit test to memcmp()
config: riscv-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260520/202605200211.1iDJR97h-lkp@intel.com/config)
compiler: riscv64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260520/202605200211.1iDJR97h-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605200211.1iDJR97h-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/riscv/lib/memcmp.S: Assembler messages:
>> arch/riscv/lib/memcmp.S:58: Error: unrecognized opcode `rev8 t1,t1', extension `zbb' or `zbkb' required
>> arch/riscv/lib/memcmp.S:59: Error: unrecognized opcode `rev8 t2,t2', extension `zbb' or `zbkb' required
   arch/riscv/lib/memcmp.S:85: Error: unrecognized opcode `rev8 t1,t1', extension `zbb' or `zbkb' required
   arch/riscv/lib/memcmp.S:86: Error: unrecognized opcode `rev8 t2,t2', extension `zbb' or `zbkb' required


vim +58 arch/riscv/lib/memcmp.S

    12	
    13	/* int memcmp(const void *cs, const void *ct, size_t n) */
    14	SYM_FUNC_START(memcmp)
    15	/*
    16	 * Parameters
    17	 *	a0 - Pointer to first memory block (cs), also return value
    18	 *	a1 - Pointer to second memory block (ct)
    19	 *	a2 - Number of bytes to compare (n), decremented during loop
    20	 *
    21	 * Returns
    22	 *	a0 - 0 if equal, positive if cs > ct, negative if cs < ct
    23	 *
    24	 * Clobbers
    25	 *	t0, t1, t2, t3, t4
    26	 */
    27		add	t3, a0, a2
    28		or	t0, a0, a1
    29		andi	t0, t0, (SZREG - 1)
    30		bnez	t0, 5f
    31	
    32		addi	t4, t3, -SZREG
    33		bltu	t4, a0, 7f
    34	
    35	1:
    36		REG_L	t1, 0(a0)
    37		REG_L	t2, 0(a1)
    38		bne	t1, t2, 2f
    39		addi	a0, a0, SZREG
    40		addi	a1, a1, SZREG
    41		bleu	a0, t4, 1b
    42	
    43	#if defined(CONFIG_TOOLCHAIN_HAS_ZBB)
    44	7:
    45		__ALTERNATIVE_CFG("j 5f", "nop", 0, RISCV_ISA_EXT_ZBB,
    46				  IS_ENABLED(CONFIG_RISCV_ISA_ZBB))
    47	
    48		beq	a0, t3, 4f
    49		REG_L	t1, 0(a0)
    50		REG_L	t2, 0(a1)
    51	
    52		sub	t0, t3, a0
    53		li	t4, SZREG
    54		sub	t0, t4, t0
    55		slli	t0, t0, 3
    56	
    57	#ifndef CONFIG_CPU_BIG_ENDIAN
  > 58		rev8	t1, t1
  > 59		rev8	t2, t2
    60	#endif
    61		srl	t1, t1, t0
    62		srl	t2, t2, t0
    63	
    64		bne	t1, t2, 8f
    65		li	a0, 0
    66		ret
    67	#else
    68		j	5f
    69	#endif
    70	5:
    71		beq	a0, t3, 4f
    72	6:
    73		lbu	t1, 0(a0)
    74		lbu	t2, 0(a1)
    75		bne	t1, t2, 3f
    76		addi	a0, a0, 1
    77		addi	a1, a1, 1
    78		bne	a0, t3, 6b
    79	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
