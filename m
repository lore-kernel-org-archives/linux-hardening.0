Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EF925B1DA;
	Thu, 29 Jan 2026 14:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769697665; cv=none; b=LmUt/IpVGgOb45v/7iwxrUeIXAMHTiehDVrVijXUtE+0ST/QoIX10uKjhyCIB37VupBIf0YztRqMmZ1yxgmHZLadqsLGGUqKkDHdVYDhE1bcIbhkI3N9eywL3Bfu+39z10PDBhEgRSZ2ZfYlXFhlNyLQc4auvxdPz7+u333rDZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769697665; c=relaxed/simple;
	bh=D6Irzj87/GiSgJK3voystE+jXtAPmSkx3H3hxWfzNkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6FiZLrrs9vrQRDRdpFiE6F33tJM5MKo+rYwI1m1qVDsu8A1WdvEa0UPxkZKduFVeAA0CG5M9vfPJvEIU37UHS8/CbwHoPLGm3jyRG4pNAu1eG7/HvRitFeWy2cbM0+9Dx7F0/wUdgE5Rt0IHMMh2Ey7Pa6uIDbZNW6ZyJeaNdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P3MsBBwA; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P3MsBBwA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769697664; x=1801233664;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D6Irzj87/GiSgJK3voystE+jXtAPmSkx3H3hxWfzNkM=;
  b=P3MsBBwAo4PGatpqRdQqXLcNtZSfZ+MCFPw94/nMm0d4YSovF92dkS5K
   ItB0YLutFhIBbe+5ssOBLZkQ3VzIiNUKx7q9TS+u9tI50zS5l3N+z5Y0y
   XxzfFJwPizSzydWUwtp519X+QmMVnlyl8FFKODz2UEjtZI6dtwQq9u3Bt
   T9c0Aep+ZtqGX6Z+mhe8sL/PjhSr4Qvt2HbNaasrPzQklDnaJxM2Bce1t
   MGDX20idpC+z3s1rgovlbRqVY4LKQ5Nr1Bb0+TaHTmjNETNqHw1B8TZym
   FGuRvG9mJYmmgLd11Nlbl+COijWmOWp0bVR5zfv0rX4Oo754N8ZtRJD19
   Q==;
X-CSE-ConnectionGUID: SO3XpvcwQUen5CieC5w74Q==
X-CSE-MsgGUID: RIyxz28GRGa95z2bzs6Psg==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="70912007"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="70912007"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 06:41:03 -0800
X-CSE-ConnectionGUID: TCJTVxH0Qbmg4ffpW5B+tg==
X-CSE-MsgGUID: iL68MgQTSImlJcoBkfPtoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="239845322"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 29 Jan 2026 06:40:58 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vlTCa-00000000bYK-0N8O;
	Thu, 29 Jan 2026 14:40:56 +0000
Date: Thu, 29 Jan 2026 22:40:09 +0800
From: kernel test robot <lkp@intel.com>
To: Feng Jiang <jiangfeng@kylinos.cn>, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, akpm@linux-foundation.org,
	kees@kernel.org, andy@kernel.org, ebiggers@kernel.org,
	martin.petersen@oracle.com, herbert@gondor.apana.org.au,
	samuel.holland@sifive.com, ajones@ventanamicro.com,
	charlie@rivosinc.com, conor.dooley@microchip.com,
	linus.walleij@linaro.org, nathan@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v6 1/8] lib/string_kunit: add correctness test for
 strlen()
Message-ID: <202601292204.xA8dUDti-lkp@intel.com>
References: <20260129070227.220866-2-jiangfeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129070227.220866-2-jiangfeng@kylinos.cn>

Hi Feng,

kernel test robot noticed the following build errors:

[auto build test ERROR on kees/for-next/hardening]
[also build test ERROR on akpm-mm/mm-nonmm-unstable akpm-mm/mm-everything linus/master v6.19-rc7 next-20260128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Feng-Jiang/lib-string_kunit-add-correctness-test-for-strlen/20260129-151036
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
patch link:    https://lore.kernel.org/r/20260129070227.220866-2-jiangfeng%40kylinos.cn
patch subject: [PATCH v6 1/8] lib/string_kunit: add correctness test for strlen()
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20260129/202601292204.xA8dUDti-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260129/202601292204.xA8dUDti-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601292204.xA8dUDti-lkp@intel.com/

All errors (new ones prefixed by >>):

   lib/tests/string_kunit.c: In function 'string_test_strlen':
>> lib/tests/string_kunit.c:116:20: error: implicit declaration of function 'PAGE_ALIGN'; did you mean 'PTR_ALIGN'? [-Wimplicit-function-declaration]
     116 |         buf_size = PAGE_ALIGN(STRING_TEST_MAX_LEN + STRING_TEST_MAX_OFFSET + 1);
         |                    ^~~~~~~~~~
         |                    PTR_ALIGN


vim +116 lib/tests/string_kunit.c

   110	
   111	static void string_test_strlen(struct kunit *test)
   112	{
   113		size_t buf_size;
   114		char *buf, *s;
   115	
 > 116		buf_size = PAGE_ALIGN(STRING_TEST_MAX_LEN + STRING_TEST_MAX_OFFSET + 1);
   117		buf = vmalloc(buf_size);
   118		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
   119	
   120		memset(buf, 'A', buf_size);
   121	
   122		for (size_t offset = 0; offset < STRING_TEST_MAX_OFFSET; offset++) {
   123			for (size_t len = 0; len <= STRING_TEST_MAX_LEN; len++) {
   124				s = buf + buf_size - 1 - offset - len;
   125				s[len] = '\0';
   126				KUNIT_EXPECT_EQ_MSG(test, strlen(s), len,
   127					"offset:%zu len:%zu", offset, len);
   128				s[len] = 'A';
   129			}
   130		}
   131	
   132		vfree(buf);
   133	}
   134	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
