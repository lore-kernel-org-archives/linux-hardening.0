Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02AAC61DA4
	for <linux-hardening@archiver.kernel.org>; Sat, 11 Feb 2023 16:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjBKQJa (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 11 Feb 2023 11:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjBKQJ3 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 11 Feb 2023 11:09:29 -0500
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156F825288
        for <linux-hardening@vger.kernel.org>; Sat, 11 Feb 2023 08:08:54 -0800 (PST)
Received: by mail-il1-f205.google.com with SMTP id c11-20020a056e020bcb00b0030be9d07d63so6454907ilu.0
        for <linux-hardening@vger.kernel.org>; Sat, 11 Feb 2023 08:08:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hc23FUJSZ8aR6OzhlvIdcqSFxxNfNJFxBa4eo3vhlkc=;
        b=wI07NtNpgc3QmVIxpuxbzhufRFli1B01CXPPka+90YNJQzvYKAHt8GmlCGMpPvH/hf
         ik79hbbsHNZlMh5wiMKL2T/ta1BTYkHlOcLq4k56Tt5jAwWTf1EEmpUekKWnhmDe7pHe
         9PZj0nPuRc+CShLpwFk/2SShQ6CY8cGGVZ01Da6h03FTVRXByOpFQCmkIKBts7xlvf/b
         VqSD3dcOVpMyIldrbAPVNl0NLYbDgKIlx9LhDld0OVXmrs1sm1PrR+xDnoI9rDImeqkZ
         rhndotTgf8HCllnju1xCvzvWQoESBX4TWfpytt65ZJjh/IoX1UNv01TLClXB8uMaqA1m
         xXVA==
X-Gm-Message-State: AO0yUKVx3ksW3fpLBv17Fdj0orgfpXPnL3WkpxD1V9VKHvgdpM/f6FJi
        Jz9dmfAnk+XI1S1Icigy39KnzUHLQkeo7UflVoi9cLDiz6wh
X-Google-Smtp-Source: AK7set+r3wGoWlQkFpfdEAQhpl7nxVexqMNSLilkNHipwws3leieNBL+EFHrQiYpLZG+p++hztcxufneC5s8vtb/Qr4xi94AkahH
MIME-Version: 1.0
X-Received: by 2002:a02:c6c4:0:b0:3c4:97a3:255f with SMTP id
 r4-20020a02c6c4000000b003c497a3255fmr4060690jan.50.1676131732858; Sat, 11 Feb
 2023 08:08:52 -0800 (PST)
Date:   Sat, 11 Feb 2023 08:08:52 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000088b3d905f46ed421@google.com>
Subject: [syzbot] BUG: bad usercopy in io_openat2_prep
From:   syzbot <syzbot+cdd9922704fc75e03ffc@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ca72d58361ee Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=14a882f3480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3e78232c1ed2b43
dashboard link: https://syzkaller.appspot.com/bug?extid=cdd9922704fc75e03ffc
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1203777b480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124c1ea3480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e2c91688b4cd/disk-ca72d583.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/af105438bee6/vmlinux-ca72d583.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4a28ec4f8f7e/Image-ca72d583.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cdd9922704fc75e03ffc@syzkaller.appspotmail.com

usercopy: Kernel memory overwrite attempt detected to SLUB object 'pid' (offset 24, size 24)!
------------[ cut here ]------------
kernel BUG at mm/usercopy.c:102!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 4411 Comm: syz-executor101 Not tainted 6.2.0-rc6-syzkaller-17549-gca72d58361ee #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : usercopy_abort+0x90/0x94
lr : usercopy_abort+0x90/0x94
sp : ffff80000fb8bb90
x29: ffff80000fb8bba0 x28: 000000000000001c x27: ffff0000c76d1a00
x26: 00000000200000c0 x25: ffff80000cf42000 x24: fffffc0000000000
x23: 05ffc00000000200 x22: fffffc0003250440 x21: ffff0000c9411618
x20: 0000000000000000 x19: 0000000000000018 x18: 0000000000002bee
x17: 63656a626f204255 x16: ffff0000c76d23f8 x15: ffff80000dbc2118
x14: ffff0000c76d1a00 x13: 00000000ffffffff x12: ffff0000c76d1a00
x11: ff808000081bbb4c x10: 0000000000000000 x9 : 295e44a4d7b9f900
x8 : 295e44a4d7b9f900 x7 : ffff80000bf60b80 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0001fefbef08 x1 : 0000000100000000 x0 : 000000000000005d
Call trace:
 usercopy_abort+0x90/0x94
 __check_heap_object+0xa8/0x100
 __check_object_size+0x208/0x6b8
 io_openat2_prep+0xcc/0x2b8
 io_submit_sqes+0x338/0xbb8
 __arm64_sys_io_uring_enter+0x168/0x1308
 invoke_syscall+0x64/0x178
 el0_svc_common+0xbc/0x180
 do_el0_svc+0x48/0x110
 el0_svc+0x58/0x14c
 el0t_64_sync_handler+0x84/0xf0
 el0t_64_sync+0x190/0x194
Code: 9133a800 aa0903e1 f90003e8 94e6c80f (d4210000) 
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
