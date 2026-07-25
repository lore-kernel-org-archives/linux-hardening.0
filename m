Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E49392C46
	for <linux-hardening@vger.kernel.org>; Sat, 25 Jul 2026 05:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784958307; cv=none; b=OIoLIL4rgdvXgvTDRndKPZWD22ZQ2kdqTBq1EyfJqgjdH5UX6lZ6B8+JjLm1iYwBQ/QrT2I24/lxzLfJydIbPgGvK1x14tTfT1e9VB3W3ZQwaVza+xqKxZYn8QC4xo4ffsr2y3Gn1t30asf9rul0m2svRq80c/INaditN+psbIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784958307; c=relaxed/simple;
	bh=YdkEbCv52sWCoQxxCcrz4pUAVt/pXjTErTBRbIw9CbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CeVSWyYoqjtnrJxbNkIjRhM2Hxif+5mh+KIAQQP0J51/7TEM6IGIGWGlfFH5URtO4gl2w3G1gq7HupmjuaFfEtBldoP8+VJ0QRPw8idLAM2hJYDFSpGxCgjq9VPoKP+00YnqduoYIds/ll0uvn6PMltin81FPlYXwZ1E/IpWOfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmBJWFAb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmBJWFAb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90E81F000E9
	for <linux-hardening@vger.kernel.org>; Sat, 25 Jul 2026 05:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784958304;
	bh=t3qBjNX9IGmyjU2kexl4//bO2wn+DnODKQrpG0AjYwc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=LmBJWFAbLlQ7K5WSuxkohr0/P2tyJac1WkR4DSSqYH41/0xJD2A8FU0uZvVfHJ/km
	 ehzxvQgwpP8bx54m1Qj04j+bAYbgD1R/zHOfckfIJMnfsv+TSsdZtlEqU9YALD7aQm
	 r2xeabZnFOGriOinu46S5bRnUgQF0zvXm13twtYpnLLQLixvrBnsDWK2cDwRkO8JRA
	 35xSlyPLDSspkFga2wtiw2pWxB2yPmVoYdxMGRVtvDcNUe/MG2J/Ak/xFbCzT4UgJN
	 SAWfxQ4EmNH/o3L1nqfTt7T+4H+m4uJ/TR0xJh7wkmNMmL0dtoXV3vlYRWHCE1UAOY
	 +iEudIuj6qhMw==
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-930c0f9c1b1so101349885a.1
        for <linux-hardening@vger.kernel.org>; Fri, 24 Jul 2026 22:45:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqsOzOCOtIaBsFJhWeH767O6450YART3+mTuR/mds3N9rxyok0gKuOHOj31t3b2v/NL5G66Ii0rN8rIHyyt0E8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTzYbSIsvGuIOYxwZ91OeXbuk2v5ol1t1Um1S+GoRuLh6mcAWh
	dr1pc/0e0ZWJWcyE9nrHm4W/Sjb9Sdhr/1JEaHzqPj7hsQkzOCUAkse1mboGuL5Kr4faIEshXoH
	pwEetMOyCUfQbACBgO8dHdquEqAYk0CM=
X-Received: by 2002:a05:620a:4008:b0:92e:5856:bdcd with SMTP id
 af79cd13be357-932df708b5amr90245385a.53.1784958304055; Fri, 24 Jul 2026
 22:45:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722142936.3287702-1-dev.jain@arm.com>
In-Reply-To: <20260722142936.3287702-1-dev.jain@arm.com>
From: Barry Song <baohua@kernel.org>
Date: Sat, 25 Jul 2026 13:44:52 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wetarsg0fFvNdeWrCa+Ka97jjmgdRsmPJJZbUFyUxjEw@mail.gmail.com>
X-Gm-Features: AUfX_mxNkc16w4WJcIVQZjkpKej00po33fTMdmd1bQ675RV-4AjKTHcthRpmOqY
Message-ID: <CAGsJ_4wetarsg0fFvNdeWrCa+Ka97jjmgdRsmPJJZbUFyUxjEw@mail.gmail.com>
Subject: Re: [PATCH] mm/usercopy: harden bounds checking for vmalloc allocations
To: Dev Jain <dev.jain@arm.com>
Cc: kees@kernel.org, akpm@linux-foundation.org, gustavoars@kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, ryan.roberts@arm.com, anshuman.khandual@arm.com, 
	david@kernel.org, urezki@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 10:43=E2=80=AFPM Dev Jain <dev.jain@arm.com> wrote:
>
> The vmalloc allocator stores the actual allocation size inside the
> vm_struct structure. We can use this bound in usercopy instead of the
> page-aligned va_end to catch usercopy beyond the actual allocation size.
>
> For vmap, the requested_size field is always page-aligned since it maps a
> certain number of pages. Same for vm_map_ram (alongwith, not even having
> a vm_struct). So the check is only relevant for vmalloc mappings.
>
> Because there are early vm areas registered even before vmalloc_init,
> requested_size may be zero. So also check whether the requested_size
> is set.
>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---

I wrote the test module below to verify the impact on user-space behavior.

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/proc_fs.h>
#include <linux/uaccess.h>
#include <linux/vmalloc.h>

#define PROC_NAME "copy_bug"

static ssize_t copy_bug_read(struct file *file, char __user *buf,
size_t count, loff_t *ppos)
{
        volatile int alloc_len =3D 5 * 1024, copy_len =3D 6 * 1024;
        void *kbuf;
        int ret;

        if (*ppos)
                return 0;

        kbuf =3D vmalloc(alloc_len);
        if (!kbuf)
                return -ENOMEM;
        memset(kbuf, 0, alloc_len);

        ret =3D copy_to_user(buf, kbuf, copy_len);
        pr_info("copy_bug: copy_to_user returned %d count:%ld\n", ret, coun=
t);
        vfree(kbuf);
        return count;
}

static const struct proc_ops copy_bug_ops =3D {
        .proc_read =3D copy_bug_read,
};

static int __init copy_bug_init(void)
{
        proc_create(PROC_NAME, 0444, NULL, &copy_bug_ops);
        return 0;
}

static void __exit copy_bug_exit(void)
{
        remove_proc_entry(PROC_NAME, NULL);
}

module_init(copy_bug_init);
module_exit(copy_bug_exit);
MODULE_LICENSE("GPL");

without the patch:
/ # cat /proc/copy_bug
[    6.517711] copy_bug: copy_to_user returned 0 count:131072
[    6.655611] copy_bug: copy_to_user returned 0 count:131072
[    6.783372] copy_bug: copy_to_user returned 0 count:131072
[    6.912167] copy_bug: copy_to_user returned 0 count:131072
[    7.039019] copy_bug: copy_to_user returned 0 count:131072

with the patch:

/ # cat /proc/copy_bug
[   11.298890] usercopy: Kernel memory exposure attempt detected from
vmalloc (offset 0, size 6144)!
[   11.299246] ------------[ cut here ]------------
[   11.299276] kernel BUG at mm/usercopy.c:102!
[   11.299616] Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
[   11.300458] CPU: 1 UID: 0 PID: 74 Comm: cat Not tainted
7.2.0-rc4-g6b5aeb5cf21a-dirty #1033 PREEMPT
[   11.300730] Hardware name: linux,dummy-virt (DT)
[   11.300940] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[   11.301088] pc : usercopy_abort+0x94/0x98
[   11.301190] lr : usercopy_abort+0x94/0x98
[   11.301280] sp : ffff800083643c40
[   11.301358] x29: ffff800083643c50 x28: ffff000004373700 x27: 00000000000=
00000
[   11.301994] x26: 0000000000000000 x25: 0000000000000000 x24: 00000000000=
00001
[   11.302152] x23: 0000000000020000 x22: 0000000000000001 x21: ffff8000833=
a6800
[   11.302298] x20: 0000000000001800 x19: ffff8000833a5000 x18: 00000000fff=
fffff
[   11.302440] x17: 2820636f6c6c616d x16: 76206d6f72662064 x15: 65746365746=
56420
[   11.302580] x14: 74706d6574746120 x13: 0000000000020000 x12: 00000000000=
08000
[   11.302720] x11: ffff800082271138 x10: ffff800082181534 x9 : ffff8000801=
2842c
[   11.302878] x8 : ffff000004373700 x7 : ffff80008012782c x6 : 00000000000=
00001
[   11.303024] x5 : 0000000000001297 x4 : 0000000000000000 x3 : 00000000000=
00000
[   11.303162] x2 : 0000000000000000 x1 : ffff000004373700 x0 : 00000000000=
00055
[   11.303378] Call trace:
[   11.303572]  usercopy_abort+0x94/0x98 (P)
[   11.303744]  __check_object_size+0x1dc/0x360
[   11.303834]  copy_bug_read+0x9c/0x1a0
[   11.303910]  proc_reg_read+0xa4/0x100
[   11.303986]  vfs_read+0xcc/0x2f8
[   11.304064]  ksys_read+0x74/0x118
[   11.304134]  __arm64_sys_read+0x24/0x38
[   11.304212]  invoke_syscall+0x5c/0x120
[   11.304288]  el0_svc_common.constprop.0+0x48/0xf0
[   11.304378]  do_el0_svc+0x24/0x38
[   11.304448]  el0_svc+0x58/0x3f0
[   11.304518]  el0t_64_sync_handler+0xa0/0xe8
[   11.304598]  el0t_64_sync+0x1ac/0x1b0
[   11.304814] Code: aa0003e3 d000e3e0 91378000 97ffec92 (d4210000)
[   11.305138] ---[ end trace 0000000000000000 ]---
[   11.305390] note: cat[74] exited with irqs disabled
[   11.305542] note: cat[74] exited with preempt_count 1
[   11.307308] ------------[ cut here ]------------

So:

Tested-by: Barry Song <baohua@kernel.org>
Reviewed-by: Barry Song <baohua@kernel.org>
