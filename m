Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7688C18EFF5;
	Mon, 30 Sep 2024 13:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727701967; cv=none; b=VFfoTg8Te7oxi2ob9xuR4bsmy31fhZvTcxPTDy9iYOs8e6COB8B3IxXmOdn4W44VKx+6UpJvEmMSV6d4b9vZr7VDa9s895C310nn1SIXf9SChxiPSH7zqOIvLh+lyHnWuzD/eH+SiM6RNG/SZhL3ueYwBPhZoPH7gZI87ZgJ+c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727701967; c=relaxed/simple;
	bh=DPTNjDOirV9vCnv9+SYnYKfD9MRoiUqF2VPw2GIoLDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOlm6ksSwoMLSgYQ3igXB586bykp5F4oGA93Vut7y9SKus5H0aBrSHvq4gqOq5m7Fb+JGn1NDKpdDEX120qeyTtSK9rZ7dVVb+KZffYfLuG5fsmIoIb2wQudCNcO/nyhLiokPBLSFkZvPYRxr9bzWXS0CcKYwPpIEOw0JWL5vkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JHLrhoFU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JHLrhoFU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D601C4CEC7;
	Mon, 30 Sep 2024 13:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727701966;
	bh=DPTNjDOirV9vCnv9+SYnYKfD9MRoiUqF2VPw2GIoLDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JHLrhoFUeARxVC6vdoZTkkJR+mSwF3Wb4D5OBui1aqOnOwlrMHUDKSdNDrmfYmcdv
	 6KAM29bK92Y4gMWBUkyP6+bE/M45HWEcg/b3VvF5xxQt0R1wVQ/tyeeb5mXQt07QHn
	 ZezHXJpjNkf9dBT98cKH+mVtPtyFdswEh+7gqyaQ=
Date: Mon, 30 Sep 2024 15:12:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Li XingYang <lixingyang1@qq.com>
Cc: kees@kernel.org, tony.luck@intel.com, gpiccoli@igalia.com,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zach Wade <zachwade.k@gmail.com>
Subject: Re: [PATCH] pstore: Fix uaf when backend is unregistered
Message-ID: <2024093032-creamer-backhand-57bb@gregkh>
References: <tencent_B2753AAC8B944F98A6F9387CECDEEBDA210A@qq.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_B2753AAC8B944F98A6F9387CECDEEBDA210A@qq.com>

On Sun, Sep 29, 2024 at 08:43:37PM +0800, Li XingYang wrote:
> when unload pstore_blk, we will unlink the pstore file and
> set pos->dentry to NULL, but simple_unlink(d_inode(root), pos->dentry)
> may free inode of pos->dentry and free pos by free_pstore_private,
> this may trigger uaf. kasan report:
> 
> kernel: ==================================================================
> kernel: BUG: KASAN: slab-use-after-free in pstore_put_backend_records+0x3a4/0x480
> kernel: Write of size 8 at addr ffff8883efbe0390 by task modprobe/4308
> kernel:
> kernel: CPU: 1 PID: 4308 Comm: modprobe Kdump: loaded Not tainted 6.10.9-arch1-2 #2 5fd36c90225554e2cc88363729bd91e76130a89f
> kernel: Hardware name: ASUS System Product Name/TUF GAMING X670E-PLUS, BIOS 3024 08/02/2024
> kernel: Call Trace:
> kernel:  <TASK>
> kernel:  dump_stack_lvl+0x5d/0x80
> kernel:  print_report+0x174/0x505
> kernel:  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> kernel:  ? pstore_put_backend_records+0x3a4/0x480
> kernel:  kasan_report+0xd0/0x150
> kernel:  ? pstore_put_backend_records+0x3a4/0x480
> kernel:  pstore_put_backend_records+0x3a4/0x480
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  pstore_unregister+0x88/0x1b0
> kernel:  unregister_pstore_zone+0x2f/0xd0 [pstore_zone 35171c701a99c31efe207b7a718dc583e4a6503a]
> kernel:  pstore_blk_exit+0x30/0x90 [pstore_blk 589d82101219208d8968e3adda9b96a2d42df635]
> kernel:  __do_sys_delete_module+0x350/0x560
> kernel:  ? __pfx___do_sys_delete_module+0x10/0x10
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? __memcg_slab_free_hook+0x28e/0x470
> kernel:  ? __pfx___audit_syscall_exit+0x10/0x10
> kernel:  do_syscall_64+0x82/0x190
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? do_syscall_64+0x8e/0x190
> kernel:  ? seq_read_iter+0x62f/0x1220
> kernel:  ? __x64_sys_openat+0x300/0x380
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? kasan_save_track+0x14/0x30
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? vfs_read+0x9a7/0xf00
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? __audit_syscall_exit+0x38a/0x520
> kernel:  ? __pfx_vfs_read+0x10/0x10
> kernel:  ? __pfx___audit_syscall_exit+0x10/0x10
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? __audit_syscall_exit+0x38a/0x520
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? __pfx___audit_syscall_exit+0x10/0x10
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? __x64_sys_read+0x162/0x250
> kernel:  ? __pfx___x64_sys_read+0x10/0x10
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? syscall_exit_to_user_mode_prepare+0x148/0x170
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? syscall_exit_to_user_mode+0x73/0x1f0
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? do_syscall_64+0x8e/0x190
> kernel:  ? syscall_exit_to_user_mode+0x73/0x1f0
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> kernel: RIP: 0033:0x741f9d72946b
> kernel: Code: 73 01 c3 48 8b 0d a5 c8 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 75 c8 0c 00 f7 d8 64 89 01 48
> kernel: RSP: 002b:00007ffed7e621f8 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
> kernel: RAX: ffffffffffffffda RBX: 00006455e060ed30 RCX: 0000741f9d72946b
> kernel: RDX: 0000000000000000 RSI: 0000000000000800 RDI: 00006455e060ed98
> kernel: RBP: 00007ffed7e62220 R08: 1999999999999999 R09: 0000000000000000
> kernel: R10: 0000741f9d7a5fe0 R11: 0000000000000206 R12: 0000000000000000
> kernel: R13: 00007ffed7e62250 R14: 0000000000000000 R15: 0000000000000000
> kernel:  </TASK>
> kernel:
> kernel: Allocated by task 3957:
> kernel:  kasan_save_stack+0x30/0x50
> kernel:  kasan_save_track+0x14/0x30
> kernel:  __kasan_kmalloc+0xaa/0xb0
> kernel:  pstore_mkfile+0x47e/0xbe0
> kernel:  pstore_get_backend_records+0x560/0x920
> kernel:  pstore_get_records+0xec/0x180
> kernel:  pstore_register+0x1c3/0x5a0
> kernel:  register_pstore_zone.cold+0x298/0x3d1 [pstore_zone]
> kernel:  pstore_blk_init+0x63c/0xff0 [pstore_blk]
> kernel:  do_one_initcall+0xa4/0x380
> kernel:  do_init_module+0x28a/0x7c0
> kernel:  load_module+0x7b57/0xb020
> kernel:  init_module_from_file+0xdf/0x150
> kernel:  idempotent_init_module+0x23c/0x780
> kernel:  __x64_sys_finit_module+0xbe/0x130
> kernel:  do_syscall_64+0x82/0x190
> kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> kernel:
> kernel: Freed by task 4308:
> kernel:  kasan_save_stack+0x30/0x50
> kernel:  kasan_save_track+0x14/0x30
> kernel:  kasan_save_free_info+0x3b/0x60
> kernel:  __kasan_slab_free+0x12c/0x1b0
> kernel:  kfree+0x198/0x3b0
> kernel:  evict+0x33d/0xab0
> kernel:  __dentry_kill+0x17f/0x590
> kernel:  dput+0x2d9/0x810
> kernel:  simple_unlink+0xf4/0x140
> kernel:  pstore_put_backend_records+0x271/0x480
> kernel:  pstore_unregister+0x88/0x1b0
> kernel:  unregister_pstore_zone+0x2f/0xd0 [pstore_zone]
> kernel:  pstore_blk_exit+0x30/0x90 [pstore_blk]
> kernel:  __do_sys_delete_module+0x350/0x560
> kernel:  do_syscall_64+0x82/0x190
> kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> kernel:
> kernel: The buggy address belongs to the object at ffff8883efbe0380
>                                     which belongs to the cache kmalloc-64 of size 64
> kernel: The buggy address is located 16 bytes inside of
>                                     freed 64-byte region [ffff8883efbe0380, ffff8883efbe03c0)
> kernel:
> kernel: The buggy address belongs to the physical page:
> kernel: page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3efbe0
> kernel: memcg:ffff8883ef245801
> kernel: flags: 0x2ffff8000000000(node=0|zone=2|lastcpupid=0x1ffff)
> kernel: page_type: 0xffffefff(slab)
> kernel: raw: 02ffff8000000000 ffff88810004c8c0 ffffea00043dcc40 dead000000000004
> kernel: raw: 0000000000000000 0000000000200020 00000001ffffefff ffff8883ef245801
> kernel: page dumped because: kasan: bad access detected
> kernel:
> kernel: Memory state around the buggy address:
> kernel:  ffff8883efbe0280: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> kernel:  ffff8883efbe0300: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
> kernel: >ffff8883efbe0380: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> kernel:                          ^
> kernel:  ffff8883efbe0400: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> kernel:  ffff8883efbe0480: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
> kernel: ==================================================================
> kernel: Disabling lock debugging due to kernel taint
> kernel: pstore: Unregistered pstore_blk as persistent store backend
> kernel: ------------[ cut here ]------------
> 
> place the pos->dentry = NULL before simple_unlink(d_inode(root), pos->dentry)
> 
> Fixes: 609e28bb139e ("pstore: Remove filesystem records when backend is unregistered")
> Signed-off-by: Li XingYang <lixingyang1@qq.com>
> Signed-off-by: Zach Wade <zachwade.k@gmail.com>
> ---
>  fs/pstore/inode.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
