Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613451FB1;
	Wed,  1 Apr 2026 00:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775002560; cv=none; b=TuLGlwoqjA94rGUa5EgFP1TNlG3gvuL4ewUYL0AXzSWHZQupW/+/nCAO++sDxPysvgFL/mc4r0zm1b3SDkTNcBRQVKzKnDEj3boN7xIRNK+mNKM8P9C3k9hUPs+dzfth3GH3t3CMx4luMTaSPh5b+rqHnDgtXJesKnI6i/dz3Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775002560; c=relaxed/simple;
	bh=p8Z3lolQagYsE0bHiEOMDsAn1qm62Ea/Xke5C/hxLEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgvBfhDwXeMxJnd4iQgbrETyOGOkCrTMJk/Ipz6Xv2YpgPkrld1pCZdzNdRpz1Ps2teCC3zkQzhpBI0BPO3aCor/BxRw77ytzszQIDLgUG+urMIrDMCtWACuTL2uoI4OgNpfkmGMNxsrbwwjgpFPQURUDYY/yIbAJmplD1nnyOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VbrRjoH2; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VbrRjoH2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775002560; x=1806538560;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p8Z3lolQagYsE0bHiEOMDsAn1qm62Ea/Xke5C/hxLEc=;
  b=VbrRjoH2XEaU9v40+VHTnmOfvjeFuudtWKaqFNrnV5cuEmj31J8Wdqk1
   MjwxUbmB4s0r9jHlnbr+a2URciLQFDEu7uQ5ABNKhBYMMinKq2kK0+eEc
   Fn25JLjnEccSo2qZFa7/2O1lOP1Mko1qb/Ev9N8nLTOMbiWsiGe7+BNfn
   +OBaZBPtHUWKt7M2NilzeK/3v6x1/Nz2DWbW5x4l+xeskeESY33h2cvun
   DxwBVzVbG7fo6atbk4CvsKaaBRXuPhp5vP5U8mOiHEgyv1jw8+1UE+1Xj
   rOyMba/SoCcfy9G1wQr7cf2ZmmWIyh6MPue10BPYHWsvgwP4XGbxpvh3D
   w==;
X-CSE-ConnectionGUID: K5vNEi7xQImW2zPjKzFt8w==
X-CSE-MsgGUID: lcEitSgOTlmxXMSO3mFKGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75069428"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="75069428"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 17:15:59 -0700
X-CSE-ConnectionGUID: 1A2psLgWTLyT/b+bsyLG1w==
X-CSE-MsgGUID: vUdoNcJwSeKHnAQ92R5I9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="226388635"
Received: from lkp-server01.sh.intel.com (HELO 283bf2e1b94a) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 31 Mar 2026 17:15:56 -0700
Received: from kbuild by 283bf2e1b94a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w7jFQ-000000004Sj-1XBm;
	Wed, 01 Apr 2026 00:15:52 +0000
Date: Wed, 1 Apr 2026 08:15:22 +0800
From: kernel test robot <lkp@intel.com>
To: david.laight.linux@gmail.com, Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH next 2/3] fortify: Optimise strnlen()
Message-ID: <202604010835.IWCsUV7z-lkp@intel.com>
References: <20260330132003.3379-3-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330132003.3379-3-david.laight.linux@gmail.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20260327]

url:    https://github.com/intel-lab-lkp/linux/commits/david-laight-linux-gmail-com/fortify-replace-__compiletime_lessthan-with-statically_true/20260331-041123
base:   next-20260327
patch link:    https://lore.kernel.org/r/20260330132003.3379-3-david.laight.linux%40gmail.com
patch subject: [PATCH next 2/3] fortify: Optimise strnlen()
config: x86_64-buildonly-randconfig-001-20260331 (https://download.01.org/0day-ci/archive/20260401/202604010835.IWCsUV7z-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260401/202604010835.IWCsUV7z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604010835.IWCsUV7z-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __fortify_undefined
   >>> referenced by fortify-string.h:290 (include/linux/fortify-string.h:290)
   >>>               vmlinux.o:(parse_early_param)
   >>> referenced by fortify-string.h:218 (include/linux/fortify-string.h:218)
   >>>               vmlinux.o:(parse_early_param)
   >>> referenced by fortify-string.h:290 (include/linux/fortify-string.h:290)
   >>>               vmlinux.o:(setup_boot_config)
   >>> referenced 2103 more times

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
