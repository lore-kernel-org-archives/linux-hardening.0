Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6865C1632DF
	for <linux-hardening@vger.kernel.org>; Sat, 12 Jul 2025 19:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752348266; cv=none; b=oa9h1OC/wFRrqEzi0jExRIDLqQtAqFlA0a3ibe4VAfiMsRrz9UI1FLAxqy/lgEf6awCz4eIVzR4hhr1KLtjqUh5As0qziOzb7q+6Wi7DUcW3rrS03LZWYR/8mEtmWx5TbIQY6Y41UMA5eRkHKR16QbVLa8Lm4RyBmXMO3DNhOPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752348266; c=relaxed/simple;
	bh=RbvF3sikpzq0k94o4d8f12C3FURuAP7ZS3mq4E8OaNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=djwdKpuOtc+S/yryHq9yYw9UVIi8kSGPdJko0Ky/1fH5PItWcQfYPfje+3iXYy3B494iYnS/DCQFnR9YYDIslcd9znmBa8Y7iy3ATmp0hPVXfsiMlEm0DBGSeYm8GjDuQaEBmuoHM5CESsi3P+UWlf3zmD+Y+pXJ24AnLjrdnq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5+rc2YN; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5+rc2YN"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-236377f00a1so29148775ad.3
        for <linux-hardening@vger.kernel.org>; Sat, 12 Jul 2025 12:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752348264; x=1752953064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwTK3Ii2JGCxUaNfIgEnGasUC7FHS2Xg5d0TWvZTkcA=;
        b=R5+rc2YN8aON1N023JwAMSgydMdGqoPfTxfAOsHR5fKmqxVcOs5vYK2Ezd9+i/4YuT
         aD1en1JPFfQe3a9Jr1Y7WZErCbQHXcHHnE9kzHO5ZcWL1GKAcFeis1jorWq0QZDJMg66
         Gs+YWCKtyaYbBhDzT+5eOcTwS41NTxEVz9RjDir6DidyvTnO2jFENfH2Il6e6IwnIwNQ
         /ADUtRogpKyc+GUR6ln6FYMnnXfTdccy+xJJSpZuJb3Igpk8N2D9vrW2wqbIyhrUfS51
         uwltWJrOKVnU4TMKp7BWWhXnHSTeis1t1lxphiWfHYfGGaAP2oYzP8QOaan3kq+K+0HF
         8HHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752348264; x=1752953064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pwTK3Ii2JGCxUaNfIgEnGasUC7FHS2Xg5d0TWvZTkcA=;
        b=umBZSUkNYlYV7A0pEMtJAzmLdTySbFk+Zp+S7OXTI+jx+Ko3qrB6FVgwpFfOsyLyKH
         QNKKQZU6kINk1oLELVZge++hgYmdPzgB/075sxm2fyDzCKQ7CGSA+/m86s3FXkAhiIS8
         B0TXPiIBfdAoI7krHFl64Z0kkuP9zJK6qwgj9aGKloBPHbs9t7DJL6lvDZkZxLyCI3JP
         0QYt9nYZOYyGbbTaS8UjNBZ26o2OaUC2jMI+ot1EjXsMs8DwP1RQIbc/aL/J9uADv9EL
         K2sSzIHpvEm7KfRYrlszPVHYOuOPfkaPGu5LE3YWUs+WLEPvliN0wtpbg+z59IXnUMvc
         fLKQ==
X-Gm-Message-State: AOJu0YzDz9ohB6ppAMcWK507+QWKjMTJU9Jm3C6+F6jaW6Lz1+oGxvKb
	HHZQmQbr8ysHz5TpoD4KsWu0PcgLH8pvztGkySxpGi1A6ZdFcxjCiY3nZ9GrcT0q
X-Gm-Gg: ASbGncutZ5fThn8qwg6zV2BE5KarUX/auHfaYD8E311t8ej898uzHSM6Iy5mweY9iFe
	DoHiR68W4aGw6LSK4srFSXmzX8WIVSiCVTyMJxcTtdQIFY2m5WZ0NlP8dqMbAoJKUsE2RZRpGj1
	XZ5tSp0/t6DnkqWBDxTa4lYhgvf7NkpqRR1QRZE/i9j3Gw9JvVgYm0GSjyXnSgc1Yr5uGBhPWtB
	YD8UfPbG7nF8e2XHigaoxv8N24ksctM0nPhmbfK0kdLhHBAU01O2gin651BpacVLx19cbLkfjao
	R0gxC3IHl7LQz8ZgJMD3ffcrMr8ws6a4eC7/rFBFydRC2pHdmPkYEQpS/HfXXKglG/kZjR4T3IS
	55FIf0xc4EDZGDfHOtI41JEOsgkCwEOEj6BXkwj3d+lfV
X-Google-Smtp-Source: AGHT+IH/qJJdxi+/YolnTuRqLzd4zlgtMZz3xDtGrx0tImiyLb3oZ2wdgq0wkR1RsqE9V20pkUpfww==
X-Received: by 2002:a17:902:d505:b0:236:8df7:b30a with SMTP id d9443c01a7336-23dede2d305mr135509085ad.1.1752348264414;
        Sat, 12 Jul 2025 12:24:24 -0700 (PDT)
Received: from localhost.localdomain ([147.182.204.210])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23de4332b0csm66013645ad.149.2025.07.12.12.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 12:24:24 -0700 (PDT)
From: Gatlin Newhouse <gatlin.newhouse@gmail.com>
To: linux-hardening@vger.kernel.org
Cc: Gatlin Newhouse <gatlin.newhouse@gmail.com>
Subject: [RFC v1 13/17] softirq: add SafeFetch statistics to irq_enter_rc() and irq_exit()
Date: Sat, 12 Jul 2025 19:21:58 +0000
Message-Id: <20250712192202.707192-14-gatlin.newhouse@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250712192202.707192-1-gatlin.newhouse@gmail.com>
References: <20250712192202.707192-1-gatlin.newhouse@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

---
 kernel/softirq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 513b1945987c..cfed8419b6c5 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -632,6 +632,10 @@ void irq_enter_rcu(void)
  */
 void irq_enter(void)
 {
+#ifdef SAFEFETCH_DEBUG
+	/* #warning IRQ_DEFENSE */
+	current->df_stats.in_irq = 1;
+#endif
 	ct_irq_enter();
 	irq_enter_rcu();
 }
@@ -708,7 +712,11 @@ void irq_exit(void)
 	__irq_exit_rcu();
 	ct_irq_exit();
 	 /* must be last! */
+#ifdef SAFEFETCH_DEBUG
+	current->df_stats.in_irq = 0;
+#endif
 	lockdep_hardirq_exit();
+
 }
 
 /*
-- 
2.25.1

