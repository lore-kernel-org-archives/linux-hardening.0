Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AE717333A;
	Thu, 21 Nov 2024 20:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732221050; cv=none; b=vCPpiXH+Ho7tzfv5hAY+7mFmkhxNFkJ2m4ruuKhK8ZMe/qqMapyM1ZP3oisgp61w7XVCzHmzD3kIZ57V+1gFbe1gu1DRX3Xori+GNso1lZPH7dLhDO6xF3a4xlxbzfphZGk1bmla8cYp8sfiHMDt85wOFWKuy1y69I3xZLhIBlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732221050; c=relaxed/simple;
	bh=ZVvJCxgJ6cywU+vTk1gExW6TynVWTqDwCnaFUlyf6KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cszWCX6z15UJ6PpDOAM/vxmeuR5wzV+hBrlSE8wzY8jE7QYVuj3plS6njssFm+yOq1vo1rzQVgdEy+2uJbsqJq1hx3sj4LJjzcgbdqamA6raq8yqnKf/GyLkhkMfy+RHC1fQASWUe4q4zqHlll6YQTVIDH0jCFHnWjBTGH3Ure0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L/NqLe6R; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L/NqLe6R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732221049; x=1763757049;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZVvJCxgJ6cywU+vTk1gExW6TynVWTqDwCnaFUlyf6KY=;
  b=L/NqLe6R07Ym6fDVm0gKXX/YQdeB1dsMSylMK+sFvQ+GlZoh3grTtPDI
   aXci/fn8KHOkAyEl3M5DkPoFGoe3VoyELIHka/Ds7Xe18z0kapXSlg7LR
   5S6RkX6zkB58hNerV6K2qZCTlfQz1SqdxU+wAuBaoPbCPQwJtBjP5l+YA
   LOifATWOq8Nt+Z+dDbPjl7a/72K3HKXvT0H+Vr10KaMBK23j6JZIvDjl8
   /a/I54k5IewTy2QCmS/ereP/zcTPcWaOV/DSWEl/dZ1dRauK5RtIxaXj+
   n4A796dBHuNL83UzY4YATwi61errhWh87eEuJ9bLy6W29riKAQjlXUjPi
   g==;
X-CSE-ConnectionGUID: bNXfWOeBQR+0syI1N/gh7Q==
X-CSE-MsgGUID: UtntHVtKR+2RZvoKhwIdKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="43755237"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="43755237"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 12:30:48 -0800
X-CSE-ConnectionGUID: 5+Ny8WzLSbacDbEeF/7zkQ==
X-CSE-MsgGUID: 1uGq9qQ6QCm8XkQ4Aew7kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="95440319"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 21 Nov 2024 12:30:46 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tEDp5-0003KN-2Y;
	Thu, 21 Nov 2024 20:30:43 +0000
Date: Fri, 22 Nov 2024 04:30:33 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Carpenter <error27@gmail.com>, Kees Cook <kees@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] overflow: improve size_add/mul for 32bit systems
Message-ID: <202411220455.2X9OAAvt-lkp@intel.com>
References: <ebdae636-11f3-4f02-a158-f15bbed2847f@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebdae636-11f3-4f02-a158-f15bbed2847f@stanley.mountain>

Hi Dan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kees/for-next/hardening]
[also build test WARNING on kees/for-next/pstore kees/for-next/kspp linus/master v6.12 next-20241121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dan-Carpenter/overflow-improve-size_add-mul-for-32bit-systems/20241121-124847
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
patch link:    https://lore.kernel.org/r/ebdae636-11f3-4f02-a158-f15bbed2847f%40stanley.mountain
patch subject: [PATCH] overflow: improve size_add/mul for 32bit systems
config: arm-allnoconfig (https://download.01.org/0day-ci/archive/20241122/202411220455.2X9OAAvt-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241122/202411220455.2X9OAAvt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411220455.2X9OAAvt-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from block/bio.c:5:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> block/bio.c:616:17: warning: result of comparison of constant 4294967295 with expression of type 'typeof (nr_vecs)' (aka 'unsigned short') is always false [-Wtautological-constant-out-of-range-compare]
     616 |         return kmalloc(struct_size(bio, bi_inline_vecs, nr_vecs), gfp_mask);
         |                ~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:396:18: note: expanded from macro 'struct_size'
     396 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:381:3: note: expanded from macro 'flex_array_size'
     381 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:281:11: note: expanded from macro 'size_mul'
     281 |             (__a >= (u64)SIZE_MAX || __b >= (u64)SIZE_MAX))             \
         |              ~~~ ^
   include/linux/slab.h:884:52: note: expanded from macro 'kmalloc'
     884 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
   include/linux/alloc_tag.h:210:31: note: expanded from macro 'alloc_hooks'
     210 |         alloc_hooks_tag(&_alloc_tag, _do_alloc);                        \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~
   include/linux/alloc_tag.h:202:27: note: expanded from macro 'alloc_hooks_tag'
     202 |         typeof(_do_alloc) _res = _do_alloc;                             \
         |                                  ^~~~~~~~~
>> block/bio.c:616:17: warning: result of comparison of constant 4294967295 with expression of type 'typeof (nr_vecs)' (aka 'unsigned short') is always false [-Wtautological-constant-out-of-range-compare]
     616 |         return kmalloc(struct_size(bio, bi_inline_vecs, nr_vecs), gfp_mask);
         |                ~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:397:26: note: expanded from macro 'struct_size'
     397 |                 size_add(sizeof(*(p)), flex_array_size(p, member, count)))
         |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:381:3: note: expanded from macro 'flex_array_size'
     381 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:281:11: note: expanded from macro 'size_mul'
     281 |             (__a >= (u64)SIZE_MAX || __b >= (u64)SIZE_MAX))             \
         |              ~~~ ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/slab.h:884:52: note: expanded from macro 'kmalloc'
     884 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
   include/linux/alloc_tag.h:210:31: note: expanded from macro 'alloc_hooks'
     210 |         alloc_hooks_tag(&_alloc_tag, _do_alloc);                        \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~
   include/linux/alloc_tag.h:202:27: note: expanded from macro 'alloc_hooks_tag'
     202 |         typeof(_do_alloc) _res = _do_alloc;                             \
         |                                  ^~~~~~~~~
   3 warnings generated.


vim +616 block/bio.c

^1da177e4c3f41 fs/bio.c    Linus Torvalds    2005-04-16  593  
3175199ab0ac8c block/bio.c Christoph Hellwig 2021-01-26  594  /**
066ff571011d84 block/bio.c Christoph Hellwig 2022-04-06  595   * bio_kmalloc - kmalloc a bio
066ff571011d84 block/bio.c Christoph Hellwig 2022-04-06  596   * @nr_vecs:	number of bio_vecs to allocate
3175199ab0ac8c block/bio.c Christoph Hellwig 2021-01-26  597   * @gfp_mask:   the GFP_* mask given to the slab allocator
3175199ab0ac8c block/bio.c Christoph Hellwig 2021-01-26  598   *
066ff571011d84 block/bio.c Christoph Hellwig 2022-04-06  599   * Use kmalloc to allocate a bio (including bvecs).  The bio must be initialized
066ff571011d84 block/bio.c Christoph Hellwig 2022-04-06  600   * using bio_init() before use.  To free a bio returned from this function use
066ff571011d84 block/bio.c Christoph Hellwig 2022-04-06  601   * kfree() after calling bio_uninit().  A bio returned from this function can
066ff571011d84 block/bio.c Christoph Hellwig 2022-04-06  602   * be reused by calling bio_uninit() before calling bio_init() again.
066ff571011d84 block/bio.c Christoph Hellwig 2022-04-06  603   *
066ff571011d84 block/bio.c Christoph Hellwig 2022-04-06  604   * Note that unlike bio_alloc() or bio_alloc_bioset() allocations from this
340e134727c9ad block/bio.c Deming Wang       2022-10-06  605   * function are not backed by a mempool can fail.  Do not use this function
066ff571011d84 block/bio.c Christoph Hellwig 2022-04-06  606   * for allocations in the file system I/O path.
3175199ab0ac8c block/bio.c Christoph Hellwig 2021-01-26  607   *
3175199ab0ac8c block/bio.c Christoph Hellwig 2021-01-26  608   * Returns: Pointer to new bio on success, NULL on failure.
3175199ab0ac8c block/bio.c Christoph Hellwig 2021-01-26  609   */
066ff571011d84 block/bio.c Christoph Hellwig 2022-04-06  610  struct bio *bio_kmalloc(unsigned short nr_vecs, gfp_t gfp_mask)
3175199ab0ac8c block/bio.c Christoph Hellwig 2021-01-26  611  {
3175199ab0ac8c block/bio.c Christoph Hellwig 2021-01-26  612  	struct bio *bio;
3175199ab0ac8c block/bio.c Christoph Hellwig 2021-01-26  613  
066ff571011d84 block/bio.c Christoph Hellwig 2022-04-06  614  	if (nr_vecs > UIO_MAXIOV)
3175199ab0ac8c block/bio.c Christoph Hellwig 2021-01-26  615  		return NULL;
066ff571011d84 block/bio.c Christoph Hellwig 2022-04-06 @616  	return kmalloc(struct_size(bio, bi_inline_vecs, nr_vecs), gfp_mask);
3175199ab0ac8c block/bio.c Christoph Hellwig 2021-01-26  617  }
3175199ab0ac8c block/bio.c Christoph Hellwig 2021-01-26  618  EXPORT_SYMBOL(bio_kmalloc);
3175199ab0ac8c block/bio.c Christoph Hellwig 2021-01-26  619  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
