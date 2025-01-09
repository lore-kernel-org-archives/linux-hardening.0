Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C55B218AA0;
	Thu,  9 Jan 2025 14:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736432164; cv=none; b=mLPA1WNQS0RmDVIsv6Fo8WvcYslRt3fit5fFdzUHY2Bo7GZCaPNrVeKHdl13PEQpJ+ii+SHxTmqHvkzRRTQfHDcfkI1GrwNir2v18oqLCkN0N/N08C+uJq02KyEr5lKUjKe/MXp0+6MCUmewSfLWlH8LrCy7/JcM0tgmTiv1K8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736432164; c=relaxed/simple;
	bh=sdeQGCyr/6RBTBZSYkpvRmADjOTqsbaOlHnGzWZq1Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1tFfvIIspd6iwUhd8hyMH5Cu3/Z+8lYiqrtSkcSqQMNtMMRefSn3Mv1bcUOCS9jlYSXk4cgTt5aaTHwPwI/jcuZ6FjKWL4OpXuGzQvxQiiB7SXhZ3w6C+6s89hTEGExCCBoeHoxTbkhuVPALc3d9ySdwIQczwkkc4yJeL6LDq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hm4A7MNb; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hm4A7MNb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736432163; x=1767968163;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sdeQGCyr/6RBTBZSYkpvRmADjOTqsbaOlHnGzWZq1Kg=;
  b=hm4A7MNbcrV33itTVyWgE/+JyhUPfSS6dT/baRx0Zs49hNw7OAgsrHVl
   q1qzq7IMwvnFcB5Pkvmkpyw67HywnmC8gGqkcQtpCxk7364Q0DJ1kjOdk
   UI7QEKQCwNU5P8nF24FSJTsz4qKGLgd0cx12bouy77VeqYzbrsYyKPql2
   YLYRc634BxKI9z7J94KETAi9zPPLvqKk/+v2E0ULx8WYH9ZLDFKhyH/U5
   Ac/fR9A5chp58p5o3cG8wPWa1EE9ydwW88TloFFJCOWUHRQfhAG/wRbNZ
   8rR6NmZokanMLWCtgUfMQgAEm1rPITzBYNbrsz/lVHJEirnDpb10AMLG4
   Q==;
X-CSE-ConnectionGUID: N7JV8AuNQqe/NCgyrO4a1w==
X-CSE-MsgGUID: eLO5FEFaTcCb4TLnjfS6Hg==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="48056736"
X-IronPort-AV: E=Sophos;i="6.12,301,1728975600"; 
   d="scan'208";a="48056736"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 06:16:02 -0800
X-CSE-ConnectionGUID: L+gnH5aWTuaDbJXjzZ8Dnw==
X-CSE-MsgGUID: yBX6xaFBTq6yqYI26GrCcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104293021"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 09 Jan 2025 06:15:58 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tVtKF-000Hel-1g;
	Thu, 09 Jan 2025 14:15:55 +0000
Date: Thu, 9 Jan 2025 22:14:54 +0800
From: kernel test robot <lkp@intel.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	David Laight <david.laight@aculab.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH] fortify: turn strlen() into an inline function using
 __builtin_constant_p()
Message-ID: <202501092158.Gp5vNOZy-lkp@intel.com>
References: <20250108-strlen_use_builtin_constant_p-v1-1-611b52e80a9f@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108-strlen_use_builtin_constant_p-v1-1-611b52e80a9f@wanadoo.fr>

Hi Vincent,

kernel test robot noticed the following build errors:

[auto build test ERROR on 9d89551994a430b50c4fffcb1e617a057fa76e20]

url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Mailhol/fortify-turn-strlen-into-an-inline-function-using-__builtin_constant_p/20250108-223159
base:   9d89551994a430b50c4fffcb1e617a057fa76e20
patch link:    https://lore.kernel.org/r/20250108-strlen_use_builtin_constant_p-v1-1-611b52e80a9f%40wanadoo.fr
patch subject: [PATCH] fortify: turn strlen() into an inline function using __builtin_constant_p()
config: x86_64-randconfig-001-20250109 (https://download.01.org/0day-ci/archive/20250109/202501092158.Gp5vNOZy-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250109/202501092158.Gp5vNOZy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501092158.Gp5vNOZy-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from scripts/mod/devicetable-offsets.c:3:
   In file included from include/linux/mod_devicetable.h:14:
   In file included from include/linux/uuid.h:11:
   In file included from include/linux/string.h:389:
>> include/linux/fortify-string.h:272:17: error: redeclaration of 'strlen' must not have the 'overloadable' attribute
     272 | __kernel_size_t strlen(const char *p)
         |                 ^
   include/linux/string.h:200:24: note: previous unmarked overload of function is here
     200 | extern __kernel_size_t strlen(const char *);
         |                        ^
   1 error generated.
   make[3]: *** [scripts/Makefile.build:102: scripts/mod/devicetable-offsets.s] Error 1 shuffle=1556232066
   make[3]: Target 'scripts/mod/' not remade because of errors.
   make[2]: *** [Makefile:1262: prepare0] Error 2 shuffle=1556232066
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:251: __sub-make] Error 2 shuffle=1556232066
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:251: __sub-make] Error 2 shuffle=1556232066
   make: Target 'prepare' not remade because of errors.


vim +272 include/linux/fortify-string.h

   257	
   258	/**
   259	 * strlen - Return count of characters in a NUL-terminated string
   260	 *
   261	 * @p: pointer to NUL-terminated string to count.
   262	 *
   263	 * Do not use this function unless the string length is known at
   264	 * compile-time. When @p is unterminated, this function may crash
   265	 * or return unexpected counts that could lead to memory content
   266	 * exposures. Prefer strnlen().
   267	 *
   268	 * Returns number of characters in @p (NOT including the final NUL).
   269	 *
   270	 */
   271	__FORTIFY_INLINE __diagnose_as(__builtin_strlen, 1)
 > 272	__kernel_size_t strlen(const char *p)
   273	{
   274		if (__builtin_constant_p(__builtin_strlen(p)))
   275			return __builtin_strlen(p);
   276		return __fortify_strlen(p);
   277	}
   278	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
