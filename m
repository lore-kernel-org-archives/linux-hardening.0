Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD49AD2F;
	Fri, 22 Nov 2024 00:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732234945; cv=none; b=mBaRD7ysm5/L0Rc/ERiKnMnXUCB8nYKiq5YMWyHoDoDcmqZOWpHYt3y06smJBC6mbDKA+Hx2wuQ4u7VlEJL/EfElwElSFGSLhfZ8qIJuHrHiQgpQglGioRegJMmTehJa8AKcwUTmSbYMd+7qPTgeVHjNisinovgn52A5Z9T6IKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732234945; c=relaxed/simple;
	bh=M3R/QgwwsZHZDHopkmm+xaMOhBFaQd/h/zvjLeAkvHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXT4EnLu89Q1xUt6SwLNllAcWwxLOxdhB0r1dlibCGPkD3AY4qCtrUUzLhVAAABWIq8u8TXe9WWiEuTYBH7eJpG7FAybZsY/BOqtH1NU3p5PZVRjE3t5KptHy7cs/6hjICrfkWSTHXOjAOBXDGGTS724ancsIjTC7jfYo0vPWSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q9UtdnJ8; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q9UtdnJ8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732234943; x=1763770943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M3R/QgwwsZHZDHopkmm+xaMOhBFaQd/h/zvjLeAkvHs=;
  b=Q9UtdnJ85onMmsn59U2KvRlIC+kQ0d5VohMJChJhJU6DUYN1tYGGE5Bh
   OObo6IgBl5AV1lm1z/gPd+n5lYvv1VZWlSqL2vl0ia5T09iAzD3TvP5F+
   iQMwHxb7EhReih9CmAnY1lBcelEY2IMXttDARx0ZL8Rr642gdFgdYNBR/
   Dmf6NYWz3rWXD8Z2On7S5/8q3R4+7VkeE/wOD+746jYAPaEDv9aGSzi0c
   DqS/88fG8EzcbpGTg1fqT92lUpVuJdr5BrlY4CCFNeEQuRouXRde4a5Kz
   joXr/7RptLYQQXi8O/f06TU4sap/oz1J9YmDrH7Lo/ZlwEGZW2FKHWEAl
   A==;
X-CSE-ConnectionGUID: /KHsTvw4Rqqeuop0V5ScxQ==
X-CSE-MsgGUID: v4jIidT4SGWaL4gU0Ix91Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="31734587"
X-IronPort-AV: E=Sophos;i="6.12,174,1728975600"; 
   d="scan'208";a="31734587"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 16:22:21 -0800
X-CSE-ConnectionGUID: HxAOaIT1QueG2hobwByEeA==
X-CSE-MsgGUID: ky2BBDDwT46nGfngUgQmQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,174,1728975600"; 
   d="scan'208";a="90833920"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 21 Nov 2024 16:22:16 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tEHR7-0003VZ-2K;
	Fri, 22 Nov 2024 00:22:13 +0000
Date: Fri, 22 Nov 2024 08:21:23 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Carpenter <error27@gmail.com>, Kees Cook <kees@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] overflow: improve size_add/mul for 32bit systems
Message-ID: <202411220837.yUJtt1Lg-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on kees/for-next/hardening]
[also build test ERROR on kees/for-next/pstore kees/for-next/kspp linus/master v6.12 next-20241121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dan-Carpenter/overflow-improve-size_add-mul-for-32bit-systems/20241121-124847
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
patch link:    https://lore.kernel.org/r/ebdae636-11f3-4f02-a158-f15bbed2847f%40stanley.mountain
patch subject: [PATCH] overflow: improve size_add/mul for 32bit systems
config: i386-randconfig-002-20241122 (https://download.01.org/0day-ci/archive/20241122/202411220837.yUJtt1Lg-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241122/202411220837.yUJtt1Lg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411220837.yUJtt1Lg-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/hv/vmbus_drv.c:21:
   In file included from include/linux/hyperv.h:17:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/hv/vmbus_drv.c:1078:17: warning: result of comparison of constant 4294967295 with expression of type 'typeof (payload_size)' (aka 'unsigned char') is always false [-Wtautological-constant-out-of-range-compare]
    1078 |                 ctx = kmalloc(struct_size(ctx, msg.payload, payload_size), GFP_ATOMIC);
         |                       ~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
>> drivers/hv/vmbus_drv.c:1078:17: warning: result of comparison of constant 4294967295 with expression of type 'typeof (payload_size)' (aka 'unsigned char') is always false [-Wtautological-constant-out-of-range-compare]
    1078 |                 ctx = kmalloc(struct_size(ctx, msg.payload, payload_size), GFP_ATOMIC);
         |                       ~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
--
   In file included from drivers/scsi/mpt3sas/mpt3sas_warpdrive.c:47:
   In file included from drivers/scsi/mpt3sas/mpt3sas_base.h:61:
   In file included from include/scsi/scsi_cmnd.h:5:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/scsi/mpt3sas/mpt3sas_warpdrive.c:144:7: warning: result of comparison of constant 4294967295 with expression of type 'typeof (num_pds)' (aka 'unsigned char') is always false [-Wtautological-constant-out-of-range-compare]
     144 |         sz = struct_size(vol_pg0, PhysDisk, num_pds);
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:396:18: note: expanded from macro 'struct_size'
     396 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:381:3: note: expanded from macro 'flex_array_size'
     381 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:281:11: note: expanded from macro 'size_mul'
     281 |             (__a >= (u64)SIZE_MAX || __b >= (u64)SIZE_MAX))             \
         |              ~~~ ^  ~~~~~~~~~~~~~
>> drivers/scsi/mpt3sas/mpt3sas_warpdrive.c:144:7: warning: result of comparison of constant 4294967295 with expression of type 'typeof (num_pds)' (aka 'unsigned char') is always false [-Wtautological-constant-out-of-range-compare]
     144 |         sz = struct_size(vol_pg0, PhysDisk, num_pds);
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:397:26: note: expanded from macro 'struct_size'
     397 |                 size_add(sizeof(*(p)), flex_array_size(p, member, count)))
         |                 ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:381:3: note: expanded from macro 'flex_array_size'
     381 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:281:11: note: expanded from macro 'size_mul'
     281 |             (__a >= (u64)SIZE_MAX || __b >= (u64)SIZE_MAX))             \
         |              ~~~ ^
   include/linux/overflow.h:309:19: note: expanded from macro 'size_add'
     309 |         typeof(b) __b = (b);                                            \
         |                          ^
   3 warnings generated.
--
   In file included from drivers/scsi/mpt3sas/mpt3sas_transport.c:52:
   In file included from include/linux/pci.h:1650:
   In file included from include/linux/dmapool.h:14:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/scsi/mpt3sas/mpt3sas_transport.c:1791:7: warning: result of comparison of constant 4294967295 with expression of type 'typeof (ioc->sas_hba.num_phys)' (aka 'unsigned char') is always false [-Wtautological-constant-out-of-range-compare]
    1791 |         sz = struct_size(sas_iounit_pg0, PhyData, ioc->sas_hba.num_phys);
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:396:18: note: expanded from macro 'struct_size'
     396 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:381:3: note: expanded from macro 'flex_array_size'
     381 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:281:11: note: expanded from macro 'size_mul'
     281 |             (__a >= (u64)SIZE_MAX || __b >= (u64)SIZE_MAX))             \
         |              ~~~ ^  ~~~~~~~~~~~~~
>> drivers/scsi/mpt3sas/mpt3sas_transport.c:1791:7: warning: result of comparison of constant 4294967295 with expression of type 'typeof (ioc->sas_hba.num_phys)' (aka 'unsigned char') is always false [-Wtautological-constant-out-of-range-compare]
    1791 |         sz = struct_size(sas_iounit_pg0, PhyData, ioc->sas_hba.num_phys);
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:397:26: note: expanded from macro 'struct_size'
     397 |                 size_add(sizeof(*(p)), flex_array_size(p, member, count)))
         |                 ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:381:3: note: expanded from macro 'flex_array_size'
     381 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:281:11: note: expanded from macro 'size_mul'
     281 |             (__a >= (u64)SIZE_MAX || __b >= (u64)SIZE_MAX))             \
         |              ~~~ ^
   include/linux/overflow.h:309:19: note: expanded from macro 'size_add'
     309 |         typeof(b) __b = (b);                                            \
         |                          ^
   drivers/scsi/mpt3sas/mpt3sas_transport.c:1831:7: warning: result of comparison of constant 4294967295 with expression of type 'typeof (ioc->sas_hba.num_phys)' (aka 'unsigned char') is always false [-Wtautological-constant-out-of-range-compare]
    1831 |         sz = struct_size(sas_iounit_pg1, PhyData, ioc->sas_hba.num_phys);
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:396:18: note: expanded from macro 'struct_size'
     396 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:381:3: note: expanded from macro 'flex_array_size'
     381 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:281:11: note: expanded from macro 'size_mul'
     281 |             (__a >= (u64)SIZE_MAX || __b >= (u64)SIZE_MAX))             \
         |              ~~~ ^  ~~~~~~~~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_transport.c:1831:7: warning: result of comparison of constant 4294967295 with expression of type 'typeof (ioc->sas_hba.num_phys)' (aka 'unsigned char') is always false [-Wtautological-constant-out-of-range-compare]
    1831 |         sz = struct_size(sas_iounit_pg1, PhyData, ioc->sas_hba.num_phys);
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:397:26: note: expanded from macro 'struct_size'
     397 |                 size_add(sizeof(*(p)), flex_array_size(p, member, count)))
         |                 ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:381:3: note: expanded from macro 'flex_array_size'
     381 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:281:11: note: expanded from macro 'size_mul'
     281 |             (__a >= (u64)SIZE_MAX || __b >= (u64)SIZE_MAX))             \
         |              ~~~ ^
   include/linux/overflow.h:309:19: note: expanded from macro 'size_add'
     309 |         typeof(b) __b = (b);                                            \
         |                          ^
   drivers/scsi/mpt3sas/mpt3sas_transport.c:1941:7: warning: result of comparison of constant 4294967295 with expression of type 'typeof (ioc->sas_hba.num_phys)' (aka 'unsigned char') is always false [-Wtautological-constant-out-of-range-compare]
    1941 |         sz = struct_size(sas_iounit_pg1, PhyData, ioc->sas_hba.num_phys);
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:396:18: note: expanded from macro 'struct_size'
     396 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:381:3: note: expanded from macro 'flex_array_size'
     381 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:281:11: note: expanded from macro 'size_mul'
     281 |             (__a >= (u64)SIZE_MAX || __b >= (u64)SIZE_MAX))             \
         |              ~~~ ^  ~~~~~~~~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_transport.c:1941:7: warning: result of comparison of constant 4294967295 with expression of type 'typeof (ioc->sas_hba.num_phys)' (aka 'unsigned char') is always false [-Wtautological-constant-out-of-range-compare]
    1941 |         sz = struct_size(sas_iounit_pg1, PhyData, ioc->sas_hba.num_phys);
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:397:26: note: expanded from macro 'struct_size'
     397 |                 size_add(sizeof(*(p)), flex_array_size(p, member, count)))
         |                 ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:381:3: note: expanded from macro 'flex_array_size'
     381 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:281:11: note: expanded from macro 'size_mul'
     281 |             (__a >= (u64)SIZE_MAX || __b >= (u64)SIZE_MAX))             \
         |              ~~~ ^
   include/linux/overflow.h:309:19: note: expanded from macro 'size_add'
     309 |         typeof(b) __b = (b);                                            \
         |                          ^
   7 warnings generated.
--
   In file included from drivers/scsi/mpt3sas/mpt3sas_base.c:52:
   In file included from include/linux/pci.h:1650:
   In file included from include/linux/dmapool.h:14:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/scsi/mpt3sas/mpt3sas_base.c:4912:7: warning: result of comparison of constant 4294967295 with expression of type 'typeof (num_phys)' (aka 'unsigned char') is always false [-Wtautological-constant-out-of-range-compare]
    4912 |         sz = struct_size(sas_iounit_pg1, PhyData, num_phys);
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:396:18: note: expanded from macro 'struct_size'
     396 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:381:3: note: expanded from macro 'flex_array_size'
     381 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:281:11: note: expanded from macro 'size_mul'
     281 |             (__a >= (u64)SIZE_MAX || __b >= (u64)SIZE_MAX))             \
         |              ~~~ ^  ~~~~~~~~~~~~~
>> drivers/scsi/mpt3sas/mpt3sas_base.c:4912:7: warning: result of comparison of constant 4294967295 with expression of type 'typeof (num_phys)' (aka 'unsigned char') is always false [-Wtautological-constant-out-of-range-compare]
    4912 |         sz = struct_size(sas_iounit_pg1, PhyData, num_phys);
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:397:26: note: expanded from macro 'struct_size'
     397 |                 size_add(sizeof(*(p)), flex_array_size(p, member, count)))
         |                 ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:381:3: note: expanded from macro 'flex_array_size'
     381 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:281:11: note: expanded from macro 'size_mul'
     281 |             (__a >= (u64)SIZE_MAX || __b >= (u64)SIZE_MAX))             \
         |              ~~~ ^
   include/linux/overflow.h:309:19: note: expanded from macro 'size_add'
     309 |         typeof(b) __b = (b);                                            \
         |                          ^
   3 warnings generated.
--
   In file included from drivers/scsi/mpt3sas/mpt3sas_scsih.c:49:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/x86/include/asm/cacheflush.h:5:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/scsi/mpt3sas/mpt3sas_scsih.c:2434:7: warning: result of comparison of constant 4294967295 with expression of type 'typeof (num_pds)' (aka 'unsigned char') is always false [-Wtautological-constant-out-of-range-compare]
    2434 |         sz = struct_size(vol_pg0, PhysDisk, num_pds);
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:396:18: note: expanded from macro 'struct_size'
     396 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:381:3: note: expanded from macro 'flex_array_size'
     381 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:281:11: note: expanded from macro 'size_mul'
     281 |             (__a >= (u64)SIZE_MAX || __b >= (u64)SIZE_MAX))             \
         |              ~~~ ^  ~~~~~~~~~~~~~
>> drivers/scsi/mpt3sas/mpt3sas_scsih.c:2434:7: warning: result of comparison of constant 4294967295 with expression of type 'typeof (num_pds)' (aka 'unsigned char') is always false [-Wtautological-constant-out-of-range-compare]
    2434 |         sz = struct_size(vol_pg0, PhysDisk, num_pds);
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:397:26: note: expanded from macro 'struct_size'
     397 |                 size_add(sizeof(*(p)), flex_array_size(p, member, count)))
         |                 ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:381:3: note: expanded from macro 'flex_array_size'
     381 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:281:11: note: expanded from macro 'size_mul'
     281 |             (__a >= (u64)SIZE_MAX || __b >= (u64)SIZE_MAX))             \
         |              ~~~ ^
   include/linux/overflow.h:309:19: note: expanded from macro 'size_add'
     309 |         typeof(b) __b = (b);                                            \
         |                          ^
>> drivers/scsi/mpt3sas/mpt3sas_scsih.c:5960:7: warning: result of comparison of constant 4294967295 with expression of type 'typeof (ioc->sas_hba.num_phys)' (aka 'unsigned char') is always false [-Wtautological-constant-out-of-range-compare]
    5960 |         sz = struct_size(sas_iounit_pg0, PhyData, ioc->sas_hba.num_phys);
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:396:18: note: expanded from macro 'struct_size'
     396 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:381:3: note: expanded from macro 'flex_array_size'
     381 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:281:11: note: expanded from macro 'size_mul'
     281 |             (__a >= (u64)SIZE_MAX || __b >= (u64)SIZE_MAX))             \
         |              ~~~ ^  ~~~~~~~~~~~~~
>> drivers/scsi/mpt3sas/mpt3sas_scsih.c:5960:7: warning: result of comparison of constant 4294967295 with expression of type 'typeof (ioc->sas_hba.num_phys)' (aka 'unsigned char') is always false [-Wtautological-constant-out-of-range-compare]
    5960 |         sz = struct_size(sas_iounit_pg0, PhyData, ioc->sas_hba.num_phys);
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:397:26: note: expanded from macro 'struct_size'
     397 |                 size_add(sizeof(*(p)), flex_array_size(p, member, count)))
         |                 ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:381:3: note: expanded from macro 'flex_array_size'
     381 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:281:11: note: expanded from macro 'size_mul'
     281 |             (__a >= (u64)SIZE_MAX || __b >= (u64)SIZE_MAX))             \
         |              ~~~ ^
   include/linux/overflow.h:309:19: note: expanded from macro 'size_add'
     309 |         typeof(b) __b = (b);                                            \
         |                          ^
   drivers/scsi/mpt3sas/mpt3sas_scsih.c:6138:7: warning: result of comparison of constant 4294967295 with expression of type 'typeof (ioc->sas_hba.num_phys)' (aka 'unsigned char') is always false [-Wtautological-constant-out-of-range-compare]
    6138 |         sz = struct_size(sas_iounit_pg0, PhyData, ioc->sas_hba.num_phys);
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:396:18: note: expanded from macro 'struct_size'
     396 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:381:3: note: expanded from macro 'flex_array_size'
     381 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:281:11: note: expanded from macro 'size_mul'
     281 |             (__a >= (u64)SIZE_MAX || __b >= (u64)SIZE_MAX))             \
         |              ~~~ ^  ~~~~~~~~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_scsih.c:6138:7: warning: result of comparison of constant 4294967295 with expression of type 'typeof (ioc->sas_hba.num_phys)' (aka 'unsigned char') is always false [-Wtautological-constant-out-of-range-compare]
    6138 |         sz = struct_size(sas_iounit_pg0, PhyData, ioc->sas_hba.num_phys);
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:397:26: note: expanded from macro 'struct_size'
     397 |                 size_add(sizeof(*(p)), flex_array_size(p, member, count)))
         |                 ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:381:3: note: expanded from macro 'flex_array_size'
     381 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:281:11: note: expanded from macro 'size_mul'
     281 |             (__a >= (u64)SIZE_MAX || __b >= (u64)SIZE_MAX))             \
         |              ~~~ ^
   include/linux/overflow.h:309:19: note: expanded from macro 'size_add'
     309 |         typeof(b) __b = (b);                                            \
         |                          ^
   drivers/scsi/mpt3sas/mpt3sas_scsih.c:6571:7: warning: result of comparison of constant 4294967295 with expression of type 'typeof (ioc->sas_hba.num_phys)' (aka 'unsigned char') is always false [-Wtautological-constant-out-of-range-compare]
    6571 |         sz = struct_size(sas_iounit_pg0, PhyData, ioc->sas_hba.num_phys);
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:396:18: note: expanded from macro 'struct_size'
     396 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:381:3: note: expanded from macro 'flex_array_size'
     381 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:281:11: note: expanded from macro 'size_mul'
     281 |             (__a >= (u64)SIZE_MAX || __b >= (u64)SIZE_MAX))             \
         |              ~~~ ^  ~~~~~~~~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_scsih.c:6571:7: warning: result of comparison of constant 4294967295 with expression of type 'typeof (ioc->sas_hba.num_phys)' (aka 'unsigned char') is always false [-Wtautological-constant-out-of-range-compare]
    6571 |         sz = struct_size(sas_iounit_pg0, PhyData, ioc->sas_hba.num_phys);
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:397:26: note: expanded from macro 'struct_size'
     397 |                 size_add(sizeof(*(p)), flex_array_size(p, member, count)))
         |                 ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:381:3: note: expanded from macro 'flex_array_size'
     381 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:281:11: note: expanded from macro 'size_mul'
     281 |             (__a >= (u64)SIZE_MAX || __b >= (u64)SIZE_MAX))             \
         |              ~~~ ^
   include/linux/overflow.h:309:19: note: expanded from macro 'size_add'
     309 |         typeof(b) __b = (b);                                            \
         |                          ^
   drivers/scsi/mpt3sas/mpt3sas_scsih.c:6722:7: warning: result of comparison of constant 4294967295 with expression of type 'typeof (ioc->sas_hba.num_phys)' (aka 'unsigned char') is always false [-Wtautological-constant-out-of-range-compare]
    6722 |         sz = struct_size(sas_iounit_pg0, PhyData, ioc->sas_hba.num_phys);
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:396:18: note: expanded from macro 'struct_size'
     396 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:381:3: note: expanded from macro 'flex_array_size'
     381 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:281:11: note: expanded from macro 'size_mul'
     281 |             (__a >= (u64)SIZE_MAX || __b >= (u64)SIZE_MAX))             \
         |              ~~~ ^  ~~~~~~~~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_scsih.c:6722:7: warning: result of comparison of constant 4294967295 with expression of type 'typeof (ioc->sas_hba.num_phys)' (aka 'unsigned char') is always false [-Wtautological-constant-out-of-range-compare]
    6722 |         sz = struct_size(sas_iounit_pg0, PhyData, ioc->sas_hba.num_phys);
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:397:26: note: expanded from macro 'struct_size'
     397 |                 size_add(sizeof(*(p)), flex_array_size(p, member, count)))
         |                 ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:381:3: note: expanded from macro 'flex_array_size'
     381 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:281:11: note: expanded from macro 'size_mul'
     281 |             (__a >= (u64)SIZE_MAX || __b >= (u64)SIZE_MAX))             \
         |              ~~~ ^
   include/linux/overflow.h:309:19: note: expanded from macro 'size_add'
     309 |         typeof(b) __b = (b);                                            \
         |                          ^
   drivers/scsi/mpt3sas/mpt3sas_scsih.c:6744:7: warning: result of comparison of constant 4294967295 with expression of type 'typeof (ioc->sas_hba.num_phys)' (aka 'unsigned char') is always false [-Wtautological-constant-out-of-range-compare]
    6744 |         sz = struct_size(sas_iounit_pg1, PhyData, ioc->sas_hba.num_phys);
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:396:18: note: expanded from macro 'struct_size'
     396 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
..


vim +117 drivers/gpu/drm/nouveau/nvif/mmu.c

eea5cf0f0170fb Ben Skeggs          2017-11-01   38  
eea5cf0f0170fb Ben Skeggs          2017-11-01   39  int
b495396cc9ccf5 Ben Skeggs          2020-03-30   40  nvif_mmu_ctor(struct nvif_object *parent, const char *name, s32 oclass,
b495396cc9ccf5 Ben Skeggs          2020-03-30   41  	      struct nvif_mmu *mmu)
eea5cf0f0170fb Ben Skeggs          2017-11-01   42  {
f5650478ab07c0 Ben Skeggs          2018-05-08   43  	static const struct nvif_mclass mems[] = {
f5650478ab07c0 Ben Skeggs          2018-05-08   44  		{ NVIF_CLASS_MEM_GF100, -1 },
f5650478ab07c0 Ben Skeggs          2018-05-08   45  		{ NVIF_CLASS_MEM_NV50 , -1 },
f5650478ab07c0 Ben Skeggs          2018-05-08   46  		{ NVIF_CLASS_MEM_NV04 , -1 },
f5650478ab07c0 Ben Skeggs          2018-05-08   47  		{}
f5650478ab07c0 Ben Skeggs          2018-05-08   48  	};
eea5cf0f0170fb Ben Skeggs          2017-11-01   49  	struct nvif_mmu_v0 args;
eea5cf0f0170fb Ben Skeggs          2017-11-01   50  	int ret, i;
eea5cf0f0170fb Ben Skeggs          2017-11-01   51  
eea5cf0f0170fb Ben Skeggs          2017-11-01   52  	args.version = 0;
eea5cf0f0170fb Ben Skeggs          2017-11-01   53  	mmu->heap = NULL;
eea5cf0f0170fb Ben Skeggs          2017-11-01   54  	mmu->type = NULL;
eea5cf0f0170fb Ben Skeggs          2017-11-01   55  	mmu->kind = NULL;
eea5cf0f0170fb Ben Skeggs          2017-11-01   56  
b495396cc9ccf5 Ben Skeggs          2020-03-30   57  	ret = nvif_object_ctor(parent, name ? name : "nvifMmu", 0, oclass,
b495396cc9ccf5 Ben Skeggs          2020-03-30   58  			       &args, sizeof(args), &mmu->object);
eea5cf0f0170fb Ben Skeggs          2017-11-01   59  	if (ret)
eea5cf0f0170fb Ben Skeggs          2017-11-01   60  		goto done;
eea5cf0f0170fb Ben Skeggs          2017-11-01   61  
eea5cf0f0170fb Ben Skeggs          2017-11-01   62  	mmu->dmabits = args.dmabits;
eea5cf0f0170fb Ben Skeggs          2017-11-01   63  	mmu->heap_nr = args.heap_nr;
eea5cf0f0170fb Ben Skeggs          2017-11-01   64  	mmu->type_nr = args.type_nr;
eea5cf0f0170fb Ben Skeggs          2017-11-01   65  	mmu->kind_nr = args.kind_nr;
eea5cf0f0170fb Ben Skeggs          2017-11-01   66  
f5650478ab07c0 Ben Skeggs          2018-05-08   67  	ret = nvif_mclass(&mmu->object, mems);
f5650478ab07c0 Ben Skeggs          2018-05-08   68  	if (ret < 0)
f5650478ab07c0 Ben Skeggs          2018-05-08   69  		goto done;
f5650478ab07c0 Ben Skeggs          2018-05-08   70  	mmu->mem = mems[ret].oclass;
f5650478ab07c0 Ben Skeggs          2018-05-08   71  
6da2ec56059c3c Kees Cook           2018-06-12   72  	mmu->heap = kmalloc_array(mmu->heap_nr, sizeof(*mmu->heap),
6da2ec56059c3c Kees Cook           2018-06-12   73  				  GFP_KERNEL);
6da2ec56059c3c Kees Cook           2018-06-12   74  	mmu->type = kmalloc_array(mmu->type_nr, sizeof(*mmu->type),
6da2ec56059c3c Kees Cook           2018-06-12   75  				  GFP_KERNEL);
eea5cf0f0170fb Ben Skeggs          2017-11-01   76  	if (ret = -ENOMEM, !mmu->heap || !mmu->type)
eea5cf0f0170fb Ben Skeggs          2017-11-01   77  		goto done;
eea5cf0f0170fb Ben Skeggs          2017-11-01   78  
6da2ec56059c3c Kees Cook           2018-06-12   79  	mmu->kind = kmalloc_array(mmu->kind_nr, sizeof(*mmu->kind),
6da2ec56059c3c Kees Cook           2018-06-12   80  				  GFP_KERNEL);
eea5cf0f0170fb Ben Skeggs          2017-11-01   81  	if (!mmu->kind && mmu->kind_nr)
eea5cf0f0170fb Ben Skeggs          2017-11-01   82  		goto done;
eea5cf0f0170fb Ben Skeggs          2017-11-01   83  
eea5cf0f0170fb Ben Skeggs          2017-11-01   84  	for (i = 0; i < mmu->heap_nr; i++) {
eea5cf0f0170fb Ben Skeggs          2017-11-01   85  		struct nvif_mmu_heap_v0 args = { .index = i };
eea5cf0f0170fb Ben Skeggs          2017-11-01   86  
eea5cf0f0170fb Ben Skeggs          2017-11-01   87  		ret = nvif_object_mthd(&mmu->object, NVIF_MMU_V0_HEAP,
eea5cf0f0170fb Ben Skeggs          2017-11-01   88  				       &args, sizeof(args));
eea5cf0f0170fb Ben Skeggs          2017-11-01   89  		if (ret)
eea5cf0f0170fb Ben Skeggs          2017-11-01   90  			goto done;
eea5cf0f0170fb Ben Skeggs          2017-11-01   91  
eea5cf0f0170fb Ben Skeggs          2017-11-01   92  		mmu->heap[i].size = args.size;
eea5cf0f0170fb Ben Skeggs          2017-11-01   93  	}
eea5cf0f0170fb Ben Skeggs          2017-11-01   94  
eea5cf0f0170fb Ben Skeggs          2017-11-01   95  	for (i = 0; i < mmu->type_nr; i++) {
eea5cf0f0170fb Ben Skeggs          2017-11-01   96  		struct nvif_mmu_type_v0 args = { .index = i };
eea5cf0f0170fb Ben Skeggs          2017-11-01   97  
eea5cf0f0170fb Ben Skeggs          2017-11-01   98  		ret = nvif_object_mthd(&mmu->object, NVIF_MMU_V0_TYPE,
eea5cf0f0170fb Ben Skeggs          2017-11-01   99  				       &args, sizeof(args));
eea5cf0f0170fb Ben Skeggs          2017-11-01  100  		if (ret)
eea5cf0f0170fb Ben Skeggs          2017-11-01  101  			goto done;
eea5cf0f0170fb Ben Skeggs          2017-11-01  102  
eea5cf0f0170fb Ben Skeggs          2017-11-01  103  		mmu->type[i].type = 0;
eea5cf0f0170fb Ben Skeggs          2017-11-01  104  		if (args.vram) mmu->type[i].type |= NVIF_MEM_VRAM;
eea5cf0f0170fb Ben Skeggs          2017-11-01  105  		if (args.host) mmu->type[i].type |= NVIF_MEM_HOST;
eea5cf0f0170fb Ben Skeggs          2017-11-01  106  		if (args.comp) mmu->type[i].type |= NVIF_MEM_COMP;
eea5cf0f0170fb Ben Skeggs          2017-11-01  107  		if (args.disp) mmu->type[i].type |= NVIF_MEM_DISP;
eea5cf0f0170fb Ben Skeggs          2017-11-01  108  		if (args.kind    ) mmu->type[i].type |= NVIF_MEM_KIND;
eea5cf0f0170fb Ben Skeggs          2017-11-01  109  		if (args.mappable) mmu->type[i].type |= NVIF_MEM_MAPPABLE;
eea5cf0f0170fb Ben Skeggs          2017-11-01  110  		if (args.coherent) mmu->type[i].type |= NVIF_MEM_COHERENT;
eea5cf0f0170fb Ben Skeggs          2017-11-01  111  		if (args.uncached) mmu->type[i].type |= NVIF_MEM_UNCACHED;
eea5cf0f0170fb Ben Skeggs          2017-11-01  112  		mmu->type[i].heap = args.heap;
eea5cf0f0170fb Ben Skeggs          2017-11-01  113  	}
eea5cf0f0170fb Ben Skeggs          2017-11-01  114  
eea5cf0f0170fb Ben Skeggs          2017-11-01  115  	if (mmu->kind_nr) {
eea5cf0f0170fb Ben Skeggs          2017-11-01  116  		struct nvif_mmu_kind_v0 *kind;
7b97492555b106 Gustavo A. R. Silva 2019-05-24 @117  		size_t argc = struct_size(kind, data, mmu->kind_nr);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
