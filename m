Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13B333C1A1
	for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 15:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567152; cv=none; b=qjJwIbnfg0dpM+4OtVknTiC4CvvNA3hixTyA7AKqesWvCinGwNfxBxlnDmsNdXYNZphLV50mRF1EhWpZyyQ0hhwAUJcCbNy3V4cUt5gyhpfqtZ0UuL7hBrlE8XiP5fnM/Q94muF9POV9Jttm+CwZR4RMLhmKkN8uP4ThxwjX8eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567152; c=relaxed/simple;
	bh=1fpsqew6FkRmrcxog8da4NhZ+AALs5Fn4Z4m4DLttGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f/lsPotMYduM5A5tgO4OukE4A6Jo7doxVksNSt6ay5asjp63oaE3J1sCIGZa9LiabBK0QIXEOXH9NbWkSZX4dapr2deEm7qSRg2jL25pVywZt5ws74VOG97XhtwNSa8z5+jdNvOx3hRZUsD70r9YDx7fZ2rxdUFsopKyrYQ38L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TDFZ1Lau; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TDFZ1Lau"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477563e28a3so8031085e9.1
        for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 07:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763567145; x=1764171945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qf0q06JpGKFVTNkejD0yb20CFvUyN2OLH5ZYFwRjaWU=;
        b=TDFZ1Lau6WPw6tyZUAI40mJfoARSjm8gLGa8hZEvOVsTVCAvvEoljNzjcqBTO3a1h9
         UX3wEiFW6HWi3GXSZ7R7C/wR9O0fSPFtMH1z8YTC6poYITj+PkCAMn2Uxa8k1QP9IEZg
         ZT3mUC3nibavdyK8E1rX5NRrHwzyeBVoWusZ8P1ljTrYjPJxQoBpdiQ9aW/xIQ7zdBfl
         lURYj6pwWn0cfxS5Fv226Pjg+zV/5OcnYIJN+UrO37SelHg2c+odhEiQCb4xNHL5/wh1
         2AzQ6Z/LAR1mF/VSx3U8b0YZ7wWAXgFO6Bw6877BgJDcul1GYRjqMQGMkLv8OYLKigZv
         TsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567145; x=1764171945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qf0q06JpGKFVTNkejD0yb20CFvUyN2OLH5ZYFwRjaWU=;
        b=eh4Rqqxv+qlxJOG1Y0hIRxnJg7eT4ZRlVlKvVGEC9d4tc39uqEHaguyy0RIHanWJOg
         PI4DjQnGgGlJZEplpY74Bd1HqYOMJBzzMD+e2GtUc2MhVPilTTfyHaTM5mg5BgHdT4RQ
         3IGUchNtBCfz+g9zGrJcTqtOZN0SCsVHdU9nuaHHWjSZN+CqnTPAaTZoJplVry2IUD8r
         y3/h7WkMDvJNraVCuUssV0rwUWsBitNP5TribWtSAhDhuziAHdyVWwIzs9XFOukqlFQP
         01d5rqNmfAOV+ufoGak9aJqyNcikzrOjGjENHGFeA7isq5uDklRbCkKA3XdZJ+WtA+6C
         xVOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp5yqKp3wC3R4fP+KWyD6nYaSW3EprbuaUIlQb51sXV8+0t3SEbGf2HJtUOaW76TPOLpGIg1IxZVNpYDpvLF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz68rG89HGIYWCKt4ZByVbh/lO4ssWJZYlOxRNoRAsMX6x2wArP
	AEOSORVyRqjf7xP+0iAYFPH9YXS8WD93+hjEPuw+JUM2J4MxoOK1TGdKW8z/P8TagdM=
X-Gm-Gg: ASbGnctjmVCi2NsDENphLQWCLlqe15lxSXbn4Qdr7hsEypFTYn9BLRneIgeyo0Csmcp
	ZTx4DLHOFjM60syOwnUls+xvWoLE83rfVj3WUfx52ow4PxrVpLQFasMlpo6QqXMlV/aZeFa2mjZ
	e1TSoYqb5Oojz2WtHk70xgJ79LPoSp3WBQmZpDz4uikZnY3zrm/hy3rruNnIWc+6tPd6A/KYZhR
	juKWog/DK/p1Kc4EH+o9R6zsVvFwSFpoi2rWPRirqBtZLn2rF9TQNpd9H3H90iZUMdjiKWb2Aqm
	cXUeJfcymtbRyTubCd7g6pw4Z2DIU/CSzwv1/HcfrLS3i9HrD5TPVVEcjx7Uti3/SZq67qwVbFQ
	8qHCmWqVKL1a9/Q/fFh/r5VDjdXDVepAEbcc0ClR9jMOX5lx7YR37pezjzhSbN5dD+ca3ONuvx8
	MpU3h20Oq4DQ/rxOn+5xzhSNfbPGlUlg==
X-Google-Smtp-Source: AGHT+IG9WtxjjgmkiAX9yQZlIznike3yBomBYuHSDjoJXaquW6OMMeXhxlHfzRespLZJBzb+ERriSg==
X-Received: by 2002:a05:600c:2313:b0:471:793:e795 with SMTP id 5b1f17b1804b1-477b1787bafmr21362035e9.0.1763567144657;
        Wed, 19 Nov 2025 07:45:44 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm38765632f8f.0.2025.11.19.07.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:45:44 -0800 (PST)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com,
	rdunlap@infradead.org,
	corbet@lwn.net,
	david@redhat.com,
	mhocko@suse.com
Cc: tudor.ambarus@linaro.org,
	mukesh.ojha@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	jonechou@google.com,
	rostedt@goodmis.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-arch@vger.kernel.org,
	tony.luck@intel.com,
	kees@kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH 16/26] mm/mm_init: Annotate static information into meminspect
Date: Wed, 19 Nov 2025 17:44:17 +0200
Message-ID: <20251119154427.1033475-17-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251119154427.1033475-1-eugen.hristev@linaro.org>
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate vital static information into inspection table:
 - high_memory

Information on these variables is stored into dedicated inspection section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 mm/mm_init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 3db2dea7db4c..c31062a3ff47 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -32,6 +32,7 @@
 #include <linux/vmstat.h>
 #include <linux/kexec_handover.h>
 #include <linux/hugetlb.h>
+#include <linux/meminspect.h>
 #include "internal.h"
 #include "slab.h"
 #include "shuffle.h"
@@ -52,6 +53,7 @@ EXPORT_SYMBOL(mem_map);
  */
 void *high_memory;
 EXPORT_SYMBOL(high_memory);
+MEMINSPECT_SIMPLE_ENTRY(high_memory);
 
 #ifdef CONFIG_DEBUG_MEMORY_INIT
 int __meminitdata mminit_loglevel;
-- 
2.43.0

