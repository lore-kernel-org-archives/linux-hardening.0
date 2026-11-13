Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599012;
	b=i2vqazwxHb7LdPwn82BWkuEhe54GHuk7fSVDCHPgGZhlenCSOFgL+/HRvEgDQJzymdUM
	 wFlV2TmTD7MgvWS4v06wMA5lnDi0sEjRA8yMIP+CMrT/6UYx4Xh/H7gNjDBM86/8Ne7m7
	 vH/v+my95UABS3j3RG+MVPPBDJjG3MInBG8ibebr4b2cGaHVS75zNNXpC4IIyETmEf40R
	 wOLvWKeDv4uf3qKwqaqZhN1lfgIji6sTxpNeIjYy2BBsgZkEKx3UzDwgpwg3edj387pSe
	 d+FCXoEAgJ4Zhc7MbGslxX+2mudZKxUmJ3ScVrKWzQ3s9GhOAGkkBzRY816rIdxq2bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599012;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=N4P8j+QMSewuz+uKE5PNg/893eiJ2vhGXM01N1veea0=;
	b=oJ2BM/9ou6T03Mol34Jsqoq1QQd+BK1J7yHr0qmb7JItth8hFTbLO7tLyrqKxfEx/w5z
	 yretDV7OSfdQgtKq8kVz0oYYu4CMwT8HlodiZiv6U2dtNbOaG5jO4w3zDlUAkWAD3+C+4
	 3/+KfISKnYtTXhBH4OUwYdXlwSq2PtFDk4X8i4icNoglcacaUzn5trwuQTiKwXDQkfT8e
	 DkKgvrTlcv55ZW9Hy0kvw9fhJ9Bdn1jrRCuBlqB/LDJCigOudrwq+SnkhnVI1EI+jNVzY
	 mm51pREgrE7kZjfI3W38gxXwc6rN//5hWfhExWSxJDog0H54RVVxPRiM1+ySUEYMeXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="Mh/kL15m";
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99DC606A327;
	Fri, 13 Nov 2026 19:43:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D99DC606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Mh/kL15m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794599012; x=1826135012;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cua/uwgNa005FQjs9yZ0Cq6T2u8yr5c8hJMGRbdb5yM=;
  b=Mh/kL15mxEoSkpoYSFdmsj/WfT/hFJYX9kjr7z/pU6NohcIXkR4JCKfE
   h6/2gDYF5sf4feyEBohfU8Xb5bQLDJrW/rjqDPc/Dv7JY4SU3daKhr4H/
   aIAOw0Tg5Kd4/QQ59eI/P+5ZFbS8A55km1mFGVJ0iF3Zv/OKlcKROBqj5
   M4y28LcGQph7tmxVKZ0BE4DaThf3oSugV500g/7QB2kCLuoKIbXWg/6aV
   LplEUVmg5QjaggDpROKAXeoZ4pNCjBCVffW6SmhlIAK2e+723D1aEtQtu
   rNT4RZhOEEucg5WVOEcW5iPwD9jEvDdR/A45jI3QF/UYVg3FUlHv/cJ92
   A==;
X-CSE-ConnectionGUID: jR5ANWCzTuC9imLvj5++5g==
X-CSE-MsgGUID: 2EkU0qL3TZWmMIbVgujrKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3405931"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3405931"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 11:43:31 -0800
X-CSE-ConnectionGUID: pS34q/LXTGORiKyYo7IdWA==
X-CSE-MsgGUID: RUTstUSRRweYGmOOPK6vdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="8841713"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 13 Nov 2026 11:43:27 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xRxBE-000000013pP-0yI7;
	Fri, 13 Nov 2026 19:43:24 +0000
Date: Sat, 14 Nov 2026 03:42:53 +0800
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
Message-ID: <202611140317.3kXloW0R-lkp@intel.com>
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
config: hexagon-allnoconfig (https://download.01.org/0day-ci/archive/20261114/202611140317.3kXloW0R-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 1b1fed44d3dcca649a9877915d57c3357a98124e)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261114/202611140317.3kXloW0R-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611140317.3kXloW0R-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/slab_common.c:1029:44: warning: non-overlapping comparisons always evaluate to false [-Wtautological-overlap-compare]
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
