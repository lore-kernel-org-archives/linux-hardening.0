Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4817437B3EF;
	Fri, 27 Feb 2026 22:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772232990; cv=none; b=chMwOmrveN7AlTq/BvFpjXDgDx3gF3qk4fxsRLHGW3N6UL85YCJl92jyehXrhY1klo77GxKtGZdS+h9omxjktbuxW4Gvu2V4NiW77QwEwVFxONRGRXd5rwrlkpBFdRQ4J1fzeG8SLJS05FiKINJMvUrdq2vmYbxO/lA9r3FUhdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772232990; c=relaxed/simple;
	bh=U0J17v32ksmWhx/78xpg+Nz3+Nk3kvxsdR51MuM0I70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7MKl3owllEcvTZ/tVxRaP95RHauwJDrp36/gJ/GxSR7ISD5sLnJ9jALjQUNRJmKszBYcxYewhvRNjNmhU9wG5Rt4DoSTODLZkUZv4ZNS66p6wiI58vj58tITae8Vx/02OPu+I+lE6YrynZCpGqFXcgVREI5wLs8tmV5mRQmU4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QfLS52DG; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QfLS52DG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772232987; x=1803768987;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U0J17v32ksmWhx/78xpg+Nz3+Nk3kvxsdR51MuM0I70=;
  b=QfLS52DGDgKxmRVt4ebtMJ7ldlJUcHHGCEtv3+imNW6A+WDN1jRZO2Oi
   ABVdrjiyHP7ZXmme5SxpcgH9BCUqa/8pZd+JJiblrcKQT/XK4zZP78h+f
   +NFQhpg4exJ8WBdmoSrlCVBJdyV90HtK2mni8geG1KayfzYVP7PJY7Lx/
   ZPv+jNZicaPr82beukC6jcgYb1W9qGXlXg52/eHNsFpglAmaHCIK+Oz5e
   4F7DxCPeqiz6VvmnmLPwxMfMNo/TXPkFuEzauy/D/vmmG8GpPdg6QlV5h
   3QizeU1GB3cyNphiMxejCHyoFxfkGgZsRWeaiv08SWzk6ccH3JAHzvwJ5
   w==;
X-CSE-ConnectionGUID: jzvnNUoEQbS6lJ6IFGXzEg==
X-CSE-MsgGUID: 3sRmCYCJTR2eZ0wak4nSww==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="77190586"
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="77190586"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 14:56:26 -0800
X-CSE-ConnectionGUID: Gj8OruRNS5+rloaJ2M5xNw==
X-CSE-MsgGUID: ehdBotFtTHOu+IA4PxmIIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="221172735"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 27 Feb 2026 14:56:19 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vw6kp-00000000B8V-2dsg;
	Fri, 27 Feb 2026 22:56:15 +0000
Date: Sat, 28 Feb 2026 06:56:15 +0800
From: kernel test robot <lkp@intel.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-hardening@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Andy Lutomirski <luto@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Ira Weiny <ira.weiny@intel.com>, Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>,
	Kees Cook <kees@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Maxwell Bland <mbland@motorola.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Pierre Langlois <pierre.langlois@arm.com>,
	Quentin Perret <qperret@google.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
	Yang Shi <yang@os.amperecomputing.com>
Subject: Re: [PATCH v6 23/30] arm64: kpkeys: Ensure the linear map can be
 modified
Message-ID: <202602280610.KQRFmbR3-lkp@intel.com>
References: <20260227175518.3728055-24-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227175518.3728055-24-kevin.brodsky@arm.com>

Hi Kevin,

kernel test robot noticed the following build errors:

[auto build test ERROR on 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f]

url:    https://github.com/intel-lab-lkp/linux/commits/Kevin-Brodsky/mm-Introduce-kpkeys/20260228-020115
base:   6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
patch link:    https://lore.kernel.org/r/20260227175518.3728055-24-kevin.brodsky%40arm.com
patch subject: [PATCH v6 23/30] arm64: kpkeys: Ensure the linear map can be modified
config: arm64-randconfig-001-20260228 (https://download.01.org/0day-ci/archive/20260228/202602280610.KQRFmbR3-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 9a109fbb6e184ec9bcce10615949f598f4c974a9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260228/202602280610.KQRFmbR3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602280610.KQRFmbR3-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/arm64/mm/pageattr.c:100:3: error: call to undeclared function 'arm64_supports_kpkeys_hardened_pgtables'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     100 |                 arm64_supports_kpkeys_hardened_pgtables();
         |                 ^
   1 error generated.
--
>> arch/arm64/mm/mmu.c:768:3: error: call to undeclared function 'arm64_supports_kpkeys_hardened_pgtables'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     768 |                 arm64_supports_kpkeys_hardened_pgtables();
         |                 ^
   1 error generated.


vim +/arm64_supports_kpkeys_hardened_pgtables +100 arch/arm64/mm/pageattr.c

    86	
    87	bool can_set_direct_map(void)
    88	{
    89		/*
    90		 * rodata_full, DEBUG_PAGEALLOC and a Realm guest all require linear
    91		 * map to be mapped at page granularity, so that it is possible to
    92		 * protect/unprotect single pages.
    93		 *
    94		 * KFENCE pool requires page-granular mapping if initialized late.
    95		 *
    96		 * Realms need to make pages shared/protected at page granularity.
    97		 */
    98		return rodata_full || debug_pagealloc_enabled() ||
    99			arm64_kfence_can_set_direct_map() || is_realm_world() ||
 > 100			arm64_supports_kpkeys_hardened_pgtables();
   101	}
   102	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
