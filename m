Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YQuC+rhl"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D631A2;
	Tue,  5 Dec 2023 23:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701846677; x=1733382677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DBIbnYwbgVp0kwWfINOfj5XakIpyE0IXeRSltkvXR7c=;
  b=YQuC+rhlvmBwCJR8XI9ru843IbQNkq45fAr6OV4tt47OFJWcj0arYn4N
   DyRdSqTtp7vXB7fq8MKMmILVMj0VokefwWY1lLB7vuWKbhLKRM2vWQS6h
   8fe+uFlXOOVrzJeUB/ECSUaiUnvb9OYwlyYcUwOj+BlijxAcSa1pTL6Au
   yx7fBle+Icals7EqgN9JVvwuIjQfnUKgj059TUVvGSnNC1oWGx8zI4vNC
   PBkZs7XmCVWmDuVileVG5wCaF2Q/SwZYSNVIO42pEhYCw68OfvH+HArlI
   UwT7YEkz0Gx6cYkqJNjxxlonV7qS0CXplHirqbnKYKQbDVDSGfWVNcTC5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="480215898"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="480215898"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 23:11:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="862019426"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="862019426"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Dec 2023 23:11:13 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rAm3o-000ARo-2g;
	Wed, 06 Dec 2023 07:11:09 +0000
Date: Wed, 6 Dec 2023 15:10:46 +0800
From: kernel test robot <lkp@intel.com>
To: tanzirh@google.com, Kees Cook <keescook@chromium.org>
Cc: oe-kbuild-all@lists.linux.dev, Andy Shevchenko <andy@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nick DeSaulniers <nnn@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	llvm@lists.linux.dev, Tanzir Hasan <tanzirh@google.com>
Subject: Re: [PATCH] lib/string: shrink lib/string.i via IWYU
Message-ID: <202312061429.BJ7GrHnt-lkp@intel.com>
References: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on 33cc938e65a98f1d29d0a18403dbbee050dcad9a]

url:    https://github.com/intel-lab-lkp/linux/commits/tanzirh-google-com/lib-string-shrink-lib-string-i-via-IWYU/20231206-050121
base:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
patch link:    https://lore.kernel.org/r/20231205-libstringheader-v1-1-7f9c573053a7%40gmail.com
patch subject: [PATCH] lib/string: shrink lib/string.i via IWYU
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20231206/202312061429.BJ7GrHnt-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312061429.BJ7GrHnt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312061429.BJ7GrHnt-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from lib/string.c:29:
   lib/string.c: In function 'strscpy':
>> arch/sh/include/asm/word-at-a-time.h:15:36: error: implicit declaration of function 'REPEAT_BYTE' [-Werror=implicit-function-declaration]
      15 | #define WORD_AT_A_TIME_CONSTANTS { REPEAT_BYTE(0x01), REPEAT_BYTE(0x80) }
         |                                    ^~~~~~~~~~~
   lib/string.c:124:49: note: in expansion of macro 'WORD_AT_A_TIME_CONSTANTS'
     124 |         const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;
         |                                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/REPEAT_BYTE +15 arch/sh/include/asm/word-at-a-time.h

cba8df4be3bdf1 Paul Mundt 2012-06-04  14  
cba8df4be3bdf1 Paul Mundt 2012-06-04 @15  #define WORD_AT_A_TIME_CONSTANTS { REPEAT_BYTE(0x01), REPEAT_BYTE(0x80) }
cba8df4be3bdf1 Paul Mundt 2012-06-04  16  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
