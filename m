Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1750944F;
	Fri, 27 Jun 2025 00:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750983318; cv=none; b=AX5zCk5QBWEZgqsY/jdx+BFLcE0R9i1XzljbyTLSDvLR3uaX7WDH1b/19rrRLRPXOBPowvP2d5SDFcZRj1WDzz/wtqL982wAuMCjR1JCX673fsaF+XInguMuYJ25f45ir5aefrIWWA/3B10gX65lyYf0d9uxEBSdmFBMV43JRLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750983318; c=relaxed/simple;
	bh=kWgIppeliAYep/KV4T4ViN4nKmeetRXoP2486C4Nt0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bz7Qlzg2z7gcMX4ZV0EpaJrS2Zu6XAbw2oJnGWA3QP1dEgoi1o97lyFfP1UrXHDHjaN4wSwOy4/2IO+snspiePlF09kbxXK3KMxVNT1/61VH/UpzU6L555XNu3qVy6UydYkw3FmJ0Q1qXSwbLoaHWOry/c0GwRzZMCvuzT/h8dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zs/5hTmr; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zs/5hTmr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750983316; x=1782519316;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kWgIppeliAYep/KV4T4ViN4nKmeetRXoP2486C4Nt0Y=;
  b=Zs/5hTmrig2i3FuqboMAybN3/lzNJujZOgkviTXqbVb65r34p/CefyrE
   nSOAAftjZAbZeAaDMsHMq3BHK4MMOBNyF6vItOmCgUC/l5+4hdJuH5Jip
   0kpxhwI1uREyV98+7o5N+cbG8znoTeLZXwdD9yDuksfDLL840u7uWsPkh
   Lm9Z5dskV0GtKs+DmFQKt/DYixqDi3uHN97CGCHJSMSDRCyiTj7LKqlwh
   CDxoCHeEWrhK619XHJySq6bOwSTiaxwl1Mo5XYfv7Loa+zQdFvUW/ENn1
   gcvgCRJPqeFoDTOJbZeZBhqYmiJGZiJoBpjffiTqyJFd05rwxVa352zpO
   A==;
X-CSE-ConnectionGUID: HwCf8xt+SaSCFrLnBY9lpg==
X-CSE-MsgGUID: CJI7i40rS9yNNMk50eaq0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="52416192"
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="52416192"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 17:15:15 -0700
X-CSE-ConnectionGUID: /qZVWOtCSxO7HLnc5LgpIA==
X-CSE-MsgGUID: cOYYjkm7TPeI8GMgIHxQdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="158143053"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 26 Jun 2025 17:15:13 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uUwkJ-000Vek-0F;
	Fri, 27 Jun 2025 00:15:11 +0000
Date: Fri, 27 Jun 2025 08:14:15 +0800
From: kernel test robot <lkp@intel.com>
To: Colin Ian King <colin.i.king@gmail.com>, Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] fortify: add branch hints on unlikely
 fortify_panic paths
Message-ID: <202506270832.QJ2ekScw-lkp@intel.com>
References: <20250625161221.295575-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625161221.295575-1-colin.i.king@gmail.com>

Hi Colin,

kernel test robot noticed the following build errors:

[auto build test ERROR on kees/for-next/hardening]
[also build test ERROR on kees/for-next/pstore kees/for-next/kspp linus/master v6.16-rc3 next-20250626]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Colin-Ian-King/fortify-add-branch-hints-on-unlikely-fortify_panic-paths/20250626-001527
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
patch link:    https://lore.kernel.org/r/20250625161221.295575-1-colin.i.king%40gmail.com
patch subject: [PATCH][next] fortify: add branch hints on unlikely fortify_panic paths
config: x86_64-buildonly-randconfig-001-20250627 (https://download.01.org/0day-ci/archive/20250627/202506270832.QJ2ekScw-lkp@intel.com/config)
compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250627/202506270832.QJ2ekScw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506270832.QJ2ekScw-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from scripts/mod/devicetable-offsets.c:3:
   In file included from include/linux/mod_devicetable.h:14:
   In file included from include/linux/uuid.h:11:
   In file included from include/linux/string.h:392:
>> include/linux/fortify-string.h:596:6: warning: non-constant static local variable in inline function may be different in different files [-Wstatic-local-in-inline]
     596 |         if (unlikely(p_size != SIZE_MAX && p_size < size))
         |             ^
   include/linux/compiler.h:47:24: note: expanded from macro 'unlikely'
      47 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^
   include/linux/compiler.h:24:4: note: expanded from macro '__branch_check__'
      24 |                         static struct ftrace_likely_data                \
         |                         ^
   In file included from scripts/mod/devicetable-offsets.c:3:
   In file included from include/linux/mod_devicetable.h:14:
   In file included from include/linux/uuid.h:11:
   In file included from include/linux/string.h:392:
   include/linux/fortify-string.h:598:11: warning: non-constant static local variable in inline function may be different in different files [-Wstatic-local-in-inline]
     598 |         else if (unlikely(q_size != SIZE_MAX && q_size < size))
         |                  ^
   include/linux/compiler.h:47:24: note: expanded from macro 'unlikely'
      47 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^
   include/linux/compiler.h:24:4: note: expanded from macro '__branch_check__'
      24 |                         static struct ftrace_likely_data                \
         |                         ^
   2 warnings generated.
--
   In file included from lib/locking-selftest.c:14:
   In file included from include/linux/rwsem.h:15:
   In file included from include/linux/spinlock.h:59:
   In file included from include/linux/irqflags.h:18:
   In file included from arch/x86/include/asm/irqflags.h:102:
   In file included from arch/x86/include/asm/paravirt.h:21:
   In file included from include/linux/cpumask.h:12:
   In file included from include/linux/bitmap.h:13:
   In file included from include/linux/string.h:392:
>> include/linux/fortify-string.h:596:6: warning: non-constant static local variable in inline function may be different in different files [-Wstatic-local-in-inline]
     596 |         if (unlikely(p_size != SIZE_MAX && p_size < size))
         |             ^
   include/linux/compiler.h:47:24: note: expanded from macro 'unlikely'
      47 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^
   include/linux/compiler.h:24:4: note: expanded from macro '__branch_check__'
      24 |                         static struct ftrace_likely_data                \
         |                         ^
   In file included from lib/locking-selftest.c:14:
   In file included from include/linux/rwsem.h:15:
   In file included from include/linux/spinlock.h:59:
   In file included from include/linux/irqflags.h:18:
   In file included from arch/x86/include/asm/irqflags.h:102:
   In file included from arch/x86/include/asm/paravirt.h:21:
   In file included from include/linux/cpumask.h:12:
   In file included from include/linux/bitmap.h:13:
   In file included from include/linux/string.h:392:
   include/linux/fortify-string.h:598:11: warning: non-constant static local variable in inline function may be different in different files [-Wstatic-local-in-inline]
     598 |         else if (unlikely(q_size != SIZE_MAX && q_size < size))
         |                  ^
   include/linux/compiler.h:47:24: note: expanded from macro 'unlikely'
      47 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^
   include/linux/compiler.h:24:4: note: expanded from macro '__branch_check__'
      24 |                         static struct ftrace_likely_data                \
         |                         ^
   lib/locking-selftest.c:2510:1: warning: unused function 'class_HARDIRQ_lock_ptr' [-Wunused-function]
    2510 | DEFINE_LOCK_GUARD_0(HARDIRQ, HARDIRQ_ENTER(), HARDIRQ_EXIT())
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:432:49: note: expanded from macro 'DEFINE_LOCK_GUARD_0'
     432 | __DEFINE_CLASS_IS_CONDITIONAL(_name, false);                            \
         |                                                                         ^
     433 | __DEFINE_UNLOCK_GUARD(_name, void, _unlock, __VA_ARGS__)                \
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:406:10: note: expanded from macro '\
   __DEFINE_UNLOCK_GUARD'
     406 |                                                                         \
         |                                                                         ^
     407 | __DEFINE_GUARD_LOCK_PTR(_name, &_T->lock)
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:314:23: note: expanded from macro '\
   __DEFINE_GUARD_LOCK_PTR'
     314 |         static inline void * class_##_name##_lock_ptr(class_##_name##_t *_T) \
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~
   <scratch space>:21:1: note: expanded from here
      21 | class_HARDIRQ_lock_ptr
         | ^~~~~~~~~~~~~~~~~~~~~~
   lib/locking-selftest.c:2511:1: warning: unused function 'class_NOTTHREADED_HARDIRQ_lock_ptr' [-Wunused-function]
    2511 | DEFINE_LOCK_GUARD_0(NOTTHREADED_HARDIRQ,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    2512 |         do {
         |         ~~~~
    2513 |                 local_irq_disable();
         |                 ~~~~~~~~~~~~~~~~~~~~
    2514 |                 __irq_enter();
         |                 ~~~~~~~~~~~~~~
    2515 |                 WARN_ON(!in_irq());
         |                 ~~~~~~~~~~~~~~~~~~~
    2516 |         } while(0), HARDIRQ_EXIT())
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:432:49: note: expanded from macro 'DEFINE_LOCK_GUARD_0'
     432 | __DEFINE_CLASS_IS_CONDITIONAL(_name, false);                            \
         |                                                                         ^
     433 | __DEFINE_UNLOCK_GUARD(_name, void, _unlock, __VA_ARGS__)                \
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:406:10: note: expanded from macro '\
   __DEFINE_UNLOCK_GUARD'
     406 |                                                                         \
         |                                                                         ^
     407 | __DEFINE_GUARD_LOCK_PTR(_name, &_T->lock)
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:314:23: note: expanded from macro '\
   __DEFINE_GUARD_LOCK_PTR'
     314 |         static inline void * class_##_name##_lock_ptr(class_##_name##_t *_T) \
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~
   <scratch space>:105:1: note: expanded from here
     105 | class_NOTTHREADED_HARDIRQ_lock_ptr
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/locking-selftest.c:2517:1: warning: unused function 'class_SOFTIRQ_lock_ptr' [-Wunused-function]
    2517 | DEFINE_LOCK_GUARD_0(SOFTIRQ, SOFTIRQ_ENTER(), SOFTIRQ_EXIT())
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:432:49: note: expanded from macro 'DEFINE_LOCK_GUARD_0'
     432 | __DEFINE_CLASS_IS_CONDITIONAL(_name, false);                            \
         |                                                                         ^
     433 | __DEFINE_UNLOCK_GUARD(_name, void, _unlock, __VA_ARGS__)                \
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:406:10: note: expanded from macro '\
   __DEFINE_UNLOCK_GUARD'
     406 |                                                                         \
         |                                                                         ^
     407 | __DEFINE_GUARD_LOCK_PTR(_name, &_T->lock)
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:314:23: note: expanded from macro '\
   __DEFINE_GUARD_LOCK_PTR'
     314 |         static inline void * class_##_name##_lock_ptr(class_##_name##_t *_T) \
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~
   <scratch space>:125:1: note: expanded from here
     125 | class_SOFTIRQ_lock_ptr
         | ^~~~~~~~~~~~~~~~~~~~~~
   lib/locking-selftest.c:2520:1: warning: unused function 'class_RCU_lock_ptr' [-Wunused-function]
--
   In file included from lib/test_bitops.c:10:
   In file included from include/linux/module.h:13:
   In file included from include/linux/stat.h:19:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:67:
   In file included from arch/x86/include/asm/timex.h:5:
   In file included from arch/x86/include/asm/processor.h:19:
   In file included from arch/x86/include/asm/cpuid/api.h:57:
   In file included from arch/x86/include/asm/paravirt.h:21:
   In file included from include/linux/cpumask.h:12:
   In file included from include/linux/bitmap.h:13:
   In file included from include/linux/string.h:392:
>> include/linux/fortify-string.h:596:6: error: non-constant static local variable in inline function may be different in different files [-Werror,-Wstatic-local-in-inline]
     596 |         if (unlikely(p_size != SIZE_MAX && p_size < size))
         |             ^
   include/linux/compiler.h:47:24: note: expanded from macro 'unlikely'
      47 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^
   include/linux/compiler.h:24:4: note: expanded from macro '__branch_check__'
      24 |                         static struct ftrace_likely_data                \
         |                         ^
   In file included from lib/test_bitops.c:10:
   In file included from include/linux/module.h:13:
   In file included from include/linux/stat.h:19:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:67:
   In file included from arch/x86/include/asm/timex.h:5:
   In file included from arch/x86/include/asm/processor.h:19:
   In file included from arch/x86/include/asm/cpuid/api.h:57:
   In file included from arch/x86/include/asm/paravirt.h:21:
   In file included from include/linux/cpumask.h:12:
   In file included from include/linux/bitmap.h:13:
   In file included from include/linux/string.h:392:
   include/linux/fortify-string.h:598:11: error: non-constant static local variable in inline function may be different in different files [-Werror,-Wstatic-local-in-inline]
     598 |         else if (unlikely(q_size != SIZE_MAX && q_size < size))
         |                  ^
   include/linux/compiler.h:47:24: note: expanded from macro 'unlikely'
      47 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^
   include/linux/compiler.h:24:4: note: expanded from macro '__branch_check__'
      24 |                         static struct ftrace_likely_data                \
         |                         ^
   2 errors generated.
--
   In file included from lib/test_maple_tree.c:10:
   In file included from include/linux/maple_tree.h:12:
   In file included from include/linux/rcupdate.h:26:
   In file included from include/linux/irqflags.h:18:
   In file included from arch/x86/include/asm/irqflags.h:102:
   In file included from arch/x86/include/asm/paravirt.h:21:
   In file included from include/linux/cpumask.h:12:
   In file included from include/linux/bitmap.h:13:
   In file included from include/linux/string.h:392:
>> include/linux/fortify-string.h:596:6: warning: non-constant static local variable in inline function may be different in different files [-Wstatic-local-in-inline]
     596 |         if (unlikely(p_size != SIZE_MAX && p_size < size))
         |             ^
   include/linux/compiler.h:47:24: note: expanded from macro 'unlikely'
      47 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^
   include/linux/compiler.h:24:4: note: expanded from macro '__branch_check__'
      24 |                         static struct ftrace_likely_data                \
         |                         ^
   In file included from lib/test_maple_tree.c:10:
   In file included from include/linux/maple_tree.h:12:
   In file included from include/linux/rcupdate.h:26:
   In file included from include/linux/irqflags.h:18:
   In file included from arch/x86/include/asm/irqflags.h:102:
   In file included from arch/x86/include/asm/paravirt.h:21:
   In file included from include/linux/cpumask.h:12:
   In file included from include/linux/bitmap.h:13:
   In file included from include/linux/string.h:392:
   include/linux/fortify-string.h:598:11: warning: non-constant static local variable in inline function may be different in different files [-Wstatic-local-in-inline]
     598 |         else if (unlikely(q_size != SIZE_MAX && q_size < size))
         |                  ^
   include/linux/compiler.h:47:24: note: expanded from macro 'unlikely'
      47 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^
   include/linux/compiler.h:24:4: note: expanded from macro '__branch_check__'
      24 |                         static struct ftrace_likely_data                \
         |                         ^
   lib/test_maple_tree.c:212:26: warning: unused function 'not_empty' [-Wunused-function]
     212 | static inline __init int not_empty(struct maple_node *node)
         |                          ^~~~~~~~~
   3 warnings generated.
--
   In file included from lib/tests/stackinit_kunit.c:14:
   In file included from include/kunit/test.h:22:
   In file included from include/linux/kref.h:16:
   In file included from include/linux/spinlock.h:59:
   In file included from include/linux/irqflags.h:18:
   In file included from arch/x86/include/asm/irqflags.h:102:
   In file included from arch/x86/include/asm/paravirt.h:21:
   In file included from include/linux/cpumask.h:12:
   In file included from include/linux/bitmap.h:13:
   In file included from include/linux/string.h:392:
>> include/linux/fortify-string.h:596:6: warning: non-constant static local variable in inline function may be different in different files [-Wstatic-local-in-inline]
     596 |         if (unlikely(p_size != SIZE_MAX && p_size < size))
         |             ^
   include/linux/compiler.h:47:24: note: expanded from macro 'unlikely'
      47 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^
   include/linux/compiler.h:24:4: note: expanded from macro '__branch_check__'
      24 |                         static struct ftrace_likely_data                \
         |                         ^
   In file included from lib/tests/stackinit_kunit.c:14:
   In file included from include/kunit/test.h:22:
   In file included from include/linux/kref.h:16:
   In file included from include/linux/spinlock.h:59:
   In file included from include/linux/irqflags.h:18:
   In file included from arch/x86/include/asm/irqflags.h:102:
   In file included from arch/x86/include/asm/paravirt.h:21:
   In file included from include/linux/cpumask.h:12:
   In file included from include/linux/bitmap.h:13:
   In file included from include/linux/string.h:392:
   include/linux/fortify-string.h:598:11: warning: non-constant static local variable in inline function may be different in different files [-Wstatic-local-in-inline]
     598 |         else if (unlikely(q_size != SIZE_MAX && q_size < size))
         |                  ^
   include/linux/compiler.h:47:24: note: expanded from macro 'unlikely'
      47 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^
   include/linux/compiler.h:24:4: note: expanded from macro '__branch_check__'
      24 |                         static struct ftrace_likely_data                \
         |                         ^
   lib/tests/stackinit_kunit.c:441:1: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     441 | DEFINE_UNION_INITIALIZER_TESTS(static, STRONG_PASS);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/tests/stackinit_kunit.c:421:3: note: expanded from macro 'DEFINE_UNION_INITIALIZER_TESTS'
     421 |                 DEFINE_UNION_TESTS(base ## _ ## all, xfail)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/tests/stackinit_kunit.c:424:3: note: expanded from macro 'DEFINE_UNION_TESTS'
     424 |                 DEFINE_UNION_TEST(same_sizes, init, xfail);     \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/tests/stackinit_kunit.c:403:3: note: expanded from macro 'DEFINE_UNION_TEST'
     403 |                 DEFINE_TEST(name ## _ ## init,                  \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     404 |                             union test_ ## name, STRUCT, init,  \
         |                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     405 |                             xfail)
         |                             ~~~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   <scratch space>:20:1: note: expanded from here
      20 | INIT_STRUCT_static_all
         | ^
   lib/tests/stackinit_kunit.c:137:8: note: expanded from macro 'INIT_STRUCT_static_all'
     137 |                                         = __static_all
         |                                           ^~~~~~~~~~~~
   lib/tests/stackinit_kunit.c:118:8: note: expanded from macro '__static_all'
     118 |                                           .two = 0,                     \
         |                                           ^~~~~~~~
   lib/tests/stackinit_kunit.c:441:1: note: previous initialization is here
     441 | DEFINE_UNION_INITIALIZER_TESTS(static, STRONG_PASS);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/tests/stackinit_kunit.c:421:3: note: expanded from macro 'DEFINE_UNION_INITIALIZER_TESTS'
     421 |                 DEFINE_UNION_TESTS(base ## _ ## all, xfail)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/tests/stackinit_kunit.c:424:3: note: expanded from macro 'DEFINE_UNION_TESTS'
     424 |                 DEFINE_UNION_TEST(same_sizes, init, xfail);     \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/tests/stackinit_kunit.c:403:3: note: expanded from macro 'DEFINE_UNION_TEST'
     403 |                 DEFINE_TEST(name ## _ ## init,                  \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     404 |                             union test_ ## name, STRUCT, init,  \
         |                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     405 |                             xfail)
         |                             ~~~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   <scratch space>:20:1: note: expanded from here
      20 | INIT_STRUCT_static_all
         | ^
   lib/tests/stackinit_kunit.c:137:8: note: expanded from macro 'INIT_STRUCT_static_all'
     137 |                                         = __static_all
         |                                           ^~~~~~~~~~~~
   lib/tests/stackinit_kunit.c:117:33: note: expanded from macro '__static_all'
     117 | #define __static_all                    { .one = 0,                     \
         |                                                  ^
   lib/tests/stackinit_kunit.c:441:1: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     441 | DEFINE_UNION_INITIALIZER_TESTS(static, STRONG_PASS);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/tests/stackinit_kunit.c:421:3: note: expanded from macro 'DEFINE_UNION_INITIALIZER_TESTS'
     421 |                 DEFINE_UNION_TESTS(base ## _ ## all, xfail)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/tests/stackinit_kunit.c:424:3: note: expanded from macro 'DEFINE_UNION_TESTS'
     424 |                 DEFINE_UNION_TEST(same_sizes, init, xfail);     \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/tests/stackinit_kunit.c:403:3: note: expanded from macro 'DEFINE_UNION_TEST'
     403 |                 DEFINE_TEST(name ## _ ## init,                  \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     404 |                             union test_ ## name, STRUCT, init,  \
         |                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     405 |                             xfail)
         |                             ~~~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   <scratch space>:20:1: note: expanded from here
      20 | INIT_STRUCT_static_all
         | ^
   lib/tests/stackinit_kunit.c:137:8: note: expanded from macro 'INIT_STRUCT_static_all'
..


vim +596 include/linux/fortify-string.h

   515	
   516	/*
   517	 * To make sure the compiler can enforce protection against buffer overflows,
   518	 * memcpy(), memmove(), and memset() must not be used beyond individual
   519	 * struct members. If you need to copy across multiple members, please use
   520	 * struct_group() to create a named mirror of an anonymous struct union.
   521	 * (e.g. see struct sk_buff.) Read overflow checking is currently only
   522	 * done when a write overflow is also present, or when building with W=1.
   523	 *
   524	 * Mitigation coverage matrix
   525	 *					Bounds checking at:
   526	 *					+-------+-------+-------+-------+
   527	 *					| Compile time  |   Run time    |
   528	 * memcpy() argument sizes:		| write | read  | write | read  |
   529	 *        dest     source   length      +-------+-------+-------+-------+
   530	 * memcpy(known,   known,   constant)	|   y   |   y   |  n/a  |  n/a  |
   531	 * memcpy(known,   unknown, constant)	|   y   |   n   |  n/a  |   V   |
   532	 * memcpy(known,   known,   dynamic)	|   n   |   n   |   B   |   B   |
   533	 * memcpy(known,   unknown, dynamic)	|   n   |   n   |   B   |   V   |
   534	 * memcpy(unknown, known,   constant)	|   n   |   y   |   V   |  n/a  |
   535	 * memcpy(unknown, unknown, constant)	|   n   |   n   |   V   |   V   |
   536	 * memcpy(unknown, known,   dynamic)	|   n   |   n   |   V   |   B   |
   537	 * memcpy(unknown, unknown, dynamic)	|   n   |   n   |   V   |   V   |
   538	 *					+-------+-------+-------+-------+
   539	 *
   540	 * y = perform deterministic compile-time bounds checking
   541	 * n = cannot perform deterministic compile-time bounds checking
   542	 * n/a = no run-time bounds checking needed since compile-time deterministic
   543	 * B = can perform run-time bounds checking (currently unimplemented)
   544	 * V = vulnerable to run-time overflow (will need refactoring to solve)
   545	 *
   546	 */
   547	__FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
   548						 const size_t p_size,
   549						 const size_t q_size,
   550						 const size_t p_size_field,
   551						 const size_t q_size_field,
   552						 const u8 func)
   553	{
   554		if (__builtin_constant_p(size)) {
   555			/*
   556			 * Length argument is a constant expression, so we
   557			 * can perform compile-time bounds checking where
   558			 * buffer sizes are also known at compile time.
   559			 */
   560	
   561			/* Error when size is larger than enclosing struct. */
   562			if (__compiletime_lessthan(p_size_field, p_size) &&
   563			    __compiletime_lessthan(p_size, size))
   564				__write_overflow();
   565			if (__compiletime_lessthan(q_size_field, q_size) &&
   566			    __compiletime_lessthan(q_size, size))
   567				__read_overflow2();
   568	
   569			/* Warn when write size argument larger than dest field. */
   570			if (__compiletime_lessthan(p_size_field, size))
   571				__write_overflow_field(p_size_field, size);
   572			/*
   573			 * Warn for source field over-read when building with W=1
   574			 * or when an over-write happened, so both can be fixed at
   575			 * the same time.
   576			 */
   577			if ((IS_ENABLED(KBUILD_EXTRA_WARN1) ||
   578			     __compiletime_lessthan(p_size_field, size)) &&
   579			    __compiletime_lessthan(q_size_field, size))
   580				__read_overflow2_field(q_size_field, size);
   581		}
   582		/*
   583		 * At this point, length argument may not be a constant expression,
   584		 * so run-time bounds checking can be done where buffer sizes are
   585		 * known. (This is not an "else" because the above checks may only
   586		 * be compile-time warnings, and we want to still warn for run-time
   587		 * overflows.)
   588		 */
   589	
   590		/*
   591		 * Always stop accesses beyond the struct that contains the
   592		 * field, when the buffer's remaining size is known.
   593		 * (The SIZE_MAX test is to optimize away checks where the buffer
   594		 * lengths are unknown.)
   595		 */
 > 596		if (unlikely(p_size != SIZE_MAX && p_size < size))
   597			fortify_panic(func, FORTIFY_WRITE, p_size, size, true);
   598		else if (unlikely(q_size != SIZE_MAX && q_size < size))
   599			fortify_panic(func, FORTIFY_READ, p_size, size, true);
   600	
   601		/*
   602		 * Warn when writing beyond destination field size.
   603		 *
   604		 * Note the implementation of __builtin_*object_size() behaves
   605		 * like sizeof() when not directly referencing a flexible
   606		 * array member, which means there will be many bounds checks
   607		 * that will appear at run-time, without a way for them to be
   608		 * detected at compile-time (as can be done when the destination
   609		 * is specifically the flexible array member).
   610		 * https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101832
   611		 */
   612		if (p_size_field != SIZE_MAX &&
   613		    p_size != p_size_field && p_size_field < size)
   614			return true;
   615	
   616		return false;
   617	}
   618	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
