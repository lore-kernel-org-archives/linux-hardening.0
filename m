Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1981D540;
	Mon,  5 Aug 2024 18:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722883689; cv=none; b=E1FTxW0ulzwCph93+M2YylsOFl9nZ4L+an3ARr7jYbpXeXRjcS1DRDRDMzultmlvun+IFcQKQKarPDDA+bu/TYeILZ4vgLDYW37ybSHnPWPobcfJ0dTtMsYHcMzf6nBYz7i2Vbp0mDt7ZGaIvLHjm0tSYfaxZaZ5vj3185bxA/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722883689; c=relaxed/simple;
	bh=gCxE2ILZu/MZn8MJmOuCe1pY1ZdE8L6T6mNlTA3+9UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UC4sSrwj5G8irdZw0mJL+rSJLqaEohZXbICmCBFi6nH3LYZFyZOa8ENRELv0dCx0V9oayRqibtdMFcP8vycz/foiZsFIZM7ng7ozdiUaL6ZuxcZJ1qLvd9d/W7/JyKAo4L1uV5suf2+TCqOsbn3BOB5gOtBAi58srf11ITE1cjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZ5wGsLq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZ5wGsLq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1ADC32782;
	Mon,  5 Aug 2024 18:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722883688;
	bh=gCxE2ILZu/MZn8MJmOuCe1pY1ZdE8L6T6mNlTA3+9UU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IZ5wGsLqwEnVtg1eyDn6NkY3kOF8/UGW6shwEqIg+jVUjkGSeU8hOlxSPwDe8kEX1
	 JgKZzpv5XgfoYiJqfyNaiRdGydEbCx4uPIblho2bju39euWIt2TxdJlpVlsR/VrxEN
	 ji4G6JBJvqKwo4bm/6r0I7ji6rTfvIpRC9K4CNr0ZYegQg8c1IRH274cZElSw5CXcD
	 dwtdtNnZ0VhwOtf/9U1U8Zt1I2zhhfk0RVn3Va7Xfp1FG/xCWBQ0VE6zaovbJaWRFS
	 XAnEnQjfMVMf7KG96hakM/e2jwj9i1kWVaIkpnU7CP0WLlKldCvF8UpHb1NvpMlZw1
	 3DLvP3khdhyxg==
Date: Mon, 5 Aug 2024 11:48:07 -0700
From: Kees Cook <kees@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
	Dave Airlie <airlied@redhat.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	intel-gfx@lists.freedesktop.org, linux-hardening@vger.kernel.org
Subject: Too large alloc in gem_exec_reloc test? (was Re: [linus:master]
 [mm/slab] 2e8000b826: WARNING:at_mm/util.c:#__kvmalloc_node_noprof)
Message-ID: <202408051141.7FB8D9C98@keescook>
References: <202408041614.dbe4b7fd-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202408041614.dbe4b7fd-lkp@intel.com>

This seems like some kind of pre-existing issue in the igt test, reachable
via eb_copy_relocations(). The only warning in kvmalloc_node_noprof() is:

        /* Don't even allow crazy sizes */
        if (unlikely(size > INT_MAX)) {
                WARN_ON_ONCE(!(flags & __GFP_NOWARN));
                return NULL;
        }

So, something is too big in the test?

-Kees

On Sun, Aug 04, 2024 at 04:56:40PM +0800, kernel test robot wrote:
> 
> hi, Kees Cook,
> 
> as we understand, this commit is not the root cause of WARNING. the WARNING just
> changes the form from (2) to (1) due to this commit.
> 
> 67f2df3b82d091ed 2e8000b826fcd2716449d09753d
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :6          100%           6:6     dmesg.WARNING:at_mm/util.c:#__kvmalloc_node_noprof  <--- (1)
>           6:6          -67%            :6     dmesg.WARNING:at_mm/util.c:#kvmalloc_node_noprof    <--- (2)
> 
> however, we failed to bisect (2). so below report is FYI what we observed in our
> tests. not sure if it can give any hint to some real issues.
> 
> 
> 
> Hello,
> 
> kernel test robot noticed "WARNING:at_mm/util.c:#__kvmalloc_node_noprof" on:
> 
> commit: 2e8000b826fcd2716449d09753d5ed843067881e ("mm/slab: Introduce kvmalloc_buckets_node() that can take kmem_buckets argument")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linus/master      786c8248dbd33a5a7a07f7c6e55a7bfc68d2ca48]
> [test failed on linux-next/master 9ec6ec93f2c1e6cd2911e2a4acd5ac85e13bb3e2]
> 
> in testcase: igt
> version: igt-x86_64-73e21b2bb-1_20240623
> with following parameters:
> 
> 	group: gem_exec_reloc
> 
> 
> 
> compiler: gcc-13
> test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz (Kaby Lake) with 32G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202408041614.dbe4b7fd-lkp@intel.com
> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240804/202408041614.dbe4b7fd-lkp@intel.com
> 
> 
> [  928.741334][ T5136] ------------[ cut here ]------------
> [  928.747005][ T5136] WARNING: CPU: 2 PID: 5136 at mm/util.c:650 __kvmalloc_node_noprof+0x142/0x190
> [  928.755967][ T5136] Modules linked in: btrfs blake2b_generic xor zstd_compress raid6_pq libcrc32c intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal ipmi_devintf ipmi_msghandler sd_mod intel_powerclamp t10_pi coretemp crc64_rocksoft_generic crc64_rocksoft crc64 kvm_intel sg i915 kvm crct10dif_pclmul crc32_pclmul crc32c_intel drm_buddy ghash_clmulni_intel intel_gtt sha512_ssse3 drm_display_helper mei_wdt ttm rapl drm_kms_helper ahci wmi_bmof libahci mei_me video intel_cstate intel_uncore idma64 libata mei i2c_designware_platform i2c_i801 i2c_designware_core i2c_smbus pinctrl_sunrisepoint wmi acpi_pad binfmt_misc loop drm fuse dm_mod ip_tables
> [  928.812981][ T5136] CPU: 2 PID: 5136 Comm: gem_exec_reloc Tainted: G S                 6.10.0-rc1-00009-g2e8000b826fc #1
> [  928.823924][ T5136] Hardware name: Dell Inc. OptiPlex 7050/062KRH, BIOS 1.2.0 12/22/2016
> [  928.832080][ T5136] RIP: 0010:__kvmalloc_node_noprof+0x142/0x190
> [  928.838186][ T5136] Code: c4 06 0e 00 48 83 c4 18 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc 49 be 00 00 00 00 00 20 00 00 eb 9f 80 e7 20 75 de <0f> 0b eb da 48 c7 c7 f0 fe cf 84 e8 5e 2c 19 00 e9 3f ff ff ff 48
> [  928.857727][ T5136] RSP: 0018:ffffc9000e82f6f8 EFLAGS: 00010246
> [  928.863744][ T5136] RAX: 0000000000000000 RBX: 00000000000000c0 RCX: 0000000000000013
> [  928.871647][ T5136] RDX: 000000000007ffff RSI: ffffffff81a13806 RDI: 0000000000000000
> [  928.879565][ T5136] RBP: 0000000080000000 R08: 0000000000000001 R09: 0000000000000000
> [  928.887466][ T5136] R10: ffffc9000e82f6f8 R11: 0000000000000000 R12: 00000000ffffffff
> [  928.895375][ T5136] R13: 0000000000000000 R14: 0000000004000000 R15: ffffc9000e82f9b0
> [  928.903288][ T5136] FS:  00007f0ff830d8c0(0000) GS:ffff88879db00000(0000) knlGS:0000000000000000
> [  928.912151][ T5136] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  928.918679][ T5136] CR2: 00007f0ff8100000 CR3: 00000008162e0004 CR4: 00000000003706f0
> [  928.926595][ T5136] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  928.934489][ T5136] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  928.942382][ T5136] Call Trace:
> [  928.945631][ T5136]  <TASK>
> [  928.948499][ T5136]  ? __warn+0xcc/0x260
> [  928.952503][ T5136]  ? __kvmalloc_node_noprof+0x142/0x190
> [  928.957994][ T5136]  ? report_bug+0x261/0x2c0
> [  928.962429][ T5136]  ? handle_bug+0x6d/0x90
> [  928.966692][ T5136]  ? exc_invalid_op+0x17/0x40
> [  928.971327][ T5136]  ? asm_exc_invalid_op+0x1a/0x20
> [  928.976295][ T5136]  ? __kmalloc_node_noprof+0x3b6/0x4e0
> [  928.981709][ T5136]  ? __kvmalloc_node_noprof+0x142/0x190
> [  928.987199][ T5136]  ? __kvmalloc_node_noprof+0x53/0x190
> [  928.992590][ T5136]  eb_copy_relocations+0x166/0x450 [i915]
> [  928.998467][ T5136]  eb_relocate_parse_slow+0xd5/0x860 [i915]
> [  929.004513][ T5136]  i915_gem_do_execbuffer+0xaa5/0x2420 [i915]
> [  929.010657][ T5136]  ? unwind_get_return_address+0x5e/0xa0
> [  929.016135][ T5136]  ? arch_stack_walk+0xac/0x100
> [  929.020836][ T5136]  ? __pfx_i915_gem_do_execbuffer+0x10/0x10 [i915]
> [  929.027424][ T5136]  ? kasan_save_track+0x14/0x30
> [  929.032147][ T5136]  ? __kasan_kmalloc+0x8f/0xa0
> [  929.036759][ T5136]  ? __pfx___might_resched+0x10/0x10
> [  929.041892][ T5136]  ? check_heap_object+0x6f/0x4b0
> [  929.046766][ T5136]  i915_gem_execbuffer2_ioctl+0x2b2/0x680 [i915]
> [  929.053171][ T5136]  ? __pfx_i915_gem_execbuffer2_ioctl+0x10/0x10 [i915]
> [  929.060100][ T5136]  drm_ioctl_kernel+0x16f/0x2e0 [drm]
> [  929.065417][ T5136]  ? __pfx_drm_ioctl_kernel+0x10/0x10 [drm]
> [  929.071239][ T5136]  drm_ioctl+0x4d0/0xad0 [drm]
> [  929.075948][ T5136]  ? __pfx_i915_gem_execbuffer2_ioctl+0x10/0x10 [i915]
> [  929.082882][ T5136]  ? __pfx_drm_ioctl+0x10/0x10 [drm]
> [  929.088119][ T5136]  ? __fget_light+0x57/0x420
> [  929.092587][ T5136]  __x64_sys_ioctl+0x137/0x1b0
> [  929.097212][ T5136]  do_syscall_64+0x5f/0x170
> [  929.101572][ T5136]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  929.107321][ T5136] RIP: 0033:0x7f0ffa6b7c5b
> [  929.111603][ T5136] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> [  929.131013][ T5136] RSP: 002b:00007ffda154ae00 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [  929.139261][ T5136] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f0ffa6b7c5b
> [  929.147077][ T5136] RDX: 00007ffda154af10 RSI: 0000000040406469 RDI: 0000000000000004
> [  929.154890][ T5136] RBP: 00007ffda154af10 R08: 0000000000000004 R09: 0000000100000000
> [  929.162704][ T5136] R10: 00007f0ffa7a8298 R11: 0000000000000246 R12: 0000000040406469
> [  929.170515][ T5136] R13: 0000000000000004 R14: 00007f0f78200000 R15: 0000000000000002
> [  929.178329][ T5136]  </TASK>
> [  929.181207][ T5136] ---[ end trace 0000000000000000 ]---
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

-- 
Kees Cook
