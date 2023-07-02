Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC2DEB64DD
	for <linux-hardening@archiver.kernel.org>; Sun,  2 Jul 2023 17:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjGBRR7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 2 Jul 2023 13:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjGBRR7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 2 Jul 2023 13:17:59 -0400
Received: from mail-pf1-f207.google.com (mail-pf1-f207.google.com [209.85.210.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258E6E5E
        for <linux-hardening@vger.kernel.org>; Sun,  2 Jul 2023 10:17:57 -0700 (PDT)
Received: by mail-pf1-f207.google.com with SMTP id d2e1a72fcca58-66a44bf4651so4167875b3a.1
        for <linux-hardening@vger.kernel.org>; Sun, 02 Jul 2023 10:17:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688318276; x=1690910276;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oxkh1rlVYSPaTWCnwoOH+MUQYhTKlCRUMgq6i3k0l+U=;
        b=k2Q95EBg3qguoTuRL6rx8AVODkE7fhnSy89esEhgwFVXASMVuVRN5koTA4cy8nUDKK
         f1AcwuOZMX3BJnTCLGTWGaEp0Ep813We73wzHa5aIaqI9UcA8d7MlH1piihEi4u1mQfU
         0oOVhfAieOTJXy8ElYABDbwo0OWfWT17Xiq6JRUiz7s7TsClyKveX9WS0JRvQvJjRWOV
         WqQu276gHjQ50b12eyMU4sg2SUssSIl8SI6ctLmbwXAp0x3ZlfxbMgltyEKWIc8k6ey8
         uw3X6sWAJ0vLx/BbHXnjBBN7dbDi7VtwCXybLAMiGedO6xgiApRIot59HHwi49sjinpI
         HPoQ==
X-Gm-Message-State: AC+VfDyyDWkLItsFn3QfPJ9e3QX7LsIAQ9zJ+YoaE8qqat8TudRghjQs
        kRv4wlF+h+Gb2hSuxA2RKZpDc0A1dwT95FcsVsdtt9vFCP/c
X-Google-Smtp-Source: ACHHUZ4jxb0ETuqCVb4he+NlUfpEskuZySMvmo5XV6rQfDo7VVCnw06aWXEwh5ekbYKojx9vSqDqIU3H59qStqGeN+2/jKzA1D58
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:198f:b0:67a:a9bf:f88b with SMTP id
 d15-20020a056a00198f00b0067aa9bff88bmr9254326pfl.3.1688318276496; Sun, 02 Jul
 2023 10:17:56 -0700 (PDT)
Date:   Sun, 02 Jul 2023 10:17:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002373f005ff843b58@google.com>
Subject: [syzbot] [mm?] [reiserfs?] kernel panic: stack is corrupted in ___slab_alloc
From:   syzbot <syzbot+cf0693aee9ea61dda749@syzkaller.appspotmail.com>
To:     42.hyeyoo@gmail.com, akpm@linux-foundation.org, cl@linux.com,
        iamjoonsoo.kim@lge.com, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        penberg@kernel.org, reiserfs-devel@vger.kernel.org,
        rientjes@google.com, roman.gushchin@linux.dev,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e8f75c0270d9 Merge tag 'x86_sgx_for_v6.5' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=168b84fb280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a98ec7f738e43bd4
dashboard link: https://syzkaller.appspot.com/bug?extid=cf0693aee9ea61dda749
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10310670a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1220c777280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f27c1d41217a/disk-e8f75c02.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/843ae5d5c810/vmlinux-e8f75c02.xz
kernel image: https://storage.googleapis.com/syzbot-assets/da48bc4c0ec1/bzImage-e8f75c02.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/658601e354e4/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cf0693aee9ea61dda749@syzkaller.appspotmail.com

Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: ___slab_alloc+0x12c3/0x1400 mm/slub.c:3270
CPU: 0 PID: 5009 Comm: syz-executor248 Not tainted 6.4.0-syzkaller-01406-ge8f75c0270d9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 panic+0x686/0x730 kernel/panic.c:340
 __stack_chk_fail+0x19/0x20 kernel/panic.c:759
 ___slab_alloc+0x12c3/0x1400 mm/slub.c:3270


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
