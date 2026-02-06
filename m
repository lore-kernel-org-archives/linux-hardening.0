Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A493112DC;
	Fri,  6 Feb 2026 20:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770411321; cv=none; b=oRnNXJ/4CrumEswMerpRv9Uo9hRDie9Q+qq5baUTtmzANDVBjPNqxgLRxbYR3ECpRCGAju8HYY1m3YmwXfPiinht19DaJC94ILtzXrcbRAIl+XiwkXLnxH2nlehV9O0AvQku4Cq0eWsax8k5+FK3wG7m8GSBaRaaHLc8llUh5X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770411321; c=relaxed/simple;
	bh=X+eWBpV8ZAR9jabdyDhZG5ofyC+EhlTNpb50tOC/kxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6RoHD0SnEfIypo78uJVxy/m65DH6OV95DURCGJmuikPCUgaQvCHFxNAiIjvUYpDYVSJHUY8dK5zA7+7HI8K8bvQrr80BOrDajGZhYt++xfUIir3mXCWPEJStSBquugSXmvFbu9VGbJzoXbzkk3TtrpzPvVZTUfBQPsACmbquz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dJGk/B/v; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dJGk/B/v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770411321; x=1801947321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X+eWBpV8ZAR9jabdyDhZG5ofyC+EhlTNpb50tOC/kxU=;
  b=dJGk/B/vLXuFfpPZWFqjHtM1v7D8Ndig/c0vIdQEq3rfxi7gq95VY/0q
   uDHeSTwCs1gwW08TRhjndUJb0eEX8T8nPcV51d0wzaC8VRaOk++bUqIED
   uoPDS7Y4GHmleyz9TmDbLdK25Kf033d2Mgz5mzS41CksFa8Xp7L8mP7i+
   i4ufkQcflfP/9OSHK3EHpyox2v8oVl8e8hxbyXXg+L2gvCTq5GqBQ5Waw
   O7vZt4GO+onKrM65vhLzL+S7vYfL1V+hAndbEnE2Cab6ax/KoDt0sDvyD
   beAgQt/5c1tYNAs9xVAJ2dBAYP5czl32d1jBu2pBk3UjUtylDH6X/jLWl
   w==;
X-CSE-ConnectionGUID: QPLel6YTR5OF5WXkmYSd7Q==
X-CSE-MsgGUID: ZMGyTXlISfCrlw34uUru0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11693"; a="71515671"
X-IronPort-AV: E=Sophos;i="6.21,277,1763452800"; 
   d="scan'208";a="71515671"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 12:55:20 -0800
X-CSE-ConnectionGUID: dPfe5RjfTYu2zLNp7Dcxyw==
X-CSE-MsgGUID: Hj7hgcNFTDOtKSad59wzHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,277,1763452800"; 
   d="scan'208";a="215945774"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 06 Feb 2026 12:55:17 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1voSrC-00000000l8a-3BHi;
	Fri, 06 Feb 2026 20:55:14 +0000
Date: Sat, 7 Feb 2026 04:54:53 +0800
From: kernel test robot <lkp@intel.com>
To: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>,
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-amlogic@lists.infradead.org,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Xianwei Zhao <xianwei.zhao@amlogic.com>
Subject: Re: [PATCH v3 2/3] dma: amlogic: Add general DMA driver for A9
Message-ID: <202602070410.F1U5kBFE-lkp@intel.com>
References: <20260206-amlogic-dma-v3-2-56fb9f59ed22@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206-amlogic-dma-v3-2-56fb9f59ed22@amlogic.com>

Hi Xianwei,

kernel test robot noticed the following build errors:

[auto build test ERROR on 3c8a86ed002ab8fb287ee4ec92f0fd6ac5b291d2]

url:    https://github.com/intel-lab-lkp/linux/commits/Xianwei-Zhao-via-B4-Relay/dt-bindings-dma-Add-Amlogic-A9-SoC-DMA/20260206-170903
base:   3c8a86ed002ab8fb287ee4ec92f0fd6ac5b291d2
patch link:    https://lore.kernel.org/r/20260206-amlogic-dma-v3-2-56fb9f59ed22%40amlogic.com
patch subject: [PATCH v3 2/3] dma: amlogic: Add general DMA driver for A9
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20260207/202602070410.F1U5kBFE-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260207/202602070410.F1U5kBFE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602070410.F1U5kBFE-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/mips/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/smp.h:116,
                    from arch/mips/include/asm/irq.h:13,
                    from drivers/dma/amlogic-dma.c:7:
   arch/mips/include/asm/irq.h: In function 'on_irq_stack':
>> arch/mips/include/asm/thread_info.h:98:22: error: 'PAGE_SIZE' undeclared (first use in this function); did you mean 'TASK_SIZE'?
      98 | #define THREAD_SIZE (PAGE_SIZE << THREAD_SIZE_ORDER)
         |                      ^~~~~~~~~
   arch/mips/include/asm/irq.h:19:41: note: in expansion of macro 'THREAD_SIZE'
      19 | #define IRQ_STACK_SIZE                  THREAD_SIZE
         |                                         ^~~~~~~~~~~
   arch/mips/include/asm/irq.h:41:36: note: in expansion of macro 'IRQ_STACK_SIZE'
      41 |         unsigned long high = low + IRQ_STACK_SIZE;
         |                                    ^~~~~~~~~~~~~~
   arch/mips/include/asm/thread_info.h:98:22: note: each undeclared identifier is reported only once for each function it appears in
      98 | #define THREAD_SIZE (PAGE_SIZE << THREAD_SIZE_ORDER)
         |                      ^~~~~~~~~
   arch/mips/include/asm/irq.h:19:41: note: in expansion of macro 'THREAD_SIZE'
      19 | #define IRQ_STACK_SIZE                  THREAD_SIZE
         |                                         ^~~~~~~~~~~
   arch/mips/include/asm/irq.h:41:36: note: in expansion of macro 'IRQ_STACK_SIZE'
      41 |         unsigned long high = low + IRQ_STACK_SIZE;
         |                                    ^~~~~~~~~~~~~~


vim +98 arch/mips/include/asm/thread_info.h

^1da177e4c3f41 include/asm-mips/thread_info.h Linus Torvalds 2005-04-16   97  
^1da177e4c3f41 include/asm-mips/thread_info.h Linus Torvalds 2005-04-16  @98  #define THREAD_SIZE (PAGE_SIZE << THREAD_SIZE_ORDER)
^1da177e4c3f41 include/asm-mips/thread_info.h Linus Torvalds 2005-04-16   99  #define THREAD_MASK (THREAD_SIZE - 1UL)
^1da177e4c3f41 include/asm-mips/thread_info.h Linus Torvalds 2005-04-16  100  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
