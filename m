Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C25C0015E
	for <linux-hardening@archiver.kernel.org>; Fri, 11 Aug 2023 14:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjHKOLD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 11 Aug 2023 10:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbjHKOKy (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 11 Aug 2023 10:10:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00DFE65;
        Fri, 11 Aug 2023 07:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691763053; x=1723299053;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=45vu1KVZaynLGE6xff8pnvoLx5zLr5L6i5XJfOncpok=;
  b=b+7nVCaTh8KDYiURxYgxKEKavZcL5BSEli5poPI1Y1e8CsrlskwFHjr4
   dlMThSyPS43KSrkZGRUeTg5djWFtWIOu4+rn9e4+fD6j7eb5uDJCeB2q1
   jAwRoaMBMXP9JQ6ukqqiJWcsMSW/H8mcAB15G6yaXlZfoZpaVa4ys8euK
   A3mzA53hdBqdP6PG9dic/u+qLu3JlMMmZPdYeL1jjjGLqNGzZFIzN7bEl
   m3IKSpZnwLkyN+rdmN4fITc4BgRDgEpW4RQhl5GFdzinTGefIW06ZtxZd
   ELEkAJ0A8rwvzY+Ce71842zTejN6Ix7XiiUtYoLvlTg5cOX4S8fHsqAxH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="351285903"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="351285903"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 07:10:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="856316188"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="856316188"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 11 Aug 2023 07:10:43 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUSqg-0007pG-2f;
        Fri, 11 Aug 2023 14:10:42 +0000
Date:   Fri, 11 Aug 2023 22:10:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Jacob Keller <jacob.e.keller@intel.com>,
        intel-wired-lan@lists.osuosl.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        linux-hardening@vger.kernel.org, Steven Zou <steven.zou@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v2 1/7] overflow: add DEFINE_FLEX() for on-stack
 allocs
Message-ID: <202308112122.OuF0YZqL-lkp@intel.com>
References: <20230811120814.169952-2-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811120814.169952-2-przemyslaw.kitszel@intel.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Przemek,

kernel test robot noticed the following build errors:

[auto build test ERROR on 6a1ed1430daa2ccf8ac457e0db93fb0925b801ca]

url:    https://github.com/intel-lab-lkp/linux/commits/Przemek-Kitszel/overflow-add-DEFINE_FLEX-for-on-stack-allocs/20230811-201509
base:   6a1ed1430daa2ccf8ac457e0db93fb0925b801ca
patch link:    https://lore.kernel.org/r/20230811120814.169952-2-przemyslaw.kitszel%40intel.com
patch subject: [PATCH net-next v2 1/7] overflow: add DEFINE_FLEX() for on-stack allocs
config: m68k-randconfig-r024-20230811 (https://download.01.org/0day-ci/archive/20230811/202308112122.OuF0YZqL-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230811/202308112122.OuF0YZqL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308112122.OuF0YZqL-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/compiler.h:5,
                    from include/linux/export.h:5,
                    from include/asm-generic/export.h:9,
                    from ./arch/m68k/include/generated/asm/export.h:1,
                    from arch/m68k/lib/mulsi3.S:35:
>> include/linux/compiler_types.h:331:5: warning: "__has_builtin" is not defined, evaluates to 0 [-Wundef]
     331 | #if __has_builtin(__builtin_dynamic_object_size)
         |     ^~~~~~~~~~~~~
>> include/linux/compiler_types.h:331:18: error: missing binary operator before token "("
     331 | #if __has_builtin(__builtin_dynamic_object_size)
         |                  ^


vim +331 include/linux/compiler_types.h

   326	
   327	/*
   328	 * When the size of an allocated object is needed, use the best available
   329	 * mechanism to find it. (For cases where sizeof() cannot be used.)
   330	 */
 > 331	#if __has_builtin(__builtin_dynamic_object_size)
   332	#define __struct_size(p)	__builtin_dynamic_object_size(p, 0)
   333	#define __member_size(p)	__builtin_dynamic_object_size(p, 1)
   334	#else
   335	#define __struct_size(p)	__builtin_object_size(p, 0)
   336	#define __member_size(p)	__builtin_object_size(p, 1)
   337	#endif
   338	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
