Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB271E00BD
	for <linux-hardening@vger.kernel.org>; Wed,  9 Oct 2024 18:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496830; cv=none; b=KGbtIQtv0ebmTBmGtd7yED4a795yUbVhaUFm38AQtXFziJ2bJ1OtjiF6nrgxqm//wMvNASrOjcAp3nC2XqFifg0i6GfG7yMl3+WbUBrCivJKUEfzn1SpwgZeMdnS8SBj6DiSjPH+IUCRUKGgf9Rd89dzo7+AWD6oCdoOoaiYovM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496830; c=relaxed/simple;
	bh=LoGWQnoZ7cN3EFsybU7FUQ8z2BvVUhdUn+aQHHQ7RMI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=udd15xepiS9Fz1kf99W59LmTUl6HdvFaP8x/dJoCF9lnukn08G93f/NvCDrebFZ2C7ofFrij61tGO6C10Pbd74ELtcNabj9udQEv52ViIeyWlC1RW7/iYbMhcfmKbEeraetiC0fwlcT8hIsNrn5TUnY+y2JE0DUy+Z2tSLk+O3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a1e69f6f51so1843395ab.1
        for <linux-hardening@vger.kernel.org>; Wed, 09 Oct 2024 11:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728496826; x=1729101626;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0wgd4SXl6zknOH4sWGdOvy3TWImFwRVnb4apVOK6wZw=;
        b=qI+HW72tJTfPplqjk6fho6kP2YbVyqJwqFc7M+Pd5yS+uowmZ2NeDXBsN7nlPHJIiX
         FoPhzUdPEqOsF3efPF83rpsmFXMTU63j3H2caaOl38wWVWAFaEGvjH+jKtRuA5eKjgS7
         SNvCq/zh3AGigHu5JAdAwFk4VhsRQMwv6ppT4ujYlFf+ivWt1QfZ5Ja1yTL+ObYNhyuE
         7yswbosfH653XJkvuPLxLB3UC3afBgtnrBzEEpAZeTEaLcorQPh2yYdUaQaIp4yi9ut5
         /8HTUXr+dm+VbfRZKbNbXr9MEPThfANXX9SFEToeeTzwQjhvSiVVDma9JZ4RWY5VpXHN
         VCkA==
X-Forwarded-Encrypted: i=1; AJvYcCU1Ik5JA8FOVDuY5gKDNEeBeCiSfChERmXxdimLTJ9o/eFGo7kI0ttImoL7U9iasTQtu7cHUSjr5qv2DT7nYHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjmL23N6xbIM4g/KnRvEYCO3qzLGxw5pGoG6xtxFI7Lmheb0s+
	gM8MrdoHyrpk/3+OjE3PCBQY2yMxm5w1YTdkMSgCLgosTTS5LRpLSYR432BvCWTgrNWdl7fl+tT
	vVpOgw+0G8Y6J7DMk94FEXevLEQ3FpynNmBHthgkoGfnBUb9tG51Xuqg=
X-Google-Smtp-Source: AGHT+IGxUIvov0XtpRxzR9eKbri2+eZ1eMFz17a1iXd7ZSNykWXYaxX4F4Ep6ESqIczFt0tzt6QVwjemeilnvTLDLApMFS5DUn7J
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a88:b0:3a3:94c5:e178 with SMTP id
 e9e14a558f8ab-3a397d39a51mr31553155ab.26.1728496826432; Wed, 09 Oct 2024
 11:00:26 -0700 (PDT)
Date: Wed, 09 Oct 2024 11:00:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6706c4ba.050a0220.1139e6.0007.GAE@google.com>
Subject: [syzbot] INFO: rcu detected stall in readlink_copy
From: syzbot <syzbot+fe1af52f6f805e2dd506@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, gustavoars@kernel.org, kees@kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4a9fe2a8ac53 dt-bindings: usb: dwc3-imx8mp: add compatible..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=152ec79f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4510af5d637450fb
dashboard link: https://syzkaller.appspot.com/bug?extid=fe1af52f6f805e2dd506
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13602d27980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/883c5319cb52/disk-4a9fe2a8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/caf4421ed2ef/vmlinux-4a9fe2a8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d8e3beb01d49/bzImage-4a9fe2a8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fe1af52f6f805e2dd506@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
 0-...D
 } 2668 jiffies s: 1077 root: 0x1/.
rcu: blocking rcu_node structures (internal RCU debug):

Sending NMI from CPU 1 to CPUs 0:
 _cond_resched include/linux/sched.h:2031 [inline]
 zap_pmd_range mm/memory.c:1742 [inline]
 zap_pud_range mm/memory.c:1768 [inline]
 zap_p4d_range mm/memory.c:1789 [inline]
 unmap_page_range+0x4b8/0x2fa0 mm/memory.c:1810
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 7765 Comm: udevd Not tainted 6.12.0-rc1-syzkaller-00027-g4a9fe2a8ac53 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:io_serial_out+0x8f/0xb0 drivers/tty/serial/8250/8250_port.c:413
Code: 48 8d 7d 40 44 89 e1 48 b8 00 00 00 00 00 fc ff df 48 89 fa d3 e3 48 c1 ea 03 80 3c 02 00 75 1c 66 03 5d 40 44 89 e8 89 da ee <5b> 5d 41 5c 41 5d c3 cc cc cc cc e8 f1 eb 0d ff eb a0 e8 7a ec 0d
RSP: 0018:ffffc90000006f60 EFLAGS: 00000002
RAX: 0000000000000032 RBX: 00000000000003f8 RCX: 0000000000000000
RDX: 00000000000003f8 RSI: ffffffff82a076c5 RDI: ffffffff936356a0
RBP: ffffffff93635660 R08: 0000000000000001 R09: 000000000000001f
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000032 R14: ffffffff82a07660 R15: 0000000000000000
FS:  00007fd9d9545c80(0000) GS:ffff8881f5800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2cc20214 CR3: 000000012251a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 serial_out drivers/tty/serial/8250/8250.h:142 [inline]
 serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:3322 [inline]
 serial8250_console_write+0xf9e/0x17c0 drivers/tty/serial/8250/8250_port.c:3393
 console_emit_next_record kernel/printk/printk.c:3092 [inline]
 console_flush_all+0x800/0xc60 kernel/printk/printk.c:3180
 __console_flush_and_unlock kernel/printk/printk.c:3239 [inline]
 console_unlock+0xd9/0x210 kernel/printk/printk.c:3279
 vprintk_emit+0x424/0x6f0 kernel/printk/printk.c:2407
 vprintk+0x7f/0xa0 kernel/printk/printk_safe.c:68
 _printk+0xc8/0x100 kernel/printk/printk.c:2432
 printk_stack_address arch/x86/kernel/dumpstack.c:72 [inline]
 show_trace_log_lvl+0x1b7/0x3d0 arch/x86/kernel/dumpstack.c:285
 sched_show_task kernel/sched/core.c:7582 [inline]
 sched_show_task+0x3f0/0x5f0 kernel/sched/core.c:7557
 show_state_filter+0xee/0x320 kernel/sched/core.c:7627
 k_spec drivers/tty/vt/keyboard.c:667 [inline]
 k_spec+0xed/0x150 drivers/tty/vt/keyboard.c:656
 kbd_keycode drivers/tty/vt/keyboard.c:1522 [inline]
 kbd_event+0xcbd/0x17a0 drivers/tty/vt/keyboard.c:1541
 input_handler_events_default+0x116/0x1b0 drivers/input/input.c:2549
 input_pass_values+0x777/0x8e0 drivers/input/input.c:126
 input_event_dispose drivers/input/input.c:352 [inline]
 input_handle_event+0xb30/0x14d0 drivers/input/input.c:369
 input_event drivers/input/input.c:398 [inline]
 input_event+0x83/0xa0 drivers/input/input.c:390
 hidinput_hid_event+0xa12/0x2410 drivers/hid/hid-input.c:1719
 hid_process_event+0x4b7/0x5e0 drivers/hid/hid-core.c:1540
 hid_input_array_field+0x535/0x710 drivers/hid/hid-core.c:1652
 hid_process_report drivers/hid/hid-core.c:1694 [inline]
 hid_report_raw_event+0xa02/0x11c0 drivers/hid/hid-core.c:2040
 __hid_input_report.constprop.0+0x341/0x440 drivers/hid/hid-core.c:2110
 hid_irq_in+0x35e/0x870 drivers/hid/usbhid/hid-core.c:285
 __usb_hcd_giveback_urb+0x389/0x6e0 drivers/usb/core/hcd.c:1650
 usb_hcd_giveback_urb+0x396/0x450 drivers/usb/core/hcd.c:1734
 dummy_timer+0x17c3/0x38d0 drivers/usb/gadget/udc/dummy_hcd.c:1988
 __run_hrtimer kernel/time/hrtimer.c:1691 [inline]
 __hrtimer_run_queues+0x20a/0xae0 kernel/time/hrtimer.c:1755
 hrtimer_run_softirq+0x17d/0x350 kernel/time/hrtimer.c:1772
 handle_softirqs+0x206/0x8d0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xac/0x110 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1037 [inline]
 sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1037
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__phys_addr_symbol+0x4b/0x80 arch/x86/mm/physaddr.c:42
Code: 00 48 81 fb ff ff ff 1f 77 30 e8 90 38 3f 00 48 c7 c0 10 a0 cc 88 48 ba 00 00 00 00 00 fc ff df 48 c1 e8 03 80 3c 10 00 75 18 <48> 8b 05 5e f3 b5 07 48 01 d8 5b c3 cc cc cc cc e8 60 38 3f 00 90
RSP: 0018:ffffc900030dfd30 EFLAGS: 00000246
RAX: 1ffffffff1199402 RBX: 0000000001000000 RCX: ffffffff8116ac82
RDX: dffffc0000000000 RSI: ffffffff8116ac90 RDI: 0000000000000007
RBP: 000000000000001c R08: 0000000000000007 R09: 000000001fffffff
R10: 0000000001000000 R11: 0000000000000000 R12: 0000000000000001
R13: ffff88811b99801c R14: ffffea00046e6600 R15: ffffffff81000000
 check_kernel_text_object mm/usercopy.c:138 [inline]
 __check_object_size mm/usercopy.c:254 [inline]
 __check_object_size+0x438/0x710 mm/usercopy.c:213
 check_object_size include/linux/thread_info.h:215 [inline]
 check_copy_size include/linux/thread_info.h:251 [inline]
 copy_to_user include/linux/uaccess.h:210 [inline]
 readlink_copy+0x83/0xf0 fs/namei.c:5230
 vfs_readlink+0x130/0x380 fs/namei.c:5271
 do_readlinkat+0x24c/0x390 fs/stat.c:551
 __do_sys_readlink fs/stat.c:574 [inline]
 __se_sys_readlink fs/stat.c:571 [inline]
 __x64_sys_readlink+0x78/0xc0 fs/stat.c:571
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd9d9671d47
Code: 73 01 c3 48 8b 0d e1 90 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 59 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b1 90 0d 00 f7 d8 64 89 01 48
RSP: 002b:00007ffd2e6d36d8 EFLAGS: 00000202 ORIG_RAX: 0000000000000059
RAX: ffffffffffffffda RBX: 000055ce56752bd0 RCX: 00007fd9d9671d47
RDX: 0000000000000400 RSI: 00007ffd2e6d3ae8 RDI: 00007ffd2e6d36e8
RBP: 00007ffd2e6d3f28 R08: 000055ce3b2f91fd R09: 0000000000000000
R10: 0000000000000007 R11: 0000000000000202 R12: 0000000000000200
R13: 00007ffd2e6d3ae8 R14: 00007ffd2e6d36e8 R15: 000055ce3b2f3a04
 </TASK>
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 hlock_class+0x4e/0x130 kernel/locking/lockdep.c:228
 </TASK>
task:kworker/u8:0    state:R  running task     stack:32568 pid:8426  tgid:8426  ppid:11     flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:25136 pid:8441  tgid:8441  ppid:274    flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 </TASK>
task:modprobe        state:R  running task     stack:23984 pid:8445  tgid:8445  ppid:274    flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:8450  tgid:8450  ppid:126    flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:8452  tgid:8452  ppid:46     flags:0x00004002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:8456  tgid:8456  ppid:46     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6854
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:8460  tgid:8460  ppid:46     flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6854
 __cond_resched+0x1b/0x30 kernel/sched/core.c:7192
 might_resched include/linux/kernel.h:73 [inline]
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0xe7/0x9c0 kernel/locking/mutex.c:752
 </TASK>
task:modprobe        state:R  running task     stack:25136 pid:8461  tgid:8461  ppid:274    flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:8464  tgid:8464  ppid:46     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6854
 __cond_resched+0x1b/0x30 kernel/sched/core.c:7192
 might_resched include/linux/kernel.h:73 [inline]
 down_write+0x74/0x200 kernel/locking/rwsem.c:1576
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:8468  tgid:8468  ppid:46     flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6854
 __cond_resched+0x1b/0x30 kernel/sched/core.c:7192
 might_resched include/linux/kernel.h:73 [inline]
 might_alloc include/linux/sched/mm.h:330 [inline]
 might_alloc include/linux/sched/mm.h:325 [inline]
 slab_pre_alloc_hook mm/slub.c:4037 [inline]
 slab_alloc_node mm/slub.c:4115 [inline]
 kmem_cache_alloc_noprof+0x24c/0x2b0 mm/slub.c:4142
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:8472  tgid:8472  ppid:46     flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6854
 __cond_resched+0x1b/0x30 kernel/sched/core.c:7192
 might_resched include/linux/kernel.h:73 [inline]
 down_read+0x78/0x330 kernel/locking/rwsem.c:1523
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:8476  tgid:8476  ppid:46     flags:0x00000000
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:8480  tgid:8480  ppid:274    flags:0x00000000
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:8484  tgid:8484  ppid:274    flags:0x00000000
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:8488  tgid:8488  ppid:46     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 </TASK>
task:modprobe        state:R  running task     stack:25136 pid:8490  tgid:8490  ppid:126    flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0aae897a90
RSP: 002b:00007ffc047e8db8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f0aae988860 RCX: 00007f0aae897a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f0aae988860 R08: 0000000000000001 R09: 1718726af67628c6
R10: 00007ffc047e8c70 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f0aae98c658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:8492  tgid:8492  ppid:274    flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:8497  tgid:8497  ppid:126    flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5b3d07ba90
RSP: 002b:00007fff46596cd8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f5b3d16c860 RCX: 00007f5b3d07ba90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f5b3d16c860 R08: 0000000000000001 R09: 4e7b09adc84dcf9c
R10: 00007fff46596b90 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f5b3d170658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:8502  tgid:8502  ppid:126    flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:8503  tgid:8503  ppid:274    flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:8507  tgid:8507  ppid:126    flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 </TASK>
task:modprobe        state:R  running task     stack:23984 pid:8508  tgid:8508  ppid:274    flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd4b3056a90
RSP: 002b:00007fff67866368 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fd4b3147860 RCX: 00007fd4b3056a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007fd4b3147860 R08: 0000000000000001 R09: 28818cea3752b27a
R10: 00007fff67866220 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fd4b314b658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:8511  tgid:8511  ppid:28     flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f26ef268a90
RSP: 002b:00007ffe2093c2d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f26ef359860 RCX: 00007f26ef268a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f26ef359860 R08: 0000000000000001 R09: a96c7241bd8de9a0
R10: 00007ffe2093c190 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f26ef35d658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25136 pid:8516  tgid:8516  ppid:126    flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:8517  tgid:8517  ppid:28     flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 </TASK>
task:kworker/u8:4    state:R  running task     stack:32568 pid:8521  tgid:8521  ppid:126    flags:0x00004000
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25136 pid:8528  tgid:8528  ppid:274    flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:8532  tgid:8532  ppid:11     flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6854
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:8537  tgid:8537  ppid:274    flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:8542  tgid:8542  ppid:11     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 </TASK>
task:modprobe        state:R  running task     stack:24416 pid:8544  tgid:8544  ppid:46     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff618bf2a90
RSP: 002b:00007fff7847df38 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007ff618ce3860 RCX: 00007ff618bf2a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007ff618ce3860 R08: 0000000000000001 R09: 39a60305f82f3c29
R10: 00007fff7847ddf0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007ff618ce7658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:23984 pid:8547  tgid:8547  ppid:11     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff68227ea90
RSP: 002b:00007ffef5261078 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007ff68236f860 RCX: 00007ff68227ea90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007ff68236f860 R08: 0000000000000001 R09: 2ac2ea6611f180c8
R10: 00007ffef5260f30 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007ff682373658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:24704 pid:8552  tgid:8552  ppid:11     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:8553  tgid:8553  ppid:46     flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f72bc4cba90
RSP: 002b:00007ffce10a73f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f72bc5bc860 RCX: 00007f72bc4cba90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f72bc5bc860 R08: 0000000000000001 R09: 5b9777350fdbf76d
R10: 00007ffce10a72b0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f72bc5c0658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:8557  tgid:8557  ppid:11     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 </TASK>
task:modprobe        state:R  running task     stack:24704 pid:8563  tgid:8563  ppid:46     flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 </TASK>
task:modprobe        state:R  running task     stack:25136 pid:8566  tgid:8566  ppid:274    flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 </TASK>
task:modprobe        state:R  running task     stack:25136 pid:8572  tgid:8572  ppid:274    flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:8573  tgid:8573  ppid:46     flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6037c51a90
RSP: 002b:00007fff5719c348 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f6037d42860 RCX: 00007f6037c51a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f6037d42860 R08: 0000000000000001 R09: f809886feeca8276
R10: 00007fff5719c200 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f6037d46658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:23984 pid:8577  tgid:8577  ppid:274    flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fead8f43a90
RSP: 002b:00007ffec44201a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fead9034860 RCX: 00007fead8f43a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007fead9034860 R08: 0000000000000001 R09: 6d98ccabcb9d2037
R10: 00007ffec4420060 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fead9038658 R15: 0000000000000001
 </TASK>
task:kworker/u8:5    state:R  running task     stack:32568 pid:8582  tgid:8582  ppid:274    flags:0x00004000
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:8583  tgid:8583  ppid:46     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:8587  tgid:8587  ppid:46     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff2c9973a90
RSP: 002b:00007ffcf3eb6008 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007ff2c9a64860 RCX: 00007ff2c9973a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007ff2c9a64860 R08: 0000000000000001 R09: b53e59ac2040563b
R10: 00007ffcf3eb5ec0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007ff2c9a68658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:24704 pid:8592  tgid:8592  ppid:46     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:8594  tgid:8594  ppid:11     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 </TASK>
task:modprobe        state:R  running task     stack:25136 pid:8596  tgid:8596  ppid:28     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:8597  tgid:8597  ppid:46     flags:0x00000000
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:24168 pid:8599  tgid:8599  ppid:11     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5de59fca90
RSP: 002b:00007ffd43889b78 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f5de5aed860 RCX: 00007f5de59fca90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f5de5aed860 R08: 0000000000000001 R09: a02a73f13a98f135
R10: 00007ffd43889a30 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f5de5af1658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:8602  tgid:8602  ppid:274    flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff5c754ca90
RSP: 002b:00007ffcb05230f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007ff5c763d860 RCX: 00007ff5c754ca90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007ff5c763d860 R08: 0000000000000001 R09: bdf12829548acda2
R10: 00007ffcb0522fb0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007ff5c7641658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:8607  tgid:8607  ppid:274    flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6854
 __cond_resched+0x1b/0x30 kernel/sched/core.c:7192
 _cond_resched include/linux/sched.h:2031 [inline]
 zap_pmd_range mm/memory.c:1742 [inline]
 zap_pud_range mm/memory.c:1768 [inline]
 zap_p4d_range mm/memory.c:1789 [inline]
 unmap_page_range+0x4b8/0x2fa0 mm/memory.c:1810
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 hlock_class+0x4e/0x130 kernel/locking/lockdep.c:228
 </TASK>
task:modprobe        state:R  running task     stack:25136 pid:8612  tgid:8612  ppid:46     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f518ed31a90
RSP: 002b:00007fffe7838b28 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f518ee22860 RCX: 00007f518ed31a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f518ee22860 R08: 0000000000000001 R09: 35f8288e1f9b669c
R10: 00007fffe78389e0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f518ee26658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:8617  tgid:8617  ppid:46     flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:8621  tgid:8621  ppid:28     flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:8623  tgid:8623  ppid:274    flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3cf1fbca90
RSP: 002b:00007ffc1b31e438 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f3cf20ad860 RCX: 00007f3cf1fbca90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f3cf20ad860 R08: 0000000000000001 R09: b17e524f852ab658
R10: 00007ffc1b31e2f0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f3cf20b1658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:24704 pid:8626  tgid:8626  ppid:28     flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6854
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:8629  tgid:8629  ppid:11     flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f151967fa90
RSP: 002b:00007ffdfc4bdd78 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f1519770860 RCX: 00007f151967fa90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f1519770860 R08: 0000000000000001 R09: 3cbb6e3238645582
R10: 00007ffdfc4bdc30 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f1519774658 R15: 0000000000000001
 </TASK>
task:kworker/u8:0    state:R  running task     stack:32568 pid:8634  tgid:8634  ppid:11     flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:8635  tgid:8635  ppid:126    flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe1f39dca90
RSP: 002b:00007fff26adf368 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fe1f3acd860 RCX: 00007fe1f39dca90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007fe1f3acd860 R08: 0000000000000001 R09: b2cc89cecc1f5d5b
R10: 00007fff26adf220 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fe1f3ad1658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:8639  tgid:8639  ppid:126    flags:0x00000000
Call Trace:
 <TASK>
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 hlock_class+0x4e/0x130 kernel/locking/lockdep.c:228
 trace_lock_acquire+0x14a/0x1d0 include/trace/events/lock.h:24


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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
