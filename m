Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A3617FAC2;
	Thu,  3 Jul 2025 14:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751553437; cv=none; b=EavLE0y6LBkbC4XRx6+fzEYWM3HHyWxMiOByNGszY6s7rKXFqVircIdmEZ/+dWKp5oTjSmka/0+PVDSCl7XSMLFjuwFYTjogVpgpaDjcT9gHo/DF6Y00eNaz25z0nJamddvKI4mSpVsmFUVzfnRfiGTOs6KQuy1LeS/ja6iua70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751553437; c=relaxed/simple;
	bh=nRuyDSyDX+FSZrEJj9Qa210f98XkC/rbLMyf1jrpcus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6QLG7Pdbbb6sdywNckP0QUbNawWZbNd8ug5U8RhI5EW+kkOzle15Xf9NsWdtCyVGK63AglX3P+a21wDKlsOfzFv+e8QVj2vSaP1T0DJNKIjoP2wmxCMC76o4Jzuzx3KZvIXALrM+UQbYtv3buYdx9hq73uEFxMf1UetXqHUdos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BtSPmFr7; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BtSPmFr7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751553437; x=1783089437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nRuyDSyDX+FSZrEJj9Qa210f98XkC/rbLMyf1jrpcus=;
  b=BtSPmFr7yJb9O/J8V4/e1PYLpMKB5Dnw+UVA1VYLc1mfDgeCT1nIsgZn
   AO9zGHAQpgOTZOkCvIvshrgUQMBgwu/TQD9JFtKI5xUCOVVHb12AJC0LF
   NbsCvRlo2BPlkVvrRjwGoL0ESbuvu6S8CNd20gH8BuaCIGXRQ0AcYWLWZ
   EK3hE9uqgELkctH1s1iLBjyFBSxMwnQ6V66zS97nVEyAafVdkUtVMUhlZ
   hD6SOQF50/8KOULg+ceQvlOvZGoW1RZXNyuzOTNRM4WQt9163q28sKt3D
   ob0/r3ASVbYIIe2w434MJP6pNakUgZyJsKJc9Cfs00tcDyfF/nS3rEFmt
   A==;
X-CSE-ConnectionGUID: ZN6i8hUlQ1mg+ln4diXsMg==
X-CSE-MsgGUID: ig2QLlWcRmC60jY0Kav78w==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53600579"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="53600579"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 07:37:16 -0700
X-CSE-ConnectionGUID: INz2QwAvS/CGnV9kNb1w8A==
X-CSE-MsgGUID: 71iwFgJZShKjYbMxILbquQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="154880140"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 03 Jul 2025 07:37:12 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uXL3m-0001uJ-1M;
	Thu, 03 Jul 2025 14:37:10 +0000
Date: Thu, 3 Jul 2025 22:36:38 +0800
From: kernel test robot <lkp@intel.com>
To: Petr Mladek <pmladek@suse.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Dan Carpenter <error27@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	David Gow <davidgow@google.com>, Arnd Bergmann <arnd@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 2/3] printk: kunit: support offstack cpumask
Message-ID: <202507032226.1sEv2EJM-lkp@intel.com>
References: <20250702095157.110916-3-pmladek@suse.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702095157.110916-3-pmladek@suse.com>

Hi Petr,

kernel test robot noticed the following build errors:

[auto build test ERROR on linux-next/master]
[cannot apply to linus/master v6.16-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Petr-Mladek/printk-ringbuffer-Explain-why-the-KUnit-test-ignores-failed-writes/20250702-175422
base:   linux-next/master
patch link:    https://lore.kernel.org/r/20250702095157.110916-3-pmladek%40suse.com
patch subject: [PATCH 2/3] printk: kunit: support offstack cpumask
config: riscv-randconfig-001-20250703 (https://download.01.org/0day-ci/archive/20250703/202507032226.1sEv2EJM-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250703/202507032226.1sEv2EJM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507032226.1sEv2EJM-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/printk/printk_ringbuffer_kunit_test.c:14:
   kernel/printk/printk_ringbuffer_kunit_test.c: In function 'prbtest_cpumask_cleanup':
>> include/kunit/resource.h:409:32: error: cast specifies array type
     409 |                 arg_type arg = (arg_type)in;                    \
         |                                ^
   kernel/printk/printk_ringbuffer_kunit_test.c:219:1: note: in expansion of macro 'KUNIT_DEFINE_ACTION_WRAPPER'
     219 | KUNIT_DEFINE_ACTION_WRAPPER(prbtest_cpumask_cleanup, free_cpumask_var, cpumask_var_t);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from printk_ringbuffer_kunit_test.c:14:
   printk_ringbuffer_kunit_test.c: In function 'prbtest_cpumask_cleanup':
>> include/kunit/resource.h:409:32: error: cast specifies array type
     409 |                 arg_type arg = (arg_type)in;                    \
         |                                ^
   printk_ringbuffer_kunit_test.c:219:1: note: in expansion of macro 'KUNIT_DEFINE_ACTION_WRAPPER'
     219 | KUNIT_DEFINE_ACTION_WRAPPER(prbtest_cpumask_cleanup, free_cpumask_var, cpumask_var_t);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +409 include/kunit/resource.h

b9dce8a1ed3efe David Gow 2023-05-25  392  
56778b49c9a2cb David Gow 2023-11-28  393  /**
56778b49c9a2cb David Gow 2023-11-28  394   * KUNIT_DEFINE_ACTION_WRAPPER() - Wrap a function for use as a deferred action.
56778b49c9a2cb David Gow 2023-11-28  395   *
56778b49c9a2cb David Gow 2023-11-28  396   * @wrapper: The name of the new wrapper function define.
56778b49c9a2cb David Gow 2023-11-28  397   * @orig: The original function to wrap.
56778b49c9a2cb David Gow 2023-11-28  398   * @arg_type: The type of the argument accepted by @orig.
56778b49c9a2cb David Gow 2023-11-28  399   *
56778b49c9a2cb David Gow 2023-11-28  400   * Defines a wrapper for a function which accepts a single, pointer-sized
56778b49c9a2cb David Gow 2023-11-28  401   * argument. This wrapper can then be passed to kunit_add_action() and
56778b49c9a2cb David Gow 2023-11-28  402   * similar. This should be used in preference to casting a function
56778b49c9a2cb David Gow 2023-11-28  403   * directly to kunit_action_t, as casting function pointers will break
56778b49c9a2cb David Gow 2023-11-28  404   * control flow integrity (CFI), leading to crashes.
56778b49c9a2cb David Gow 2023-11-28  405   */
56778b49c9a2cb David Gow 2023-11-28  406  #define KUNIT_DEFINE_ACTION_WRAPPER(wrapper, orig, arg_type)	\
56778b49c9a2cb David Gow 2023-11-28  407  	static void wrapper(void *in)				\
56778b49c9a2cb David Gow 2023-11-28  408  	{							\
56778b49c9a2cb David Gow 2023-11-28 @409  		arg_type arg = (arg_type)in;			\
56778b49c9a2cb David Gow 2023-11-28  410  		orig(arg);					\
56778b49c9a2cb David Gow 2023-11-28  411  	}
56778b49c9a2cb David Gow 2023-11-28  412  
56778b49c9a2cb David Gow 2023-11-28  413  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
