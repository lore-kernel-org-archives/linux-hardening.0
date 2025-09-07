Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355731494A8;
	Sun,  7 Sep 2025 01:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757208903; cv=none; b=EuDRIiOS34x+eRG34ed8CWYpYdXpGdtiVtt+ng0dX8UvD0bAX19C7OCHlB4R1Sza/c79Kz+fKuYTpiKGYgCRqkBBoNpuYrBMWylPsZ71YCE4pllS0AOpuCcdc8GxKl2tYrsmGudiXr56k+Az573xXDC4KJNry5PPJ6IpcuXs0f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757208903; c=relaxed/simple;
	bh=UxbxUc/VKm4HHhIR90lpehc8o/Q6VK8OV39QtNoLfwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMkmlHj6GTlGltah8mtr9qIdOcb1FfxGJ6tsyV0Smjr0pwrIJC8p+6SDqXl+rgFsiuCeA70ntU5iB0Z3oHX7ziXqOxfZd0qleE6v09gbrQV/MSjGhAVPh1fcRbHsj2EafsnLF9O/dmA4MIdRvMJ2/je5wmUCcz2GKh19t3xIdc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dTc7vz3Y; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dTc7vz3Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757208902; x=1788744902;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UxbxUc/VKm4HHhIR90lpehc8o/Q6VK8OV39QtNoLfwI=;
  b=dTc7vz3YSkQiPUiGVW7nHInNWIoQfWqtBdTSeyHrNfb8NJi3kIBl7uPL
   QDpiYjV0aoj02kOx/MxXrs3AOjB483zXZlcR9V5mIlEEfqWPgQcTtE5p9
   AjvAl/Fqacsoc5v7YNQIrutoTd0fz0my1FAd9t8RczAY+u/eC3HG7yNHg
   ryr/ilWLn8ZRTBB2T1+w8KdzD0D6FeCIjHtLYMV7SFbR8vO9TH6vX+Bk1
   +SeF1fni2GR5zVV6nKn8Jo/ChRtuOqW9OEjFbCn7MAnYW7jt/KTL5h59G
   fvoxIX068WvIOjlogee6h2QvmFOyyS3avhESNvPTtv0ohVvXqZmoPkUiU
   A==;
X-CSE-ConnectionGUID: srYyCidsQLKaqmrHNnzSlg==
X-CSE-MsgGUID: CL6MSwrrSLCQHPK2bvMmsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="70606768"
X-IronPort-AV: E=Sophos;i="6.18,245,1751266800"; 
   d="scan'208";a="70606768"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 18:35:01 -0700
X-CSE-ConnectionGUID: NKkeqWiNRJC5fZlRCPLjzQ==
X-CSE-MsgGUID: mfikFJyuTPWoUdUoHfPzeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,245,1751266800"; 
   d="scan'208";a="172578636"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 06 Sep 2025 18:34:55 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uv4Iv-0001vP-1L;
	Sun, 07 Sep 2025 01:34:53 +0000
Date: Sun, 7 Sep 2025 09:34:05 +0800
From: kernel test robot <lkp@intel.com>
To: Manikanta Guntupalli <manikanta.guntupalli@amd.com>, git@amd.com,
	michal.simek@amd.com, alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, kees@kernel.org, gustavoars@kernel.org,
	jarkko.nikula@linux.intel.com, linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, radhey.shyam.pandey@amd.com,
	srinivas.goud@amd.com, shubhrajyoti.datta@amd.com,
	manion05gk@gmail.com,
	Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Subject: Re: [PATCH V4 2/2] i3c: master: Add AMD I3C bus controller driver
Message-ID: <202509070943.sSXhFOJV-lkp@intel.com>
References: <20250905113740.3841181-3-manikanta.guntupalli@amd.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905113740.3841181-3-manikanta.guntupalli@amd.com>

Hi Manikanta,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.17-rc4 next-20250905]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Manikanta-Guntupalli/dt-bindings-i3c-Add-AMD-I3C-master-controller-support/20250905-193904
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250905113740.3841181-3-manikanta.guntupalli%40amd.com
patch subject: [PATCH V4 2/2] i3c: master: Add AMD I3C bus controller driver
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20250907/202509070943.sSXhFOJV-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250907/202509070943.sSXhFOJV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509070943.sSXhFOJV-lkp@intel.com/

All errors (new ones prefixed by >>):

         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:75:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      75 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:155:17: note: in expansion of macro '__BF_FIELD_CHECK'
     155 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   drivers/i3c/master/amd-i3c-master.c:593:34: note: in expansion of macro 'FIELD_GET'
     593 |                 pid_bcr_dcr[i] = FIELD_GET(XI3C_PID_MASK,
         |                                  ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/i3c/master/amd-i3c-master.c:54:49: note: in expansion of macro 'GENMASK'
      54 | #define XI3C_PID_MASK                           GENMASK(63, 16)
         |                                                 ^~~~~~~
   drivers/i3c/master/amd-i3c-master.c:593:44: note: in expansion of macro 'XI3C_PID_MASK'
     593 |                 pid_bcr_dcr[i] = FIELD_GET(XI3C_PID_MASK,
         |                                            ^~~~~~~~~~~~~
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/compiler_types.h:552:23: note: in definition of macro '__compiletime_assert'
     552 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:572:9: note: in expansion of macro '_compiletime_assert'
     572 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:75:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      75 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:76:56: note: in expansion of macro '__bf_shf'
      76 |                                               (1ULL << __bf_shf(_mask))); \
         |                                                        ^~~~~~~~
   include/linux/bitfield.h:155:17: note: in expansion of macro '__BF_FIELD_CHECK'
     155 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   drivers/i3c/master/amd-i3c-master.c:593:34: note: in expansion of macro 'FIELD_GET'
     593 |                 pid_bcr_dcr[i] = FIELD_GET(XI3C_PID_MASK,
         |                                  ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/i3c/master/amd-i3c-master.c:54:49: note: in expansion of macro 'GENMASK'
      54 | #define XI3C_PID_MASK                           GENMASK(63, 16)
         |                                                 ^~~~~~~
   drivers/i3c/master/amd-i3c-master.c:593:44: note: in expansion of macro 'XI3C_PID_MASK'
     593 |                 pid_bcr_dcr[i] = FIELD_GET(XI3C_PID_MASK,
         |                                            ^~~~~~~~~~~~~
   In file included from drivers/i3c/master/amd-i3c-master.c:8:
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/bitfield.h:156:44: note: in definition of macro 'FIELD_GET'
     156 |                 (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
         |                                            ^~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/i3c/master/amd-i3c-master.c:54:49: note: in expansion of macro 'GENMASK'
      54 | #define XI3C_PID_MASK                           GENMASK(63, 16)
         |                                                 ^~~~~~~
   drivers/i3c/master/amd-i3c-master.c:593:44: note: in expansion of macro 'XI3C_PID_MASK'
     593 |                 pid_bcr_dcr[i] = FIELD_GET(XI3C_PID_MASK,
         |                                            ^~~~~~~~~~~~~
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/i3c/master/amd-i3c-master.c:593:34: note: in expansion of macro 'FIELD_GET'
     593 |                 pid_bcr_dcr[i] = FIELD_GET(XI3C_PID_MASK,
         |                                  ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/i3c/master/amd-i3c-master.c:54:49: note: in expansion of macro 'GENMASK'
      54 | #define XI3C_PID_MASK                           GENMASK(63, 16)
         |                                                 ^~~~~~~
   drivers/i3c/master/amd-i3c-master.c:593:44: note: in expansion of macro 'XI3C_PID_MASK'
     593 |                 pid_bcr_dcr[i] = FIELD_GET(XI3C_PID_MASK,
         |                                            ^~~~~~~~~~~~~
   drivers/i3c/master/amd-i3c-master.c: In function 'xi3c_master_bus_init':
   drivers/i3c/master/amd-i3c-master.c:926:62: warning: left shift count >= width of type [-Wshift-count-overflow]
     926 |         info.pid = ((FIELD_GET(XI3C_PID1_MASK, pid1_bcr_dcr) << 32) |
         |                                                              ^~
   drivers/i3c/master/amd-i3c-master.c: In function 'xi3c_master_do_daa':
>> include/linux/compiler_types.h:572:45: error: call to '__compiletime_assert_400' declared with attribute error: FIELD_GET: mask is zero
     572 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:553:25: note: in definition of macro '__compiletime_assert'
     553 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:572:9: note: in expansion of macro '_compiletime_assert'
     572 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:67:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      67 |                 BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:155:17: note: in expansion of macro '__BF_FIELD_CHECK'
     155 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   drivers/i3c/master/amd-i3c-master.c:593:34: note: in expansion of macro 'FIELD_GET'
     593 |                 pid_bcr_dcr[i] = FIELD_GET(XI3C_PID_MASK,
         |                                  ^~~~~~~~~
--
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:75:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      75 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:155:17: note: in expansion of macro '__BF_FIELD_CHECK'
     155 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   amd-i3c-master.c:593:34: note: in expansion of macro 'FIELD_GET'
     593 |                 pid_bcr_dcr[i] = FIELD_GET(XI3C_PID_MASK,
         |                                  ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   amd-i3c-master.c:54:49: note: in expansion of macro 'GENMASK'
      54 | #define XI3C_PID_MASK                           GENMASK(63, 16)
         |                                                 ^~~~~~~
   amd-i3c-master.c:593:44: note: in expansion of macro 'XI3C_PID_MASK'
     593 |                 pid_bcr_dcr[i] = FIELD_GET(XI3C_PID_MASK,
         |                                            ^~~~~~~~~~~~~
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/compiler_types.h:552:23: note: in definition of macro '__compiletime_assert'
     552 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:572:9: note: in expansion of macro '_compiletime_assert'
     572 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:75:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      75 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:76:56: note: in expansion of macro '__bf_shf'
      76 |                                               (1ULL << __bf_shf(_mask))); \
         |                                                        ^~~~~~~~
   include/linux/bitfield.h:155:17: note: in expansion of macro '__BF_FIELD_CHECK'
     155 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   amd-i3c-master.c:593:34: note: in expansion of macro 'FIELD_GET'
     593 |                 pid_bcr_dcr[i] = FIELD_GET(XI3C_PID_MASK,
         |                                  ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   amd-i3c-master.c:54:49: note: in expansion of macro 'GENMASK'
      54 | #define XI3C_PID_MASK                           GENMASK(63, 16)
         |                                                 ^~~~~~~
   amd-i3c-master.c:593:44: note: in expansion of macro 'XI3C_PID_MASK'
     593 |                 pid_bcr_dcr[i] = FIELD_GET(XI3C_PID_MASK,
         |                                            ^~~~~~~~~~~~~
   In file included from amd-i3c-master.c:8:
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/bitfield.h:156:44: note: in definition of macro 'FIELD_GET'
     156 |                 (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
         |                                            ^~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   amd-i3c-master.c:54:49: note: in expansion of macro 'GENMASK'
      54 | #define XI3C_PID_MASK                           GENMASK(63, 16)
         |                                                 ^~~~~~~
   amd-i3c-master.c:593:44: note: in expansion of macro 'XI3C_PID_MASK'
     593 |                 pid_bcr_dcr[i] = FIELD_GET(XI3C_PID_MASK,
         |                                            ^~~~~~~~~~~~~
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   amd-i3c-master.c:593:34: note: in expansion of macro 'FIELD_GET'
     593 |                 pid_bcr_dcr[i] = FIELD_GET(XI3C_PID_MASK,
         |                                  ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   amd-i3c-master.c:54:49: note: in expansion of macro 'GENMASK'
      54 | #define XI3C_PID_MASK                           GENMASK(63, 16)
         |                                                 ^~~~~~~
   amd-i3c-master.c:593:44: note: in expansion of macro 'XI3C_PID_MASK'
     593 |                 pid_bcr_dcr[i] = FIELD_GET(XI3C_PID_MASK,
         |                                            ^~~~~~~~~~~~~
   amd-i3c-master.c: In function 'xi3c_master_bus_init':
   amd-i3c-master.c:926:62: warning: left shift count >= width of type [-Wshift-count-overflow]
     926 |         info.pid = ((FIELD_GET(XI3C_PID1_MASK, pid1_bcr_dcr) << 32) |
         |                                                              ^~
   amd-i3c-master.c: In function 'xi3c_master_do_daa':
>> include/linux/compiler_types.h:572:45: error: call to '__compiletime_assert_400' declared with attribute error: FIELD_GET: mask is zero
     572 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:553:25: note: in definition of macro '__compiletime_assert'
     553 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:572:9: note: in expansion of macro '_compiletime_assert'
     572 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:67:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      67 |                 BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:155:17: note: in expansion of macro '__BF_FIELD_CHECK'
     155 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   amd-i3c-master.c:593:34: note: in expansion of macro 'FIELD_GET'
     593 |                 pid_bcr_dcr[i] = FIELD_GET(XI3C_PID_MASK,
         |                                  ^~~~~~~~~


vim +/__compiletime_assert_400 +572 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  558  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  559  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  560  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  561  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  562  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  563   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  564   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  565   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  566   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  567   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  568   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  569   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  570   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  571  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @572  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  573  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
