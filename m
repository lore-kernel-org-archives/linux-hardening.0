Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AC0622
	for <linux-hardening@vger.kernel.org>; Fri, 17 May 2024 00:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715906836; cv=none; b=V5OlLz70a5FdiNbpfOX2k9sVsxIFFx1396+vhVhfrBepHOkJtBsAjPTmdp1s59q5FJyawcVk3udSMiEbBepDM89M3DVoQ9/kcwjuLX4fux9aKDiqQxTiW7Unm75utJaaCcKEHd+UnXNWjQnJh4OBfCwVZUIZmj+MyVf4QayuNww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715906836; c=relaxed/simple;
	bh=APN4VP2Crr6QKrWp/Xr/rV+r2whWDGdcimi2/j06TL0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IWU+GeHNtXDjrXpIoZifxDHKHXF+iZ9Il3pF0tNF9tsfvqEAbhWiNXauVz3mvNNqEYAVm/RyYWi61SDfzCnj34sPhfZrSc9gWX4D2HM40ggPn/LSDJvOCfSJsOCjdg8hxJyR/eCreRZjOrqFNrEWp9KT9tIBJE7LQ3lM04tmbkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z2GqWuh4; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z2GqWuh4"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be1fcf9abso131370827b3.1
        for <linux-hardening@vger.kernel.org>; Thu, 16 May 2024 17:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715906834; x=1716511634; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+sBRFmlKo34YzhiPfM618pBAaUxmxSb2mTc1sHV0NzU=;
        b=z2GqWuh4Sa8kYuOqoGjmcnhxDLhN/f37rYyce6a1tI7roz7XRoZYgXO5Rr6YlrSlgl
         RVxzot8aHFDPQeaVaMZwjtno9p0EIwJJVaMIdFFOIS70CjyVGA5+xE9klI0ap/8Pv0CQ
         0bFYqhZJFWADQMHrh5Sl+DFawx3eObIdvoP/z3+fs0Xwt8wfkkMKQCEyvOdZmZRE6uUi
         91OnNNdIIiT6LuNZhUZVcWGq+DY+xbIb4QXRudNil8n0qaS9XY9leb5nngVds8HTjCaY
         QOtXNB66gW6tVQtZg2uxFRymUJfHcJ3qKt3/Pze+lN3J9htL9L0UZGrd7MlEUNJLot0B
         zizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715906834; x=1716511634;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+sBRFmlKo34YzhiPfM618pBAaUxmxSb2mTc1sHV0NzU=;
        b=hAR8il821ebZR1vLktICY/Bklo2Ci+nZ/JsmxG4FVMaDiOc06ENGv8WCPCQuGATEZk
         s0IVf6Jt74x5KL/BIPpzyNzBJy2gXlG8s8WU+jJSy4GNauB/0PgHcm72hV5vQqg5uflF
         IIR+fFZG3OhswK+ENc2jUEt7Cods6LVD2ug+FRe+iWOa42C8hqboTXPREq2PL8IREOaR
         AJ0MjDSQasy4QY55coRJ1f1FCzjA2F0HUKDRf4xAD+JEAMXGRZgtRVuR296sHDkQw01O
         PaGaigFKAT9GjhJV1tIoa4c6jzS5ffz+5tp9Rl3RzGv4CPE8JJ9EVLzGCZL98vAG/E62
         g4vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSg9lmw8+kbmS0aJVXBGE22c9KenCuN4X/wkjRtp8PIbRuJMWTt2d6pFM3nMbLKxPbvJHNnRPOMlFLzmAkA0x7wdLRVsVw9F+1w6sIYDCw
X-Gm-Message-State: AOJu0Yyx+79gdv7vAj05uAWq0h1hcSOSTI3hCSb2Y6rIZCFDhXFBAHjL
	o7pO3Auz3vESzvwwGb4C7Iv4sEezjEaKV03sDS5gVYulRWYIogvHL1HSThT+HR8/IIvmPs0HEM/
	KH58+q8srMC5npycJMNip+A==
X-Google-Smtp-Source: AGHT+IETpYv5Kjvsk8OyrTodOgdwpPqjDaOSc1Z+SNVKHGp/NLwKQuB7PDtZOHT9w6zHvkJhoKySJ/78MmzZqKV0rQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:690c:4508:b0:61b:e9d5:ac1d with
 SMTP id 00721157ae682-622afd65a8emr54872957b3.0.1715906833765; Thu, 16 May
 2024 17:47:13 -0700 (PDT)
Date: Fri, 17 May 2024 00:47:10 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAA2pRmYC/3WMwQrCMBBEf6Xs2ZVkbat46n9ID0lc0wVtSlKCU
 vLvxt49DW+YeRskjsIJrs0GkbMkCXMFOjTgJjN7RrlXBlLUqk71aFusG5zXBR06orNV5PrOnKB elsgPee+621h5krSG+NntWf/aP6KsUaNRmi7a1LBm8CH4Jx9deMFYSvkCn07L/akAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715906832; l=2916;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=APN4VP2Crr6QKrWp/Xr/rV+r2whWDGdcimi2/j06TL0=; b=lVQhJSXTmnBiRmTpSG1PZj6jdwvTeXv2JarvTTQ1WVuAkjVh09o5tkjDw6JS3PNECmkC/jajo
 5RhTx6x5HKxC1PMpnksmZbLIIwZoUFWoMnm5GuoEn0sHIeScvxHC4Yz
X-Mailer: b4 0.12.3
Message-ID: <20240517-b4-sio-ntp-c-v2-1-f3a80096f36f@google.com>
Subject: [PATCH v2] ntp: safeguard against time_constant overflow case
From: Justin Stitt <justinstitt@google.com>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Stephen Boyd <sboyd@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

Using syzkaller with the recently reintroduced signed integer overflow
sanitizer produces this UBSAN report:

UBSAN: signed-integer-overflow in ../kernel/time/ntp.c:738:18
9223372036854775806 + 4 cannot be represented in type 'long'
Call Trace:
 <TASK>
 dump_stack_lvl+0x93/0xd0
 handle_overflow+0x171/0x1b0
 __do_adjtimex+0x1236/0x1440
 do_adjtimex+0x2be/0x740
 __x64_sys_clock_adjtime+0x154/0x1d0

Rework the logic surrounding time_constant and how it is incremented so
that it doesn't wrap-around.

Link: https://github.com/llvm/llvm-project/pull/82432 [1]
Closes: https://github.com/KSPP/linux/issues/352
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- Adjust commit log (thanks Thomas)
- massively simplify bounds checking for time_constant
- Link to v1: https://lore.kernel.org/r/20240506-b4-sio-ntp-c-v1-1-a01281aa01ba@google.com
---
Historically, the signed integer overflow sanitizer did not work in the
kernel due to its interaction with `-fwrapv` but this has since been
changed [1] in the newest version of Clang. It was re-enabled in the
kernel with Commit 557f8c582a9ba8ab ("ubsan: Reintroduce signed overflow
sanitizer").

Here's the syzkaller reproducer:
| # {Threaded:false Repeat:false RepeatTimes:0 Procs:1 Slowdown:1 Sandbox:
| # SandboxArg:0 Leak:false NetInjection:false NetDevices:false
| # NetReset:false Cgroups:false BinfmtMisc:false CloseFDs:false KCSAN:false
| # DevlinkPCI:false NicVF:false USB:false VhciInjection:false Wifi:false
| # IEEE802154:false Sysctl:false Swap:false UseTmpDir:false
| # HandleSegv:false Repro:false Trace:false LegacyOptions:{Collide:false
| # Fault:false FaultCall:0 FaultNth:0}}
| clock_adjtime(0x0, &(0x7f0000000280)={0xff, 0x0, 0x0, 0x0, 0x0, 0x0, 0x7ffffffffffffffe})

... which was used against Kees' tree here (v6.8rc2):
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=wip/v6.9-rc2/unsigned-overflow-sanitizer

... with this config:
https://gist.github.com/JustinStitt/824976568b0f228ccbcbe49f3dee9bf4
---
 kernel/time/ntp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 406dccb79c2b..d64f69e14938 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -733,8 +733,7 @@ static inline void process_adjtimex_modes(const struct __kernel_timex *txc,
 		time_esterror = txc->esterror;
 
 	if (txc->modes & ADJ_TIMECONST) {
-		time_constant = txc->constant;
-		if (!(time_status & STA_NANO))
+		if (!(time_status & STA_NANO) && time_constant < MAXTC)
 			time_constant += 4;
 		time_constant = min(time_constant, (long)MAXTC);
 		time_constant = max(time_constant, 0l);

---
base-commit: 0106679839f7c69632b3b9833c3268c316c0a9fc
change-id: 20240506-b4-sio-ntp-c-c227b02c65a3

Best regards,
--
Justin Stitt <justinstitt@google.com>

