Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22255287516
	for <linux-hardening@vger.kernel.org>; Mon,  2 Feb 2026 04:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770005998; cv=pass; b=o8ZTYft8+xhk1qh93NYW45W0bpckpda6lp8yTtdIrMO5Ek+64uYZPpU5xinOb6S3V3nkqK04RfXO5qo+W/30/0Mo1AFspskGQOqA0yzbVLimyUD74EVs+2cblK+ljzYYbOmTKzU1RuU1jDroexOTJ6Ieogkck1yqRZRu9XbK7Dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770005998; c=relaxed/simple;
	bh=WALAIziZrsPO/QFVeuwfw07zhX4EufzEzDdCR7Bthfw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Uj7MOp2ACkrE9Rh92tQwmuX9kgtMlJeQcYxsbA+YAtaPmJWKYf3cM7hXg4pr4HZ0sQEIeTEsrEdrg8Axdl6zA/W5AwgQXh9P1HV+kzerM8MVVTeQWNBMGJm6Bm9+/PN1QNpKJNyXB2mSSfD0tMgt8JUDVnIJQDiKXHUZHdIDmOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImuJy2IV; arc=pass smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImuJy2IV"
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-8947e17968eso46673596d6.0
        for <linux-hardening@vger.kernel.org>; Sun, 01 Feb 2026 20:19:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770005996; cv=none;
        d=google.com; s=arc-20240605;
        b=UpT6KsXRHG/luWFxkVqi2zuuj2ZWYk5Ae4wMq+TxDwTtu/o46J4XyIDdL8BaZGsYde
         UviVugZBuHINdQE5cqxibshN54aeGIcMCIAbGNMdhmWxqmcIy2YQNFY/OOdcSL+yUCIS
         vB5p0iy+IuF01ITYhM2xBd0JT2ngXLR/lO4iYvnBPWKRF4uPwgCelcmvTs2c1CxiGID9
         Bj0Q1c9lJjOIDHNn2n6yoQIdFiXO0fyL4lwAW16ofSaPHqCLGUGArIR4hesI1n68s7op
         SijzrtD+nZb/k2nm9WB1dCUrsDcz0VU+ZMMcyAHI7EMsTbz+z+EfSVPz/b5DHP2gyYx8
         lvmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=/BHCGN97b2CUzoCjfaVTV+5xiWhmY0WLUcNVgu2xZ1s=;
        fh=w4mcuJluhEKFCKlLuyzpjq2tqgfypeiHOfJRySJI+tQ=;
        b=INgTLP0YEteIYlpYAh50UWJMrh+mzVlqYsJZV42rMfAgo2ykO2ULxsVASvF2s1J477
         Ak1NUqPap993Jpnim4ho9mpa3/0yNsJk+mLZoo5uM6NOVf2I9/63gEHrYfx1YM8YoBKd
         Dm6IuvqWvXC3BLkFqj4JsXfxNaRiu8uaMxTHJ5k1dnOIAu8FNupGc9Sf2lpbT5J/bCRH
         +Nx42uwIxI6Ilm4xoSxG7KOgnhVfdE8qiNI35LUx4vy8RUrLydfDp5sMh+VzkkU1DHtl
         I9cZCzntAull39HSQ+MQqClY8fVu79BP0LlzdaLPrsn6bamO21pRRlIHkmxH4pLssPtM
         RyYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770005996; x=1770610796; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/BHCGN97b2CUzoCjfaVTV+5xiWhmY0WLUcNVgu2xZ1s=;
        b=ImuJy2IVb6/Lguz+EepbQeu+HNm2vkBn83W0jc7alZXYIlym3Dpicyytg+ue9ZParn
         wpGGWm8p2B2xbmTFgzAte1V5p9snahrQ4Y0JvvOT1TQEHBDoAhtnTfka8IKfGu+Yc4Zt
         qAbQz1Kb5328eXCkU8uVMA3xq8DoWyxQAM9Sz6oqH3hkNYhGvWi6kyzSpw+KmBomPZ8P
         dma7Lt0Z9daoLgEHCBjvzpblTnkxwsarTkYaxyRg61cNlKvs0PmrxlQ8OlADoOyzRtQM
         KLsCc5VNWO4rJsI2idMOJob+itJWEe+r0225MwmcJbTz601nrd5gb6r5qH0NyAW46lKA
         BjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770005996; x=1770610796;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/BHCGN97b2CUzoCjfaVTV+5xiWhmY0WLUcNVgu2xZ1s=;
        b=h+iEGkI7SXIkVmESjQF82+vZ5P2c4LP9Z2A5A1lf16UokToDfEtaL+mzTQ4YahiHUI
         Iol62xseobkjTDT9L0kKAr3yv7TuAWW3cvmFFeywftjyv/6DzMnOLy3gbjpxwxxfTWlz
         B2y9wBXy//Rsvg+mQj1tYacCG+Lb3o79c9bYW3mBUO36wEg9hah3lu1bZ/ZivqX7siza
         n/wA0g4YJSMxGghI1ynJls5J0QHikNcMSWegzVEvSyrJ7j6h0ngJU1j8q5TdZ/fUyi5x
         a/4ua2MXUd6rdXdZsy7dwAvdYMoOCIqzyfEs0oHv5ViSSTn6RamEkaHYr6mG2JpBmlG5
         RZkA==
X-Forwarded-Encrypted: i=1; AJvYcCWRNrP9VRUdjn/xZ6foKn/iI3IQaQ2WGf0kaiOisKuAC6ZXNYzGSrXK1UcMLd6JvHQ9itJ+NTbsR6HHrDD+ofs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk+zSjqmbQZaPGtBNOZkSQeN5G9nk8Gfj0l8Dq02WbqpsCxgZ8
	JTLOlUq6yr4LEpmaA3XCE0iVmem+I6OsbZ4weTotA9WzDU8Plg1PP0WWHbp68BpKz42vATJ1TrB
	Ri/FJWLW+BFkZ4okyoUu6mYq/+XsRVwZAdjodu6D49Q==
X-Gm-Gg: AZuq6aJMsSaPD9jmmnKCqyNtzhirG8Ngl2oBfuNaWmUe3R95McZmALFcRHM6g9+YEqL
	lLUIIHXz8qRy0uvl3cfMgCcfZjX9Q71QIMsWSZQOyfy0g/7GDyAPDovzcd2AUsqaxk0vG8lK7F1
	K6WD15WhYdialZlTne3CZOMQgidt6UUNuwmjoigQ0V6XkX2UHIEUcONLQ8erhKZu8oh08Bp751O
	SlgYdB6u6We1qsEzLqbT2Dc9Q7gMcetxbU+2oi3RgjVI/vqqNl7cf7yGLqgOfYcUTwlwEihd3Wy
	rQqGF0UwFHmwy5yLMWDzRVSp0A==
X-Received: by 2002:a05:6214:519c:b0:894:7077:fd6a with SMTP id
 6a1803df08f44-894ea0a37ecmr148183456d6.45.1770005995859; Sun, 01 Feb 2026
 20:19:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?5p2O6b6Z5YW0?= <coregee2000@gmail.com>
Date: Mon, 2 Feb 2026 12:19:45 +0800
X-Gm-Features: AZwV_QhiOo37lgj9LnasX1F6u4sKFToWLS4n7386Crk-8B8oeyoLNNNwHJvg8Yc
Message-ID: <CAHPqNmzBb2LruMA6jymoHXQRsoiAKMFZ1wVEz8JcYKg4U6TBbw@mail.gmail.com>
Subject: [Kernel Bug] WARNING in ext4_fill_super
To: syzkaller@googlegroups.com, kees@kernel.org, andy@kernel.org, 
	akpm@linux-foundation.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux kernel developers and maintainers,

We would like to report a new kernel bug found by our tool. The issue
is a WARNING in ext4_fill_super. Details are as follows.

Kernel commit: v6.18.2
Kernel config: see attachment
report: see attachment

We are currently analyzing the root cause and  working on a
reproducible PoC. We will provide further updates in this thread as
soon as we have more information.

Best regards,
Longxing Li

loop4: detected capacity change from 0 to 514
------------[ cut here ]------------
strnlen: detected buffer overflow: 65 byte read of buffer size 64
WARNING: CPU: 0 PID: 12320 at lib/string_helpers.c:1035
__fortify_report+0x9c/0xd0 lib/string_helpers.c:1035
Modules linked in:
CPU: 0 UID: 0 PID: 12320 Comm: syz.4.59 Not tainted 6.18.2 #1 PREEMPT(full)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:__fortify_report+0x9c/0xd0 lib/string_helpers.c:1035
Code: ed 48 c7 c0 80 c8 cf 8b 48 0f 44 d8 e8 cd dd 17 fd 4d 89 e0 48
89 ea 4c 89 f6 48 89 d9 48 c7 c7 00 c9 cf 8b e8 b5 57 d6 fc 90 <0f> 0b
90 90 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc 48 89 de 48 c7
RSP: 0018:ffffc90011f9fa18 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffffff8bcfc880 RCX: ffffffff817afc38
RDX: ffff8881095eca80 RSI: ffffffff817afc45 RDI: 0000000000000001
RBP: 0000000000000041 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000040
R13: 0000000000000000 R14: ffffffff8bcfd240 R15: ffff88803c484400
FS:  00007f9e5f45c640(0000) GS:ffff8880cf053000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000123400000 CR4: 0000000000752ef0
PKRU: 80000000
Call Trace:
 <TASK>
 __fortify_panic+0x23/0x30 lib/string_helpers.c:1042
 strnlen include/linux/fortify-string.h:235 [inline]
 sized_strscpy include/linux/fortify-string.h:309 [inline]
 parse_apply_sb_mount_options fs/ext4/super.c:2486 [inline]
 __ext4_fill_super fs/ext4/super.c:5306 [inline]
 ext4_fill_super+0x3972/0xaf70 fs/ext4/super.c:5736
 get_tree_bdev_flags+0x38c/0x620 fs/super.c:1698
 vfs_get_tree+0x8e/0x340 fs/super.c:1758
 fc_mount fs/namespace.c:1199 [inline]
 do_new_mount_fc fs/namespace.c:3642 [inline]
 do_new_mount fs/namespace.c:3718 [inline]
 path_mount+0x7b9/0x23a0 fs/namespace.c:4028
 do_mount fs/namespace.c:4041 [inline]
 __do_sys_mount fs/namespace.c:4229 [inline]
 __se_sys_mount fs/namespace.c:4206 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:4206
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x56755e
Code: 48 c7 c0 ff ff ff ff eb aa e8 3e 1c 00 00 66 2e 0f 1f 84 00 00
00 00 00 0f 1f 40 00 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9e5f45bdf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f9e5f45be80 RCX: 000000000056755e
RDX: 0000000020000140 RSI: 0000000020000440 RDI: 00007f9e5f45be40
RBP: 0000000020000140 R08: 00007f9e5f45be80 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000020000440
R13: 00007f9e5f45be40 R14: 00000000000003d5 R15: 0000000020000200
 </TASK>

https://drive.google.com/file/d/12W8B3IU88RBdBpV4nMcAj9TVOzlx6xL-/view?usp=drive_link

https://drive.google.com/file/d/1efTUJTmSTMuJqSpCq686RjXdUzhyEJDL/view?usp=drive_link
