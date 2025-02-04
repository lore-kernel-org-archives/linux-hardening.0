Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CB620CCC7;
	Tue,  4 Feb 2025 11:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738669127; cv=none; b=gfsoNT1JHVssr0uw8uvJyWK8YCxOrXG9zDtPRinIsJ4kEuMf2TOQcvw/E/uyt84qMYjAR2Zd3pExGR8z/eDsm6hXWCuHmPccY4lpn/h/sN2v09+PQGymccIbPcAcqThRiAggQWcuNF3KJo6XZk8uQQkF0BhWCLVR71tFYRq3l4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738669127; c=relaxed/simple;
	bh=5zVc5547KtTIaBfKazQ5CFOg3KCn/D785+HliKGBazE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UpocsxXTVmGmdEECZC4rmqxNw5vEogob5NUju6avJL5jmpGuqBh6NJbstNVmLf42amYpuFSW+S7JRYn+K/9TfaWllXCuW8fTOKWYsFu9zvaFa2LEmoJUw3MFe5Y8SdBj8gC4SEsi/Kw7IIHy58XBJASsVZughYvrWpGhIPLlYWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oezl6b4S; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oezl6b4S"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5dcb060ca2dso3630199a12.2;
        Tue, 04 Feb 2025 03:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738669124; x=1739273924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUTNWo3PzksJvTvTctW86BkYIYA3CWwkWfANE6jfeow=;
        b=Oezl6b4SXPIwHAglkPdkMWQnLZJcO8q9YG+Vzc8MBbIz5H00NwMbV112nwyZ7fiVlC
         B5Jy88Q6C6YKdFVQRt05NF5F0ODUcF+G5SNnBSq1F0UvponOce4wIkxt5Mm8yEWEFXNs
         LdSc3nDjlXaz+13j7fzOwrMcfBfV4GMg9LVlDJ0j62OarYeEgf1cIxQbXh+BUqjbJHfO
         heQ5mTWJ49WYmISkdcmiXWP44v+tJnPajzyRN/w5MfXQJpawWReqhHuX5QeSoJJm2JVj
         eCK14jbVRP07KYlHU8HMwAlpUtIyuZXldXohfKx7X+T2ofJlzOnzOTz76S4aWgZVT3Ed
         iutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738669124; x=1739273924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUTNWo3PzksJvTvTctW86BkYIYA3CWwkWfANE6jfeow=;
        b=Y1TkaC8RhMvmAwcTSkUrJqmffD0LpWfg8xG/1DrUm2HscJRw6AFG4CectT1lqnRoQE
         dYcNhYRFLPWhwlUs92xb5e23uzrkt+DFloU0bGMGGYHRQe5w9EyaumLCnqCCszYg5mEp
         xExtoEtRJ8GuyneTsRCTEYnqUkAP4/A28+oeGmgoET7l17jjVdbxHIge79Z74cGS+DGp
         EcGZ0w8rSaBim3wDNyZiOqx1n53nBW0HMHStrcKSf3f4f9Wg6o/S755qe+ayVF07uF+Q
         CpN+NT7+ENYrdzNJE9S+a3JE0qQff6v/i4o0mjZKJLrwBANlzd/U1jtnfqeYK/IVwG66
         CyGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLic2iVieQ0AslsDSiezF3WlxdL8NHJnVlwkNtM9Ck217oNyv/iFAyACpO63nmPgqVuJMCtc4QDOc9K6it@vger.kernel.org, AJvYcCXUGsng9nJwZDu5BIj46pNpEPrKJp+209IiJ/5LaW6BtRuy94kvWjDI4wZTdk803FUnzmf8EJDHYSxHcoBkyG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjr85X6dYS8xXsFt8seijqK1GHVaLQwI9fqOvbCVkV940vXhu+
	L9lO4iDavZofBxr1aUESBUWHrBZb6BVSIjl3M+PMxEH5UnSVYrTW9GfLDwTpOSAjhRkyK0ee+As
	aYMuj0FHQkt325pJW7iNDBjKttPE=
X-Gm-Gg: ASbGncseWseWzd12EkhIoz7TL65ZpnZjwbEskzsZUcOgzzy9RDr13d9gZ/iCBM3QJ+6
	cY6hbVgvcfGmDwqPdPKjoMTy4RTWWlsMG2xaWS8LM50zyzg+NhKEEUVV4SfnS3B+4AAmpR7c=
X-Google-Smtp-Source: AGHT+IGS00l03X/FG+p9i6/sNKmSoENhb9rFYn4vCBR/JH55vW+4qShWTxfIVPaVZTiVDEikWosu1V116YKuK787od8=
X-Received: by 2002:a05:6402:5023:b0:5dc:7b59:445b with SMTP id
 4fb4d7f45d1cf-5dc7b594606mr23427510a12.28.1738669123386; Tue, 04 Feb 2025
 03:38:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67a1e1f4.050a0220.163cdc.0063.GAE@google.com>
In-Reply-To: <67a1e1f4.050a0220.163cdc.0063.GAE@google.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 4 Feb 2025 12:38:30 +0100
X-Gm-Features: AWEUYZmDZLGOL4TcuVyVWmxV6lgjPitZsBmRqhtIEmd39wUoE9ZnbtBHMCrTS-4
Message-ID: <CAGudoHHCXHA=7e8M=6jMVqbh8=keRBBF8yHvDm9PnyeN6Bb7Xw@mail.gmail.com>
Subject: Re: [syzbot] [hardening?] [mm?] BUG: bad usercopy in vfs_readlink
To: syzbot <syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com>, 
	"Theodore Ts'o" <tytso@mit.edu>
Cc: akpm@linux-foundation.org, brauner@kernel.org, gustavoars@kernel.org, 
	kees@kernel.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 10:46=E2=80=AFAM syzbot
<syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    69b8923f5003 Merge tag 'for-linus-6.14-ofs4' of git://git=
...
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D1258aeb058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D57ab43c279fa6=
14d
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D48a99e426f29859=
818c0
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15825724580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1658aeb058000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ea84ac864e92/dis=
k-69b8923f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/6a465997b4e0/vmlinu=
x-69b8923f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/d72b67b2bd15/b=
zImage-69b8923f.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/7c29196107=
64/mount_0.gz
>
> The issue was bisected to:
>
> commit bae80473f7b0b25772619e7692019b1549d4a82c
> Author: Mateusz Guzik <mjguzik@gmail.com>
> Date:   Wed Nov 20 11:20:35 2024 +0000
>
>     ext4: use inode_set_cached_link()
>

This looks like a case of a deliberately corrupted image.

I added back a debug printk I used when writing the patch before. For
correct cases it reports:

[   19.574861] __ext4_iget: inode ff18d9bec05977c8 [/etc/environment]
i_size 16 strlen 16
[   19.585987] __ext4_iget: inode ff18d9bed6f25c68
[/etc/alternatives/awk] i_size 21 strlen 21
[   19.590419] __ext4_iget: inode ff18d9bed6f24108 [/usr/bin/gawk]
i_size 13 strlen 13
[   19.592199] __ext4_iget: inode ff18d9bed6abeea8
[libassuan.so.0.8.5] i_size 18 strlen 18
[   19.593804] __ext4_iget: inode ff18d9bed6f29368
[libsigsegv.so.2.0.7] i_size 19 strlen 19

etc.

However, the bogus case is:
[   52.161476] __ext4_iget: inode ff18d9bed1cc2a38
[/tmp/syz-imagegen43743633/file0/file0] i_size 131109
strlen 37

That is i_size is out of sync with strlen.

Prior to my patch this happened to work because the copying was in
fact issuing strlen to find the size every time.

Given this code in fs/ext4/inode.c:
  5008                 } else if (ext4_inode_is_fast_symlink(inode)) {
  5009                         inode->i_op =3D
&ext4_fast_symlink_inode_operations;
  5010                         nd_terminate_link(ei->i_data, inode->i_size,
  5011                                 sizeof(ei->i_data) - 1);

To me this looks like a pre-existing bug in ext4 which just happened
to get exposed with:

  5012                         inode_set_cached_link(inode, (char *)ei->i_d=
ata,
  5013                                               inode->i_size);


However, if the strlen thing is indeed the source of truth, the
inode_set_cached_link call can be trivially patched to use it instead
of i_size.

> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1248c3df98=
0000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D1148c3df98=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1648c3df98000=
0
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com
> Fixes: bae80473f7b0 ("ext4: use inode_set_cached_link()")
>
> EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 =
r/w without journal. Quota mode: writeback.
> usercopy: Kernel memory exposure attempt detected from SLUB object 'ext4_=
inode_cache' (offset 0, size 176)!
> ------------[ cut here ]------------
> kernel BUG at mm/usercopy.c:102!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 1 UID: 0 PID: 5826 Comm: syz-executor349 Not tainted 6.13.0-syzkalle=
r-09793-g69b8923f5003 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 12/27/2024
> RIP: 0010:usercopy_abort+0x84/0x90 mm/usercopy.c:102
> Code: 49 89 ce 48 c7 c3 80 5f 18 8c 48 0f 44 de 48 c7 c7 20 5e 18 8c 4c 8=
9 de 48 89 c1 41 52 41 56 53 e8 d1 3a f5 fe 48 83 c4 18 90 <0f> 0b 66 2e 0f=
 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90
> RSP: 0018:ffffc90003fa7c90 EFLAGS: 00010296
> RAX: 000000000000006b RBX: ffffffff8c185f80 RCX: ba71ae4bd9cf0200
> RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: ffffffff819f1fbc R09: 1ffff920007f4f2c
> R10: dffffc0000000000 R11: fffff520007f4f2d R12: ffffea0001e70200
> R13: 00000000000000b0 R14: 0000000000000000 R15: 00000000000000b0
> FS:  00005555602a7380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000066c7e0 CR3: 0000000078aac000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __check_heap_object+0xb1/0x100 mm/slub.c:5818
>  check_heap_object mm/usercopy.c:196 [inline]
>  __check_object_size+0x1da/0x730 mm/usercopy.c:251
>  check_object_size include/linux/thread_info.h:228 [inline]
>  check_copy_size include/linux/thread_info.h:264 [inline]
>  copy_to_user include/linux/uaccess.h:219 [inline]
>  readlink_copy fs/namei.c:5284 [inline]
>  vfs_readlink+0x1cf/0x550 fs/namei.c:5307
>  do_readlinkat+0x249/0x3a0 fs/stat.c:576
>  __do_sys_readlinkat fs/stat.c:593 [inline]
>  __se_sys_readlinkat fs/stat.c:590 [inline]
>  __x64_sys_readlinkat+0x9a/0xb0 fs/stat.c:590
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fdaffabc639
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffeb88c4948 EFLAGS: 00000246 ORIG_RAX: 000000000000010b
> RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007fdaffabc639
> RDX: 00000000200002c0 RSI: 0000000020000240 RDI: 00000000ffffff9c
> RBP: 00007fdaffb30610 R08: 0000000000000000 R09: 0000000000000000
> R10: 00000000000000b0 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffeb88c4b18 R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:usercopy_abort+0x84/0x90 mm/usercopy.c:102
> Code: 49 89 ce 48 c7 c3 80 5f 18 8c 48 0f 44 de 48 c7 c7 20 5e 18 8c 4c 8=
9 de 48 89 c1 41 52 41 56 53 e8 d1 3a f5 fe 48 83 c4 18 90 <0f> 0b 66 2e 0f=
 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90
> RSP: 0018:ffffc90003fa7c90 EFLAGS: 00010296
> RAX: 000000000000006b RBX: ffffffff8c185f80 RCX: ba71ae4bd9cf0200
> RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: ffffffff819f1fbc R09: 1ffff920007f4f2c
> R10: dffffc0000000000 R11: fffff520007f4f2d R12: ffffea0001e70200
> R13: 00000000000000b0 R14: 0000000000000000 R15: 00000000000000b0
> FS:  00005555602a7380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055dd00353bf8 CR3: 0000000078aac000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup



--=20
Mateusz Guzik <mjguzik gmail.com>
