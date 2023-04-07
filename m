Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B222DC77B61
	for <linux-hardening@archiver.kernel.org>; Fri,  7 Apr 2023 10:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjDGK14 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 7 Apr 2023 06:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239705AbjDGK1w (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 7 Apr 2023 06:27:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAB6A5D3
        for <linux-hardening@vger.kernel.org>; Fri,  7 Apr 2023 03:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680863269; x=1712399269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7edVbc99053vvbrnLS4HCEABW1YsZFGYJKqGCy78KsM=;
  b=Ir61D+ZsB/aoUnY37iE637rIXCbQns9/0UznUpN38x5NBMM/TH5bYoQn
   uYL31jRiR+QrocubTl8CWd8fv0ExoQ/a987aQeXBbxyocoS2P6CE+SUUD
   LLTAZkqHmyKsCXzeF7oAXJ2NNtPS3eFJ56StjzzeEWH+hgJRF3wkQLOTu
   5/ZqxGWVD8rBaXvHz5LQYRaMab5wu6QnO9Us8CahzciwQz7DNfJ3xVqDC
   qx4v2zc59lrrE0reTM+QdDBHFh6bWGSlR05gh3k2UnDMxUrACT8HzT/4H
   8uEtahhf4DBFiS1F+cRCuvgaGo4P/kY4GTLL3bNe6Iayy+wICoRrB1KVT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="344734397"
X-IronPort-AV: E=Sophos;i="5.98,326,1673942400"; 
   d="scan'208";a="344734397"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 03:27:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="756679889"
X-IronPort-AV: E=Sophos;i="5.98,326,1673942400"; 
   d="scan'208";a="756679889"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 07 Apr 2023 03:27:40 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pkjJj-000SNG-12;
        Fri, 07 Apr 2023 10:27:39 +0000
Date:   Fri, 7 Apr 2023 18:26:51 +0800
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
Subject: Re: [PATCH 6/9] fortify: Split reporting and avoid passing string
 pointer
Message-ID: <202304071824.648116sH-lkp@intel.com>
References: <20230406000212.3442647-6-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406000212.3442647-6-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Kees,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kees/for-next/hardening]
[also build test WARNING on kees/for-next/pstore kees/for-next/kspp akpm-mm/mm-everything linus/master v6.3-rc5 next-20230406]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kees-Cook/kunit-tool-Enable-CONFIG_FORTIFY_SOURCE-under-UML/20230406-081014
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
patch link:    https://lore.kernel.org/r/20230406000212.3442647-6-keescook%40chromium.org
patch subject: [PATCH 6/9] fortify: Split reporting and avoid passing string pointer
config: arm64-randconfig-s053-20230406 (https://download.01.org/0day-ci/archive/20230407/202304071824.648116sH-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/4fd520e6ee549e1ffe8859e26e57ea64b48e78ea
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kees-Cook/kunit-tool-Enable-CONFIG_FORTIFY_SOURCE-under-UML/20230406-081014
        git checkout 4fd520e6ee549e1ffe8859e26e57ea64b48e78ea
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304071824.648116sH-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   lib/string_helpers.c:1030:14: sparse: sparse: undefined identifier 'FORTIFY_FUNC_strncpy'
   lib/string_helpers.c:1033:14: sparse: sparse: undefined identifier 'FORTIFY_FUNC_strnlen'
   lib/string_helpers.c:1036:14: sparse: sparse: undefined identifier 'FORTIFY_FUNC_strlen'
   lib/string_helpers.c:1039:14: sparse: sparse: undefined identifier 'FORTIFY_FUNC_strlcpy'
   lib/string_helpers.c:1042:14: sparse: sparse: undefined identifier 'FORTIFY_FUNC_strscpy'
   lib/string_helpers.c:1045:14: sparse: sparse: undefined identifier 'FORTIFY_FUNC_strlcat'
   lib/string_helpers.c:1048:14: sparse: sparse: undefined identifier 'FORTIFY_FUNC_strcat'
   lib/string_helpers.c:1051:14: sparse: sparse: undefined identifier 'FORTIFY_FUNC_strncat'
   lib/string_helpers.c:1054:14: sparse: sparse: undefined identifier 'FORTIFY_FUNC_memset'
   lib/string_helpers.c:1057:14: sparse: sparse: undefined identifier 'FORTIFY_FUNC_memcpy'
   lib/string_helpers.c:1060:14: sparse: sparse: undefined identifier 'FORTIFY_FUNC_memmove'
   lib/string_helpers.c:1063:14: sparse: sparse: undefined identifier 'FORTIFY_FUNC_memscan'
   lib/string_helpers.c:1066:14: sparse: sparse: undefined identifier 'FORTIFY_FUNC_memcmp'
   lib/string_helpers.c:1069:14: sparse: sparse: undefined identifier 'FORTIFY_FUNC_memchr'
   lib/string_helpers.c:1072:14: sparse: sparse: undefined identifier 'FORTIFY_FUNC_memchr_inv'
   lib/string_helpers.c:1075:14: sparse: sparse: undefined identifier 'FORTIFY_FUNC_kmemdup'
   lib/string_helpers.c:1078:14: sparse: sparse: undefined identifier 'FORTIFY_FUNC_strcpy'
>> lib/string_helpers.c:1030:14: sparse: sparse: incompatible types for 'case' statement
   lib/string_helpers.c:1033:14: sparse: sparse: incompatible types for 'case' statement
   lib/string_helpers.c:1036:14: sparse: sparse: incompatible types for 'case' statement
   lib/string_helpers.c:1039:14: sparse: sparse: incompatible types for 'case' statement
   lib/string_helpers.c:1042:14: sparse: sparse: incompatible types for 'case' statement
   lib/string_helpers.c:1045:14: sparse: sparse: incompatible types for 'case' statement
   lib/string_helpers.c:1048:14: sparse: sparse: incompatible types for 'case' statement
   lib/string_helpers.c:1051:14: sparse: sparse: incompatible types for 'case' statement
   lib/string_helpers.c:1054:14: sparse: sparse: incompatible types for 'case' statement
   lib/string_helpers.c:1057:14: sparse: sparse: incompatible types for 'case' statement
   lib/string_helpers.c:1060:14: sparse: sparse: incompatible types for 'case' statement
   lib/string_helpers.c:1063:14: sparse: sparse: incompatible types for 'case' statement
   lib/string_helpers.c:1066:14: sparse: sparse: incompatible types for 'case' statement
   lib/string_helpers.c:1069:14: sparse: sparse: incompatible types for 'case' statement
   lib/string_helpers.c:1072:14: sparse: sparse: incompatible types for 'case' statement
   lib/string_helpers.c:1075:14: sparse: sparse: incompatible types for 'case' statement
   lib/string_helpers.c:1078:14: sparse: sparse: incompatible types for 'case' statement
   lib/string_helpers.c:1030:14: sparse: sparse: Expected constant expression in case statement
   lib/string_helpers.c:1033:14: sparse: sparse: Expected constant expression in case statement
   lib/string_helpers.c:1036:14: sparse: sparse: Expected constant expression in case statement
   lib/string_helpers.c:1039:14: sparse: sparse: Expected constant expression in case statement
   lib/string_helpers.c:1042:14: sparse: sparse: Expected constant expression in case statement
   lib/string_helpers.c:1045:14: sparse: sparse: Expected constant expression in case statement
   lib/string_helpers.c:1048:14: sparse: sparse: Expected constant expression in case statement
   lib/string_helpers.c:1051:14: sparse: sparse: Expected constant expression in case statement
   lib/string_helpers.c:1054:14: sparse: sparse: Expected constant expression in case statement
   lib/string_helpers.c:1057:14: sparse: sparse: Expected constant expression in case statement
   lib/string_helpers.c:1060:14: sparse: sparse: Expected constant expression in case statement
   lib/string_helpers.c:1063:14: sparse: sparse: Expected constant expression in case statement
   lib/string_helpers.c:1066:14: sparse: sparse: Expected constant expression in case statement
   lib/string_helpers.c:1069:14: sparse: sparse: Expected constant expression in case statement
   lib/string_helpers.c:1072:14: sparse: sparse: Expected constant expression in case statement
   lib/string_helpers.c:1075:14: sparse: sparse: Expected constant expression in case statement
   lib/string_helpers.c:1078:14: sparse: sparse: Expected constant expression in case statement

vim +/case +1030 lib/string_helpers.c

  1023	
  1024	void __fortify_report(u8 reason)
  1025	{
  1026		const char *name;
  1027		const bool write = !!(reason & 0x1);
  1028	
  1029		switch (reason >> 1) {
> 1030		case FORTIFY_FUNC_strncpy:
  1031			name = "strncpy";
  1032			break;
  1033		case FORTIFY_FUNC_strnlen:
  1034			name = "strnlen";
  1035			break;
  1036		case FORTIFY_FUNC_strlen:
  1037			name = "strlen";
  1038			break;
  1039		case FORTIFY_FUNC_strlcpy:
  1040			name = "strlcpy";
  1041			break;
  1042		case FORTIFY_FUNC_strscpy:
  1043			name = "strscpy";
  1044			break;
  1045		case FORTIFY_FUNC_strlcat:
  1046			name = "strlcat";
  1047			break;
  1048		case FORTIFY_FUNC_strcat:
  1049			name = "strcat";
  1050			break;
  1051		case FORTIFY_FUNC_strncat:
  1052			name = "strncat";
  1053			break;
> 1054		case FORTIFY_FUNC_memset:
  1055			name = "memset";
  1056			break;
  1057		case FORTIFY_FUNC_memcpy:
  1058			name = "memcpy";
  1059			break;
  1060		case FORTIFY_FUNC_memmove:
  1061			name = "memmove";
  1062			break;
  1063		case FORTIFY_FUNC_memscan:
  1064			name = "memscan";
  1065			break;
  1066		case FORTIFY_FUNC_memcmp:
  1067			name = "memcmp";
  1068			break;
  1069		case FORTIFY_FUNC_memchr:
  1070			name = "memchr";
  1071			break;
  1072		case FORTIFY_FUNC_memchr_inv:
  1073			name = "memchr_inv";
  1074			break;
  1075		case FORTIFY_FUNC_kmemdup:
  1076			name = "kmemdup";
  1077			break;
  1078		case FORTIFY_FUNC_strcpy:
  1079			name = "strcpy";
  1080			break;
  1081		default:
  1082			name = "unknown";
  1083		}
  1084		WARN(1, "%s: detected buffer %s overflow\n", name, write ? "write" : "read");
  1085	}
  1086	EXPORT_SYMBOL(__fortify_report);
  1087	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
