Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D6413DDB0
	for <linux-hardening@vger.kernel.org>; Fri, 17 May 2024 20:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715977369; cv=none; b=IMAf/hhnpi2pKfR2v+FQFx45YxbAyo8CfpoAoBFRAs5CvcfNeBhQ2QZsVBlsl9XNAyYb7NDTAkLflpekjygG3H/Lf59nDLgapXBkHXAWYZiZfYyoIHGfulN+FElK6gqwuJMcT3wnMW83zCorDpr2Xqwq6oc8XWdRl+i9hJYWVS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715977369; c=relaxed/simple;
	bh=zCP9p5DazSmD8jpaLDilhAropKLjmvEgx/aHY8ray1k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QCsbAaxnOfYwbEqvACtqu6spCQytnt5MhHoJ4ZHsGRLHJ45VQuLAISy1mopXaMSBJFG+7Phw5LGl4e7gzspimpU13xY7Z8uEXWiNKHzHeb5Vxl8ZWuE5HwXfg9bbHZ/pXM/NcvlkhlrNQCzXaOS9vIYtyVc2qkdBvplsDBKzY2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0cGDEcla; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0cGDEcla"
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-7e17eba6ba3so831515039f.3
        for <linux-hardening@vger.kernel.org>; Fri, 17 May 2024 13:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715977366; x=1716582166; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D7DM0Nh6MbSVPhbmkBCW9PHR6CHMneFfFGcAG6fF5BM=;
        b=0cGDEclaSnhNAKLSNwEcm0TLKXUrx5Ew9m1fbd3h0yQaw/2k8NnKZLg+ALKTMQIGNC
         9vl8UlEAtb6+wqrz/iSE3dZRXjDCwypGpLwltZta1bg2u77ATCo+m2rG4Hnis9Cj43Tw
         phvwUXIU2Vt7ey06hBVtmkVpDuYQ26Nq6OGk+Aq+VU4TaqwxtJltuKg0jRHp9Tk8uwVr
         E0alXlOaxaYwAMCbZJea1pP2d6RckDD4AxNhx7NR5+uY+Hg/7TG6yNEjjZpzO0PjJXh6
         Ze77MwsQRaN+jtHsOGMz7nmOBfITbxBQioEcqx9FECJthevsaxzc7H1BuV31d7fRlbey
         KO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715977366; x=1716582166;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D7DM0Nh6MbSVPhbmkBCW9PHR6CHMneFfFGcAG6fF5BM=;
        b=X5L9P72qNVMBwoX4GaHP6JjU34YRam9Skz3sOSIbncib9rWt37AFKk5pPq3UAoNj3X
         kuvWxaG80aEk1YphWRd9jxZeSWjOy4zb4ATcHc64RthKpdVZ5w39T67Wn/bLGtF49ZHt
         Eizv/Qb/M6yQytLL9Ry7NHzx8Ydim1Sq31seslLU1r9ipb7icaBT+XLGR9/TeCcoGWBC
         ZNMOVAbIBolQAfu+rdLC3Q1khwtofSuvlWnko/v3aQ1rPwY2q/EKgTocECD3wtydjumI
         kVjiqiqmH6i13oPgi1crh7Azrc6oe13gFjTynRhFJa57S4PvC70gzBjmOCuBhDrSJIVO
         cCfw==
X-Forwarded-Encrypted: i=1; AJvYcCX2FBA9a4iWh7T+8HdRi6wWl3oadAesBsZtmsA1Zs4RmB7rXT6DLlIXvZkB3RmFizpkLAqHV9WkUhlfRFhfj81lFfIIOM9Yy9snPLlO2a29
X-Gm-Message-State: AOJu0Yw1xFEB7A5vH3BjFdh32uhBZv8EJFUT31lYcnQ+uQVAyK4PZMgd
	RwgcAVDD+0N8eZA2jn8/kMbyYzmdcGOrLRCaqIZ1NSP35ad5A5fZlTkpRn64a3GalS/mckJq4VH
	b7+YxHAVq7pNmuwpu82ItTQ==
X-Google-Smtp-Source: AGHT+IEfzcIHL3aw4YYGj6jIF23GXxwmDFMKDO2f0kNIal/VHLvCveT/oVQ6Bz6/dmvmREEIyJ0p9emzA+0NcVytQg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6602:3f85:b0:7da:9d28:6578 with
 SMTP id ca18e2360f4ac-7e1b521c6famr81756139f.3.1715977365684; Fri, 17 May
 2024 13:22:45 -0700 (PDT)
Date: Fri, 17 May 2024 20:22:44 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJO8R2YC/3WNTQ7CIBCFr9LM2jFAqY2ueg/TBdApJVFooBJNw
 93F7s1bfS/vZ4dE0VGCW7NDpOySC76CODVgFuUtoZsqg2BCso71qCXWDPptxVcig1y1Sl96PRn iUFtrpNm9j8X7WHlxaQvxcxxk/nP/b2WOVR1j7WyuRmg52BDsg84mPGEspXwBVUmrHa8AAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715977364; l=3277;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=zCP9p5DazSmD8jpaLDilhAropKLjmvEgx/aHY8ray1k=; b=8vlKBluIsE/OTHUNTS0iYpLHyH5gn9756JcxqGcKKnz4w4qVnCZ/gwGWo5e0kNu4zgcQAfvTW
 roM1h0fyCt/A4Rci9/I0rO/OOSMd6u+5uK4XrMe/stqDGC7K4YOi1Z1
X-Mailer: b4 0.12.3
Message-ID: <20240517-b4-sio-ntp-usec-v2-1-d539180f2b79@google.com>
Subject: [PATCH v2] ntp: remove accidental integer wrap-around
From: Justin Stitt <justinstitt@google.com>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Stephen Boyd <sboyd@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

Using syzkaller alongside the newly reintroduced signed integer overflow
sanitizer spits out this report:

UBSAN: signed-integer-overflow in ../kernel/time/ntp.c:461:16
9223372036854775807 + 500 cannot be represented in type 'long'
Call Trace:
 <IRQ>
 dump_stack_lvl+0x93/0xd0
 handle_overflow+0x171/0x1b0
 second_overflow+0x2d6/0x500
 accumulate_nsecs_to_secs+0x60/0x160
 timekeeping_advance+0x1fe/0x890
 update_wall_time+0x10/0x30
...

time_maxerror is unconditionally incremented and the result is checked
against NTP_PHASE_LIMIT, but the increment itself can overflow,
resulting in wrap-around to negative space.

The user can supply some crazy values which is causing the overflow. Add
an extra validation step checking that maxerror is reasonable.

Link: https://github.com/llvm/llvm-project/pull/82432 [1]
Closes: https://github.com/KSPP/linux/issues/354
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- update commit log (thanks Thomas)
- check for sane user input during validation (thanks Thomas)
- Link to v1: https://lore.kernel.org/r/20240507-b4-sio-ntp-usec-v1-1-15003fc9c2b4@google.com
---

Historically, the signed integer overflow sanitizer did not work in the
kernel due to its interaction with `-fwrapv` but this has since been
changed [1] in the newest version of Clang. It was re-enabled in the
kernel with Commit 557f8c582a9ba8ab ("ubsan: Reintroduce signed overflow
sanitizer").

Here's the syzkaller reproducer:
| #{Threaded:false Repeat:false RepeatTimes:0 Procs:1 Slowdown:1 Sandbox:
| #SandboxArg:0 Leak:false NetInjection:false NetDevices:false
| #NetReset:false Cgroups:false BinfmtMisc:false CloseFDs:false KCSAN:false
| #DevlinkPCI:false NicVF:false USB:false VhciInjection:false Wifi:false
| #IEEE802154:false Sysctl:false Swap:false UseTmpDir:false
| #HandleSegv:false Repro:false Trace:false LegacyOptions:{Collide:false
| #Fault:false FaultCall:0 FaultNth:0}}
| clock_adjtime(0x0, &(0x7f0000000000)={0x5, 0x1, 0x40,
| 0x7fffffffffffffff, 0x8, 0xb2, 0x256, 0x6, 0x5, 0x8001, 0x9, 0x3f, 0x0,
| 0x8000, 0x800, 0x64d, 0x50000, 0x7ff, 0x8000000000000001, 0x1f, 0x3,
| 0xfff, 0x7fffffff, 0x5, 0x100, 0x4})

... which was used against Kees' tree here (v6.8rc2):
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=wip/v6.9-rc2/unsigned-overflow-sanitizer

... with this config:
https://gist.github.com/JustinStitt/824976568b0f228ccbcbe49f3dee9bf4
---
 kernel/time/timekeeping.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index b58dffc58a8f..321f251c02aa 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2388,6 +2388,11 @@ static int timekeeping_validate_timex(const struct __kernel_timex *txc)
 		}
 	}
 
+	if (txc->modes & ADJ_MAXERROR) {
+		if (txc->maxerror < 0 || txc->maxerror > NTP_PHASE_LIMIT)
+			return -EINVAL;
+	}
+
 	/*
 	 * Check for potential multiplication overflows that can
 	 * only happen on 64-bit systems:

---
base-commit: 0106679839f7c69632b3b9833c3268c316c0a9fc
change-id: 20240507-b4-sio-ntp-usec-1a3ab67bdce1

Best regards,
--
Justin Stitt <justinstitt@google.com>

