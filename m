Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F7B3D5679
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jun 2026 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782226486; cv=none; b=NSBYwIGNToyR6GJUamToIJvvZaV3gq3COwunSSuyb9e2N85FFpNhcKuZtpxGsV/ufMlbTn4GdfOBCWKL83AtuGZaCJH3AlGjDIRVeDuSMeE9Ej5ZIfDrmnjlUNYru8uoN1s7ZJqbeQvJgwAsKhU9P5frL4gDFB1Qgh4Dd2UGWak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782226486; c=relaxed/simple;
	bh=L90/AkyCB9U0geyi1lWA/eHf7voiXgf417DXWgwVaXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lt0qKVW+AMB4C92xKWbMxChh7lRYlIV3RD+dKkpyBDfPy7JwtBHLcJnqqo8RCMfhz1OTsV4hMYGls/CgHgt8yCglZpEtCH7F0kYoSLxVmUgTUMlNgfMHW/f8tzjRy0Fku/h+xNV77Zh+PRExA4mjvPHmvGRIQ3DiBSsk5uIH6g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRbupCAR; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRbupCAR"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1390f75d8bbso6240541c88.0
        for <linux-hardening@vger.kernel.org>; Tue, 23 Jun 2026 07:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782226484; x=1782831284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IY3KFhICfndG+RHDKCrSaeQPMXM8dmxeDhVM/4MoFI4=;
        b=SRbupCARI7MYaWuFBF0iNPDW3bnl1Yvh5aNmuzOLlmacehSE3eZ1uu6844w0iwmcPl
         YifKmvZwdTMr9m/HJTG2dV+VtEZ3mVOHtJ5I0yNml/5T3W5PVnQcldvjX6LdzKEpc8sp
         sMssFA+3h8u0Lu9VaF7o5dEtipVvSCrxocqQT7RihS28qI7cRttyzwl0/usFYhD2+VkS
         6IpBZjxyEonjgrO8ECMEtlRx7OjmEvimsTku0/KUa6EmITpuzbDF3oUri4V9FBj1zwbo
         H+vHOSLgj6UDWHZb9LWhiF26YqGlYILI9eO+5bADxQZbAvuyi5eO2S+yoZzAf54etk40
         Km3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782226484; x=1782831284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IY3KFhICfndG+RHDKCrSaeQPMXM8dmxeDhVM/4MoFI4=;
        b=MeWEOUBXdBoUNuU9Xg2/BwIBt1W8+0AXE38xcAG1CVwehTqpg6b5eIX1zjS1EQZx3Q
         ZO2CqtUun2bnqLaRc3MyzFWKY1yUpEsqyV+6iAlZYfvKt1hUe0J56AaJP5bc30yyuEFq
         VCN40xJ6aWTmDBPT8e/wRn4PgI3RhPctEBjNnk30A7EzsJffp+irGUeyM4suVvUqDnqU
         MgIwa7CeOLx3S1yR/WClHdklYq8kUOuYmltPtOu9tVZUosqCqJL/tBnmcIErAu6R2vSG
         zdfRzw0b0qSYwqsB7VXceRlnbPzYZlQBYAXJS5oi7urvNKKus6NO5vcNrPO5G4RSVz1H
         Tb8g==
X-Forwarded-Encrypted: i=1; AFNElJ+JnLRaTs1dsyUDEnRGKk3frX32MgZ1EdcFwqRgqC9N2nH8Gi3NLNYw97RSKw8Zsyjcgr06yVnWcKaP8C/dmXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwSLE1dkaKMHBjGt6kzkNnff7JKeMJIcBFcpK6WCJyWFlt1R9N
	6co5DNdjtSG+/lSV2pOQclietjBpx5qy0j4NIQ4AI1PMqtytH5rDJMmo2WjLbY92
X-Gm-Gg: AfdE7clbl9rl3mq5s/pENN0tCv8I/rljuAC3oyXCjyYeFODiSQ75yMEupSWSGH2jMac
	00CHFLbqHea7UsR6MrrP56FtGfnkDZAMkOMO7LuS2NjGYvXtN6XWbsp8cGdPjDmQK9Erca41Gpj
	kJRIyoMnueyqqpww79OOMsGTAfhylz77hoRI6388zNW806gjtSFGS8IHYX395d8JOTbD7gH10sN
	g9OHfEBVfcvPAjsk+YApWAKwTew3bkJOd95L7M9zT+ScuUeDmaR1hbGrBx22ZiiPKFxyDH4lBQa
	oPGPnQPUJ8R0ghd/sjzVAc+WX6Fmjp3cRo94fIsauBki5Y+f7W1ugeRA5EKbQ9VEbJcJNA5dpVD
	S55dy//HfIKQ8QSWxiiUL+1T2kxv5gSG3SAz8VOS2U3ZdjYzis0rh2UerHYPhJWB3bDrTZ6hg9u
	1/CXjrfuN9BMzCXnA1Wo9Zjhc16ovKt0U8dm4UdQ==
X-Received: by 2002:a05:7022:90d:b0:12a:6fb7:87e3 with SMTP id a92af1059eb24-139c5e033b1mr2686422c88.31.1782226484332;
        Tue, 23 Jun 2026 07:54:44 -0700 (PDT)
Received: from mo-Inspiron-5559.. ([2001:fb1:d9:863a:37d9:e7c4:e450:11e4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139adca1b00sm12963863c88.2.2026.06.23.07.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 07:54:43 -0700 (PDT)
From: Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	shuah@kernel.org,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	jkoolstra@xs4all.nl,
	woradorn.laon@gmail.com
Subject: [PATCH v3] tracing: Use seq_buf for string concatenation
Date: Tue, 23 Jun 2026 21:51:47 +0700
Message-ID: <20260623145147.12145-1-woradorn.laon@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for removing the strlcat API[1],
replace the string concatenation logic with a struct seq_buf,
which tracks the current position and the remaining space internally.

Use seq_buf_str() to NUL-terminate before passing to early_enable_events().

Link: https://github.com/KSPP/linux/issues/370 [1]

Signed-off-by: Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>
---
v1 -> v2: 
	- Fixed WARN_ON when booting with empty trace_event.
v2 -> v3: 
	- Addressed Sashiko's concern about the compound literal backing buffer.
	- Replaced the compund literal with an explicit declared buffer and pointed
	seq_buf.buffer to it. This guarantees the backing storage is placed in 
	`.init.data` and reclaimed after boot.

v1: https://lore.kernel.org/all/20260620175441.223342-1-woradorn.laon@gmail.com
v2: https://lore.kernel.org/all/20260622094623.18469-1-woradorn.laon@gmail.com
Sashiko: https://sashiko.dev/#/patchset/20260622094623.18469-1-woradorn.laon%40gmail.com

 kernel/trace/trace_events.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index c46e623e7e0d..5ab630155ab6 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -22,6 +22,7 @@
 #include <linux/sort.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/seq_buf.h>
 
 #include <trace/events/sched.h>
 #include <trace/syscall.h>
@@ -4501,13 +4502,20 @@ extern struct trace_event_call *__start_ftrace_events[];
 extern struct trace_event_call *__stop_ftrace_events[];
 
 static char bootup_event_buf[COMMAND_LINE_SIZE] __initdata;
+static struct seq_buf bootup_event_seq __initdata = {
+	.buffer = bootup_event_buf,
+	.size = COMMAND_LINE_SIZE,
+};
 
 static __init int setup_trace_event(char *str)
 {
-	if (bootup_event_buf[0] != '\0')
-		strlcat(bootup_event_buf, ",", COMMAND_LINE_SIZE);
+	if (seq_buf_used(&bootup_event_seq) > 0)
+		seq_buf_puts(&bootup_event_seq, ",");
+
+	seq_buf_puts(&bootup_event_seq, str);
 
-	strlcat(bootup_event_buf, str, COMMAND_LINE_SIZE);
+	if (seq_buf_has_overflowed(&bootup_event_seq))
+		return -ENOMEM;
 
 	trace_set_ring_buffer_expanded(NULL);
 	disable_tracing_selftest("running event tracing");
@@ -4766,7 +4774,7 @@ static __init int event_trace_enable(void)
 	 */
 	__trace_early_add_events(tr);
 
-	early_enable_events(tr, bootup_event_buf, false);
+	early_enable_events(tr, (char *)seq_buf_str(&bootup_event_seq), false);
 
 	trace_printk_start_comm();
 
@@ -4794,7 +4802,7 @@ static __init int event_trace_enable_again(void)
 	if (!tr)
 		return -ENODEV;
 
-	early_enable_events(tr, bootup_event_buf, true);
+	early_enable_events(tr, (char *)seq_buf_str(&bootup_event_seq), true);
 
 	return 0;
 }
-- 
2.43.0

