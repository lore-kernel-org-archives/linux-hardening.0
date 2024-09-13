Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CA647A73;
	Fri, 13 Sep 2024 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726245993; cv=none; b=BkI4GagSbOjVTNM8YtzMomRjvgZMbS1FsCkzBnpuoBPmgC95YrUEEAtKWDu98hQtegvJfVPWEvf+5HU36+iw2HTNe81N5YKALMEVgLY/2GK0sQa1NbJRzLggWG++HY78wmxxPlliQhaMW2i+8Cn5Wa+pkN2kPfwHFbe5TjRgICk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726245993; c=relaxed/simple;
	bh=Xf9yhGxbYsPVbBubiSfRm3OAwS9A2rfwksrzPpACNl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgVSDtYp24tzEKVe9usDcqPwjp25QH5wkYMbforZ+dQxG0J7KeInmsCfKPR9VKL2qka1bS6l+eQMiRMwFGVCdu/ywBe4iGwEiu43x/rIoVxwJeFKUOrDVgoJFoqb+YvPfPPTAcPllzGy65/JkOuPJvwBfGLJRQobKkRaGUCIejM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQqEeJXW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQqEeJXW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F70C4CEC0;
	Fri, 13 Sep 2024 16:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726245992;
	bh=Xf9yhGxbYsPVbBubiSfRm3OAwS9A2rfwksrzPpACNl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZQqEeJXWeF+fpZFyFMurAx/7lnM0WcNE+IXkKdc0CS/hF7VNIGa0bToYo1Ro7ORf3
	 OsuUi6hB4atQ/XmQxt9Xn2xDnmRmDwSPHTlqPbswggmJXngEv58LAStnOTEgpcxGlp
	 ow1FqVTea7TipJNmKeMhBYQ0scCy2qb1d2cRvc9G5PqlekcffGxOWnOsDVwMfqGRs6
	 o5T034zJq/OuJqv+h5ZvS4RrmaitzZ3E9NC95JjURWcgNi9JgbvZCIqo34AU20Pdr9
	 J5RgUain9X3w+n28sxbMKZgucVfuznQmPL8h/KBLYV7guKozKYUgoDsZ58gFM3JMht
	 3k2OwlGYnMeVg==
Date: Fri, 13 Sep 2024 09:46:30 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: kees@kernel.org, gustavoars@kernel.org,
	andriy.shevchenko@linux.intel.com, mcgrof@kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2] params: Annotate struct module_param_attrs
 with __counted_by()
Message-ID: <20240913164630.GA4091534@thelio-3990X>
References: <20240909162725.1805-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909162725.1805-2-thorsten.blum@toblux.com>

Hi Thorsten,

On Mon, Sep 09, 2024 at 06:27:26PM +0200, Thorsten Blum wrote:
> Add the __counted_by compiler attribute to the flexible array member
> attrs to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Increment num before adding a new param_attribute to the attrs array and
> adjust the array index accordingly. Increment num immediately after the
> first reallocation such that the reallocation for the NULL terminator
> only needs to add 1 (instead of 2) to mk->mp->num.
> 
> Use struct_size() instead of manually calculating the size for the
> reallocation.
> 
> Use krealloc_array() for the additional NULL terminator.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
> Changes in v2:
> - Use krealloc_array() as suggested by Andy Shevchenko
> - Link to v1: https://lore.kernel.org/linux-kernel/20240823123300.37574-1-thorsten.blum@toblux.com/
> ---
>  kernel/params.c | 29 +++++++++++++----------------
>  1 file changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/params.c b/kernel/params.c
> index 2e447f8ae183..5f6643676697 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -551,7 +551,7 @@ struct module_param_attrs
>  {
>  	unsigned int num;
>  	struct attribute_group grp;
> -	struct param_attribute attrs[];
> +	struct param_attribute attrs[] __counted_by(num);
>  };
>  
>  #ifdef CONFIG_SYSFS
> @@ -651,35 +651,32 @@ static __modinit int add_sysfs_param(struct module_kobject *mk,
>  	}
>  
>  	/* Enlarge allocations. */
> -	new_mp = krealloc(mk->mp,
> -			  sizeof(*mk->mp) +
> -			  sizeof(mk->mp->attrs[0]) * (mk->mp->num + 1),
> +	new_mp = krealloc(mk->mp, struct_size(mk->mp, attrs, mk->mp->num + 1),
>  			  GFP_KERNEL);
>  	if (!new_mp)
>  		return -ENOMEM;
>  	mk->mp = new_mp;
> +	mk->mp->num++;
>  
>  	/* Extra pointer for NULL terminator */
> -	new_attrs = krealloc(mk->mp->grp.attrs,
> -			     sizeof(mk->mp->grp.attrs[0]) * (mk->mp->num + 2),
> -			     GFP_KERNEL);
> +	new_attrs = krealloc_array(mk->mp->grp.attrs, mk->mp->num + 1,
> +				   sizeof(mk->mp->grp.attrs[0]), GFP_KERNEL);
>  	if (!new_attrs)
>  		return -ENOMEM;
>  	mk->mp->grp.attrs = new_attrs;
>  
>  	/* Tack new one on the end. */
> -	memset(&mk->mp->attrs[mk->mp->num], 0, sizeof(mk->mp->attrs[0]));
> -	sysfs_attr_init(&mk->mp->attrs[mk->mp->num].mattr.attr);
> -	mk->mp->attrs[mk->mp->num].param = kp;
> -	mk->mp->attrs[mk->mp->num].mattr.show = param_attr_show;
> +	memset(&mk->mp->attrs[mk->mp->num - 1], 0, sizeof(mk->mp->attrs[0]));
> +	sysfs_attr_init(&mk->mp->attrs[mk->mp->num - 1].mattr.attr);
> +	mk->mp->attrs[mk->mp->num - 1].param = kp;
> +	mk->mp->attrs[mk->mp->num - 1].mattr.show = param_attr_show;
>  	/* Do not allow runtime DAC changes to make param writable. */
>  	if ((kp->perm & (S_IWUSR | S_IWGRP | S_IWOTH)) != 0)
> -		mk->mp->attrs[mk->mp->num].mattr.store = param_attr_store;
> +		mk->mp->attrs[mk->mp->num - 1].mattr.store = param_attr_store;
>  	else
> -		mk->mp->attrs[mk->mp->num].mattr.store = NULL;
> -	mk->mp->attrs[mk->mp->num].mattr.attr.name = (char *)name;
> -	mk->mp->attrs[mk->mp->num].mattr.attr.mode = kp->perm;
> -	mk->mp->num++;
> +		mk->mp->attrs[mk->mp->num - 1].mattr.store = NULL;
> +	mk->mp->attrs[mk->mp->num - 1].mattr.attr.name = (char *)name;
> +	mk->mp->attrs[mk->mp->num - 1].mattr.attr.mode = kp->perm;
>  
>  	/* Fix up all the pointers, since krealloc can move us */
>  	for (i = 0; i < mk->mp->num; i++)
> -- 
> 2.46.0
> 

I just bisected this change to a fortify failure that I see with a
couple different ARM configurations when built with a version of clang
that supports __counted_by(). I can reproduce this with:

  $ curl -LSso .config https://gist.github.com/nathanchance/6df4bd2ab4c4418020b3ed5417ef4f80/raw/758abf666dfe8c76e0f16735f336849ea47ef791/.config

  $ make -skj"$(nproc)" ARCH=arm LLVM=1 olddefconfig zImage

  $ curl -LSs https://github.com/ClangBuiltLinux/boot-utils/releases/download/20230707-182910/arm-rootfs.cpio.zst | zstd -d >rootfs.cpio

  $ qemu-system-arm \
      -display none \
      -nodefaults \
      -no-reboot \
      -machine virt \
      -append 'console=ttyAMA0 earlycon' \
      -kernel arch/arm/boot/zImage \
      -initrd rootfs.cpio \
      -m 512m \
      -serial mon:stdio
  [    0.000000] Booting Linux on physical CPU 0x0
  [    0.000000] Linux version 6.11.0-rc4+ (nathan@thelio-3990X) (ClangBuiltLinux clang version 19.1.0-rc4 (https://github.com/llvm/llvm-project.git 0c641568515a797473394694f05937e1f1913d87), ClangBuiltLinux LLD 19.1.0 (https://github.com/llvm/llvm-project.git 0c641568515a797473394694f05937e1f1913d87)) #1 SMP Fri Sep 13 09:36:38 MST 2024
  ...
  [    0.623959] ------------[ cut here ]------------
  [    0.624158] WARNING: CPU: 0 PID: 1 at lib/string_helpers.c:1030 __fortify_report+0x64/0x6c
  [    0.625050] memset: detected buffer overflow: 32 byte write of buffer size 0
  [    0.625297] Modules linked in:
  [    0.625712] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-rc4+ #1
  [    0.626008] Hardware name: Generic DT based system
  [    0.626274] Call trace:
  [    0.626342]  unwind_backtrace from show_stack+0x28/0x2c
  [    0.626690]  show_stack from dump_stack_lvl+0x34/0x70
  [    0.626936]  dump_stack_lvl from __warn+0xe0/0x200
  [    0.627100]  __warn from warn_slowpath_fmt+0xc8/0x194
  [    0.627335]  warn_slowpath_fmt from __fortify_report+0x64/0x6c
  [    0.627551]  __fortify_report from __fortify_panic+0x8/0xc
  [    0.627739]  __fortify_panic from add_sysfs_param+0x224/0x228
  [    0.627927]  add_sysfs_param from kernel_add_sysfs_param+0x5c/0xa0
  [    0.628206]  kernel_add_sysfs_param from param_sysfs_builtin+0xf4/0x130
  [    0.628412]  param_sysfs_builtin from param_sysfs_builtin_init+0x30/0x38
  [    0.628649]  param_sysfs_builtin_init from do_one_initcall+0xd0/0x2d4
  [    0.628869]  do_one_initcall from do_initcall_level+0x9c/0x104
  [    0.629068]  do_initcall_level from do_initcalls+0x74/0xb0
  [    0.629254]  do_initcalls from kernel_init_freeable+0x10c/0x158
  [    0.629452]  kernel_init_freeable from kernel_init+0x20/0x1cc
  [    0.629654]  kernel_init from ret_from_fork+0x14/0x28
  [    0.629872] Exception stack(0xe080dfb0 to 0xe080dff8)
  [    0.630108] dfa0:                                     00000000 00000000 00000000 00000000
  [    0.630391] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
  [    0.630656] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
  [    0.631064] ---[ end trace 0000000000000000 ]---
  [    0.631800] ------------[ cut here ]------------
  [    0.631989] kernel BUG at lib/string_helpers.c:1037!
  [    0.632175] Internal error: Oops - BUG: 0 [#1] SMP ARM
  [    0.632472] Modules linked in:
  [    0.632761] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.11.0-rc4+ #1
  [    0.633077] Tainted: [W]=WARN
  [    0.633186] Hardware name: Generic DT based system
  [    0.633357] PC is at __fortify_panic+0x8/0xc
  [    0.633521] LR is at __warn+0x16c/0x200
  [    0.633668] pc : [<c0f6daa8>]    lr : [<c035300c>]    psr: 60000013
  [    0.633878] sp : e080db98  ip : 00000000  fp : e080dbb8
  [    0.634059] r10: 6e72656b  r9 : 006c656e  r8 : c1000009
  [    0.634240] r7 : fffffff4  r6 : c135947c  r5 : c13d5ebc  r4 : c2466f00
  [    0.634470] r3 : 00000200  r2 : 00000000  r1 : 244cee50  r0 : 244cee50
  [    0.634738] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
  [    0.634987] Control: 10c5387d  Table: 423ec06a  DAC: 00000051
  [    0.635206] Register r0 information: non-paged memory
  [    0.635559] Register r1 information: non-paged memory
  [    0.635745] Register r2 information: NULL pointer
  [    0.635917] Register r3 information: non-paged memory
  [    0.636100] Register r4 information: slab kmalloc-64 start c2466f00 pointer offset 0 size 64
  [    0.636772] Register r5 information: non-slab/vmalloc memory
  [    0.637001] Register r6 information: non-slab/vmalloc memory
  [    0.637205] Register r7 information: non-paged memory
  [    0.637385] Register r8 information: non-slab/vmalloc memory
  [    0.637597] Register r9 information: non-paged memory
  [    0.637791] Register r10 information: non-paged memory
  [    0.637977] Register r11 information: 2-page vmalloc region starting at 0xe080c000 allocated at copy_process+0x17c/0xf18
  [    0.638382] Register r12 information: NULL pointer
  [    0.638569] Process swapper/0 (pid: 1, stack limit = 0x8a022d6d)
  [    0.639040] Stack: (0xe080db98 to 0xe080e000)
  [    0.639194] db80:                                                       e080dbb8 c037f5f8
  [    0.639462] dba0: c2466f00 c13d5ebc 00000000 c1000009 e080dbd8 6e72656b e080dbd0 c151d860
  [    0.639728] dbc0: c13d5ebc c13d6dbc 00000000 6e72656b e080dc38 c151d6d8 6e72656b 00006c65
  [    0.639993] dbe0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
  [    0.640261] dc00: 00000000 00000000 00000000 00000000 00000000 00000000 244cee50 c1655918
  [    0.640531] dc20: c215c200 c21f9300 c170f458 c151d4f8 00000000 00000000 e080dc40 c151d528
  [    0.640795] dc40: e080df40 c0302398 5e4e6cd4 ef580029 00000000 00000000 00000000 00000000
  [    0.641067] dc60: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
  [    0.641330] dc80: 00000000 00000000 00000000 00000000 ffffffff 00000000 c18926ac 00000080
  [    0.641599] dca0: 000000b0 c061cb68 debbd794 debbd794 00000000 c21fd000 e080dce8 c061cb68
  [    0.641863] dcc0: 244cee50 00000001 00000801 debbd794 00000000 00000801 c1892640 00000000
  [    0.642126] dce0: c1893440 e080ddd0 e080ddb0 c061e2ec deb63e40 deb63e5c 00000000 00052cc0
  [    0.642390] dd00: 00000001 00000001 000000b0 00000001 00000000 00000000 00000000 00000064
  [    0.642657] dd20: 0000006c 00000080 00000001 e080ddd0 00000000 00000000 00000000 00000001
  [    0.642923] dd40: 00000000 00000000 00000000 00000001 00000000 00000000 00000001 00000000
  [    0.643187] dd60: c1892930 00000000 00000000 244cee50 00000000 00000000 00000000 00000000
  [    0.643451] dd80: 00000801 7ffe0000 c1892640 c0b3c530 244cee50 00000000 00052cc0 00000001
  [    0.643724] dda0: 00000008 00000001 00052cc0 00000000 e080de08 c061cddc 00000820 c0775f50
  [    0.643992] ddc0: 00000000 c215c200 00000000 00052cc0 c1893440 00000000 c1893440 244cee50
  [    0.644259] dde0: 00000020 debbd794 7ffe0000 c062c97c c21329c0 debbd794 0000000e 00000020
  [    0.644532] de00: 00000080 7ffe0000 e080de40 c062c97c c20a763c 00000020 e080de28 c0f74fc0
  [    0.644800] de20: 244cee50 00000000 00000080 c2133e80 00000000 7fff0000 c21329c0 deb64100
  [    0.645066] de40: e080dea0 c062a584 c21c1180 c17cb818 0fffffff 00000001 e080ded4 c0f655d8
  [    0.645330] de60: 00000000 00000001 c2132a48 ffffffff 00000000 c0f43544 ffff0a01 c0f71f18
  [    0.645592] de80: e080df20 c0f71f18 244cee50 c21c1180 00000cc0 e080ded4 00000079 00000000
  [    0.645857] dea0: 0fffffff 00000001 00000000 c0f43544 c071ca3c 00000003 00000dc0 00000000
  [    0.646121] dec0: 00000cc0 00000000 0003ffff 80000053 c21fd66c c17cb818 00000000 00000000
  [    0.646121] dec0: 00000cc0 00000000 0003ffff 80000053 c21fd66c c17cb818 00000000 00000000
  [    0.646391] dee0: 00000000 00000000 000000c0 c13d6dbc 00000000 c037e2ec 000000c0 c037e328
  [    0.646663] df00: e080df40 c037e328 c21fd600 00000000 c12e093d c13d5ebc 00000000 244cee50
  [    0.646929] df20: 244cee50 c1655918 c1655aa0 c21f9300 deffff00 c13578a8 00000000 00000000
  [    0.647197] df40: e080df68 c1501898 00000007 00000007 00000000 c1501900 00000019 c21f9300
  [    0.647462] df60: 00000007 00000000 e080df88 c15017c0 c2143a00 c215c200 00000000 00000000
  [    0.647736] df80: 00000000 00000000 e080df98 c150163c 00000000 c0f6fa60 e080dfa8 c0f6fa80
  [    0.648006] dfa0: 00000000 00000000 00000000 c030016c 00000000 00000000 00000000 00000000
  [    0.648273] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
  [    0.648536] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
  [    0.648801] Call trace:
  [    0.648840]  __fortify_panic from add_sysfs_param+0x224/0x228
  [    0.649129]  add_sysfs_param from kernel_add_sysfs_param+0x5c/0xa0
  [    0.649348]  kernel_add_sysfs_param from param_sysfs_builtin+0xf4/0x130
  [    0.649572]  param_sysfs_builtin from param_sysfs_builtin_init+0x30/0x38
  [    0.649801]  param_sysfs_builtin_init from do_one_initcall+0xd0/0x2d4
  [    0.650021]  do_one_initcall from do_initcall_level+0x9c/0x104
  [    0.650223]  do_initcall_level from do_initcalls+0x74/0xb0
  [    0.650412]  do_initcalls from kernel_init_freeable+0x10c/0x158
  [    0.650612]  kernel_init_freeable from kernel_init+0x20/0x1cc
  [    0.650810]  kernel_init from ret_from_fork+0x14/0x28
  [    0.650984] Exception stack(0xe080dfb0 to 0xe080dff8)
  [    0.651164] dfa0:                                     00000000 00000000 00000000 00000000
  [    0.651427] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
  [    0.651697] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
  [    0.652032] Code: e8bd4bf0 eae457a7 e92d4800 ebe4aaef (e7f001f2)
  [    0.652584] ---[ end trace 0000000000000000 ]---
  [    0.652825] note: swapper/0[1] exited with irqs disabled
  [    0.653314] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
  [    0.654033] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---

I haven't had a chance to really look over this too much but I figured I
would get the report out sooner rather than later, especially with the
merge window being around the corner. If there is any other information
I can provide or patches I can test, I am more than happy to do so.

Cheers,
Nathan

# bad: [57f962b956f1d116cd64d5c406776c4975de549d] Add linux-next specific files for 20240912
# good: [77f587896757708780a7e8792efe62939f25a5ab] Merge tag 'arm-fixes-6.11-3' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect start '57f962b956f1d116cd64d5c406776c4975de549d' '77f587896757708780a7e8792efe62939f25a5ab'
# good: [5e6a31306949eb18be8d6dc7ad6c42f8bea8e743] Merge branch 'main' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect good 5e6a31306949eb18be8d6dc7ad6c42f8bea8e743
# bad: [9802faa85f4ccbc8cc0893fe76b939a9c56b9e62] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
git bisect bad 9802faa85f4ccbc8cc0893fe76b939a9c56b9e62
# good: [793a135214a81488066fb8ccecbd4f182c416326] drm/xe/mmio: Drop compatibility macros
git bisect good 793a135214a81488066fb8ccecbd4f182c416326
# good: [d8bfeb4282b1c55342d2dd946eaf00f4f13785db] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git
git bisect good d8bfeb4282b1c55342d2dd946eaf00f4f13785db
# bad: [f5315deb662e813be5fa93f2b67d46fe9fcd383c] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
git bisect bad f5315deb662e813be5fa93f2b67d46fe9fcd383c
# good: [4b1d9019b26fd654ebc2d0d2e100ed56ef1821f0] ASoC: dt-bindings: amlogic,axg-sound-card: document clocks property
git bisect good 4b1d9019b26fd654ebc2d0d2e100ed56ef1821f0
# bad: [2ca98b409c36e91bb359a2997f4a7810e799bd62] Merge branch 'modules-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git
git bisect bad 2ca98b409c36e91bb359a2997f4a7810e799bd62
# good: [d39b510a145a4766906cd49177695913d6e6bfd2] Add audio support for the MediaTek Genio 350-evk
git bisect good d39b510a145a4766906cd49177695913d6e6bfd2
# good: [43fbb2c702663d7af844ee952aec224a0e059e26] ASoC: loongson: Simplify code formatting
git bisect good 43fbb2c702663d7af844ee952aec224a0e059e26
# good: [0b0aa67baa8904e3c1e13be48a2ca125f59ead3d] ASoC: amd: acp: remove MODULE_ALIAS for sof based generic machine driver
git bisect good 0b0aa67baa8904e3c1e13be48a2ca125f59ead3d
# good: [8905d39085c60a13d47bd07d2766bfdde933cc8d] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
git bisect good 8905d39085c60a13d47bd07d2766bfdde933cc8d
# good: [907fa79d787f6f762c0afb67b8b02be8ed1f7bd2] MAINTAINERS: scale modules with more reviewers
git bisect good 907fa79d787f6f762c0afb67b8b02be8ed1f7bd2
# bad: [e1d90ff7bc4b93c0b6c4821bef71b51ce145d7a7] module: abort module loading when sysfs setup suffer errors
git bisect bad e1d90ff7bc4b93c0b6c4821bef71b51ce145d7a7
# bad: [7125cb974977aa80959817548b5221314fe46bc0] params: Annotate struct module_param_attrs with __counted_by()
git bisect bad 7125cb974977aa80959817548b5221314fe46bc0
# first bad commit: [7125cb974977aa80959817548b5221314fe46bc0] params: Annotate struct module_param_attrs with __counted_by()
