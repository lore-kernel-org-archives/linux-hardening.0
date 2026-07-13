Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6059034D389
	for <linux-hardening@vger.kernel.org>; Mon, 13 Jul 2026 04:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783918451; cv=none; b=MRkx2ngielMoK+eM7XSfbgJWGZFV2kKKVKYIv750y6PX3C0zS69DRJS4ScSZ6ezT/PWHXtcrYSXiDA5eOO7tymYiRreO95LkWC3F3d2A0ZlZwbUQQR55p06xJF7m+r/flc/py8+UEE8rOwUlfEkBZfwDbHpmrx+QNvv78bBV5nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783918451; c=relaxed/simple;
	bh=aWyuivC0uBr2raUrYrGhB6xX3JmGBmcCaiXVvYEGVQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YJf56hqkthRigcfzpbM1zu6b3FZ9DVZmBAn3MZ6irW0a9jbW+OFFP0EaX0/Pagc+Mvm9L1/B3U7Z32H8JKgbwscjhxbxfoC+9HwGxxfW70uEKH7MmZTUHzJFAzCCpFHXcWtZqE7XjM/QvMx9ISIADZXBIBZ9m1FBDsXbcnvu664=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVFZFK3V; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVFZFK3V"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2caf228a910so19087525ad.2
        for <linux-hardening@vger.kernel.org>; Sun, 12 Jul 2026 21:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783918449; x=1784523249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sFT84HfE6g23Y0JSEsGGMWs+C5GZdiRx3RFEfHBMGN4=;
        b=TVFZFK3VZffAe1yuSIkedDFa3KTAXLhI/6j7UIyHz1n/fUko7w9Aitw2+qYxV+i6yz
         fDGaKoD9D0pg6l/b752JMBlS/15cbk0fngiH3B1ectkCsfRC8ZCc3erik8yifqdbGEEn
         uXFW42hgVapJqCdY8A8wMKS89eSnQEWTpYHJ5wsmQ8qMInOR85b2FiPmAtNhbvcenERE
         YA7IsDaSNQLt55ggtafDHYACH/H7Jy8Nt5TtPbhjmRy6ivcwnRJP8jCKYnqgXUjCimiL
         znr4eeTtpx403DOfQV6RrduRxmMOtucMoJw8e09xPY4ljHe6vEYQJ+5lRB53oSynyzfy
         efhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783918449; x=1784523249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sFT84HfE6g23Y0JSEsGGMWs+C5GZdiRx3RFEfHBMGN4=;
        b=KbKyBetVnqhundK51/wmoTOJnvAUjstESKAuis22RJbvZyv7ZQsi5bEDyNz0lvotkU
         qiBzcNaEeILVzJ2lbCb4ZTjj9t5GaK+W+OexQngFSdYrELKxD86Z7rmAXx1u1ZHRyrB4
         4vLoFP62Vg5Lviuv3KO8SXnyMHBIfA162Cn9gNiwy/7yTEbSRLpXk9swA1Nm1bTrzrIa
         6p8IQPgOCKc3+MoxhVlrIOmdgdzJWX9hUpaOr3bDiSvZXxSntii+U8orcmvrAhhFADY+
         B+ZVIPJIvt0dsSA3gZK5lG9RloMiYLtFu03+47PfQla0OVqzOhn9qlBofgzuGFgT7ql9
         x93w==
X-Forwarded-Encrypted: i=1; AHgh+RqERH2fN4tQNVIYmC2E/DzVgJiLmHH5zmkgxIspfgfPWV4S9esQ/oNjmSR1AmaGzIMrwx+F26f8Xn4I7XQaOm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYKP4raB1Saw+Y8iOUf7DZkLkhZbt7H/59PUt2hvod4yUD2i8x
	hQV++mB9jhD7fmxvekrFSUjXF0Q27dDuFiJwWXilFk45GDvpmJHUEzhd
X-Gm-Gg: AfdE7clhHbmLkWHJgBDqmQbsOBpZWBV8EefsOlaky18wCfWVDWiST7W5LqlmQ6n4TmA
	EzcniXeNjqhshgblgmlI8lZqzzKXXX+cGEhqYAF5joWYSNMTebty2NS3GD5VYM1PdWGnWquw7Ic
	HplRzNIu6sb1JsHORCdX8rnaBNoq+Vbeor5lytZTP1Kp3dlbVMmV1/hN2hLvdk3BsEczo4hyTIO
	POP9V5KHwSFWvSu6vlMyVXJaslqIajFvn0gL8KijYqJ8qxt19Rq2kF6dfgUAIkkQRSZp6T0X31N
	7fn8ju/CnhVaZ5TaK3qq7G8Tk0sxKxQUdQTCw/eY53mzgjyF/ds3pa+Y9TKgqlWM8reB8zmWi2E
	QbrcuRglmC0Jmim5uHhzojGZvOpv2XqyYhtj8uGbwYbL5X3eVvVMhl9Ho1j06MEEZFrl5469lRd
	GNgz/wF3/LTx6L3zCQgOgQQ/f7Q/k=
X-Received: by 2002:a17:903:b07:b0:2c9:ff29:3f91 with SMTP id d9443c01a7336-2ce9e7a5613mr78426635ad.6.1783918449548;
        Sun, 12 Jul 2026 21:54:09 -0700 (PDT)
Received: from mo-Inspiron-5559.. ([2001:fb1:db:5c33:ea21:9586:4d37:987d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bbaesm92010215ad.57.2026.07.12.21.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 21:54:08 -0700 (PDT)
From: Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	shuah@kernel.org,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	jkoolstra@xs4all.nl,
	woradorn.laon@gmail.com
Subject: [PATCH v4] tracing: Use seq_buf for string concatenation
Date: Mon, 13 Jul 2026 11:52:49 +0700
Message-ID: <20260713045249.69942-1-woradorn.laon@gmail.com>
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
v3 -> v4:
	- Removed typecast a const char* to non const.

v1: https://lore.kernel.org/all/20260620175441.223342-1-woradorn.laon@gmail.com
v2: https://lore.kernel.org/all/20260622094623.18469-1-woradorn.laon@gmail.com
v3: https://lore.kernel.org/all/20260623145147.12145-1-woradorn.laon@gmail.com
Sashiko: https://sashiko.dev/#/patchset/20260622094623.18469-1-woradorn.laon%40gmail.com

 kernel/trace/trace_events.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index c46e623e7e0d..4f5a0e73a89b 100644
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
+	.size = sizeof(bootup_event_buf),
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
@@ -4766,6 +4774,7 @@ static __init int event_trace_enable(void)
 	 */
 	__trace_early_add_events(tr);
 
+	seq_buf_str(&bootup_event_seq);
 	early_enable_events(tr, bootup_event_buf, false);
 
 	trace_printk_start_comm();
@@ -4794,6 +4803,7 @@ static __init int event_trace_enable_again(void)
 	if (!tr)
 		return -ENODEV;
 
+	seq_buf_str(&bootup_event_seq);
 	early_enable_events(tr, bootup_event_buf, true);
 
 	return 0;
-- 
2.43.0

