Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EA62746A;
	Fri, 27 Jun 2025 01:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750986381; cv=none; b=HRHdzCi+eTb8BTI5YhE441zyHBxvwUpQrnkBBqFI9rZ+YhLAfmnqxKfBtBYRynUHGgBdDweP3t7r91gB8nrp/pLj9MsNBQwCGzs35jJw5C0nz/2f7ir507w8ngPPgTWCaD1eca//75dPUjJYBb9PwZlL81juLLqwDVfyoYO/6Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750986381; c=relaxed/simple;
	bh=+G/t9+B65nWdGibqPQwfKA9JGs6zB4rCzJDnBF/Kous=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrMPbfoW4B8b+7yycAv1trqoZMa7qmKrqgDzPRMBl8B55WPVaXC/diZKn+RSodXhSQ0Zh6z7B2mAZHbnu6IeWOar+oK/hxfpRqGCy5AeSfUVIhXvUIPNQ8sGmyhwWMY/EnlLqSzCuNuXAQYcPuiy/93vyjUXxtzWMe6zm+jUm40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YaEX0Cw0; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YaEX0Cw0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750986380; x=1782522380;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+G/t9+B65nWdGibqPQwfKA9JGs6zB4rCzJDnBF/Kous=;
  b=YaEX0Cw0AaCmPaDbtMWwnTIPm3qNEHcIZvDMTbjbS2Cnn/Dnz0OiO12k
   tu1p74ldd2OX0OaQZcEbtK6RuynihZO2QK+9Y6Hq2g2TqBGYEdB4T4o90
   uRa00LyDLS8pyW63WWV3va9M+GxETK+wG11bzaXIQOGewqxaCKwU+fBLW
   W4d9fL9yFgHRz+H3ifTIflmyehh18njlRIp7tvmsRLDyKiQeUAis6jPuT
   +1vg84a2mMxLNFzNobuVkGLCYD84xJUt+wFI8b/CYqXxjzxYYIKQNfFfU
   thGsXxu6EOQIoXJecwx0fZTgXY2/3MYOgVH3NFWRNxt9T1sa3+klUOda7
   g==;
X-CSE-ConnectionGUID: gmc35tN6RtS8C59ZuzXX5Q==
X-CSE-MsgGUID: yV1/kx7MTcexgM3RdY+wZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="53023629"
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; 
   d="scan'208";a="53023629"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 18:06:19 -0700
X-CSE-ConnectionGUID: wEPlNzg9Qker8t5pQL+EYA==
X-CSE-MsgGUID: YSqscLQrSFS6EmqJEU55cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; 
   d="scan'208";a="153381319"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 26 Jun 2025 18:06:17 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uUxXi-000Vg2-2o;
	Fri, 27 Jun 2025 01:06:14 +0000
Date: Fri, 27 Jun 2025 09:05:48 +0800
From: kernel test robot <lkp@intel.com>
To: Colin Ian King <colin.i.king@gmail.com>, Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] fortify: add branch hints on unlikely
 fortify_panic paths
Message-ID: <202506270831.FzLx5USH-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on kees/for-next/hardening]
[also build test WARNING on kees/for-next/pstore kees/for-next/kspp linus/master v6.16-rc3 next-20250626]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Colin-Ian-King/fortify-add-branch-hints-on-unlikely-fortify_panic-paths/20250626-001527
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
patch link:    https://lore.kernel.org/r/20250625161221.295575-1-colin.i.king%40gmail.com
patch subject: [PATCH][next] fortify: add branch hints on unlikely fortify_panic paths
config: i386-buildonly-randconfig-004-20250627 (https://download.01.org/0day-ci/archive/20250627/202506270831.FzLx5USH-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250627/202506270831.FzLx5USH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506270831.FzLx5USH-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/array_size.h:5,
                    from include/linux/string.h:6,
                    from include/linux/uuid.h:11,
                    from include/linux/mod_devicetable.h:14,
                    from scripts/mod/devicetable-offsets.c:3:
>> include/linux/compiler.h:27:33: warning: '______f' is static but declared in inline function 'fortify_memcpy_chk' which is not static
      27 |                                 ______f = {                             \
         |                                 ^~~~~~~
   include/linux/compiler.h:47:26: note: in expansion of macro '__branch_check__'
      47 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:598:18: note: in expansion of macro 'unlikely'
     598 |         else if (unlikely(q_size != SIZE_MAX && q_size < size))
         |                  ^~~~~~~~
>> include/linux/compiler.h:27:33: warning: '______f' is static but declared in inline function 'fortify_memcpy_chk' which is not static
      27 |                                 ______f = {                             \
         |                                 ^~~~~~~
   include/linux/compiler.h:47:26: note: in expansion of macro '__branch_check__'
      47 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:596:13: note: in expansion of macro 'unlikely'
     596 |         if (unlikely(p_size != SIZE_MAX && p_size < size))
         |             ^~~~~~~~
--
   In file included from include/linux/export.h:5,
                    from include/linux/linkage.h:7,
                    from arch/x86/include/asm/cache.h:5,
                    from include/vdso/cache.h:5,
                    from include/linux/cache.h:6,
                    from include/linux/slab.h:15,
                    from fs/ocfs2/dlmglue.c:11:
>> include/linux/compiler.h:27:33: warning: '______f' is static but declared in inline function 'fortify_memcpy_chk' which is not static
      27 |                                 ______f = {                             \
         |                                 ^~~~~~~
   include/linux/compiler.h:47:26: note: in expansion of macro '__branch_check__'
      47 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:598:18: note: in expansion of macro 'unlikely'
     598 |         else if (unlikely(q_size != SIZE_MAX && q_size < size))
         |                  ^~~~~~~~
>> include/linux/compiler.h:27:33: warning: '______f' is static but declared in inline function 'fortify_memcpy_chk' which is not static
      27 |                                 ______f = {                             \
         |                                 ^~~~~~~
   include/linux/compiler.h:47:26: note: in expansion of macro '__branch_check__'
      47 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:596:13: note: in expansion of macro 'unlikely'
     596 |         if (unlikely(p_size != SIZE_MAX && p_size < size))
         |             ^~~~~~~~
   In file included from include/linux/string.h:392,
                    from arch/x86/include/asm/page_32.h:18,
                    from arch/x86/include/asm/page.h:14,
                    from arch/x86/include/asm/thread_info.h:12,
                    from include/linux/thread_info.h:60,
                    from include/linux/spinlock.h:60,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16:
   In function 'fortify_memset_chk',
       inlined from 'ocfs2_lock_res_free' at fs/ocfs2/dlmglue.c:791:2:
   include/linux/fortify-string.h:480:25: warning: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
     480 |                         __write_overflow_field(p_size_field, size);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   kernel/bpf/helpers.c: In function '____bpf_snprintf':
   kernel/bpf/helpers.c:1067:9: warning: function '____bpf_snprintf' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1067 |         err = bstr_printf(str, str_size, fmt, data.bin_args);
         |         ^~~
   In file included from include/uapi/linux/filter.h:9,
                    from include/linux/bpf.h:8,
                    from kernel/bpf/helpers.c:4:
   include/linux/fortify-string.h: At top level:
>> include/linux/compiler.h:27:33: warning: '______f' is static but declared in inline function 'fortify_memcpy_chk' which is not static
      27 |                                 ______f = {                             \
         |                                 ^~~~~~~
   include/linux/compiler.h:47:26: note: in expansion of macro '__branch_check__'
      47 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:598:18: note: in expansion of macro 'unlikely'
     598 |         else if (unlikely(q_size != SIZE_MAX && q_size < size))
         |                  ^~~~~~~~
>> include/linux/compiler.h:27:33: warning: '______f' is static but declared in inline function 'fortify_memcpy_chk' which is not static
      27 |                                 ______f = {                             \
         |                                 ^~~~~~~
   include/linux/compiler.h:47:26: note: in expansion of macro '__branch_check__'
      47 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:596:13: note: in expansion of macro 'unlikely'
     596 |         if (unlikely(p_size != SIZE_MAX && p_size < size))
         |             ^~~~~~~~
--
   In file included from include/linux/build_bug.h:5,
                    from include/linux/bits.h:32,
                    from include/linux/ioport.h:13,
                    from include/linux/acpi.h:12,
                    from sound/soc/codecs/rt1318.c:10:
>> include/linux/compiler.h:27:33: warning: '______f' is static but declared in inline function 'fortify_memcpy_chk' which is not static
      27 |                                 ______f = {                             \
         |                                 ^~~~~~~
   include/linux/compiler.h:47:26: note: in expansion of macro '__branch_check__'
      47 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:598:18: note: in expansion of macro 'unlikely'
     598 |         else if (unlikely(q_size != SIZE_MAX && q_size < size))
         |                  ^~~~~~~~
>> include/linux/compiler.h:27:33: warning: '______f' is static but declared in inline function 'fortify_memcpy_chk' which is not static
      27 |                                 ______f = {                             \
         |                                 ^~~~~~~
   include/linux/compiler.h:47:26: note: in expansion of macro '__branch_check__'
      47 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:596:13: note: in expansion of macro 'unlikely'
     596 |         if (unlikely(p_size != SIZE_MAX && p_size < size))
         |             ^~~~~~~~
   sound/soc/codecs/rt1318.c:1148:34: warning: 'rt1318_of_match' defined but not used [-Wunused-const-variable=]
    1148 | static const struct of_device_id rt1318_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~
--
   In file included from include/linux/dev_printk.h:14,
                    from include/linux/device.h:15,
                    from include/linux/extcon.h:21,
                    from sound/soc/samsung/aries_wm8994.c:2:
>> include/linux/compiler.h:27:33: warning: '______f' is static but declared in inline function 'fortify_memcpy_chk' which is not static
      27 |                                 ______f = {                             \
         |                                 ^~~~~~~
   include/linux/compiler.h:47:26: note: in expansion of macro '__branch_check__'
      47 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:598:18: note: in expansion of macro 'unlikely'
     598 |         else if (unlikely(q_size != SIZE_MAX && q_size < size))
         |                  ^~~~~~~~
>> include/linux/compiler.h:27:33: warning: '______f' is static but declared in inline function 'fortify_memcpy_chk' which is not static
      27 |                                 ______f = {                             \
         |                                 ^~~~~~~
   include/linux/compiler.h:47:26: note: in expansion of macro '__branch_check__'
      47 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:596:13: note: in expansion of macro 'unlikely'
     596 |         if (unlikely(p_size != SIZE_MAX && p_size < size))
         |             ^~~~~~~~
   sound/soc/samsung/aries_wm8994.c:524:34: warning: 'samsung_wm8994_of_match' defined but not used [-Wunused-const-variable=]
     524 | static const struct of_device_id samsung_wm8994_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~
--
   kernel/trace/bpf_trace.c: In function '____bpf_trace_printk':
   kernel/trace/bpf_trace.c:378:9: warning: function '____bpf_trace_printk' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     378 |         ret = bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, data.bin_args);
         |         ^~~
   kernel/trace/bpf_trace.c: In function '____bpf_trace_vprintk':
   kernel/trace/bpf_trace.c:434:9: warning: function '____bpf_trace_vprintk' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     434 |         ret = bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, data.bin_args);
         |         ^~~
   kernel/trace/bpf_trace.c: In function '____bpf_seq_printf':
   kernel/trace/bpf_trace.c:476:9: warning: function '____bpf_seq_printf' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     476 |         seq_bprintf(m, fmt, data.bin_args);
         |         ^~~~~~~~~~~
   In file included from include/linux/array_size.h:5,
                    from include/linux/kernel.h:16,
                    from kernel/trace/bpf_trace.c:5:
   include/linux/fortify-string.h: At top level:
>> include/linux/compiler.h:27:33: warning: '______f' is static but declared in inline function 'fortify_memcpy_chk' which is not static
      27 |                                 ______f = {                             \
         |                                 ^~~~~~~
   include/linux/compiler.h:47:26: note: in expansion of macro '__branch_check__'
      47 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:598:18: note: in expansion of macro 'unlikely'
     598 |         else if (unlikely(q_size != SIZE_MAX && q_size < size))
         |                  ^~~~~~~~
>> include/linux/compiler.h:27:33: warning: '______f' is static but declared in inline function 'fortify_memcpy_chk' which is not static
      27 |                                 ______f = {                             \
         |                                 ^~~~~~~
   include/linux/compiler.h:47:26: note: in expansion of macro '__branch_check__'
      47 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:596:13: note: in expansion of macro 'unlikely'
     596 |         if (unlikely(p_size != SIZE_MAX && p_size < size))
         |             ^~~~~~~~
--
   In file included from include/linux/err.h:5,
                    from drivers/regulator/pbias-regulator.c:17:
>> include/linux/compiler.h:27:33: warning: '______f' is static but declared in inline function 'fortify_memcpy_chk' which is not static
      27 |                                 ______f = {                             \
         |                                 ^~~~~~~
   include/linux/compiler.h:47:26: note: in expansion of macro '__branch_check__'
      47 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:598:18: note: in expansion of macro 'unlikely'
     598 |         else if (unlikely(q_size != SIZE_MAX && q_size < size))
         |                  ^~~~~~~~
>> include/linux/compiler.h:27:33: warning: '______f' is static but declared in inline function 'fortify_memcpy_chk' which is not static
      27 |                                 ______f = {                             \
         |                                 ^~~~~~~
   include/linux/compiler.h:47:26: note: in expansion of macro '__branch_check__'
      47 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:596:13: note: in expansion of macro 'unlikely'
     596 |         if (unlikely(p_size != SIZE_MAX && p_size < size))
         |             ^~~~~~~~
   drivers/regulator/pbias-regulator.c:136:34: warning: 'pbias_of_match' defined but not used [-Wunused-const-variable=]
     136 | static const struct of_device_id pbias_of_match[] = {
         |                                  ^~~~~~~~~~~~~~
--
   drivers/iommu/mtk_iommu_v1.c: In function 'mtk_iommu_v1_probe_finalize':
   drivers/iommu/mtk_iommu_v1.c:512:35: warning: variable 'mtk_mapping' set but not used [-Wunused-but-set-variable]
     512 |         struct dma_iommu_mapping *mtk_mapping;
         |                                   ^~~~~~~~~~~
   In file included from include/asm-generic/bug.h:5,
                    from arch/x86/include/asm/bug.h:103,
                    from include/linux/bug.h:5,
                    from drivers/iommu/mtk_iommu_v1.c:10:
   include/linux/fortify-string.h: At top level:
>> include/linux/compiler.h:27:33: warning: '______f' is static but declared in inline function 'fortify_memcpy_chk' which is not static
      27 |                                 ______f = {                             \
         |                                 ^~~~~~~
   include/linux/compiler.h:47:26: note: in expansion of macro '__branch_check__'
      47 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:598:18: note: in expansion of macro 'unlikely'
     598 |         else if (unlikely(q_size != SIZE_MAX && q_size < size))
         |                  ^~~~~~~~
>> include/linux/compiler.h:27:33: warning: '______f' is static but declared in inline function 'fortify_memcpy_chk' which is not static
      27 |                                 ______f = {                             \
         |                                 ^~~~~~~
   include/linux/compiler.h:47:26: note: in expansion of macro '__branch_check__'
      47 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:596:13: note: in expansion of macro 'unlikely'
     596 |         if (unlikely(p_size != SIZE_MAX && p_size < size))
         |             ^~~~~~~~
--
   drivers/usb/renesas_usbhs/mod.c: In function 'usbhs_status_get_each_irq':
   drivers/usb/renesas_usbhs/mod.c:195:13: warning: variable 'intenb0' set but not used [-Wunused-but-set-variable]
     195 |         u16 intenb0, intenb1;
         |             ^~~~~~~
   In file included from include/linux/array_size.h:5,
                    from include/linux/kernel.h:16,
                    from include/linux/interrupt.h:6,
                    from drivers/usb/renesas_usbhs/mod.c:9:
   include/linux/fortify-string.h: At top level:
>> include/linux/compiler.h:27:33: warning: '______f' is static but declared in inline function 'fortify_memcpy_chk' which is not static
      27 |                                 ______f = {                             \
         |                                 ^~~~~~~
   include/linux/compiler.h:47:26: note: in expansion of macro '__branch_check__'
      47 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:598:18: note: in expansion of macro 'unlikely'
     598 |         else if (unlikely(q_size != SIZE_MAX && q_size < size))
         |                  ^~~~~~~~
>> include/linux/compiler.h:27:33: warning: '______f' is static but declared in inline function 'fortify_memcpy_chk' which is not static
      27 |                                 ______f = {                             \
         |                                 ^~~~~~~
   include/linux/compiler.h:47:26: note: in expansion of macro '__branch_check__'
      47 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:596:13: note: in expansion of macro 'unlikely'
     596 |         if (unlikely(p_size != SIZE_MAX && p_size < size))
         |             ^~~~~~~~
--
   fs/nfsd/export.c: In function 'exp_rootfh':
   fs/nfsd/export.c:1029:34: warning: variable 'inode' set but not used [-Wunused-but-set-variable]
    1029 |         struct inode            *inode;
         |                                  ^~~~~
   In file included from include/linux/export.h:5,
                    from include/linux/linkage.h:7,
                    from arch/x86/include/asm/cache.h:5,
                    from include/vdso/cache.h:5,
                    from include/linux/cache.h:6,
                    from include/linux/slab.h:15,
                    from fs/nfsd/export.c:15:
   include/linux/fortify-string.h: At top level:
>> include/linux/compiler.h:27:33: warning: '______f' is static but declared in inline function 'fortify_memcpy_chk' which is not static
      27 |                                 ______f = {                             \
         |                                 ^~~~~~~
   include/linux/compiler.h:47:26: note: in expansion of macro '__branch_check__'
      47 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:598:18: note: in expansion of macro 'unlikely'
     598 |         else if (unlikely(q_size != SIZE_MAX && q_size < size))
         |                  ^~~~~~~~
>> include/linux/compiler.h:27:33: warning: '______f' is static but declared in inline function 'fortify_memcpy_chk' which is not static
      27 |                                 ______f = {                             \
         |                                 ^~~~~~~
   include/linux/compiler.h:47:26: note: in expansion of macro '__branch_check__'
      47 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:596:13: note: in expansion of macro 'unlikely'
     596 |         if (unlikely(p_size != SIZE_MAX && p_size < size))
         |             ^~~~~~~~
--
   In file included from include/linux/err.h:5,
                    from include/linux/clk.h:12,
                    from drivers/iio/adc/aspeed_adc.c:15:
>> include/linux/compiler.h:27:33: warning: '______f' is static but declared in inline function 'fortify_memcpy_chk' which is not static
      27 |                                 ______f = {                             \
         |                                 ^~~~~~~
   include/linux/compiler.h:47:26: note: in expansion of macro '__branch_check__'
      47 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:598:18: note: in expansion of macro 'unlikely'
     598 |         else if (unlikely(q_size != SIZE_MAX && q_size < size))
         |                  ^~~~~~~~
>> include/linux/compiler.h:27:33: warning: '______f' is static but declared in inline function 'fortify_memcpy_chk' which is not static
      27 |                                 ______f = {                             \
         |                                 ^~~~~~~
   include/linux/compiler.h:47:26: note: in expansion of macro '__branch_check__'
      47 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:596:13: note: in expansion of macro 'unlikely'
     596 |         if (unlikely(p_size != SIZE_MAX && p_size < size))
         |             ^~~~~~~~
   drivers/iio/adc/aspeed_adc.c: In function 'aspeed_adc_probe':
   drivers/iio/adc/aspeed_adc.c:493:65: warning: '%s' directive argument is null [-Wformat-overflow=]
     493 |         snprintf(clk_parent_name, ARRAY_SIZE(clk_parent_name), "%s",
         |                                                                 ^~
..


vim +27 include/linux/compiler.h

1f0d69a9fc815d Steven Rostedt          2008-11-12  21  
d45ae1f7041ac5 Steven Rostedt (VMware  2017-01-17  22) #define __branch_check__(x, expect, is_constant) ({			\
2026d35741f2c3 Mikulas Patocka         2018-05-30  23  			long ______r;					\
134e6a034cb004 Steven Rostedt (VMware  2017-01-19  24) 			static struct ftrace_likely_data		\
e04462fb82f8dd Miguel Ojeda            2018-09-03  25  				__aligned(4)				\
33def8498fdde1 Joe Perches             2020-10-21  26  				__section("_ftrace_annotated_branch")	\
1f0d69a9fc815d Steven Rostedt          2008-11-12 @27  				______f = {				\
134e6a034cb004 Steven Rostedt (VMware  2017-01-19  28) 				.data.func = __func__,			\
134e6a034cb004 Steven Rostedt (VMware  2017-01-19  29) 				.data.file = __FILE__,			\
134e6a034cb004 Steven Rostedt (VMware  2017-01-19  30) 				.data.line = __LINE__,			\
1f0d69a9fc815d Steven Rostedt          2008-11-12  31  			};						\
d45ae1f7041ac5 Steven Rostedt (VMware  2017-01-17  32) 			______r = __builtin_expect(!!(x), expect);	\
d45ae1f7041ac5 Steven Rostedt (VMware  2017-01-17  33) 			ftrace_likely_update(&______f, ______r,		\
d45ae1f7041ac5 Steven Rostedt (VMware  2017-01-17  34) 					     expect, is_constant);	\
1f0d69a9fc815d Steven Rostedt          2008-11-12  35  			______r;					\
1f0d69a9fc815d Steven Rostedt          2008-11-12  36  		})
1f0d69a9fc815d Steven Rostedt          2008-11-12  37  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
