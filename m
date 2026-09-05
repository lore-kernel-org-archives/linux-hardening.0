Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5E33B8BA5
	for <linux-hardening@vger.kernel.org>; Sat,  5 Sep 2026 19:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788636606; cv=none; b=EO+ttnu5EEBnJdX9IAPnX8vizklCVCh3+Uq08R3wf55WgymITB0bthzDiRKKzQ80ZsGWueDFIcGN8Tqs72Ay9Ep2JGaIkBETycO26X2Kv2iQeCkbSwJEdJ1FUeLsSa2IeshvxbOk/5RUyoeBAKgrvnnCyFgaPeVBU67zizFh7DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788636606; c=relaxed/simple;
	bh=qrjdKgOfiKlVqpd955ImNGsDNT2gjKCr1YxX8TKeUE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dm0qEtqHEfDYOxuWRw8CA+L1I8lzExNzXDjS4MOebVBdZdVQErZEAi4smn+S4PqJKrF2zuqJxkF+5HQKZr9Jqvt604M7vYOYG4rCjkYNGoIDP6XKMMo+Mci6O3CUi8dsz8cIg2cLy9cCUdYsWrouj2+Wb14ZSVj0ULoQ7Nm3GNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqaBPQ7B; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqaBPQ7B"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-86b03b75fecso35134837b3.0
        for <linux-hardening@vger.kernel.org>; Sat, 05 Sep 2026 12:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788636603; x=1789241403; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VqyBgw8DXZ4Qanhy+S2yq9brLoyk1/YXyp0HTo9TDwE=;
        b=kqaBPQ7BmsqbwdYCXq4771rKioMgD+1cKvexceNOvqrNtoEwx/qCurbQ7JBafU/MF8
         EiWz8C0zX2YK6VDHqGmdTilzHQJR9X7K2rt9ial2IWt1+OY2dFbH7Oqcr1ALUG8jo/qJ
         7ud2nHh2QIKdEYKCALXyRm+HQBMGC20p3KkkBF60BEVXCLm6DWttU3AZJroJr+QBP2s3
         xXHbbZU+T1E29bX9tsEhWq9RBvL+d0ttNkV4XqwItxtI2BoPC5AJiYG/r6h1vzMfGLw+
         CmDpJWIsKUCM57MboPIF7ZT57m2DNsq9Tkcxhu5UlakoJ8QLnt3FGOiAjRXUug+z9pNW
         JojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788636603; x=1789241403;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VqyBgw8DXZ4Qanhy+S2yq9brLoyk1/YXyp0HTo9TDwE=;
        b=LE8L0oQPxgnxGbilQ6NzZxiUqealDRdpxw7bM18aTa7t9kZtRG1tOtHJQ0/AOZLoq3
         b6dIT1n/79laQ0vgXalEuwy85CdrV7vlRGnsZ2YAldjrteDkMvizJf0PdSimKwX0hH6y
         lRBPM5D3CBlNcx7zAKaAChqYV0SHIPyEtZ3Poyzzm1vgG39XJAIQ5Yw+DkUgNofoioLI
         FQ7Oh78XHI5hvQrr+FovLHdp74NVoPrrb8mb9VKkkBJiPf6eHmGvxk4C1aeaxucM8LAN
         YdDopS1QTXVybs9j1pD6gPeq9S55JNSlG0W4YGs0FvTFAADhIvfNezdXFqVA8jxK5FBD
         NyEw==
X-Forwarded-Encrypted: i=1; AKwUvBwTMvvDWaCpW5HLQBPM+0HTn+AGFrGG1vCLCodmi5IhqKvmTuBHxDMNvi8GZXKgyjNbOjvmkfVwxTZVgdTlcfU=@vger.kernel.org
X-Gm-Message-State: AFuF++lSGnR+8JdESLwxacd/ZnXqXBQ/y/FXNDfvkhOI+39pZyaeg5Kv
	xRTsj6o5f9bSQ0SnorNAH2iq2Eg+31TGaHRJksQS77qzMqwWtYRsoy+n
X-Gm-Gg: AYBFou1EGDJhm53DpZUKb4il3rC3hxgoDAV7JCsOigbKB9rbDemt6x8W8LJrZ+pq6nj
	B3b5qGkaKGk/irjUs5BKOS0ZjH3v/ilN7ygwYobX6q/kUcybK6kB4C5UntVvPNkGNxEtIGKgbEf
	UsdNm+SJyIUcCfQYf6m75iUCNeUPmXCe8w8jzA0MlpYvaDVf43Ikz04FQjHPyHgfpLsGJRjNMS+
	9VPpZKBB45noflyLZpEwC4u1YMDOExPb6qyUQjipnJY6I2uBZo5n+JsSS/LUxOBv7PktJ2TMLIO
	4zv9gLExPBa2VYkKCcn714Of+wZ8uinn9lq26unVVvByC5VjQkU75mcFQgm0Iu+F83x0Iojwmp7
	R88j6s82XuPTn1fEEsT/1mF94BaO0BZxgQ0tPKYsbh47CQpS/NecXglvDNcRZa0r26UnTAUfWze
	vGqpwHDu+8JL8jubwv0Zw6NBl/lwd6Fj/KCShlv+eRFiQ9248Gk7kb+rAsD0kS2w==
X-Received: by 2002:a05:690c:c674:b0:820:b01:9d6 with SMTP id 00721157ae682-8712313fc98mr51950977b3.11.1788636603301;
        Sat, 05 Sep 2026 12:30:03 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-871439c454esm43605057b3.7.2026.09.05.12.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 12:30:02 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Sat, 05 Sep 2026 15:29:38 -0400
Subject: [PATCH v2 17/22] alpha: select SYSCTL_EXCEPTION_TRACE
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-arch-kconfig-options-v2-v2-17-83e8245761a2@gmail.com>
References: <20260905-arch-kconfig-options-v2-v2-0-83e8245761a2@gmail.com>
In-Reply-To: <20260905-arch-kconfig-options-v2-v2-0-83e8245761a2@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>, Kees Cook <kees@kernel.org>, 
 Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org, 
 linux-doc@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2633; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=qrjdKgOfiKlVqpd955ImNGsDNT2gjKCr1YxX8TKeUE4=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLm5E7Zf1Vx/u3FyhNePmjMKOnUWDmlKmv2/PMiyhf+a
 m1/ZK4X0/GRhUGMi2GmmCJL3HpFllltO5b6nJb+BTOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GQIZOkbxEDk9Bo3M4uLS1CLdtIIih7z8ksSSzPy8Yr38gtS8gvQCvbTMtJKMjPyi4lSgEXp5qSW
 mro5uRoYGJpaOFmZOFo6mJs7OToZObo6Ozq5ORpbmJgbOlo4mrpbmDFycAjDXVOxmZGjWyJ1l33
 C68M/Jq/X3H3IeuWJ0VjA7/JpZ9e+V1YHN0csY/nBOfKk2x6Hz655luyZIqDDWbvkfMdvtqbDaw
 ROFPQYf/JkB
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

Report unhandled user faults the way other architectures do, and hook up
the debug.exception-trace sysctl that controls the reporting.

The message gives the faulting address, the PC and the user stack
pointer, and is rate limited.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Matt Turner <mattst88@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/Kconfig    |  1 +
 arch/alpha/mm/fault.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index f2a5b8c8688a..b9ff67370877 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -61,6 +61,7 @@ config ALPHA
 	select MMU_GATHER_NO_RANGE
 	select MMU_GATHER_RCU_TABLE_FREE
 	select SPARSEMEM_EXTREME if SPARSEMEM
+	select SYSCTL_EXCEPTION_TRACE
 	select ZONE_DMA
 	select TRACE_IRQFLAGS_SUPPORT
 	select ARCH_WANT_FRAME_POINTERS
diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index a9816bbc9f34..dfe427d93072 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -27,8 +27,32 @@
 #include <linux/uaccess.h>
 #include <linux/perf_event.h>
 
+#include <asm/pal.h>
+
 extern void die_if_kernel(char *,struct pt_regs *,long, unsigned long *);
 
+int show_unhandled_signals = 1;
+
+static void
+show_signal_msg(struct pt_regs *regs, unsigned long address, int signo,
+		const char *desc)
+{
+	const char *level;
+
+	if (!show_unhandled_signals || !unhandled_signal(current, signo))
+		return;
+	if (!printk_ratelimit())
+		return;
+
+	/* Losing init is fatal, so shout about it.  */
+	level = task_pid_nr(current) > 1 ? KERN_INFO : KERN_EMERG;
+
+	printk("%s%s[%d]: %s at %016lx pc %016lx sp %016lx\n",
+	       level, current->comm, task_pid_nr(current), desc,
+	       address, regs->pc, rdusp());
+	print_vma_addr(KERN_CONT "  in ", regs->pc);
+	printk(KERN_CONT "\n");
+}
 
 /*
  * Force a new ASN for a task.
@@ -217,12 +241,17 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
 	mmap_read_unlock(mm);
 	/* Send a sigbus, regardless of whether we were in kernel
 	   or user mode.  */
+	if (user_mode(regs))
+		show_signal_msg(regs, address, SIGBUS, "bus error");
 	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *) address);
 	if (!user_mode(regs))
 		goto no_context;
 	return;
 
  do_sigsegv:
+	show_signal_msg(regs, address, SIGSEGV,
+			si_code == SEGV_MAPERR ? "unmapped access"
+					       : "access violation");
 	force_sig_fault(SIGSEGV, si_code, (void __user *) address);
 	return;
 

-- 
2.54.0

