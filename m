Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7B8C76196
	for <linux-hardening@archiver.kernel.org>; Thu,  6 Apr 2023 04:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbjDFEUr (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 6 Apr 2023 00:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbjDFEUp (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 6 Apr 2023 00:20:45 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761FD9747
        for <linux-hardening@vger.kernel.org>; Wed,  5 Apr 2023 21:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680754844; x=1712290844;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wKEFDQF1XVPPVHZwUg8G4bWa/HEfSKPyND1ksY/zx+o=;
  b=WPP9SVWF6QNyk2/ztT9hw/KWzVTymMPNYAk8rcTPvDllTILbAolv4XbG
   eRrzEQEqpRxjwwtXU1JcdB65dqQMiejLJTrMsoWhywcUsPphaf5BV5mjG
   hfkZQUtZn71msnZ7WY16XHGdzstQ7RXazNooBAFTfUyh5wV4I6QX1q/mf
   /Vmmu5XhIziLSCe+KYgnWi2cfEE40JaKq9/hrNTGqEIJ7oNFxldwjbmfs
   GFEn+jUP+JMzyzQ3dpgFty/FRCbN17aTT+5NjhWYVoDpF113nlkkHvNu1
   5KFJkdUCJyp84sXyVEVCuvqPyyYVtzGpik8sgYQ/iXoX5iaWtlRHMCz7O
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="370470308"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="370470308"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 21:20:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="830607147"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="830607147"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 05 Apr 2023 21:20:36 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pkH6y-000R2c-0l;
        Thu, 06 Apr 2023 04:20:36 +0000
Date:   Thu, 6 Apr 2023 12:19:46 +0800
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
        Andrey Konovalov <andreyknvl@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/9] string: Add Kunit tests for strcat() family
Message-ID: <202304061243.Bx5SK1xq-lkp@intel.com>
References: <20230406000212.3442647-3-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406000212.3442647-3-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Kees,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kees/for-next/hardening]
[also build test WARNING on kees/for-next/pstore kees/for-next/kspp akpm-mm/mm-everything linus/master v6.3-rc5 next-20230405]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kees-Cook/kunit-tool-Enable-CONFIG_FORTIFY_SOURCE-under-UML/20230406-081014
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
patch link:    https://lore.kernel.org/r/20230406000212.3442647-3-keescook%40chromium.org
patch subject: [PATCH 3/9] string: Add Kunit tests for strcat() family
config: riscv-randconfig-r042-20230403 (https://download.01.org/0day-ci/archive/20230406/202304061243.Bx5SK1xq-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/1cdc1d7eeb09497f84367bfc2919d5fcc380e454
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kees-Cook/kunit-tool-Enable-CONFIG_FORTIFY_SOURCE-under-UML/20230406-081014
        git checkout 1cdc1d7eeb09497f84367bfc2919d5fcc380e454
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304061243.Bx5SK1xq-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/err.h:5,
                    from include/kunit/assert.h:12,
                    from include/kunit/test.h:12,
                    from lib/strcat_kunit.c:8:
   lib/strcat_kunit.c: In function 'strncat_test':
>> lib/strcat_kunit.c:52:33: warning: 'strncat' output truncated copying 2 bytes from a string of length 4 [-Wstringop-truncation]
      52 |         KUNIT_EXPECT_TRUE(test, strncat(dest, "ABCD", 2) == dest);
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:77:45: note: in definition of macro 'likely'
      77 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   include/kunit/test.h:545:9: note: in expansion of macro 'KUNIT_UNARY_ASSERTION'
     545 |         KUNIT_UNARY_ASSERTION(test,                                            \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:736:9: note: in expansion of macro 'KUNIT_TRUE_MSG_ASSERTION'
     736 |         KUNIT_TRUE_MSG_ASSERTION(test,                                         \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:733:9: note: in expansion of macro 'KUNIT_EXPECT_TRUE_MSG'
     733 |         KUNIT_EXPECT_TRUE_MSG(test, condition, NULL)
         |         ^~~~~~~~~~~~~~~~~~~~~
   lib/strcat_kunit.c:52:9: note: in expansion of macro 'KUNIT_EXPECT_TRUE'
      52 |         KUNIT_EXPECT_TRUE(test, strncat(dest, "ABCD", 2) == dest);
         |         ^~~~~~~~~~~~~~~~~


vim +/strncat +52 lib/strcat_kunit.c

    29	
    30	static void strncat_test(struct kunit *test)
    31	{
    32		char dest[8];
    33	
    34		/* Destination is terminated. */
    35		memset(dest, 0, sizeof(dest));
    36		KUNIT_EXPECT_EQ(test, strlen(dest), 0);
    37		/* Empty copy of size 0 does nothing. */
    38		KUNIT_EXPECT_TRUE(test, strncat(dest, "", 0) == dest);
    39		KUNIT_EXPECT_STREQ(test, dest, "");
    40		/* Empty copy of size 1 does nothing too. */
    41		KUNIT_EXPECT_TRUE(test, strncat(dest, "", 1) == dest);
    42		KUNIT_EXPECT_STREQ(test, dest, "");
    43		/* Copy of max 0 characters should do nothing. */
    44		KUNIT_EXPECT_TRUE(test, strncat(dest, "asdf", 0) == dest);
    45		KUNIT_EXPECT_STREQ(test, dest, "");
    46	
    47		/* 4 characters copied in, even if max is 8. */
    48		KUNIT_EXPECT_TRUE(test, strncat(dest, "four\000123", 8) == dest);
    49		KUNIT_EXPECT_STREQ(test, dest, "four");
    50		KUNIT_EXPECT_EQ(test, dest[5], '\0');
    51		/* 2 characters copied in okay, 2 ignored. */
  > 52		KUNIT_EXPECT_TRUE(test, strncat(dest, "ABCD", 2) == dest);
    53		KUNIT_EXPECT_STREQ(test, dest, "fourAB");
    54	}
    55	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
