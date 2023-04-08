Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BC6C76196
	for <linux-hardening@archiver.kernel.org>; Sat,  8 Apr 2023 00:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjDHAd0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 7 Apr 2023 20:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjDHAd0 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 7 Apr 2023 20:33:26 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08373C66C
        for <linux-hardening@vger.kernel.org>; Fri,  7 Apr 2023 17:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680914004; x=1712450004;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+4kq+ByesKZ4cTl2OIrt3sTsul9XMQzu+dHP9ObqPHM=;
  b=VH8Y/lV5zHx5uoKuVnw+c9+Yg/o6Qnkx3iWJs+RJN0mwo1x6zbSYA7wL
   MTxfkVL03GrHgVV4EA6pb/N0yhYivEpDYfsIbuR2NG9sYw8FuDZB1QKvj
   4xo26SZzjheJrxjL4FmB5v9b8sEMx87gQs2PGhWd7GXxOzKSWIojJbJvv
   IE6YmxCm1c0mzP9f5Za1ccHx+iv0wDP2AgLZ0NUr5bskRTC0gPuk9jrK1
   9EnDaSF+sQgdpgsqqSr2cVamE0YbowgvuQ4jBdSx61rSRhya1qGvMrRN4
   s2Cb7Wwboh9RRXRXFOchMAFyUZ0WFEWL9JUG+WsHmz6zw8938WOV+H4Z0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="345749412"
X-IronPort-AV: E=Sophos;i="5.98,328,1673942400"; 
   d="scan'208";a="345749412"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 17:33:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="717987704"
X-IronPort-AV: E=Sophos;i="5.98,328,1673942400"; 
   d="scan'208";a="717987704"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 07 Apr 2023 17:33:15 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pkwW2-000T4T-3C;
        Sat, 08 Apr 2023 00:33:14 +0000
Date:   Sat, 8 Apr 2023 08:33:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Puyou Lu <puyou.lu@gmail.com>, Mark Brown <broonie@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH v2 09/10] fortify: Add KUnit tests for runtime overflows
Message-ID: <202304080811.nYP4KpPZ-lkp@intel.com>
References: <20230407192717.636137-9-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407192717.636137-9-keescook@chromium.org>
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
patch link:    https://lore.kernel.org/r/20230407192717.636137-9-keescook%40chromium.org
patch subject: [PATCH v2 09/10] fortify: Add KUnit tests for runtime overflows
config: openrisc-randconfig-r034-20230405 (https://download.01.org/0day-ci/archive/20230408/202304080811.nYP4KpPZ-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d212962ef7682ee160bf38fa455475558f031759
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kees-Cook/kunit-tool-Enable-CONFIG_FORTIFY_SOURCE-under-UML/20230408-032959
        git checkout d212962ef7682ee160bf38fa455475558f031759
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=openrisc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=openrisc SHELL=/bin/bash lib/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304080811.nYP4KpPZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from lib/fortify_kunit.c:28:
   lib/fortify_kunit.c: In function 'strnlen_test':
>> lib/fortify_kunit.c:412:31: warning: 'strnlen' specified bound 33 exceeds source size 32 [-Wstringop-overread]
     412 |         KUNIT_EXPECT_EQ(test, strnlen(pad.buf, end + 1), end);
   include/kunit/test.h:584:38: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     584 |         const typeof(left) __left = (left);                                    \
         |                                      ^~~~
   include/kunit/test.h:776:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     776 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:773:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     773 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/fortify_kunit.c:412:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
     412 |         KUNIT_EXPECT_EQ(test, strnlen(pad.buf, end + 1), end);
         |         ^~~~~~~~~~~~~~~
   lib/fortify_kunit.c:359:14: note: source object allocated here
     359 |         char buf[32];
         |              ^~~
   lib/fortify_kunit.c:414:31: warning: 'strnlen' specified bound 34 exceeds source size 32 [-Wstringop-overread]
     414 |         KUNIT_EXPECT_EQ(test, strnlen(pad.buf, end + 2), end);
   include/kunit/test.h:584:38: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     584 |         const typeof(left) __left = (left);                                    \
         |                                      ^~~~
   include/kunit/test.h:776:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     776 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:773:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     773 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/fortify_kunit.c:414:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
     414 |         KUNIT_EXPECT_EQ(test, strnlen(pad.buf, end + 2), end);
         |         ^~~~~~~~~~~~~~~
   lib/fortify_kunit.c:359:14: note: source object allocated here
     359 |         char buf[32];
         |              ^~~


vim +/strnlen +412 lib/fortify_kunit.c

   387	
   388	static void strnlen_test(struct kunit *test)
   389	{
   390		struct fortify_padding pad = { };
   391		int i, end = sizeof(pad.buf) - 1;
   392	
   393		/* Fill 31 bytes with valid characters. */
   394		for (i = 0; i < sizeof(pad.buf) - 1; i++)
   395			pad.buf[i] = i + '0';
   396		/* Trailing bytes are still %NUL. */
   397		KUNIT_EXPECT_EQ(test, pad.buf[end], '\0');
   398		KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
   399	
   400		/* String is terminated, so strnlen() is valid. */
   401		KUNIT_EXPECT_EQ(test, strnlen(pad.buf, sizeof(pad.buf)), end);
   402		KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
   403		/* A truncated strnlen() will be safe, too. */
   404		KUNIT_EXPECT_EQ(test, strnlen(pad.buf, sizeof(pad.buf) / 2),
   405						sizeof(pad.buf) / 2);
   406		KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
   407	
   408		/* Make string unterminated, and recount. */
   409		pad.buf[end] = 'A';
   410		end = sizeof(pad.buf);
   411		/* Reading beyond with strncpy() will fail. */
 > 412		KUNIT_EXPECT_EQ(test, strnlen(pad.buf, end + 1), end);
   413		KUNIT_EXPECT_EQ(test, fortify_read_overflows, 1);
   414		KUNIT_EXPECT_EQ(test, strnlen(pad.buf, end + 2), end);
   415		KUNIT_EXPECT_EQ(test, fortify_read_overflows, 2);
   416	
   417		/* Early-truncated is safe still, though. */
   418		KUNIT_EXPECT_EQ(test, strnlen(pad.buf, end), end);
   419		KUNIT_EXPECT_EQ(test, fortify_read_overflows, 2);
   420	
   421		end = sizeof(pad.buf) / 2;
   422		KUNIT_EXPECT_EQ(test, strnlen(pad.buf, end), end);
   423		KUNIT_EXPECT_EQ(test, fortify_read_overflows, 2);
   424	}
   425	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
