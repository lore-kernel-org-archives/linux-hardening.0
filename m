Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABCC20125D
	for <linux-hardening@vger.kernel.org>; Tue,  4 Feb 2025 09:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738662391; cv=none; b=SDH491YmQQ4V1zCk1q0VPPfOWv8hGG5Y2Iyw5RSZR8fQTxdb7K1e5ARI9NRvA9D1vlHsCX1AA/xFbDOkHJlceO1nLwdBTSukGdri5IquTN9js0QAlGCOVeDIUmdlnw0kfInw1T61MSz6cS/JPSub83U9Y3d0mQEtu6YidTHGcPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738662391; c=relaxed/simple;
	bh=TwNDP+00RgGf4vX+sViNbRUp1sqAvulqoCSyRLnSZmA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UtKNLD0feobyQ1psC5PY0341RjRanANEhHFKr9wbUrSBZ1HC8qfFuDGTlzUyuvurvlmLmYRNyxjL7z6S6I8SOHVMIkBQ/H+49d0D5ejZEtEwFNztre1Sqdp65YBD9q1tltm5CebTspK+wTT/L9/9RnfUvEN0BTxKHDMbMPekdXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3cfb2d37dbdso38490245ab.2
        for <linux-hardening@vger.kernel.org>; Tue, 04 Feb 2025 01:46:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738662389; x=1739267189;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wZE+EmsDVH3/iA7xkKOngyxwK7oLNaXw/irVVx8Ze1o=;
        b=TgrqUEFEzzhelVHWY8TsaVZhty+EY2aPtovI25TvDMuvXt3FdUnzIorLaCqlZZc7O2
         wNpup1lvzIyl6O3wFEdMjDAMxVQ9HNeMfB0yEGwhUXkvQXPJUMhzYmvBezsbiaOmlhIv
         p0DGH0yhM34qI4m015qxEnCTQy68iH5okEY/TNz+rD0KypHcvssHr2QeEWBSYkG1i47e
         1p5tmQ17jP2e5HyMaTagBMyQkckfADs6UBySGOsSMB71c5NNLluS4G4bKWceqbgPTiRp
         VeJ1A7qt2l0qmOltW1BY+u7GlYOwa/aAhOwwR4R+i8FnL+hkD2mFen8LyS2vCps0W3yP
         v7OA==
X-Forwarded-Encrypted: i=1; AJvYcCUczhrOlthDCNTyNe+fd3OlzEKzP1w94Ki2l40eOueoZrtIWbhPMqbf5MFWZLvnCfphPM+R5hmIZw5HbYrhi6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgygbQzS6NVFdnDn6xFqAaG/6GdVjkiGSWOWApBaH8ogOifHu4
	pAVg2d3muAVAFsBNKkfZhpqMLPkbct4Rngs6B2fF5umSZKdkRUOlAIt4ckffRr513IqRuTcsvXs
	FGwxkZmxmi6tlweRJtWy6gxkRU6vz2dlJGmJlstTvLEC1umgIHCSTRqI=
X-Google-Smtp-Source: AGHT+IGfBkb9X7jQRYB3l44Jn9qXd32Mgl3O/5Z3FsJx3kkyI/TxfbmDUwsUUNE+b72TmVTtOxHviz6OKHqhBBngU7QrxIywQYSp
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0c:b0:3cf:cc97:c9c6 with SMTP id
 e9e14a558f8ab-3cffe41a2admr213283495ab.17.1738662388859; Tue, 04 Feb 2025
 01:46:28 -0800 (PST)
Date: Tue, 04 Feb 2025 01:46:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a1e1f4.050a0220.163cdc.0063.GAE@google.com>
Subject: [syzbot] [hardening?] [mm?] BUG: bad usercopy in vfs_readlink
From: syzbot <syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, brauner@kernel.org, gustavoars@kernel.org, 
	kees@kernel.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mjguzik@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    69b8923f5003 Merge tag 'for-linus-6.14-ofs4' of git://git...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1258aeb0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57ab43c279fa614d
dashboard link: https://syzkaller.appspot.com/bug?extid=48a99e426f29859818c0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15825724580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1658aeb0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ea84ac864e92/disk-69b8923f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6a465997b4e0/vmlinux-69b8923f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d72b67b2bd15/bzImage-69b8923f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7c2919610764/mount_0.gz

The issue was bisected to:

commit bae80473f7b0b25772619e7692019b1549d4a82c
Author: Mateusz Guzik <mjguzik@gmail.com>
Date:   Wed Nov 20 11:20:35 2024 +0000

    ext4: use inode_set_cached_link()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1248c3df980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1148c3df980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1648c3df980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com
Fixes: bae80473f7b0 ("ext4: use inode_set_cached_link()")

EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: writeback.
usercopy: Kernel memory exposure attempt detected from SLUB object 'ext4_inode_cache' (offset 0, size 176)!
------------[ cut here ]------------
kernel BUG at mm/usercopy.c:102!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 5826 Comm: syz-executor349 Not tainted 6.13.0-syzkaller-09793-g69b8923f5003 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
RIP: 0010:usercopy_abort+0x84/0x90 mm/usercopy.c:102
Code: 49 89 ce 48 c7 c3 80 5f 18 8c 48 0f 44 de 48 c7 c7 20 5e 18 8c 4c 89 de 48 89 c1 41 52 41 56 53 e8 d1 3a f5 fe 48 83 c4 18 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90003fa7c90 EFLAGS: 00010296
RAX: 000000000000006b RBX: ffffffff8c185f80 RCX: ba71ae4bd9cf0200
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff819f1fbc R09: 1ffff920007f4f2c
R10: dffffc0000000000 R11: fffff520007f4f2d R12: ffffea0001e70200
R13: 00000000000000b0 R14: 0000000000000000 R15: 00000000000000b0
FS:  00005555602a7380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000066c7e0 CR3: 0000000078aac000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __check_heap_object+0xb1/0x100 mm/slub.c:5818
 check_heap_object mm/usercopy.c:196 [inline]
 __check_object_size+0x1da/0x730 mm/usercopy.c:251
 check_object_size include/linux/thread_info.h:228 [inline]
 check_copy_size include/linux/thread_info.h:264 [inline]
 copy_to_user include/linux/uaccess.h:219 [inline]
 readlink_copy fs/namei.c:5284 [inline]
 vfs_readlink+0x1cf/0x550 fs/namei.c:5307
 do_readlinkat+0x249/0x3a0 fs/stat.c:576
 __do_sys_readlinkat fs/stat.c:593 [inline]
 __se_sys_readlinkat fs/stat.c:590 [inline]
 __x64_sys_readlinkat+0x9a/0xb0 fs/stat.c:590
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdaffabc639
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeb88c4948 EFLAGS: 00000246 ORIG_RAX: 000000000000010b
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007fdaffabc639
RDX: 00000000200002c0 RSI: 0000000020000240 RDI: 00000000ffffff9c
RBP: 00007fdaffb30610 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000000000b0 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffeb88c4b18 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:usercopy_abort+0x84/0x90 mm/usercopy.c:102
Code: 49 89 ce 48 c7 c3 80 5f 18 8c 48 0f 44 de 48 c7 c7 20 5e 18 8c 4c 89 de 48 89 c1 41 52 41 56 53 e8 d1 3a f5 fe 48 83 c4 18 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90003fa7c90 EFLAGS: 00010296
RAX: 000000000000006b RBX: ffffffff8c185f80 RCX: ba71ae4bd9cf0200
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff819f1fbc R09: 1ffff920007f4f2c
R10: dffffc0000000000 R11: fffff520007f4f2d R12: ffffea0001e70200
R13: 00000000000000b0 R14: 0000000000000000 R15: 00000000000000b0
FS:  00005555602a7380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055dd00353bf8 CR3: 0000000078aac000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
