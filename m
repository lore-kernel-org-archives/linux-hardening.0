Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850A7C77B75
	for <linux-hardening@archiver.kernel.org>; Sun,  7 May 2023 11:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjEGLDr (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 7 May 2023 07:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjEGLDq (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 7 May 2023 07:03:46 -0400
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40181BD7
        for <linux-hardening@vger.kernel.org>; Sun,  7 May 2023 04:03:44 -0700 (PDT)
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-33117143894so21990395ab.3
        for <linux-hardening@vger.kernel.org>; Sun, 07 May 2023 04:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683457424; x=1686049424;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c72EbN12zCyTbiKnRkzFCPBXm2izdNMcWEWjtzkemnI=;
        b=mANMwTyu7qvFMMlcmn3zgbxD3z8yEtuA+15XRt6/579qrbOBw4lij4qDLbMiIQAOE7
         K6M6CYac4/IlQ7B6sSdX4KMLT3QfBIRg9V9EKrWTkvlB1LiU3jyG94iGap6Gi5vMzGF8
         mYHoKb+qrwwVOxcp53TDB4c4W4m4vfIQPo1WCVrXdZdy9WlYJUrvuVY1G0Pvg4vdPIxA
         chEnYXhg4hGJ0iWlFLSIgV2JyF5NqdyLUV9fY6QX+zUCNTqR/TshOQ4iz/thzmV2C8ed
         DWgwAocEUKKdp5M+tFt1qKL5rRnZ6z5OZEMp3760Ho2RVmQczQvYWDe6h0IAbWR+iwZ6
         7PEQ==
X-Gm-Message-State: AC+VfDyieBJ05ml06R58Xin1PDJQAX10lGaTX9gynGM9lAahnIhK37pi
        r5e5mrdMmseGSIL17GF/6N84SI2MhubnAk3GE3XOGelzU3w4
X-Google-Smtp-Source: ACHHUZ6DqG3e4uWgn2+a5rn8tOfmIV+GAT/IRvlJIvIOUkV7lcz2oa50DZv8HeJ0eEYjmcVXxyzB8JLTno/vzMaL35fS696srlhv
MIME-Version: 1.0
X-Received: by 2002:a92:cb42:0:b0:331:550:2cc3 with SMTP id
 f2-20020a92cb42000000b0033105502cc3mr3655722ilq.1.1683457424130; Sun, 07 May
 2023 04:03:44 -0700 (PDT)
Date:   Sun, 07 May 2023 04:03:44 -0700
In-Reply-To: <0000000000004cf5c205faf1c7f3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c2892305fb187969@google.com>
Subject: Re: [syzbot] [hardening?] [mm?] BUG: bad usercopy in fpa_set
From:   syzbot <syzbot+cb76c2983557a07cdb14@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    457391b03803 Linux 6.3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13565c32280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=385e197a58ca4afe
dashboard link: https://syzkaller.appspot.com/bug?extid=cb76c2983557a07cdb14
compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16426cb8280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124f0d7a280000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/c35b5b2731d2/non_bootable_disk-457391b0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2a1bf3bafeb6/vmlinux-457391b0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/21f1e3b4a5a9/zImage-457391b0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cb76c2983557a07cdb14@syzkaller.appspotmail.com

usercopy: Kernel memory overwrite attempt detected to SLUB object 'task_struct' (offset 96, size 116)!
------------[ cut here ]------------
kernel BUG at mm/usercopy.c:102!
Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 1 PID: 3090 Comm: syz-executor177 Not tainted 6.3.0-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at usercopy_abort+0x98/0x9c mm/usercopy.c:102
LR is at __wake_up_klogd.part.0+0x7c/0xac kernel/printk/printk.c:3807
pc : [<817b706c>]    lr : [<802aef04>]    psr: 60000013
sp : dfaade58  ip : dfaadd98  fp : dfaade7c
r10: 0000001a  r9 : 00003e4d  r8 : 83e4dc60
r7 : dde85220  r6 : 00000000  r5 : 00000074  r4 : 00000060
r3 : 00000000  r2 : 00000000  r1 : ddddc584  r0 : 00000066
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 30c5387d  Table: 841e40c0  DAC: 00000000
Register r0 information: non-paged memory
Register r1 information: non-slab/vmalloc memory
Register r2 information: NULL pointer
Register r3 information: NULL pointer
Register r4 information: non-paged memory
Register r5 information: non-paged memory
Register r6 information: NULL pointer
Register r7 information: non-slab/vmalloc memory
Register r8 information: slab task_struct start 83e4dc00 pointer offset 96 size 2944
Register r9 information: non-paged memory
Register r10 information: non-paged memory
Register r11 information: 2-page vmalloc region starting at 0xdfaac000 allocated at kernel_clone+0x9c/0x3d4 kernel/fork.c:2683
Register r12 information: 2-page vmalloc region starting at 0xdfaac000 allocated at kernel_clone+0x9c/0x3d4 kernel/fork.c:2683
Process syz-executor177 (pid: 3090, stack limit = 0xdfaac000)
Stack: (0xdfaade58 to 0xdfaae000)
de40:                                                       81da9fcc 81d8176c
de60: 81d94abc 00000060 00000074 00003e4d dfaadeac dfaade80 804956ec 817b6fe0
de80: 00000074 dfaade90 80216d0c 83e4dc60 00000074 00000000 83e4dcd4 dde85220
dea0: dfaadee4 dfaadeb0 804b5624 80495620 00000074 0000000f dfaaded4 83e4dc60
dec0: 00000074 0000000f 00000000 00000000 833edc00 0000001a dfaadefc dfaadee8
dee0: 80209fc8 804b5454 00000000 83e4dc00 dfaadf74 dfaadf00 8020a728 80209f44
df00: 00000000 00000000 817dae24 802756e8 dfaadf74 dfaadf20 8027c28c 817dae00
df20: dfaadf3c 00000000 00000000 833edc00 80276968 60000013 8178d188 817a1de8
df40: dfaadf5c a154bf06 00000000 83e4dc00 00000000 a154bf06 83e4dc00 00000000
df60: 0000000f 00000000 dfaadfa4 dfaadf78 80251188 8020a480 00000000 a154bf06
df80: 00000000 00000000 000118c0 0000001a 80200288 833edc00 00000000 dfaadfa8
dfa0: 80200060 80250f20 00000000 00000000 0000000f 00000c13 00000000 00000000
dfc0: 00000000 00000000 000118c0 0000001a 000f4240 00000000 7ec23ca4 00003a97
dfe0: 7ec23c90 7ec23c80 00010624 0002a910 00000010 0000000f 00000000 00000000
Backtrace: 
[<817b6fd4>] (usercopy_abort) from [<804956ec>] (__check_heap_object+0xd8/0xf4 mm/slub.c:4762)
[<80495614>] (__check_heap_object) from [<804b5624>] (check_heap_object mm/usercopy.c:196 [inline])
[<80495614>] (__check_heap_object) from [<804b5624>] (__check_object_size mm/usercopy.c:251 [inline])
[<80495614>] (__check_heap_object) from [<804b5624>] (__check_object_size+0x1dc/0x2fc mm/usercopy.c:213)
 r8:dde85220 r7:83e4dcd4 r6:00000000 r5:00000074 r4:83e4dc60
[<804b5448>] (__check_object_size) from [<80209fc8>] (check_object_size include/linux/thread_info.h:215 [inline])
[<804b5448>] (__check_object_size) from [<80209fc8>] (__copy_from_user include/linux/uaccess.h:79 [inline])
[<804b5448>] (__check_object_size) from [<80209fc8>] (user_regset_copyin include/linux/regset.h:268 [inline])
[<804b5448>] (__check_object_size) from [<80209fc8>] (fpa_set+0x90/0xb0 arch/arm/kernel/ptrace.c:589)
 r10:0000001a r9:833edc00 r8:00000000 r7:00000000 r6:0000000f r5:00000074
 r4:83e4dc60
[<80209f38>] (fpa_set) from [<8020a728>] (copy_regset_from_user include/linux/regset.h:337 [inline])
[<80209f38>] (fpa_set) from [<8020a728>] (arch_ptrace+0x2b4/0x40c arch/arm/kernel/ptrace.c:764)
 r5:83e4dc00 r4:00000000
[<8020a474>] (arch_ptrace) from [<80251188>] (__do_sys_ptrace kernel/ptrace.c:1296 [inline])
[<8020a474>] (arch_ptrace) from [<80251188>] (sys_ptrace+0x274/0x4f4 kernel/ptrace.c:1269)
 r7:00000000 r6:0000000f r5:00000000 r4:83e4dc00
[<80250f14>] (sys_ptrace) from [<80200060>] (ret_fast_syscall+0x0/0x1c arch/arm/mm/proc-v7.S:66)
Exception stack(0xdfaadfa8 to 0xdfaadff0)
dfa0:                   00000000 00000000 0000000f 00000c13 00000000 00000000
dfc0: 00000000 00000000 000118c0 0000001a 000f4240 00000000 7ec23ca4 00003a97
dfe0: 7ec23c90 7ec23c80 00010624 0002a910
 r9:833edc00 r8:80200288 r7:0000001a r6:000118c0 r5:00000000 r4:00000000
Code: e3090fd0 e34801da e58dc000 ebfff87f (e7f001f2) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	e3090fd0 	movw	r0, #40912	; 0x9fd0
   4:	e34801da 	movt	r0, #33242	; 0x81da
   8:	e58dc000 	str	ip, [sp]
   c:	ebfff87f 	bl	0xffffe210
* 10:	e7f001f2 	udf	#18 <-- trapping instruction


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
