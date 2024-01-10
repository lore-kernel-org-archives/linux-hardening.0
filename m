Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D4929433
	for <linux-hardening@vger.kernel.org>; Wed, 10 Jan 2024 06:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dFy9fmEH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704869335; x=1736405335;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8ikySU9oHyyYA/ejUAVCGaQPSVfY4FaBmlyZgZw7wk8=;
  b=dFy9fmEHG6yD97wD7Up/FkxY4N2imp+D1+oRP/vS3tX98DNUBMUWLGmY
   0Y/B10qnI6HIViLTwvZR4D37aBNG6slOuYwEhN/9lJakfY43mkWYT9EHw
   CNa+AcvpMpzmLfAVcy5wbbNohv2W7L6cbanNTINfzAopI0wFpz0cFPnj/
   TxJZq1cpsYAtkB3GgoLS2LjAV7jkKghhEWsR7JJymmjtVaoDQNrSlBMx9
   bb5LJfhOnaOzYQxvAOLZTPLQ6hMQ0h9HqNaf3+nvk/j+Axbbknox6sMxM
   cgrjdGmnS5yFwdnFK8BpBOtznTXyahIF1xbuArLlS4abPnk7lhah1UMb9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="402211510"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="402211510"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 22:48:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="785503361"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="785503361"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jan 2024 22:48:45 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNSOJ-0006hY-0H;
	Wed, 10 Jan 2024 06:48:43 +0000
Date: Wed, 10 Jan 2024 14:34:56 +0800
From: kernel test robot <lkp@intel.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-hardening@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] arm: ptdump: Rename CONFIG_DEBUG_WX to
 CONFIG_ARM_DEBUG_WX
Message-ID: <202401101436.2juWuJ02-lkp@intel.com>
References: <d651269a681150f9bdca8103434fb3f4b509f784.1704800524.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d651269a681150f9bdca8103434fb3f4b509f784.1704800524.git.christophe.leroy@csgroup.eu>

Hi Christophe,

kernel test robot noticed the following build errors:

[auto build test ERROR on powerpc/next]
[also build test ERROR on powerpc/fixes s390/features tip/x86/mm linus/master v6.7 next-20240109]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christophe-Leroy/arm-ptdump-Rename-CONFIG_DEBUG_WX-to-CONFIG_ARM_DEBUG_WX/20240109-201723
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
patch link:    https://lore.kernel.org/r/d651269a681150f9bdca8103434fb3f4b509f784.1704800524.git.christophe.leroy%40csgroup.eu
patch subject: [PATCH 1/4] arm: ptdump: Rename CONFIG_DEBUG_WX to CONFIG_ARM_DEBUG_WX
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240110/202401101436.2juWuJ02-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240110/202401101436.2juWuJ02-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401101436.2juWuJ02-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/arm/mm/init.c:461:2: error: implicit declaration of function 'debug_checkwx' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           debug_checkwx();
           ^
   1 error generated.


vim +/debug_checkwx +461 arch/arm/mm/init.c

08925c2f124f1b Laura Abbott 2015-11-30  457  
80d6b0c2eed2a5 Kees Cook    2014-04-03  458  void mark_rodata_ro(void)
80d6b0c2eed2a5 Kees Cook    2014-04-03  459  {
08925c2f124f1b Laura Abbott 2015-11-30  460  	stop_machine(__mark_rodata_ro, NULL, NULL);
a8e53c151fe7ac Jinbum Park  2017-12-12 @461  	debug_checkwx();
80d6b0c2eed2a5 Kees Cook    2014-04-03  462  }
80d6b0c2eed2a5 Kees Cook    2014-04-03  463  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
