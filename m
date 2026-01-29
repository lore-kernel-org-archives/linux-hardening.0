Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496B0344DB7;
	Thu, 29 Jan 2026 16:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769705772; cv=none; b=p1GzCq7sXCFWMauW2kw43HXJg/jZ744VzYb4Rh44otlBSmiUL6RLpWRwAaeLqJxQYf25OtC2mbByf0+EoYK9cVBj++CmCX9+dvXFEWtZBCbKYakZg+rQDtVk2ld8evOkeRhkMTG8dGJkMkgHGxrculltsJWwUs11odqdvsiA/Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769705772; c=relaxed/simple;
	bh=x02qV4au/TuLv4V8MtUCIAIWZZekdKDY3XKo5CuezRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ks3IbRcPamhQ0yvZhj3/YiBdY8YpvysXvhQGwaCwW6xWWlQ5yQMCWZIhyEvUkLE5VKA6PJj+01TjJqaPMNmPyjQgDBFRTt/HRqgAEYdY08JLwgl69+6JeTEe+UYomwfUeWivZvZGVcm6KDuZr1AvDRMLO5za/aGOGEhuuIM2ekk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fcHe0sBL; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fcHe0sBL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769705771; x=1801241771;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x02qV4au/TuLv4V8MtUCIAIWZZekdKDY3XKo5CuezRQ=;
  b=fcHe0sBLbfi7TnXJfCkic3Pcic5da/6O7aLp3mZSVzF20pdoNEKY/2Wv
   +m4UOpn97P6m1J9akKRyopEPIKEket2lnXZazP0G0jpKdEaLDRlyf9cGU
   Q1XEtg4SWaBhSGR8j/eDgPf2/lrITYlqj9St5LXKSlQzSRPGyKASTCiGb
   yAzE27eRHvHA2wj7ZdhSzBCX3im5YM9pGIge+W3tnL3Pr3XXD5wdyaTsm
   tCUE+hWnPjKMEfzvKZ6FX4cAjZeuees8XtB2Lyv6IKZ08Z2sl6BI8fFoZ
   XHqfu+CnX8/zJcfmVKm74LbvKiTe/BJ3CPihmFoblPi0AvUUKAzOQQ6ic
   A==;
X-CSE-ConnectionGUID: 5tkPBM9ySmqUo905+NkRgg==
X-CSE-MsgGUID: YqwAJLL2QDKMIPhKkgwBiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="70855693"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="70855693"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 08:56:10 -0800
X-CSE-ConnectionGUID: 6Aeu5JrkQ7OMG3d+GVA+MA==
X-CSE-MsgGUID: dlHZOkGMTBa/hLVs/WNp3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="208232554"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 29 Jan 2026 08:56:05 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vlVJL-00000000bhc-07O9;
	Thu, 29 Jan 2026 16:56:03 +0000
Date: Fri, 30 Jan 2026 00:55:27 +0800
From: kernel test robot <lkp@intel.com>
To: Feng Jiang <jiangfeng@kylinos.cn>, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, akpm@linux-foundation.org,
	kees@kernel.org, andy@kernel.org, ebiggers@kernel.org,
	martin.petersen@oracle.com, herbert@gondor.apana.org.au,
	samuel.holland@sifive.com, ajones@ventanamicro.com,
	charlie@rivosinc.com, conor.dooley@microchip.com,
	linus.walleij@linaro.org, nathan@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v6 1/8] lib/string_kunit: add correctness test for
 strlen()
Message-ID: <202601300014.gbv48Y5D-lkp@intel.com>
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
config: x86_64-randconfig-001-20260129 (https://download.01.org/0day-ci/archive/20260130/202601300014.gbv48Y5D-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260130/202601300014.gbv48Y5D-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601300014.gbv48Y5D-lkp@intel.com/

All errors (new ones prefixed by >>):

>> lib/tests/string_kunit.c:116:13: error: call to undeclared function 'PAGE_ALIGN'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     116 |         buf_size = PAGE_ALIGN(STRING_TEST_MAX_LEN + STRING_TEST_MAX_OFFSET + 1);
         |                    ^
   1 error generated.


vim +/PAGE_ALIGN +116 lib/tests/string_kunit.c

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
