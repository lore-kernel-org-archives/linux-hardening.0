Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42759477999;
	Fri, 27 Feb 2026 20:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772224266; cv=none; b=Y4wq813pHusp2AE7bkJxH9TO1AAnfmb4IbCP9rJWq2pGAQAmSuC/lqWq0va0mfyo3Q6zACy8qEvRRqZE+XqxmdR5vigMIOq8l0ewpEYjvcocxCdJyK+u6UuUz327J38vSJoSC0eJQFJX0Zr1WrGTWZw41x/5RV4nrV7v0IAt5xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772224266; c=relaxed/simple;
	bh=fuAscArmYg357MsE3htAgFOOKf+t4SCUkyfha++zEk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fq53duZeHC4OABWaqzDG4lwI8RiPxsEw3PuWeGfTow1zSky32KCA8m5lju3DXfop9gn0Szb2J6HBU3g3oFGAbS+XRhC+pQ7ynVbI19yt6fUxyQYezIu+vCbCe+ztQC+ENJ7SCCt4NIR/dpCkNMrOqI3LKEehX1y6akp4iykWkiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=leIYpou+; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="leIYpou+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772224265; x=1803760265;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fuAscArmYg357MsE3htAgFOOKf+t4SCUkyfha++zEk0=;
  b=leIYpou+O1Gb4XfdSlW6guZdWAWjgb7yHr/OHT4RHrtIdpfx9FNINRpP
   cwoJHByC//gE/0BUki4+XK7Pxt3PPFYy4/klp1eOaDkiSpipsSNvlUZ9I
   aY0m8tzI5W4Kw1+6BOkKlKBsGTPXf2gnJzjKH3YJ1iuXEUtUDjNYZ1op+
   yP84PTAB/Rd5mMCoeG7RQqSPaYRapz/oHOMCncRvC5vWzDelywZwLicBE
   CP3Pcmp0cZkmFfHgBrgjxPL4SPrRTkF+iHEUPbRFZb86+MmzNOwz+vVyh
   mtinTVPRMWSvr4kGJTT0x05Ig8AGPyCIJv2C9cNv+EKiFhJQFNsmwWln0
   g==;
X-CSE-ConnectionGUID: A96D0qXvQm25NJK8WOX0iA==
X-CSE-MsgGUID: iPdy1EXkTI+a1wv/bO3MOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="73225504"
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="73225504"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 12:31:05 -0800
X-CSE-ConnectionGUID: n5E4HiogTn2++Omp7xOvsg==
X-CSE-MsgGUID: ziHmHMINSxmQwCOKxmGv5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="240005993"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 27 Feb 2026 12:30:58 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vw4UA-00000000B2T-3vIz;
	Fri, 27 Feb 2026 20:30:54 +0000
Date: Sat, 28 Feb 2026 04:28:12 +0800
From: kernel test robot <lkp@intel.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-hardening@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
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
Message-ID: <202602280415.zn69IEgu-lkp@intel.com>
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
config: arm64-allnoconfig (https://download.01.org/0day-ci/archive/20260228/202602280415.zn69IEgu-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260228/202602280415.zn69IEgu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602280415.zn69IEgu-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/arm64/mm/mmu.c: In function 'force_pte_mapping':
>> arch/arm64/mm/mmu.c:768:17: error: implicit declaration of function 'arm64_supports_kpkeys_hardened_pgtables' [-Wimplicit-function-declaration]
     768 |                 arm64_supports_kpkeys_hardened_pgtables();
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   arch/arm64/mm/pageattr.c: In function 'can_set_direct_map':
>> arch/arm64/mm/pageattr.c:100:17: error: implicit declaration of function 'arm64_supports_kpkeys_hardened_pgtables' [-Wimplicit-function-declaration]
     100 |                 arm64_supports_kpkeys_hardened_pgtables();
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/arm64_supports_kpkeys_hardened_pgtables +768 arch/arm64/mm/mmu.c

   757	
   758	static inline bool force_pte_mapping(void)
   759	{
   760		const bool bbml2 = system_capabilities_finalized() ?
   761			system_supports_bbml2_noabort() : cpu_supports_bbml2_noabort();
   762	
   763		if (debug_pagealloc_enabled())
   764			return true;
   765		if (bbml2)
   766			return false;
   767		return rodata_full || arm64_kfence_can_set_direct_map() || is_realm_world() ||
 > 768			arm64_supports_kpkeys_hardened_pgtables();
   769	}
   770	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
