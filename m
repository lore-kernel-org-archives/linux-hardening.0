Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426CD1531D2
	for <linux-hardening@vger.kernel.org>; Fri, 13 Sep 2024 23:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726270357; cv=none; b=fdz9f9pTIqXFpq/MyvaFr5mG+6qpA2LjxEOQz3oGP5Vmkbnz9tCzhtHeiCKCI+9uoLNVnnYPTVa4Jqz8z4M1Qvgtip7G/G0C17mD4iOLJOcIIgMnSypgBRYTRGPRuG3jQGBsWxP7vuz0/oWOdTpsNsZb9RyqssCyKbH23OKBrIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726270357; c=relaxed/simple;
	bh=f2n/WFZTuyWN8YlaGeQOHWsH20Dsa4QZdhuMNphSYmk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=qPRqIfPLXayza87591pXUoL+s/yzTszTsKI6KDH4yd5Ascdsy6TXGBfZLDcq/o1HYutU8CSMxlHMjmW4LHgSDnVrcl5rLNd8AKToNkraAFMdiwhmBrGd5zdbdM/4JsllMG45q42gwzJPEBNAT113UqIFvnLwY97sXtOWJolwstY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=J7OAdsAE; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="J7OAdsAE"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a866902708fso42125266b.2
        for <linux-hardening@vger.kernel.org>; Fri, 13 Sep 2024 16:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1726270352; x=1726875152; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16u6DzGmkKfR+A0pv1KM2Fp3oAIJDmhPCCpBAnLfzKk=;
        b=J7OAdsAEXfvTAAU9R1hQzACdet3j6HbMTPQLDqQOwwhi12Ph1nK3ZhZanKRjfasccW
         iL8qn8QZxcCFStU/YCIcIZQOuX+WoREFK38zIyE4xqOYZHAb8OHLEItQz+TJWWx6k1Pr
         OAzGoWdsr8CWZs2d2aNuAh8ooMnVS+ej7J+dBC7u01RalUSDQR9y0NJANk8kWH0ws7fF
         +evQbthzQwHFjP7wzuqIm4UZRQ+JscTEZxJ5ELzOCneXa/EY2zJYQnMfm/BbXnedlY5T
         nH5HmbN3fpLuMi91VwNpnbhCI4O4OrE+kKoTPGqMHPbxwtitDtoMebxpO9FtKD7/Ji2e
         JvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726270352; x=1726875152;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16u6DzGmkKfR+A0pv1KM2Fp3oAIJDmhPCCpBAnLfzKk=;
        b=Ed9gdJ3LHQig3tCNpNjLKfUaKUahlz+3n/MnEvSowDRmIU7erza/gDIDPBpavBhJal
         mxfgZMu1CpR5yn2hjyxd/6nDDjqc4TG2JCxH1Sv9AyqJMVzHUzqmDWMoGzZW+g4bGt9b
         1xg2d7v9/MHfCmcFu/C43oipq8s5/9VLOu8XlC/X56fH+SiwPIYJOXzaiIeUcEzO4Zv0
         +9vASSsYv7sKOk/3drpuCDiyGtDRqkoDzT5xc6MJ1n+aAnoINCm2L+c1oUPcO3m/BTXg
         2uIMtae7oqxBZatTVDTwzffc/E7jYEyhj8gKqltRQAXW3obSu5PJs5saT6hZTIm52TrR
         Qqaw==
X-Forwarded-Encrypted: i=1; AJvYcCX5IbfgeTw358/PJ+kpS1gARGAQt3oAvWKM7ruEcdJTbIXiV3t357bRfIS/oyeWREVRe+lQTJfOHfRvvxH8UcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBuH23X96SeLr2mT8EKToxbsaPHbhZv6q6/cE2MTbYbxz6l0R/
	WjSugvDTfj3yrQjwQzl8SxxTQJQP2kxLbrSWSYyHDyNYkMBazdS6BeLelzCFi4Bta1RyDAKzgFQ
	TaAE=
X-Google-Smtp-Source: AGHT+IGiT89bhm819dNpX9j3glZ5HLdImlO68G11HFHqGpzkMUzG1O0WPsIw2shcjyCeGKap3FH4jw==
X-Received: by 2002:a05:6402:e9e:b0:5c4:2508:aa1b with SMTP id 4fb4d7f45d1cf-5c42508ac84mr523114a12.6.1726270352214;
        Fri, 13 Sep 2024 16:32:32 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:a4f:301:c80a:ca57:56fa:ebff])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb5eb72sm95389a12.48.2024.09.13.16.32.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2024 16:32:31 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [RESEND PATCH v2] params: Annotate struct module_param_attrs with
 __counted_by()
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <20240913164630.GA4091534@thelio-3990X>
Date: Sat, 14 Sep 2024 01:32:19 +0200
Cc: kees@kernel.org,
 gustavoars@kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 mcgrof@kernel.org,
 linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <60B48C52-12A6-4810-8C8C-9CC1C1E77E68@toblux.com>
References: <20240909162725.1805-2-thorsten.blum@toblux.com>
 <20240913164630.GA4091534@thelio-3990X>
To: Nathan Chancellor <nathan@kernel.org>
X-Mailer: Apple Mail (2.3776.700.51)

Hi Nathan,

> On 13. Sep 2024, at 18:46, Nathan Chancellor <nathan@kernel.org> =
wrote:
>=20
> Hi Thorsten,
>=20
> On Mon, Sep 09, 2024 at 06:27:26PM +0200, Thorsten Blum wrote:
>> Add the __counted_by compiler attribute to the flexible array member
>> attrs to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
>> CONFIG_FORTIFY_SOURCE.
>>=20
>> Increment num before adding a new param_attribute to the attrs array =
and
>> adjust the array index accordingly. Increment num immediately after =
the
>> first reallocation such that the reallocation for the NULL terminator
>> only needs to add 1 (instead of 2) to mk->mp->num.
>>=20
>> Use struct_size() instead of manually calculating the size for the
>> reallocation.
>>=20
>> Use krealloc_array() for the additional NULL terminator.
>>=20
>> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
>> ---
>> Changes in v2:
>> - Use krealloc_array() as suggested by Andy Shevchenko
>> - Link to v1: =
https://lore.kernel.org/linux-kernel/20240823123300.37574-1-thorsten.blum@=
toblux.com/
>> ---
>> kernel/params.c | 29 +++++++++++++----------------
>> 1 file changed, 13 insertions(+), 16 deletions(-)
>>=20
>> diff --git a/kernel/params.c b/kernel/params.c
>> index 2e447f8ae183..5f6643676697 100644
>> --- a/kernel/params.c
>> +++ b/kernel/params.c
>> @@ -551,7 +551,7 @@ struct module_param_attrs
>> {
>> unsigned int num;
>> struct attribute_group grp;
>> - struct param_attribute attrs[];
>> + struct param_attribute attrs[] __counted_by(num);
>> };
>>=20
>> #ifdef CONFIG_SYSFS
>> @@ -651,35 +651,32 @@ static __modinit int add_sysfs_param(struct =
module_kobject *mk,
>> }
>>=20
>> /* Enlarge allocations. */
>> - new_mp =3D krealloc(mk->mp,
>> -  sizeof(*mk->mp) +
>> -  sizeof(mk->mp->attrs[0]) * (mk->mp->num + 1),
>> + new_mp =3D krealloc(mk->mp, struct_size(mk->mp, attrs, mk->mp->num =
+ 1),
>> GFP_KERNEL);
>> if (!new_mp)
>> return -ENOMEM;
>> mk->mp =3D new_mp;
>> + mk->mp->num++;
>>=20
>> /* Extra pointer for NULL terminator */
>> - new_attrs =3D krealloc(mk->mp->grp.attrs,
>> -     sizeof(mk->mp->grp.attrs[0]) * (mk->mp->num + 2),
>> -     GFP_KERNEL);
>> + new_attrs =3D krealloc_array(mk->mp->grp.attrs, mk->mp->num + 1,
>> +   sizeof(mk->mp->grp.attrs[0]), GFP_KERNEL);
>> if (!new_attrs)
>> return -ENOMEM;
>> mk->mp->grp.attrs =3D new_attrs;
>>=20
>> /* Tack new one on the end. */
>> - memset(&mk->mp->attrs[mk->mp->num], 0, sizeof(mk->mp->attrs[0]));
>> - sysfs_attr_init(&mk->mp->attrs[mk->mp->num].mattr.attr);
>> - mk->mp->attrs[mk->mp->num].param =3D kp;
>> - mk->mp->attrs[mk->mp->num].mattr.show =3D param_attr_show;
>> + memset(&mk->mp->attrs[mk->mp->num - 1], 0, =
sizeof(mk->mp->attrs[0]));
>> + sysfs_attr_init(&mk->mp->attrs[mk->mp->num - 1].mattr.attr);
>> + mk->mp->attrs[mk->mp->num - 1].param =3D kp;
>> + mk->mp->attrs[mk->mp->num - 1].mattr.show =3D param_attr_show;
>> /* Do not allow runtime DAC changes to make param writable. */
>> if ((kp->perm & (S_IWUSR | S_IWGRP | S_IWOTH)) !=3D 0)
>> - mk->mp->attrs[mk->mp->num].mattr.store =3D param_attr_store;
>> + mk->mp->attrs[mk->mp->num - 1].mattr.store =3D param_attr_store;
>> else
>> - mk->mp->attrs[mk->mp->num].mattr.store =3D NULL;
>> - mk->mp->attrs[mk->mp->num].mattr.attr.name =3D (char *)name;
>> - mk->mp->attrs[mk->mp->num].mattr.attr.mode =3D kp->perm;
>> - mk->mp->num++;
>> + mk->mp->attrs[mk->mp->num - 1].mattr.store =3D NULL;
>> + mk->mp->attrs[mk->mp->num - 1].mattr.attr.name =3D (char *)name;
>> + mk->mp->attrs[mk->mp->num - 1].mattr.attr.mode =3D kp->perm;
>>=20
>> /* Fix up all the pointers, since krealloc can move us */
>> for (i =3D 0; i < mk->mp->num; i++)
>> --=20
>> 2.46.0
>>=20
>=20
> I just bisected this change to a fortify failure that I see with a
> couple different ARM configurations when built with a version of clang
> that supports __counted_by(). I can reproduce this with:
>=20
> $ curl -LSso .config =
https://gist.github.com/nathanchance/6df4bd2ab4c4418020b3ed5417ef4f80/raw/=
758abf666dfe8c76e0f16735f336849ea47ef791/.config
>=20
> $ make -skj"$(nproc)" ARCH=3Darm LLVM=3D1 olddefconfig zImage
>=20
> $ curl -LSs =
https://github.com/ClangBuiltLinux/boot-utils/releases/download/20230707-1=
82910/arm-rootfs.cpio.zst | zstd -d >rootfs.cpio
>=20
> $ qemu-system-arm \
>     -display none \
>     -nodefaults \
>     -no-reboot \
>     -machine virt \
>     -append 'console=3DttyAMA0 earlycon' \
>     -kernel arch/arm/boot/zImage \
>     -initrd rootfs.cpio \
>     -m 512m \
>     -serial mon:stdio
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 6.11.0-rc4+ (nathan@thelio-3990X) =
(ClangBuiltLinux clang version 19.1.0-rc4 =
(https://github.com/llvm/llvm-project.git =
0c641568515a797473394694f05937e1f1913d87), ClangBuiltLinux LLD 19.1.0 =
(https://github.com/llvm/llvm-project.git =
0c641568515a797473394694f05937e1f1913d87)) #1 SMP Fri Sep 13 09:36:38 =
MST 2024
> ...
> [    0.623959] ------------[ cut here ]------------
> [    0.624158] WARNING: CPU: 0 PID: 1 at lib/string_helpers.c:1030 =
__fortify_report+0x64/0x6c
> [    0.625050] memset: detected buffer overflow: 32 byte write of =
buffer size 0
> [    0.625297] Modules linked in:
> [    0.625712] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted =
6.11.0-rc4+ #1
> [    0.626008] Hardware name: Generic DT based system
> [    0.626274] Call trace:
> [    0.626342]  unwind_backtrace from show_stack+0x28/0x2c
> [    0.626690]  show_stack from dump_stack_lvl+0x34/0x70
> [    0.626936]  dump_stack_lvl from __warn+0xe0/0x200
> [    0.627100]  __warn from warn_slowpath_fmt+0xc8/0x194
> [    0.627335]  warn_slowpath_fmt from __fortify_report+0x64/0x6c
> [    0.627551]  __fortify_report from __fortify_panic+0x8/0xc
> [    0.627739]  __fortify_panic from add_sysfs_param+0x224/0x228
> [    0.627927]  add_sysfs_param from kernel_add_sysfs_param+0x5c/0xa0
> [    0.628206]  kernel_add_sysfs_param from =
param_sysfs_builtin+0xf4/0x130
> [    0.628412]  param_sysfs_builtin from =
param_sysfs_builtin_init+0x30/0x38
> [    0.628649]  param_sysfs_builtin_init from =
do_one_initcall+0xd0/0x2d4
> [    0.628869]  do_one_initcall from do_initcall_level+0x9c/0x104
> [    0.629068]  do_initcall_level from do_initcalls+0x74/0xb0
> [    0.629254]  do_initcalls from kernel_init_freeable+0x10c/0x158
> [    0.629452]  kernel_init_freeable from kernel_init+0x20/0x1cc
> [    0.629654]  kernel_init from ret_from_fork+0x14/0x28
> [    0.629872] Exception stack(0xe080dfb0 to 0xe080dff8)
> [    0.630108] dfa0:                                     00000000 =
00000000 00000000 00000000
> [    0.630391] dfc0: 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000 00000000
> [    0.630656] dfe0: 00000000 00000000 00000000 00000000 00000013 =
00000000
> [    0.631064] ---[ end trace 0000000000000000 ]---
> [    0.631800] ------------[ cut here ]------------
> [    0.631989] kernel BUG at lib/string_helpers.c:1037!
> [    0.632175] Internal error: Oops - BUG: 0 [#1] SMP ARM
> [    0.632472] Modules linked in:
> [    0.632761] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        =
W          6.11.0-rc4+ #1
> [    0.633077] Tainted: [W]=3DWARN
> [    0.633186] Hardware name: Generic DT based system
> [    0.633357] PC is at __fortify_panic+0x8/0xc
> [    0.633521] LR is at __warn+0x16c/0x200
> [    0.633668] pc : [<c0f6daa8>]    lr : [<c035300c>]    psr: 60000013
> [    0.633878] sp : e080db98  ip : 00000000  fp : e080dbb8
> [    0.634059] r10: 6e72656b  r9 : 006c656e  r8 : c1000009
> [    0.634240] r7 : fffffff4  r6 : c135947c  r5 : c13d5ebc  r4 : =
c2466f00
> [    0.634470] r3 : 00000200  r2 : 00000000  r1 : 244cee50  r0 : =
244cee50
> [    0.634738] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  =
Segment none
> [    0.634987] Control: 10c5387d  Table: 423ec06a  DAC: 00000051
> [    0.635206] Register r0 information: non-paged memory
> [    0.635559] Register r1 information: non-paged memory
> [    0.635745] Register r2 information: NULL pointer
> [    0.635917] Register r3 information: non-paged memory
> [    0.636100] Register r4 information: slab kmalloc-64 start c2466f00 =
pointer offset 0 size 64
> [    0.636772] Register r5 information: non-slab/vmalloc memory
> [    0.637001] Register r6 information: non-slab/vmalloc memory
> [    0.637205] Register r7 information: non-paged memory
> [    0.637385] Register r8 information: non-slab/vmalloc memory
> [    0.637597] Register r9 information: non-paged memory
> [    0.637791] Register r10 information: non-paged memory
> [    0.637977] Register r11 information: 2-page vmalloc region =
starting at 0xe080c000 allocated at copy_process+0x17c/0xf18
> [    0.638382] Register r12 information: NULL pointer
> [    0.638569] Process swapper/0 (pid: 1, stack limit =3D 0x8a022d6d)
> [    0.639040] Stack: (0xe080db98 to 0xe080e000)
> [    0.639194] db80:                                                   =
    e080dbb8 c037f5f8
> [    0.639462] dba0: c2466f00 c13d5ebc 00000000 c1000009 e080dbd8 =
6e72656b e080dbd0 c151d860
> [    0.639728] dbc0: c13d5ebc c13d6dbc 00000000 6e72656b e080dc38 =
c151d6d8 6e72656b 00006c65
> [    0.639993] dbe0: 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000 00000000
> [    0.640261] dc00: 00000000 00000000 00000000 00000000 00000000 =
00000000 244cee50 c1655918
> [    0.640531] dc20: c215c200 c21f9300 c170f458 c151d4f8 00000000 =
00000000 e080dc40 c151d528
> [    0.640795] dc40: e080df40 c0302398 5e4e6cd4 ef580029 00000000 =
00000000 00000000 00000000
> [    0.641067] dc60: 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000 00000000
> [    0.641330] dc80: 00000000 00000000 00000000 00000000 ffffffff =
00000000 c18926ac 00000080
> [    0.641599] dca0: 000000b0 c061cb68 debbd794 debbd794 00000000 =
c21fd000 e080dce8 c061cb68
> [    0.641863] dcc0: 244cee50 00000001 00000801 debbd794 00000000 =
00000801 c1892640 00000000
> [    0.642126] dce0: c1893440 e080ddd0 e080ddb0 c061e2ec deb63e40 =
deb63e5c 00000000 00052cc0
> [    0.642390] dd00: 00000001 00000001 000000b0 00000001 00000000 =
00000000 00000000 00000064
> [    0.642657] dd20: 0000006c 00000080 00000001 e080ddd0 00000000 =
00000000 00000000 00000001
> [    0.642923] dd40: 00000000 00000000 00000000 00000001 00000000 =
00000000 00000001 00000000
> [    0.643187] dd60: c1892930 00000000 00000000 244cee50 00000000 =
00000000 00000000 00000000
> [    0.643451] dd80: 00000801 7ffe0000 c1892640 c0b3c530 244cee50 =
00000000 00052cc0 00000001
> [    0.643724] dda0: 00000008 00000001 00052cc0 00000000 e080de08 =
c061cddc 00000820 c0775f50
> [    0.643992] ddc0: 00000000 c215c200 00000000 00052cc0 c1893440 =
00000000 c1893440 244cee50
> [    0.644259] dde0: 00000020 debbd794 7ffe0000 c062c97c c21329c0 =
debbd794 0000000e 00000020
> [    0.644532] de00: 00000080 7ffe0000 e080de40 c062c97c c20a763c =
00000020 e080de28 c0f74fc0
> [    0.644800] de20: 244cee50 00000000 00000080 c2133e80 00000000 =
7fff0000 c21329c0 deb64100
> [    0.645066] de40: e080dea0 c062a584 c21c1180 c17cb818 0fffffff =
00000001 e080ded4 c0f655d8
> [    0.645330] de60: 00000000 00000001 c2132a48 ffffffff 00000000 =
c0f43544 ffff0a01 c0f71f18
> [    0.645592] de80: e080df20 c0f71f18 244cee50 c21c1180 00000cc0 =
e080ded4 00000079 00000000
> [    0.645857] dea0: 0fffffff 00000001 00000000 c0f43544 c071ca3c =
00000003 00000dc0 00000000
> [    0.646121] dec0: 00000cc0 00000000 0003ffff 80000053 c21fd66c =
c17cb818 00000000 00000000
> [    0.646121] dec0: 00000cc0 00000000 0003ffff 80000053 c21fd66c =
c17cb818 00000000 00000000
> [    0.646391] dee0: 00000000 00000000 000000c0 c13d6dbc 00000000 =
c037e2ec 000000c0 c037e328
> [    0.646663] df00: e080df40 c037e328 c21fd600 00000000 c12e093d =
c13d5ebc 00000000 244cee50
> [    0.646929] df20: 244cee50 c1655918 c1655aa0 c21f9300 deffff00 =
c13578a8 00000000 00000000
> [    0.647197] df40: e080df68 c1501898 00000007 00000007 00000000 =
c1501900 00000019 c21f9300
> [    0.647462] df60: 00000007 00000000 e080df88 c15017c0 c2143a00 =
c215c200 00000000 00000000
> [    0.647736] df80: 00000000 00000000 e080df98 c150163c 00000000 =
c0f6fa60 e080dfa8 c0f6fa80
> [    0.648006] dfa0: 00000000 00000000 00000000 c030016c 00000000 =
00000000 00000000 00000000
> [    0.648273] dfc0: 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000 00000000
> [    0.648536] dfe0: 00000000 00000000 00000000 00000000 00000013 =
00000000 00000000 00000000
> [    0.648801] Call trace:
> [    0.648840]  __fortify_panic from add_sysfs_param+0x224/0x228
> [    0.649129]  add_sysfs_param from kernel_add_sysfs_param+0x5c/0xa0
> [    0.649348]  kernel_add_sysfs_param from =
param_sysfs_builtin+0xf4/0x130
> [    0.649572]  param_sysfs_builtin from =
param_sysfs_builtin_init+0x30/0x38
> [    0.649801]  param_sysfs_builtin_init from =
do_one_initcall+0xd0/0x2d4
> [    0.650021]  do_one_initcall from do_initcall_level+0x9c/0x104
> [    0.650223]  do_initcall_level from do_initcalls+0x74/0xb0
> [    0.650412]  do_initcalls from kernel_init_freeable+0x10c/0x158
> [    0.650612]  kernel_init_freeable from kernel_init+0x20/0x1cc
> [    0.650810]  kernel_init from ret_from_fork+0x14/0x28
> [    0.650984] Exception stack(0xe080dfb0 to 0xe080dff8)
> [    0.651164] dfa0:                                     00000000 =
00000000 00000000 00000000
> [    0.651427] dfc0: 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000 00000000
> [    0.651697] dfe0: 00000000 00000000 00000000 00000000 00000013 =
00000000
> [    0.652032] Code: e8bd4bf0 eae457a7 e92d4800 ebe4aaef (e7f001f2)
> [    0.652584] ---[ end trace 0000000000000000 ]---
> [    0.652825] note: swapper/0[1] exited with irqs disabled
> [    0.653314] Kernel panic - not syncing: Attempted to kill init! =
exitcode=3D0x0000000b
> [    0.654033] ---[ end Kernel panic - not syncing: Attempted to kill =
init! exitcode=3D0x0000000b ]---
>=20
> I haven't had a chance to really look over this too much but I figured =
I
> would get the report out sooner rather than later, especially with the
> merge window being around the corner. If there is any other =
information
> I can provide or patches I can test, I am more than happy to do so.
>=20
> Cheers,
> Nathan
>=20
> # bad: [57f962b956f1d116cd64d5c406776c4975de549d] Add linux-next =
specific files for 20240912
> # good: [77f587896757708780a7e8792efe62939f25a5ab] Merge tag =
'arm-fixes-6.11-3' of =
git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> git bisect start '57f962b956f1d116cd64d5c406776c4975de549d' =
'77f587896757708780a7e8792efe62939f25a5ab'
> # good: [5e6a31306949eb18be8d6dc7ad6c42f8bea8e743] Merge branch 'main' =
of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
> git bisect good 5e6a31306949eb18be8d6dc7ad6c42f8bea8e743
> # bad: [9802faa85f4ccbc8cc0893fe76b939a9c56b9e62] Merge branch =
'for-next' of =
git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
> git bisect bad 9802faa85f4ccbc8cc0893fe76b939a9c56b9e62
> # good: [793a135214a81488066fb8ccecbd4f182c416326] drm/xe/mmio: Drop =
compatibility macros
> git bisect good 793a135214a81488066fb8ccecbd4f182c416326
> # good: [d8bfeb4282b1c55342d2dd946eaf00f4f13785db] Merge branch =
'for-next' of =
https://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git
> git bisect good d8bfeb4282b1c55342d2dd946eaf00f4f13785db
> # bad: [f5315deb662e813be5fa93f2b67d46fe9fcd383c] Merge branch 'next' =
of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
> git bisect bad f5315deb662e813be5fa93f2b67d46fe9fcd383c
> # good: [4b1d9019b26fd654ebc2d0d2e100ed56ef1821f0] ASoC: dt-bindings: =
amlogic,axg-sound-card: document clocks property
> git bisect good 4b1d9019b26fd654ebc2d0d2e100ed56ef1821f0
> # bad: [2ca98b409c36e91bb359a2997f4a7810e799bd62] Merge branch =
'modules-next' of =
git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git
> git bisect bad 2ca98b409c36e91bb359a2997f4a7810e799bd62
> # good: [d39b510a145a4766906cd49177695913d6e6bfd2] Add audio support =
for the MediaTek Genio 350-evk
> git bisect good d39b510a145a4766906cd49177695913d6e6bfd2
> # good: [43fbb2c702663d7af844ee952aec224a0e059e26] ASoC: loongson: =
Simplify code formatting
> git bisect good 43fbb2c702663d7af844ee952aec224a0e059e26
> # good: [0b0aa67baa8904e3c1e13be48a2ca125f59ead3d] ASoC: amd: acp: =
remove MODULE_ALIAS for sof based generic machine driver
> git bisect good 0b0aa67baa8904e3c1e13be48a2ca125f59ead3d
> # good: [8905d39085c60a13d47bd07d2766bfdde933cc8d] Merge branch =
'for-next' of =
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
> git bisect good 8905d39085c60a13d47bd07d2766bfdde933cc8d
> # good: [907fa79d787f6f762c0afb67b8b02be8ed1f7bd2] MAINTAINERS: scale =
modules with more reviewers
> git bisect good 907fa79d787f6f762c0afb67b8b02be8ed1f7bd2
> # bad: [e1d90ff7bc4b93c0b6c4821bef71b51ce145d7a7] module: abort module =
loading when sysfs setup suffer errors
> git bisect bad e1d90ff7bc4b93c0b6c4821bef71b51ce145d7a7
> # bad: [7125cb974977aa80959817548b5221314fe46bc0] params: Annotate =
struct module_param_attrs with __counted_by()
> git bisect bad 7125cb974977aa80959817548b5221314fe46bc0
> # first bad commit: [7125cb974977aa80959817548b5221314fe46bc0] params: =
Annotate struct module_param_attrs with __counted_by()

Thanks for reporting this.

Changing

 memset(&mk->mp->attrs[mk->mp->num - 1], 0, sizeof(mk->mp->attrs[0]));

to

 memset(mk->mp->attrs + mk->mp->num - 1, 0, sizeof(mk->mp->attrs[0]));

fixes the false-positive warning

 memset: detected buffer overflow: 32 byte write of buffer size 0

even though the pointers have the same value. Does anyone know why?

Thanks,
Thorsten=
