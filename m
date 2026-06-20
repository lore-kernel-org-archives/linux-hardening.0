Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF2533DEE9
	for <linux-hardening@vger.kernel.org>; Sat, 20 Jun 2026 18:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781978510; cv=none; b=pd0kuuXuG+jX8FmH+T0ct3ttbOEu57He6NKFHl4GF6uWOV2g+A4monlwEB7Jxr+4jpVWkktmdAUbCQGmbJ2zVssWDgnOEMeH32KRE9ztDl3VnUPH2XsLw1HTQaJueIVXYJSlj3ba9wCGXsb+FVdeN939OVZk/f7xlazNxeQj1AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781978510; c=relaxed/simple;
	bh=81qX+qAPsLCiqIdHPLg1+JhVNjcZxVE57fRIFw3hA+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YUNO7QpkzogKSspJELfY1c0QOrY5QD+PRnuk20QQcGstuPwDTqQzu0k097GhDi0aRgzkpjV1/aKcyh0dNordtFrfuYJS7US/tTQp1Hp+Wz9wb+GHuW9sTMpT107iL0x2JIdy41iL6H/sroyPOdO7dlzlc1oa7l6rhHdpBDCXT+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqZq5B9Y; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqZq5B9Y"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-30c23abc62eso595907eec.1
        for <linux-hardening@vger.kernel.org>; Sat, 20 Jun 2026 11:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781978508; x=1782583308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TU1KHjg1xw4SOUVLZNaBDJ/t1F+t4VC9J/t07Bu+tLw=;
        b=YqZq5B9YZ/8aNQ543wv/K3X7t66V/M7Ou/RnXbYLPlYojaAqADP8dJqx+FsPSZwF7i
         qI1SoCkY47sDM2j/SZnXl4Qn56eFv/QioNgNWa4w/Fsic/QNpM0aQ7vH/CgSleihZNj2
         JsVti0YeWI3vJl5l8Hxia6R9/k76KmrwgCsWNMRALl6zYC/YzZxHPG1nv41z/3AzSEZt
         HGroct1CkP3LImxJrYRrWhY+muGyMR6H3bfMplC0RpngtMu8GScHsDteIuT5yqCsfJsk
         QI/9jMmUXdAcLd4gxiC8bfm6326Bet/50abc84PncZJ+VAk4vNuuXh8Lm7temN8yfCwL
         hDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781978508; x=1782583308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TU1KHjg1xw4SOUVLZNaBDJ/t1F+t4VC9J/t07Bu+tLw=;
        b=cDA8+VZK8lQH6PIwh/PhQXwZ8VKAuipRryVKxBV2kjWIEgG2BtQH8WlHsb0DaK7if7
         D96ONl0mxNlm1Muqr2/XOLNXr5nHfxxsSbh5SVSguntOQTrgslSnU1ahfbObgd9xbvgM
         CCyUU2IpBWZe1Vw/lgtG9QNPCw9B2MKcyrTd3mrcOe2oUB+Xb+g/rhAhstxzuOaCHeTC
         XIJKiWBhmZpeG6iaGsxhpDrml+6PgAWwO4Mrk5ogM0BUTAEB+G6q7qzQXBXUWF0+6vg8
         yK+I8stD9Bq1a538MgVe/kiBDBMKy3i4lAvWzdLf7ZJU/3w7NBq2MXZsII7B9jwz8WKp
         /zxg==
X-Forwarded-Encrypted: i=1; AFNElJ+kU8apIyiP4Diei+wosnuGf529sPb8Bz2else0TibMANoHzX3s5z+Uj4hPOHsvK60569mKQ4A2ZRxfyXX8m9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSvYejeukzgmcZnYDVhzEJjyJlZqNbEDKhWFBG6iv3pswdkDKX
	Ez4o3ks83u4G3tbp6VX9AY1texlwO3rTXe6qkn8/7Q5wAtK8Mu7gX0oZ
X-Gm-Gg: AfdE7clVNoXpCYz2rnex2FJdBCEXpWOu9p+kE4bMUVqgSFQsyqF0Pif5orak2ELLdbo
	leUfEykah6NhVoCt6waICJDjF2m0BaF0uPh4H4/8W1hxiPDTwNcJ2Dy2OyQM3q44cQwRupPZ9d5
	i6YTHOu1JeT2wcw8aEjoi9+56/MlbiYb5DA2Dgnnl4fSoZHWjBFnLfUocZJntRN/mr4AusMeSOb
	9f+iQvIUU44MP/kt7on825Czb9lGnKv1qfeaTsMoUE7PdJIJsVo6AjNrG51sZjMDKdoJB30fydO
	eyz4bRfDAMX02Mlcw6RlvqFs5pzssqm1cFo1+TjSnsYTLUnhOJ9Z59646abWL2vvmKutgqvYcpG
	jEnfJCGwekj08O0YP12YCaJlFgNQQuFGXOM8suMymCTDMlk6nQhT+EexbkRFsIxEOlio4q6k14F
	T6gVKMA6TC08Z6PUZPRO8Zm0jf5g==
X-Received: by 2002:a05:7300:1826:b0:2f3:5266:fdfc with SMTP id 5a478bee46e88-30c071a7ff2mr5939362eec.33.1781978507455;
        Sat, 20 Jun 2026 11:01:47 -0700 (PDT)
Received: from mo-Inspiron-5559.. ([2001:fb1:da:4242:fb25:44f6:726:5eda])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1ba57db7sm4025121eec.7.2026.06.20.11.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 11:01:46 -0700 (PDT)
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
Subject: [PATCH] tracing: Use seq_buf for string concatenation
Date: Sun, 21 Jun 2026 00:54:41 +0700
Message-ID: <20260620175441.223342-1-woradorn.laon@gmail.com>
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

The backing buffer bootup_event_buf allocation is unchanged.
Use seq_buf_str() to NUL-terminate before passing to early_enable_events().

Link: https://github.com/KSPP/linux/issues/370 [1]

Signed-off-by: Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>
---
 kernel/trace/trace_events.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index c46e623e7e0d..15164723e028 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -22,6 +22,7 @@
 #include <linux/sort.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/seq_buf.h>
 
 #include <trace/events/sched.h>
 #include <trace/syscall.h>
@@ -4501,13 +4502,23 @@ extern struct trace_event_call *__start_ftrace_events[];
 extern struct trace_event_call *__stop_ftrace_events[];
 
 static char bootup_event_buf[COMMAND_LINE_SIZE] __initdata;
+static struct seq_buf bootup_event_seq;
+static bool bootup_event_seq_initialized;
 
 static __init int setup_trace_event(char *str)
 {
-	if (bootup_event_buf[0] != '\0')
-		strlcat(bootup_event_buf, ",", COMMAND_LINE_SIZE);
+	if (!bootup_event_seq_initialized) {
+		seq_buf_init(&bootup_event_seq, bootup_event_buf, COMMAND_LINE_SIZE);
+		bootup_event_seq_initialized = true;
+	}
+
+	if (seq_buf_used(&bootup_event_seq) > 0)
+		seq_buf_puts(&bootup_event_seq, ",");
 
-	strlcat(bootup_event_buf, str, COMMAND_LINE_SIZE);
+	seq_buf_puts(&bootup_event_seq, str);
+
+	if (seq_buf_has_overflowed(&bootup_event_seq))
+		return -ENOMEM;
 
 	trace_set_ring_buffer_expanded(NULL);
 	disable_tracing_selftest("running event tracing");
@@ -4766,7 +4777,7 @@ static __init int event_trace_enable(void)
 	 */
 	__trace_early_add_events(tr);
 
-	early_enable_events(tr, bootup_event_buf, false);
+	early_enable_events(tr, (char *)seq_buf_str(&bootup_event_seq), false);
 
 	trace_printk_start_comm();
 
@@ -4794,7 +4805,7 @@ static __init int event_trace_enable_again(void)
 	if (!tr)
 		return -ENODEV;
 
-	early_enable_events(tr, bootup_event_buf, true);
+	early_enable_events(tr, (char *)seq_buf_str(&bootup_event_seq), true);
 
 	return 0;
 }
-- 
2.43.0

