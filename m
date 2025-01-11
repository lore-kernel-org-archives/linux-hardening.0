Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F75817C68;
	Sat, 11 Jan 2025 02:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736561619; cv=none; b=Ns2geh29ucT+jyJKPwADpXzZuioCCPOkO80EYvxgh9pEM1EPe0b919O/hULEW2IwUgm10YZqiexiNKt9p5Ltp452j24QxcJhXqkMP1P7R6+C1dLGuHGZPpeyZGnf/Fg8QWr0/0WVPjC0Dt84ELaiklw9hmLhZFOLJeO3r/WWn+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736561619; c=relaxed/simple;
	bh=DftX6aQhvgmb9ePJ1K/sp914/tMimWDvyvye8J0QWe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhRoXsjZWX/GY4Oqk2hQl8EKQrF69i0yP3X/1iP+e6isvkzsGy+SE/P6GGokQ3Cxhw8CoP92qqcKnhAK9dhi7oS6OgQwS9CNkEJPpF//7HOIie1eytLiJLvFOYdAhkHuPltoZJWuDucacMfjH2UZOGTq1cQ5F7DTH2fK/GeXRpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fc71G1GC; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fc71G1GC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736561617; x=1768097617;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DftX6aQhvgmb9ePJ1K/sp914/tMimWDvyvye8J0QWe8=;
  b=Fc71G1GC/Ixh6w9mj3GmzjyYeVEEBgszQilcowZnPDpLCnvPA8jKTUzB
   HOjEbPc/gPGY/uX23tbSpHnykLJYjZBlqgYwpN7WjImIiXWBEIIOLfx2F
   z+vKdzpngbsqPSPWedxdiFXsM41vz+Z9FdH/r9FB8S67BJUJMjwO5MwKY
   JXj0CckXaFoQ71JykqJATwoKiIqCV4dFxxVMnJRdHFrSKNXFkgBidgSCN
   m/vkAwhfcsy0L8n5+JOJF2uPqQbocADqRfZUv2j9f1OuP4rW1aV9JNJhN
   erg1Dcbc0UwXgQmfF3/j0R93WnVz9bo6VoNN8fPnYPBfU3XKUum15ccft
   Q==;
X-CSE-ConnectionGUID: ql67X/grSj2KJLit5TQSWQ==
X-CSE-MsgGUID: aN3AQpAvSCS8Ypk77gGvNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="37097265"
X-IronPort-AV: E=Sophos;i="6.12,305,1728975600"; 
   d="scan'208";a="37097265"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 18:13:36 -0800
X-CSE-ConnectionGUID: F16tXYebQfiTLSF1ilTRTQ==
X-CSE-MsgGUID: mzW84XBpQe+okEkwyvDy4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,305,1728975600"; 
   d="scan'208";a="108900360"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 10 Jan 2025 18:13:33 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tWR0E-000K2F-1F;
	Sat, 11 Jan 2025 02:13:30 +0000
Date: Sat, 11 Jan 2025 10:13:05 +0800
From: kernel test robot <lkp@intel.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: oe-kbuild-all@lists.linux.dev, David Laight <david.laight@aculab.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH] fortify: turn strlen() into an inline function using
 __builtin_constant_p()
Message-ID: <202501110943.PA4ylzB9-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on 9d89551994a430b50c4fffcb1e617a057fa76e20]

url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Mailhol/fortify-turn-strlen-into-an-inline-function-using-__builtin_constant_p/20250108-223159
base:   9d89551994a430b50c4fffcb1e617a057fa76e20
patch link:    https://lore.kernel.org/r/20250108-strlen_use_builtin_constant_p-v1-1-611b52e80a9f%40wanadoo.fr
patch subject: [PATCH] fortify: turn strlen() into an inline function using __builtin_constant_p()
config: s390-randconfig-r064-20250111 (https://download.01.org/0day-ci/archive/20250111/202501110943.PA4ylzB9-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project f5cd181ffbb7cb61d582fe130d46580d5969d47a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250111/202501110943.PA4ylzB9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501110943.PA4ylzB9-lkp@intel.com/

All warnings (new ones prefixed by >>):

         |                 ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/most/most_cdev.c:8:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:168:
   include/linux/compat.h:454:22: warning: array index 3 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     454 |         case 4: v.sig[7] = (set->sig[3] >> 32); v.sig[6] = set->sig[3];
         |                             ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/most/most_cdev.c:8:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:168:
   include/linux/compat.h:454:10: warning: array index 7 is past the end of the array (that has type 'compat_sigset_word[2]' (aka 'unsigned int[2]')) [-Warray-bounds]
     454 |         case 4: v.sig[7] = (set->sig[3] >> 32); v.sig[6] = set->sig[3];
         |                 ^     ~
   include/linux/compat.h:130:2: note: array 'sig' declared here
     130 |         compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
         |         ^
   include/linux/compat.h:454:42: warning: array index 6 is past the end of the array (that has type 'compat_sigset_word[2]' (aka 'unsigned int[2]')) [-Warray-bounds]
     454 |         case 4: v.sig[7] = (set->sig[3] >> 32); v.sig[6] = set->sig[3];
         |                                                 ^     ~
   include/linux/compat.h:130:2: note: array 'sig' declared here
     130 |         compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
         |         ^
   include/linux/compat.h:454:53: warning: array index 3 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     454 |         case 4: v.sig[7] = (set->sig[3] >> 32); v.sig[6] = set->sig[3];
         |                                                            ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/most/most_cdev.c:8:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:168:
   include/linux/compat.h:456:22: warning: array index 2 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     456 |         case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
         |                             ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/most/most_cdev.c:8:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:168:
   include/linux/compat.h:456:10: warning: array index 5 is past the end of the array (that has type 'compat_sigset_word[2]' (aka 'unsigned int[2]')) [-Warray-bounds]
     456 |         case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
         |                 ^     ~
   include/linux/compat.h:130:2: note: array 'sig' declared here
     130 |         compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
         |         ^
   include/linux/compat.h:456:42: warning: array index 4 is past the end of the array (that has type 'compat_sigset_word[2]' (aka 'unsigned int[2]')) [-Warray-bounds]
     456 |         case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
         |                                                 ^     ~
   include/linux/compat.h:130:2: note: array 'sig' declared here
     130 |         compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
         |         ^
   include/linux/compat.h:456:53: warning: array index 2 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     456 |         case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
         |                                                            ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/most/most_cdev.c:8:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:168:
   include/linux/compat.h:458:22: warning: array index 1 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     458 |         case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
         |                             ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/most/most_cdev.c:8:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:168:
   include/linux/compat.h:458:10: warning: array index 3 is past the end of the array (that has type 'compat_sigset_word[2]' (aka 'unsigned int[2]')) [-Warray-bounds]
     458 |         case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
         |                 ^     ~
   include/linux/compat.h:130:2: note: array 'sig' declared here
     130 |         compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
         |         ^
   include/linux/compat.h:458:42: warning: array index 2 is past the end of the array (that has type 'compat_sigset_word[2]' (aka 'unsigned int[2]')) [-Warray-bounds]
     458 |         case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
         |                                                 ^     ~
   include/linux/compat.h:130:2: note: array 'sig' declared here
     130 |         compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
         |         ^
   include/linux/compat.h:458:53: warning: array index 1 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     458 |         case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
         |                                                            ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
>> drivers/most/most_cdev.c:449:2: warning: implicit conversion from 'unsigned long' to 'unsigned int' changes value from 18446744073709551615 to 4294967295 [-Wconstant-conversion]
     449 |         INIT_KFIFO(c->fifo);
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:135:69: note: expanded from macro 'INIT_KFIFO'
     135 |         __kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : ARRAY_SIZE(__tmp->buf) - 1;\
         |                       ~                             ~~~~~~~~~~~~~~~~~~~~~~~^~~
   62 warnings and 1 error generated.
--
         |                 ^     ~
   include/linux/compat.h:130:2: note: array 'sig' declared here
     130 |         compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
         |         ^
   include/linux/compat.h:454:42: warning: array index 6 is past the end of the array (that has type 'compat_sigset_word[2]' (aka 'unsigned int[2]')) [-Warray-bounds]
     454 |         case 4: v.sig[7] = (set->sig[3] >> 32); v.sig[6] = set->sig[3];
         |                                                 ^     ~
   include/linux/compat.h:130:2: note: array 'sig' declared here
     130 |         compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
         |         ^
   include/linux/compat.h:454:53: warning: array index 3 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     454 |         case 4: v.sig[7] = (set->sig[3] >> 32); v.sig[6] = set->sig[3];
         |                                                            ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/tty/tty_port.c:8:
   In file included from include/linux/tty.h:9:
   In file included from include/linux/tty_driver.h:9:
   In file included from include/linux/cdev.h:8:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:168:
   include/linux/compat.h:456:22: warning: array index 2 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     456 |         case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
         |                             ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/tty/tty_port.c:8:
   In file included from include/linux/tty.h:9:
   In file included from include/linux/tty_driver.h:9:
   In file included from include/linux/cdev.h:8:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:168:
   include/linux/compat.h:456:10: warning: array index 5 is past the end of the array (that has type 'compat_sigset_word[2]' (aka 'unsigned int[2]')) [-Warray-bounds]
     456 |         case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
         |                 ^     ~
   include/linux/compat.h:130:2: note: array 'sig' declared here
     130 |         compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
         |         ^
   include/linux/compat.h:456:42: warning: array index 4 is past the end of the array (that has type 'compat_sigset_word[2]' (aka 'unsigned int[2]')) [-Warray-bounds]
     456 |         case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
         |                                                 ^     ~
   include/linux/compat.h:130:2: note: array 'sig' declared here
     130 |         compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
         |         ^
   include/linux/compat.h:456:53: warning: array index 2 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     456 |         case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
         |                                                            ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/tty/tty_port.c:8:
   In file included from include/linux/tty.h:9:
   In file included from include/linux/tty_driver.h:9:
   In file included from include/linux/cdev.h:8:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:168:
   include/linux/compat.h:458:22: warning: array index 1 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     458 |         case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
         |                             ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/tty/tty_port.c:8:
   In file included from include/linux/tty.h:9:
   In file included from include/linux/tty_driver.h:9:
   In file included from include/linux/cdev.h:8:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:168:
   include/linux/compat.h:458:10: warning: array index 3 is past the end of the array (that has type 'compat_sigset_word[2]' (aka 'unsigned int[2]')) [-Warray-bounds]
     458 |         case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
         |                 ^     ~
   include/linux/compat.h:130:2: note: array 'sig' declared here
     130 |         compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
         |         ^
   include/linux/compat.h:458:42: warning: array index 2 is past the end of the array (that has type 'compat_sigset_word[2]' (aka 'unsigned int[2]')) [-Warray-bounds]
     458 |         case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
         |                                                 ^     ~
   include/linux/compat.h:130:2: note: array 'sig' declared here
     130 |         compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
         |         ^
   include/linux/compat.h:458:53: warning: array index 1 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     458 |         case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
         |                                                            ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
>> drivers/tty/tty_port.c:266:2: warning: implicit conversion from 'unsigned long' to 'unsigned int' changes value from 18446744073709551615 to 4294967295 [-Wconstant-conversion]
     266 |         INIT_KFIFO(port->xmit_fifo);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:135:69: note: expanded from macro 'INIT_KFIFO'
     135 |         __kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : ARRAY_SIZE(__tmp->buf) - 1;\
         |                       ~                             ~~~~~~~~~~~~~~~~~~~~~~~^~~
   62 warnings and 1 error generated.


vim +449 drivers/most/most_cdev.c

9bc79bbcd0c526 drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-07-24  400  
9bc79bbcd0c526 drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-07-24  401  /**
1fd923f38610a8 drivers/staging/most/cdev/cdev.c     Christian Gromm    2017-11-21  402   * comp_probe - probe function of the driver module
9bc79bbcd0c526 drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-07-24  403   * @iface: pointer to interface instance
9bc79bbcd0c526 drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-07-24  404   * @channel_id: channel index/ID
9bc79bbcd0c526 drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-07-24  405   * @cfg: pointer to actual channel configuration
9bc79bbcd0c526 drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-07-24  406   * @name: name of the device to be created
fba3993e86cc44 drivers/most/most_cdev.c             Randy Dunlap       2023-01-12  407   * @args: pointer to array of component parameters (from configfs)
9bc79bbcd0c526 drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-07-24  408   *
9bc79bbcd0c526 drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-07-24  409   * This allocates a channel object and creates the device node in /dev
9bc79bbcd0c526 drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-07-24  410   *
9bc79bbcd0c526 drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-07-24  411   * Returns 0 on success or error code otherwise.
9bc79bbcd0c526 drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-07-24  412   */
1fd923f38610a8 drivers/staging/most/cdev/cdev.c     Christian Gromm    2017-11-21  413  static int comp_probe(struct most_interface *iface, int channel_id,
dfee92dd50464c drivers/staging/most/cdev/cdev.c     Christian Gromm    2019-04-03  414  		      struct most_channel_config *cfg, char *name, char *args)
9bc79bbcd0c526 drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-07-24  415  {
ef0fbbbb9a6004 drivers/staging/most/cdev/cdev.c     Christian Gromm    2017-11-21  416  	struct comp_channel *c;
9bc79bbcd0c526 drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-07-24  417  	unsigned long cl_flags;
9bc79bbcd0c526 drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-07-24  418  	int retval;
9bc79bbcd0c526 drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-07-24  419  	int current_minor;
9bc79bbcd0c526 drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-07-24  420  
e8e0f7fd7715de drivers/staging/most/cdev/cdev.c     Christian Gromm    2020-06-22  421  	if (!cfg || !name)
9bc79bbcd0c526 drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-07-24  422  		return -EINVAL;
61fd971eddecdc drivers/staging/most/cdev/cdev.c     Christian Gromm    2020-06-22  423  
d8b082e6c625cb drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-12-22  424  	c = get_channel(iface, channel_id);
d8b082e6c625cb drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-12-22  425  	if (c)
9bc79bbcd0c526 drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-07-24  426  		return -EEXIST;
9bc79bbcd0c526 drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-07-24  427  
b737a221702c7b drivers/most/most_cdev.c             Christophe JAILLET 2024-06-08  428  	current_minor = ida_alloc(&comp.minor_id, GFP_KERNEL);
9bc79bbcd0c526 drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-07-24  429  	if (current_minor < 0)
9bc79bbcd0c526 drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-07-24  430  		return current_minor;
9bc79bbcd0c526 drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-07-24  431  
d8b082e6c625cb drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-12-22  432  	c = kzalloc(sizeof(*c), GFP_KERNEL);
d8b082e6c625cb drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-12-22  433  	if (!c) {
9bc79bbcd0c526 drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-07-24  434  		retval = -ENOMEM;
bddd3c2546e9c4 drivers/staging/most/cdev/cdev.c     Christian Gromm    2018-09-21  435  		goto err_remove_ida;
9bc79bbcd0c526 drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-07-24  436  	}
9bc79bbcd0c526 drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-07-24  437  
c73d915dd293a4 drivers/staging/most/cdev/cdev.c     Christian Gromm    2017-11-21  438  	c->devno = MKDEV(comp.major, current_minor);
d8b082e6c625cb drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-12-22  439  	cdev_init(&c->cdev, &channel_fops);
d8b082e6c625cb drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-12-22  440  	c->cdev.owner = THIS_MODULE;
5ae890780e1b4d drivers/staging/most/cdev/cdev.c     Colin Ian King     2019-02-02  441  	retval = cdev_add(&c->cdev, c->devno, 1);
5ae890780e1b4d drivers/staging/most/cdev/cdev.c     Colin Ian King     2019-02-02  442  	if (retval < 0)
5ae890780e1b4d drivers/staging/most/cdev/cdev.c     Colin Ian King     2019-02-02  443  		goto err_free_c;
d8b082e6c625cb drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-12-22  444  	c->iface = iface;
d8b082e6c625cb drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-12-22  445  	c->cfg = cfg;
d8b082e6c625cb drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-12-22  446  	c->channel_id = channel_id;
b3c9f3c56c41cb drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-12-22  447  	c->access_ref = 0;
fa96b8ed9cc562 drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-12-22  448  	spin_lock_init(&c->unlink);
d8b082e6c625cb drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-12-22 @449  	INIT_KFIFO(c->fifo);
d8b082e6c625cb drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-12-22  450  	retval = kfifo_alloc(&c->fifo, cfg->num_buffers, GFP_KERNEL);
ebf256e36754fc drivers/staging/most/cdev/cdev.c     Keyur Patel        2019-07-14  451  	if (retval)
bddd3c2546e9c4 drivers/staging/most/cdev/cdev.c     Christian Gromm    2018-09-21  452  		goto err_del_cdev_and_free_channel;
d8b082e6c625cb drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-12-22  453  	init_waitqueue_head(&c->wq);
d8b082e6c625cb drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-12-22  454  	mutex_init(&c->io_mutex);
9bc79bbcd0c526 drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-07-24  455  	spin_lock_irqsave(&ch_list_lock, cl_flags);
d8b082e6c625cb drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-12-22  456  	list_add_tail(&c->list, &channel_list);
9bc79bbcd0c526 drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-07-24  457  	spin_unlock_irqrestore(&ch_list_lock, cl_flags);
c73d915dd293a4 drivers/staging/most/cdev/cdev.c     Christian Gromm    2017-11-21  458  	c->dev = device_create(comp.class, NULL, c->devno, NULL, "%s", name);
9bc79bbcd0c526 drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-07-24  459  
ea39854712ba8a drivers/staging/most/aim-cdev/cdev.c Sudip Mukherjee    2016-02-08  460  	if (IS_ERR(c->dev)) {
ea39854712ba8a drivers/staging/most/aim-cdev/cdev.c Sudip Mukherjee    2016-02-08  461  		retval = PTR_ERR(c->dev);
bddd3c2546e9c4 drivers/staging/most/cdev/cdev.c     Christian Gromm    2018-09-21  462  		goto err_free_kfifo_and_del_list;
9bc79bbcd0c526 drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-07-24  463  	}
d8b082e6c625cb drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-12-22  464  	kobject_uevent(&c->dev->kobj, KOBJ_ADD);
9bc79bbcd0c526 drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-07-24  465  	return 0;
9bc79bbcd0c526 drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-07-24  466  
bddd3c2546e9c4 drivers/staging/most/cdev/cdev.c     Christian Gromm    2018-09-21  467  err_free_kfifo_and_del_list:
d8b082e6c625cb drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-12-22  468  	kfifo_free(&c->fifo);
d8b082e6c625cb drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-12-22  469  	list_del(&c->list);
bddd3c2546e9c4 drivers/staging/most/cdev/cdev.c     Christian Gromm    2018-09-21  470  err_del_cdev_and_free_channel:
d8b082e6c625cb drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-12-22  471  	cdev_del(&c->cdev);
5ae890780e1b4d drivers/staging/most/cdev/cdev.c     Colin Ian King     2019-02-02  472  err_free_c:
d8b082e6c625cb drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-12-22  473  	kfree(c);
bddd3c2546e9c4 drivers/staging/most/cdev/cdev.c     Christian Gromm    2018-09-21  474  err_remove_ida:
b737a221702c7b drivers/most/most_cdev.c             Christophe JAILLET 2024-06-08  475  	ida_free(&comp.minor_id, current_minor);
9bc79bbcd0c526 drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-07-24  476  	return retval;
9bc79bbcd0c526 drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-07-24  477  }
9bc79bbcd0c526 drivers/staging/most/aim-cdev/cdev.c Christian Gromm    2015-07-24  478  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
