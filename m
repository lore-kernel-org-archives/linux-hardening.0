Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE89CEB64D9
	for <linux-hardening@archiver.kernel.org>; Tue,  4 Jul 2023 14:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjGDOB7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 4 Jul 2023 10:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjGDOBi (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 4 Jul 2023 10:01:38 -0400
Received: from mail-pg1-f206.google.com (mail-pg1-f206.google.com [209.85.215.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54FB1727
        for <linux-hardening@vger.kernel.org>; Tue,  4 Jul 2023 07:01:17 -0700 (PDT)
Received: by mail-pg1-f206.google.com with SMTP id 41be03b00d2f7-55ac8f85360so5317785a12.0
        for <linux-hardening@vger.kernel.org>; Tue, 04 Jul 2023 07:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688479275; x=1691071275;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OAJrIpPYsWuzkKicppsd7MNNDIGXlm7pXpjIQFZBeio=;
        b=C5BsoSgZlfA9bk/1tYF+rsWfT/pncfQH65YEUVF1RZabg8iwj27fFDPR8G4TFxCZ5Q
         j6iGGc22f4CH1b1+AXjc27CImEI3Hh+heKj2Y8kQ1eEpPVDVj367Zx3iIaD7Nqs15+X3
         aAAVnn/AWIEUgRlNaltvHqs3svO/VxedaeDkGtHPDmjt6rcJ0bsXAA3gI9jRDpDZuuPy
         v7dr/cP32kV9EVvP9BJ/lnBQjYLeX1S1zwF08hAEQi+FllBb6O6awjspV5YkbqN04uSS
         3yDB6A5oELiO/6iX6QD5LHs4Y3zLJf+OYBGiDS1O5jiy+9cUkun8n0vnfpBIDHdDlFFa
         QZGw==
X-Gm-Message-State: ABy/qLYjoIceexqlHsVDy4GZHa7llf5FP7UXXJ+eV29X+Q4eHoW3Ln9E
        xVaeoQ4zR1nMxdjCv4pJ6EkQGzOd7KKE2zIRSIpnFit+CQE/
X-Google-Smtp-Source: APBJJlGX4eLqwacKHZtmGRo7GlT1QTl55Rjvwfiq4SMYYmeIA3CYU2tiLQdewQDtU+lFVqZ/KMRTt3ByDYq2La4t9QO2UdnWjMpr
MIME-Version: 1.0
X-Received: by 2002:a63:5c02:0:b0:553:b2a0:4ddd with SMTP id
 q2-20020a635c02000000b00553b2a04dddmr7882265pgb.2.1688479275716; Tue, 04 Jul
 2023 07:01:15 -0700 (PDT)
Date:   Tue, 04 Jul 2023 07:01:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007096ce05ffa9b7aa@google.com>
Subject: [syzbot] [arm?] BUG: unable to handle kernel paging request in invoke_syscall
From:   syzbot <syzbot+a5638594f1bc152f1200@syzkaller.appspotmail.com>
To:     catalin.marinas@arm.com, keescook@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3a8a670eeeaa Merge tag 'net-next-6.5' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1652699f280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ce7f4ca96cdf82c7
dashboard link: https://syzkaller.appspot.com/bug?extid=a5638594f1bc152f1200
compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1645c714a80000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-3a8a670e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a940531a9b86/vmlinux-3a8a670e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4f3cbae5be61/Image-3a8a670e.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a5638594f1bc152f1200@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address bfff800082cebd10
Mem abort info:
  ESR = 0x0000000086000004
  EC = 0x21: IABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000042480000
[bfff800082cebd10] pgd=10000000bffff803, p4d=10000000bffff803, pud=10000000bfffe803, pmd=1000000043834003, pte=0068000048f30f07
Internal error: Oops: 0000000086000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 3234 Comm: udevd Not tainted 6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : 0xbfff800082cebd10
lr : 0xffff800082cebd10
sp : ffff800082cf3df0
x29: ffff800082cf3df0 x28: f9ff00000705af40 x27: 0000000000000000
x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
x23: 0000000060000000 x22: 0000ffffa736068c x21: 00000000ffffffff
x20: f9ff00000705af40 x19: ffff800082cf3eb0 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: ffff800082cf3c88
x14: 0000000000000000 x13: 0000000000001000 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000701 x9 : 0000000600000000
x8 : 000000001dcd6500 x7 : 0000000000000027 x6 : 0000ffffef8c1df8
x5 : 0000ffffef8c1df8 x4 : 0000000000000008 x3 : 0000000000000000
x2 : 0000000000000000 x1 : f9ff00000705af40 x0 : 0000000000000000
Call trace:
 0xbfff800082cebd10
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
Code: 00000002 00000000 eed50f00 041d12ac (82cebd30) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	00000002 	udf	#2
   4:	00000000 	udf	#0
   8:	eed50f00 	.inst	0xeed50f00 ; undefined
   c:	041d12ac 	.inst	0x041d12ac ; undefined
* 10:	82cebd30 	.inst	0x82cebd30 ; undefined <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
