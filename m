Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CE0C64EC4
	for <linux-hardening@archiver.kernel.org>; Fri,  3 Mar 2023 21:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjCCViE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 3 Mar 2023 16:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjCCViB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 3 Mar 2023 16:38:01 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BDE5596
        for <linux-hardening@vger.kernel.org>; Fri,  3 Mar 2023 13:37:56 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id a5-20020a92ce45000000b00318aa18d2fbso2068221ilr.23
        for <linux-hardening@vger.kernel.org>; Fri, 03 Mar 2023 13:37:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VDb/oN8pa2bSuFN4Ui9nfP2pxdomt8W/GDE9wFn9RyQ=;
        b=hB2uX1X5frHQX46Qn2X0vAmOD7/Hqw/PzK0HuX0ayLb5tZLUL23H+PcU/9GhJG+j5m
         93S2mQozjlG+XB5mrrthP6KQ0ZeWZgyFXVZBEvSk4rhe1Nc9RHKPixF23alFF/dfRK/n
         Hz4NHQKFpG7cNX3l1HUbfDpfU7Qo5wYe9uM9sNb3uRXNINZLVf/oiQiC6QdYa58y/rD/
         3cvUE+YOVFXw2STF4rEXVNUt37SO2PYAyqvQ8gbksktBBYwmPS1E9lR7OXrzxsXgv1Dr
         ARF5ev+VZVh9qsAZTFM9QHrirckINUlqMbn5emPOFBkxdxuvm7xogj5e4P7FI5igwmsc
         e9Vg==
X-Gm-Message-State: AO0yUKVwGJHez3BIx+IeRFhiKc/iDCJxwWxX9tkt9gE2DY+8mwqVP87t
        C3FKF2iYaKO7fj5ZJNgmtCsg6Z/Hx9ffTOjdXT7G9KfiZMmG
X-Google-Smtp-Source: AK7set+AwR/J9UVhmgkmV9QeFWskMRZYdkjiZFq8Cxv5vt6ZXRsSD5jwvnuIY5btoSPErVNvUsloFypusjrLzeda4T31tsiz4eT3
MIME-Version: 1.0
X-Received: by 2002:a92:b512:0:b0:30f:543d:e52c with SMTP id
 f18-20020a92b512000000b0030f543de52cmr1646847ile.2.1677879475508; Fri, 03 Mar
 2023 13:37:55 -0800 (PST)
Date:   Fri, 03 Mar 2023 13:37:55 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001d1fb505f605c295@google.com>
Subject: [syzbot] [hardening?] [mm?] BUG: bad usercopy in con_font_op
From:   syzbot <syzbot+3af17071816b61e807ed@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2eb29d59ddf0 Merge tag 'drm-next-2023-03-03-1' of git://an..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12e88ebcc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cab35c936731a347
dashboard link: https://syzkaller.appspot.com/bug?extid=3af17071816b61e807ed
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b71504c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f02d9cc80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ea23ee201337/disk-2eb29d59.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/40a9db02dede/vmlinux-2eb29d59.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8d4b574642d0/bzImage-2eb29d59.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3af17071816b61e807ed@syzkaller.appspotmail.com

usercopy: Kernel memory exposure attempt detected from page alloc (offset 0, size 4194560)!
------------[ cut here ]------------
kernel BUG at mm/usercopy.c:102!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5073 Comm: syz-executor309 Not tainted 6.2.0-syzkaller-13277-g2eb29d59ddf0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/16/2023
RIP: 0010:usercopy_abort+0xb7/0xd0 mm/usercopy.c:102
Code: e8 fe e8 a1 ff 49 89 d9 4c 89 e1 48 89 ee 41 56 48 c7 c7 00 73 5b 8a 41 55 41 57 4c 8b 44 24 20 48 8b 54 24 18 e8 59 8b 85 ff <0f> 0b 48 c7 c3 00 71 5b 8a 49 89 df 49 89 d8 e9 71 ff ff ff 0f 1f
RSP: 0018:ffffc90003bcf9e0 EFLAGS: 00010286
RAX: 000000000000005b RBX: ffffffff8a5b7100 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff816931fc RDI: 0000000000000005
RBP: ffffffff8a5b72c0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: ffffffff8a5b7500
R13: 0000000000000000 R14: 0000000000400100 R15: ffffffff8a5b7100
FS:  0000555555b1b300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 0000000075655000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 check_heap_object mm/usercopy.c:200 [inline]
 __check_object_size mm/usercopy.c:251 [inline]
 __check_object_size+0x50a/0x6e0 mm/usercopy.c:213
 check_object_size include/linux/thread_info.h:215 [inline]
 check_copy_size include/linux/thread_info.h:251 [inline]
 copy_to_user include/linux/uaccess.h:168 [inline]
 con_font_get drivers/tty/vt/vt.c:4580 [inline]
 con_font_op+0x397/0xf10 drivers/tty/vt/vt.c:4674
 vt_k_ioctl drivers/tty/vt/vt_ioctl.c:474 [inline]
 vt_ioctl+0x620/0x2df0 drivers/tty/vt/vt_ioctl.c:752
 tty_ioctl+0x773/0x16e0 drivers/tty/tty_io.c:2777
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f6672fd82d9
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc66955e38 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6672fd82d9
RDX: 0000000020000000 RSI: 0000000000004b72 RDI: 0000000000000003
RBP: 00007f6672f9c0c0 R08: 000000000000000d R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6672f9c150
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:usercopy_abort+0xb7/0xd0 mm/usercopy.c:102
Code: e8 fe e8 a1 ff 49 89 d9 4c 89 e1 48 89 ee 41 56 48 c7 c7 00 73 5b 8a 41 55 41 57 4c 8b 44 24 20 48 8b 54 24 18 e8 59 8b 85 ff <0f> 0b 48 c7 c3 00 71 5b 8a 49 89 df 49 89 d8 e9 71 ff ff ff 0f 1f
RSP: 0018:ffffc90003bcf9e0 EFLAGS: 00010286
RAX: 000000000000005b RBX: ffffffff8a5b7100 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff816931fc RDI: 0000000000000005
RBP: ffffffff8a5b72c0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: ffffffff8a5b7500
R13: 0000000000000000 R14: 0000000000400100 R15: ffffffff8a5b7100
FS:  0000555555b1b300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 0000000075655000 CR4: 0000000000350ee0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
