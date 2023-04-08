Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BDEC76196
	for <linux-hardening@archiver.kernel.org>; Sat,  8 Apr 2023 02:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjDHC1b (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 7 Apr 2023 22:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjDHC1a (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 7 Apr 2023 22:27:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1017E184
        for <linux-hardening@vger.kernel.org>; Fri,  7 Apr 2023 19:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680920849; x=1712456849;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8jePMQVInnFDg91u5cV3zE5KaByy9eUAydIBN3Z3FVc=;
  b=NM+uYoBFeABFkewNPlF8vRg+X4DwC277AH1aPAcFs7FejNdg+vMLNVUH
   4d9kttde4//lAuF4rUy+Y/VPFr6YXTvn7L3eFQUwNB+PWBsuunqzd2rBg
   SXP53gxYJkD/WOJ+F068hBO3ElskqX+qIIVU4X1II5mFxFSlvimcPU1ZZ
   dVbKoNbdB/LfUPx0wWXhC5be98BUZikyUil2BQf2ijgWx9KH3VvBimkmX
   fS7Cq+1suR3kTojUPKvYLOrOtciCcCq7WXY4qBqbiD7nsy++tSRuenZ8T
   DNAWK1uzYeF/GwoKg1yQkzzXa+fVM3us2Kud9N3lqIt2c4ippsYuTCUpV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="327193484"
X-IronPort-AV: E=Sophos;i="5.98,328,1673942400"; 
   d="scan'208";a="327193484"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 19:27:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="637879072"
X-IronPort-AV: E=Sophos;i="5.98,328,1673942400"; 
   d="scan'208";a="637879072"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 07 Apr 2023 19:27:22 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pkyIT-000TBa-0e;
        Sat, 08 Apr 2023 02:27:21 +0000
Date:   Sat, 8 Apr 2023 10:26:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Puyou Lu <puyou.lu@gmail.com>, Mark Brown <broonie@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <yury.norov@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Sander Vanheule <sander@svanheule.net>,
        Eric Biggers <ebiggers@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Andrey Konovalov <andreyknvl@gmail.com>
Subject: Re: [PATCH v2 07/10] fortify: Split reporting and avoid passing
 string pointer
Message-ID: <202304081026.0GjsJGNP-lkp@intel.com>
References: <20230407192717.636137-7-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407192717.636137-7-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Kees,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kees/for-next/hardening]
[also build test WARNING on kees/for-next/pstore kees/for-next/kspp linus/master tip/x86/core v6.3-rc5 next-20230406]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kees-Cook/kunit-tool-Enable-CONFIG_FORTIFY_SOURCE-under-UML/20230408-032959
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
patch link:    https://lore.kernel.org/r/20230407192717.636137-7-keescook%40chromium.org
patch subject: [PATCH v2 07/10] fortify: Split reporting and avoid passing string pointer
config: arm-randconfig-r046-20230404 (https://download.01.org/0day-ci/archive/20230408/202304081026.0GjsJGNP-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/124d051177d6812a0b5bd445a9f89e0694d56f2d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kees-Cook/kunit-tool-Enable-CONFIG_FORTIFY_SOURCE-under-UML/20230408-032959
        git checkout 124d051177d6812a0b5bd445a9f89e0694d56f2d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304081026.0GjsJGNP-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/arm/boot/compressed/misc.c:129:17: warning: no previous prototype for '__div0' [-Wmissing-prototypes]
     129 | asmlinkage void __div0(void)
         |                 ^~~~~~
   arch/arm/boot/compressed/misc.c:138:1: warning: no previous prototype for 'decompress_kernel' [-Wmissing-prototypes]
     138 | decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
         | ^~~~~~~~~~~~~~~~~
>> arch/arm/boot/compressed/misc.c:163:6: warning: no previous prototype for '__fortify_panic' [-Wmissing-prototypes]
     163 | void __fortify_panic(const u8 reason)
         |      ^~~~~~~~~~~~~~~


vim +/__fortify_panic +163 arch/arm/boot/compressed/misc.c

   128	
 > 129	asmlinkage void __div0(void)
   130	{
   131		error("Attempting division by 0!");
   132	}
   133	
   134	extern int do_decompress(u8 *input, int len, u8 *output, void (*error)(char *x));
   135	
   136	
   137	void
   138	decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
   139			unsigned long free_mem_ptr_end_p,
   140			int arch_id)
   141	{
   142		int ret;
   143	
   144		output_data		= (unsigned char *)output_start;
   145		free_mem_ptr		= free_mem_ptr_p;
   146		free_mem_end_ptr	= free_mem_ptr_end_p;
   147		__machine_arch_type	= arch_id;
   148	
   149	#ifdef CONFIG_ARCH_EP93XX
   150		ep93xx_decomp_setup();
   151	#endif
   152		arch_decomp_setup();
   153	
   154		putstr("Uncompressing Linux...");
   155		ret = do_decompress(input_data, input_data_end - input_data,
   156				    output_data, error);
   157		if (ret)
   158			error("decompressor returned an error");
   159		else
   160			putstr(" done, booting the kernel.\n");
   161	}
   162	
 > 163	void __fortify_panic(const u8 reason)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
