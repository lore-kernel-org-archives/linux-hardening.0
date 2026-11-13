Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794605966;
	b=I1rQB14SejABkAW3GrEuINB6b5zhcq4JqcarrFL5ZpTqR3rI36TxPAetSnCiW9c6yM37
	 ePg+c8rqnqvnQg7JYoUDCRz1R0fJfU0AigsbmfGwaV1vQF7erMgt2qb43dxyhYpr/uD6t
	 V+8XTViaATk+axf6Sh4xA62Woz/xEsUFqKZQNRsjFkXslWOcGPFxyjz3jopAzNIgzSZsz
	 aDq3XcqYiEnWJiKQXgXVFiOP499kLPTs7dGkS47dv7lYvOMq0pW7wsJSKrc090Gr+EDzt
	 JijJfRxK9lWcj7dGoRaWyjcb1dlJ0MBOU3JB1isiUvySurUukYkJmNUeEJrVMY3sL6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605966;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=sN3tj/FW6lEkb5ESYZ24Fc6VqpV32e4/0iNa9+GF0B8=;
	b=vxbgYM6/GnlqyT4v24X6xKPK9C+taeeSm4I0lbC7+d0W6kFwDgN8y309NQSk/vrUBO4V
	 2RO+urZHo72SwREROKYP+7bfxLl6h1RPWVfszLq26OLbch0Ftxpllyl0fj+okotlzfzHu
	 5p3+TKDaVb5O406jpQM7yEE/M/m/aJfyLuywdIXOdVYwfftQoSzFzO6O3AmBG3WhxRI6D
	 l+GIpjnVbN1RXFMoR9tf+9BPPETxCiBHN8x7knl6ay2VBiPeC/mqq9Mi0WetZvlTLzkgL
	 BnPd0mEoyAITHIhwjki0ahEOl7ekibQEioHfiRlaC0edtsUWcu40ntYZxjQZlWR1C0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Yf8PQ2Dy;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68593606A323;
	Fri, 13 Nov 2026 21:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68593606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Yf8PQ2Dy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794605966; x=1826141966;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c9p9t4VE534FXUhXu6OxhZWuIffdCLQSBk4DddauVXw=;
  b=Yf8PQ2DyY/qXrRaiwqWp+CwkloDsHUYjn7xnrfJVQUM1PK4vBMakq9+t
   /qwBuHkjFw0LZFOKbmvLU9JM7AkOfJdkF+Lg2J2DrEOXQCrP8SLuxpy8o
   Ay1QXOEhhiFqyI01yncH1AXKCnQB1Wh/dikiJixzOrNwTcoInHDgkBNJd
   ZupaiIViQY1DghVLLRN+Bi/ZvVedu4Y8j+vcLMdHVh2dn6HUc1Qe+IieM
   WAt0mmfMs+42kDenD1uaTvGTXMs5qRN8s+vV08JhSzYFE3kVHo6UO/8K4
   ZZrVMuSwYzLZCPaU8ZzEV+4zpyne2MhLcUCM7xw/wlQ71zXjc3vSV7wWC
   w==;
X-CSE-ConnectionGUID: cZ+TJkpqRLm8E2PXBvWMzQ==
X-CSE-MsgGUID: xjRo7hK1SlK4GTCSsqAqeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3410979"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3410979"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 13:39:25 -0800
X-CSE-ConnectionGUID: 2Pw22IxDSriY6YrYR05Tyg==
X-CSE-MsgGUID: e+pYcP6CSwGCNkglA8Exjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="9342060"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 13 Nov 2026 13:39:21 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xRyzN-0000000147T-03zh;
	Fri, 13 Nov 2026 21:39:17 +0000
Date: Sat, 14 Nov 2026 05:38:50 +0800
From: kernel test robot <lkp@intel.com>
To: Chris Down <chris@chrisdown.name>, Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@linux-foundation.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Kees Cook <kees@kernel.org>, Marco Elver <elver@google.com>,
	GONG Ruiqi <gongruiqi@huaweicloud.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-hardening@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v3 5/6] mm/slab: Support disabling
 KMALLOC_PARTITION_CACHES at boot
Message-ID: <202611140551.XAyf9KWi-lkp@intel.com>
References: <9a4caff0336c78a7adc746786c81c9c01f89c40b.1794506262.git.chris@chrisdown.name>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a4caff0336c78a7adc746786c81c9c01f89c40b.1794506262.git.chris@chrisdown.name>

Hi Chris,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ce6518e61e3b4bf4f97f7ac6204049b9eba7eb75]

url:    https://github.com/intel-lab-lkp/linux/commits/Chris-Down/mm-slab-Enable-SLAB_FREELIST_HARDENED-by-default/20261113-005125
base:   ce6518e61e3b4bf4f97f7ac6204049b9eba7eb75
patch link:    https://lore.kernel.org/r/9a4caff0336c78a7adc746786c81c9c01f89c40b.1794506262.git.chris%40chrisdown.name
patch subject: [PATCH v3 5/6] mm/slab: Support disabling KMALLOC_PARTITION_CACHES at boot
config: arm-allnoconfig (https://download.01.org/0day-ci/archive/20261114/202611140551.XAyf9KWi-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261114/202611140551.XAyf9KWi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611140551.XAyf9KWi-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/slab_common.c:1029:44: warning: overlapping comparisons always evaluate to false [-Wtautological-overlap-compare]
    1029 |         } else if (type > KMALLOC_PARTITION_START && type <= KMALLOC_PARTITION_END) {
         |                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +1029 mm/slab_common.c

   999	
  1000	static void __init
  1001	new_kmalloc_cache(int idx, enum kmalloc_cache_type type)
  1002	{
  1003		slab_flags_t flags = 0;
  1004		unsigned int minalign = __kmalloc_minalign();
  1005		unsigned int aligned_size = kmalloc_info[idx].size;
  1006		int aligned_idx = idx;
  1007	
  1008		if ((KMALLOC_RECLAIM != KMALLOC_NORMAL) && (type == KMALLOC_RECLAIM)) {
  1009			flags |= SLAB_RECLAIM_ACCOUNT;
  1010		} else if (IS_ENABLED(CONFIG_MEMCG) && (type == KMALLOC_CGROUP)) {
  1011			if (mem_cgroup_kmem_disabled()) {
  1012				kmalloc_caches[type][idx] = kmalloc_caches[KMALLOC_NORMAL][idx];
  1013				return;
  1014			}
  1015			flags |= SLAB_ACCOUNT;
  1016		} else if (IS_ENABLED(CONFIG_SLAB_OBJ_EXT) && type == KMALLOC_NO_OBJ_EXT) {
  1017			if (!need_kmalloc_no_objext()) {
  1018				kmalloc_caches[type][idx] = kmalloc_caches[KMALLOC_NORMAL][idx];
  1019				return;
  1020			}
  1021			flags |= SLAB_NO_OBJ_EXT | SLAB_NO_MERGE;
  1022		} else if (IS_ENABLED(CONFIG_ZONE_DMA) && (type == KMALLOC_DMA)) {
  1023			flags |= SLAB_CACHE_DMA;
  1024		}
  1025	
  1026		if (kmalloc_partition_enabled) {
  1027			if (type >= KMALLOC_PARTITION_START && type <= KMALLOC_PARTITION_END)
  1028				flags |= SLAB_NO_MERGE;
> 1029		} else if (type > KMALLOC_PARTITION_START && type <= KMALLOC_PARTITION_END) {
  1030			/* Use the normal caches, which have already been created. */
  1031			kmalloc_caches[type][idx] = kmalloc_caches[KMALLOC_NORMAL][idx];
  1032			return;
  1033		}
  1034	
  1035		/*
  1036		 * If memcg_kmem is enabled and this is a KMALLOC_NORMAL cache and not
  1037		 * aliased with any other type, make sure it's never merged with any other
  1038		 * cache.
  1039		 *
  1040		 * In other cases the kmalloc cache may end up being used for a
  1041		 * __GFP_ACCOUNT allocation so mark it as such. The exception is a
  1042		 * KMALLOC_NO_OBJ_EXT cache.
  1043		 */
  1044		if (!mem_cgroup_kmem_disabled()) {
  1045			if (type == KMALLOC_NORMAL && KMALLOC_RECLAIM != KMALLOC_NORMAL)
  1046				flags |= SLAB_NO_MERGE;
  1047			else if (!(flags & SLAB_NO_OBJ_EXT))
  1048				flags |= SLAB_MAY_ACCOUNT;
  1049		}
  1050	
  1051		if (minalign > ARCH_KMALLOC_MINALIGN) {
  1052			aligned_size = ALIGN(aligned_size, minalign);
  1053			aligned_idx = __kmalloc_index(aligned_size, false);
  1054		}
  1055	
  1056		if (!kmalloc_caches[type][aligned_idx])
  1057			kmalloc_caches[type][aligned_idx] = create_kmalloc_cache(
  1058						kmalloc_info[aligned_idx].name[type],
  1059						aligned_size, flags);
  1060		if (idx != aligned_idx)
  1061			kmalloc_caches[type][idx] = kmalloc_caches[type][aligned_idx];
  1062	}
  1063	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
