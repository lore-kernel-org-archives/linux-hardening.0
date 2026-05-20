Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF1A3A6F06
	for <linux-hardening@vger.kernel.org>; Wed, 20 May 2026 21:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779314320; cv=none; b=GR5g/2R6xo1UEg/dTiY25iXZ+xVX3AKFX/sFWLoGZkxZ4vWvrRvanz9XNKeexA8PnGx9r4oiLSORvbPy7N5ZVsg/vW8/LJPHhdBJTXAO3lhOvnE9JyLJcfN60s3p08+DMSaxPgHLUdjQoBylL/jtPtlLNDkeaSE1R2p9dmJ0fVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779314320; c=relaxed/simple;
	bh=39Gt8rB1JCMWARzBhN7sjVwIsshPckmW2W55n9ARnbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sxDGCwkWcwGM7vgYH03qRA2C0N2cVjycp3NJRlzbQD2H0Yj6rK4L6TmaT+NAhoCwnwh56emCeJn3rbxF4J7TibouLh/iOWtS196sxJVScw78CazBI10IRbpuXI5VMjMWWDmo6eqpa5FKonM2KnjLTm95vCuffUCnYFwNFZz3t1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=snaad4Tl; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="snaad4Tl"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-365d8e43759so2888087a91.0
        for <linux-hardening@vger.kernel.org>; Wed, 20 May 2026 14:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779314315; x=1779919115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jDSnjm/dJwUnHCR5eUkgy/BeIvqG46BmxLZ8ZhFb2Wg=;
        b=snaad4TlCj+vJ0n8+bEkwQL9e2BOGqxR76JIc+Cps6/Qxc4zwSy34r1wLMjPHpVzOx
         KJHxZ4tm5o/zk+iiBK+1haShY7IzaJyV7IfZCNK3hT994G6QfEOkR+nNjzwKZjPsxCJ9
         qtmhd8ym03Rdk1GtxmC8khktS9Xf9qKujH8gPdsaRp0bNQZ2RSNlp1cZ6y6G3PIUnp5q
         +WIxnlXXXwzInAZFadpj7Tphhr2NGWSV4grNF2dqHm6TIQ6KpsraM4w1zZESOos+x547
         oge0NpdJB5luckjfnsm8GYFk8lXWMKFOu4OiSeYg361h8UCXqtVXVz145XsseflYPcs7
         vUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779314315; x=1779919115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDSnjm/dJwUnHCR5eUkgy/BeIvqG46BmxLZ8ZhFb2Wg=;
        b=Qn0eXEeXAkh4ff0UNbEFX09ffvVZpJQf4YtlLMlCHTxHlU5iYjrlblyyrwouRNtQVo
         vqoHX3hTTZV13eg4fiB53CxE6bNJYufLvdEFV7ql2XTk919ezDR+sMAs86OMnJ6E9fFS
         /KdyykdOScvgxzd3KPUHiUIwgdbcYNhrr7+sDWsuCXli1RC1xngvdakE948OuTuUvAX5
         WMy4vafxE1Q+ewS/1sHqZVHAhgGK7oM6+rBCI/AlPxohnYowtswfTHkHjXQvrl0DQ6nx
         rPkMGWFA0ePNs5PgX4YDRhi1Qlq8BgksOOgYBZPUu5bXuOl/iUY3QvIawT1kYFjSUAle
         MYuw==
X-Forwarded-Encrypted: i=1; AFNElJ91esIiYNxwyXh1Yc95BcdljR4NEEGYAmdr/94vAj7ivwtHc1Jm3rZ2cVzw6Nu+NOwnUlG1DWHxOGjMXF879us=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW9jpVl4WCdssZotiLUv3WH02uOdO6/qFRxcJQFoeiFk8QYv1R
	1KRTK+zCCbCwWVzGsIGJh7BJyZPsCntvyj2YioIBhl3thueKRsAN430JUEzLxNyx
X-Gm-Gg: Acq92OFl4iRzr03WxZnmFmoZZvc0Y4OSSlYYcH59Q4aqwbZKp1AI5qsjs/K40RHmYP+
	lr8bzODa8cvVcqyZdq3442UhIC0ah2SOTcx4JCNcyu2qDUZGbyIhwG3cQjFONDQy9gUl7IzPLgu
	trizQNx1hTOY+Sj7SN2mJW6q2gFOXLbs0cd/UdiW+Vl1A5nhkDhvD/HYZQy27An4htDw6+mCWa1
	PmYUL+QKA8LvHI1ljPNoH39pKPGVPi2hRIjqXVx7624EuUrbM7b4mVngPH1Z4AOj7RH5udhlBO4
	YHHIdtMlvh0RQQy/XnjtPprDhe9CsbVJblAJh8Zp4RPHgrOmF6jmywo8YCZ0zNoKBguDWiH4jZ7
	QTUt/VMjVZ0Eqm5p9OYJftpKZJz7zYFzrvh6AATLicI76aK7QuopvLRSgar4EHQV9cD7trpchYf
	mJW9SqY6ZmL/XziDG9GpgaF4JaZd4admoR6eAKi3uXPfzp8KDi1cIdLYt3G5smsHVZ+14475dof
	e2C0PGYYtstg2fS+qIkPZ0g8ODGurQOvVc=
X-Received: by 2002:a17:90b:3942:b0:35f:b9f1:fded with SMTP id 98e67ed59e1d1-36a491ad00emr104057a91.12.1779314315554;
        Wed, 20 May 2026 14:58:35 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a3cc5643dsm646368a91.7.2026.05.20.14.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 14:58:35 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list:TRACING),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCH] tracing: Use flexible array for entry fetch code
Date: Wed, 20 May 2026 14:58:17 -0700
Message-ID: <20260520215817.16560-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Store probe entry fetch instructions in the probe_entry_arg
allocation instead of allocating a separate instruction array.

This keeps the entry fetch code tied to the entry argument lifetime while
leaving regular probe_arg instruction arrays separately allocated and
freed.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 kernel/trace/trace_probe.c | 8 +-------
 kernel/trace/trace_probe.h | 2 +-
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index e0d3a0da26af..39f040c863e8 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -838,15 +838,10 @@ static int __store_entry_arg(struct trace_probe *tp, int argnum)
 	int i, offset, last_offset = 0;
 
 	if (!earg) {
-		earg = kzalloc_obj(*tp->entry_arg);
+		earg = kzalloc_flex(*earg, code, 2 * tp->nr_args + 1);
 		if (!earg)
 			return -ENOMEM;
 		earg->size = 2 * tp->nr_args + 1;
-		earg->code = kzalloc_objs(struct fetch_insn, earg->size);
-		if (!earg->code) {
-			kfree(earg);
-			return -ENOMEM;
-		}
 		/* Fill the code buffer with 'end' to simplify it */
 		for (i = 0; i < earg->size; i++)
 			earg->code[i].op = FETCH_OP_END;
@@ -2051,7 +2046,6 @@ void trace_probe_cleanup(struct trace_probe *tp)
 		traceprobe_free_probe_arg(&tp->args[i]);
 
 	if (tp->entry_arg) {
-		kfree(tp->entry_arg->code);
 		kfree(tp->entry_arg);
 		tp->entry_arg = NULL;
 	}
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 262d8707a3df..1076f1df347b 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -238,8 +238,8 @@ struct probe_arg {
 };
 
 struct probe_entry_arg {
-	struct fetch_insn	*code;
 	unsigned int		size;	/* The entry data size */
+	struct fetch_insn	code[] __counted_by(size);
 };
 
 struct trace_uprobe_filter {
-- 
2.54.0

