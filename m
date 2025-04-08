Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBF6288B1;
	Tue,  8 Apr 2025 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744118035; cv=none; b=Uj/CtZMlZaKE3vuKD4OAPkWpVzMFHtfdYHVC3igH141TODvcOMmyasEYPTvUiASNPBJ0PpmdhKAAGDVxv8tkohqWR3wDanPh8KVZunoHvuCQedrt8nDeQjxZOHPJ1jTwKQfxvZ+Kx24QTy9a7gh3J9Q6f10HUoATWPHTijFrHuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744118035; c=relaxed/simple;
	bh=RtWJsLdfsF5FuefGDDBVSYMGNCOsbla7o3mG81ggG3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z02DNBHNjZxdpQbvFIox4jBF80o8TTOQezKkVHLvY7m38UxUZhQPyN+W0cqHMY8QwWiny5iRsIeyvepjoXIEmXdmnymGszCSQUc85/+e/UnZfDV2ZT7q2D3JIF9YPA2CzQyVfmx6tlZpeYleQBoWByS4qwoqExRl5DvcJbxbU3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FZPGEJlH; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FZPGEJlH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744118034; x=1775654034;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RtWJsLdfsF5FuefGDDBVSYMGNCOsbla7o3mG81ggG3Q=;
  b=FZPGEJlH95KWktQWP1tjKcPhe++OKe1w9JcRRtWBEVRNhFTLytN/FOsJ
   rTZaFjcLHzKSjeuvteZI0kAQ7aPGv9j3PoFjhNkgfmXkx65lHKkPzElWq
   2aJSY/CdnsNmtQ6ERvsP7ykgetWqxPihDa3QLDEzLNtNvxamKAi4QZWJR
   nebX8F6v08Vbpkyac9rMyf3Ls4rMCMf0iWjHohb+hSNqrB0VwIuL9tucT
   TpZPPNmvNAnFbsIFoTXlPc0OGZOtq4HdqE/F1AES7g4ERZHd7Vs37UbB/
   mKnLMFfRT6VXBtaGD8nhujl3Ggl9xhIZyzwApjl4o6tkO5QraDDYYur+D
   Q==;
X-CSE-ConnectionGUID: 3t303aABSaCXFbwMg8O+Yg==
X-CSE-MsgGUID: HOzs4p0TTNmdBwTwV+2TsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45435772"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="45435772"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 06:13:53 -0700
X-CSE-ConnectionGUID: /a8O9W8cQo+w1L3WxOLlzw==
X-CSE-MsgGUID: koJ63wdhTdqIZp1M6sJbqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="159263408"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 08 Apr 2025 06:13:51 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u28lw-0007PX-1B;
	Tue, 08 Apr 2025 13:13:48 +0000
Date: Tue, 8 Apr 2025 21:13:00 +0800
From: kernel test robot <lkp@intel.com>
To: Zijun Hu <zijun_hu@icloud.com>, Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Zijun Hu <zijun_hu@icloud.com>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, "Rob Herring (Arm)" <robh@kernel.org>
Subject: Re: [PATCH 1/2] lib/string: Improve strstarts() performance
Message-ID: <202504082037.VtV65Bnb-lkp@intel.com>
References: <20250407-imp_str_perf-v1-1-ed95d52964a4@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407-imp_str_perf-v1-1-ed95d52964a4@quicinc.com>

Hi Zijun,

kernel test robot noticed the following build errors:

[auto build test ERROR on 0af2f6be1b4281385b618cb86ad946eded089ac8]

url:    https://github.com/intel-lab-lkp/linux/commits/Zijun-Hu/lib-string-Improve-strstarts-performance/20250407-212519
base:   0af2f6be1b4281385b618cb86ad946eded089ac8
patch link:    https://lore.kernel.org/r/20250407-imp_str_perf-v1-1-ed95d52964a4%40quicinc.com
patch subject: [PATCH 1/2] lib/string: Improve strstarts() performance
config: riscv-randconfig-002-20250408 (https://download.01.org/0day-ci/archive/20250408/202504082037.VtV65Bnb-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 92c93f5286b9ff33f27ff694d2dc33da1c07afdd)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250408/202504082037.VtV65Bnb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504082037.VtV65Bnb-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined hidden symbol: __efistub_strstarts
   >>> referenced by gop.c:119 (drivers/firmware/efi/libstub/gop.c:119)
   >>>               gop.stub.o:(__efistub_efi_parse_option_graphics) in archive ./drivers/firmware/efi/libstub/lib.a
   >>> referenced by gop.c:42 (drivers/firmware/efi/libstub/gop.c:42)
   >>>               gop.stub.o:(__efistub_efi_parse_option_graphics) in archive ./drivers/firmware/efi/libstub/lib.a
   >>> referenced by gop.c:42 (drivers/firmware/efi/libstub/gop.c:42)
   >>>               gop.stub.o:(__efistub_efi_parse_option_graphics) in archive ./drivers/firmware/efi/libstub/lib.a
   >>> referenced 3 more times

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
