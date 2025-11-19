Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1A4377EA8
	for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 15:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567157; cv=none; b=mH/w21XF5k442BzcLzZ0UvOnlYkJDDMbPNa3WGa2CmacQInADBz9OY7AgwNXLLziDFNNVknMHkSoES5bz7ajKCmfPE3oXmJxW4eGxZTwPuE7ySyQ8PizmScEyBSbvK0r1E2igMsX7J9YmQ89Mj01mH/Oyb3RGTZQuWejFboxBeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567157; c=relaxed/simple;
	bh=puCNsUx1cqEsVIIsTQXC2Zu04afcvVugn2nqwtYBNCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mowbu6Cr5tXp+cT0Q3kuMrUyFZPnR67jNVQhwvY8AL3ItZ+hioK72p4E8NYX7KM9cDi46IlkmtuLQY09+HYGdaXgEMwfI3vMdXVxjisTf2+Nb2GckQ0mCc2ENflDOXxXEDehUPjl39vn3YNkDy1fEC3xbxxJ/JNnuv4jotWPDxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u2cvfbXn; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u2cvfbXn"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b3c965ca9so3588477f8f.1
        for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 07:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763567146; x=1764171946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDp3sMBoTlmxBrCfHcN3bT849KzRdDNMVpiuychnTdo=;
        b=u2cvfbXnHZX8S86mhbmVlDKoHQ2qZIBOHUToZr3q51jGLlJFmHxxQcU/fm1uw3dr/L
         ryR8SU3D5iO0H6+339AdAvKpGNAn1CK6/oOlstGHI4cd4xG6+/w44Ge5Or0ybjFmHaS3
         TmyiHTUji9gaHk7uex4IBqSQYtfvzqDF4k1l4LfR1824PbZuKmIt9zwUJc4RzpmuIicf
         FnV8EwOu8LdVRf/aAcAWgL+Gv4kc4rnhvuoRDiBZpPwDdKCtUw0xPkaSpKH5yXwWXj/t
         JHK8eUL5sBMFkiK5dz64vZJDZsK1hF9kybnlSUvlmbITELWgyWL8yGyyhYzSYh/yxDZ1
         XWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567146; x=1764171946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cDp3sMBoTlmxBrCfHcN3bT849KzRdDNMVpiuychnTdo=;
        b=GmRF7qsCIojKYD/robGKxPooUYLjd0Ptsm8fDxJ/wxBzAnW5kuSZda0DgA7N5RTM74
         gQN1MrZSxlK4tT3XQEKmg0fd748pXcILnLX/1unogH9IVwsU0oBfZMLldjoyuEGrg99a
         43WCDGOITuNl7Vhx9LNRMOAGlHZYyFTE9OPSyTEmYGojV4JFMI/c+hbNtPETI8vm1nlV
         bHAnKi33SZMYNLs4iMSV7dovvBwNzh/zxVj/2tZfvAfzd8Oa7m4FGAk1GI9Sb1FYWsgW
         NPbMd+Eb2uSEVylQ8kCDDzAkoxHlINddxKAdGYWmZkraxh5PLf5WX7e6aFAZHlsNZLzx
         8soA==
X-Forwarded-Encrypted: i=1; AJvYcCVuTMKGBaxYuqtGigx02athPSLiwQnZlk9ghUKlcHMweGVsvl171enwP1Ul/WbxjwJhyebNgb145a5ez1XWysM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+8HJZd07olkEiG00MMFbp7fI1UlRkbNoUwTuhRVYe27r9oQwp
	mrxkqxmlBZtnDdbAEZOq9ahxmPnjCaGDh4Vn8FyFrzCNi/yLF8wv3Z3URX5L2zrj+Ds=
X-Gm-Gg: ASbGncs6RjADmdCs5oezuhzbxMKO/C6arRloFNXcPH6lwKunnDAWoIFzE87tpiPgqQw
	avBRePCpemiLHcvtO8nXDmBoJ/HQFOzAjK7KBjEgdlU/6mq5UMiipYg1xyM6ORgrHNn6kD7qd4F
	TMk91CHqFPAri3coXBoe9eWSGmYZvjTNC8tfKZGOHP8ru4jEyPqNsDpWacfGRnh4KZTZS8nfiEH
	i1NpoFuThV4d3dM+1gBr+H+rPzR0kQydyQpkiIdZZ5j4JOqGNE7eieUrr+eRayCniUkO29Wu3Yp
	rwRS+u6FvdfQbBl8g/N6GupKLaH6vzx1EH55yllcL06uVvkRZawGjRGYhU/KG0NqiEBejL+oDvZ
	EK/UL3XXGBeND3zQZzT4h73CjdStfsWRKG2ybYVtzS8bqOH6+szDEUXZkny5RqEkResDslEYXhz
	VUpxpZZlVroqGBhbabBSo=
X-Google-Smtp-Source: AGHT+IHSn97ivXqqEi+3+TEBhok4L0zKY5jBJq8AwBEmyjMgjDaigOLXet9t8Pqm4XTXHvlHGh5HZw==
X-Received: by 2002:a05:6000:2891:b0:42b:39d0:638d with SMTP id ffacd0b85a97d-42cb1f9e35bmr3506384f8f.28.1763567146421;
        Wed, 19 Nov 2025 07:45:46 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm38765632f8f.0.2025.11.19.07.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:45:46 -0800 (PST)
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
Subject: [PATCH 17/26] sched/core: Annotate runqueues into meminspect
Date: Wed, 19 Nov 2025 17:44:18 +0200
Message-ID: <20251119154427.1033475-18-eugen.hristev@linaro.org>
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

Annotate runqueues into meminspect. Even if these are static, they
are defined percpu, and a later init call will instantiate them for each
cpu. Hence, we cannot annotate them in the usual way, but rather have
to call meminspect API at init time.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/sched/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f1ebf67b48e2..a68367daddb4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -69,6 +69,7 @@
 #include <linux/wait_api.h>
 #include <linux/workqueue_api.h>
 #include <linux/livepatch_sched.h>
+#include <linux/meminspect.h>
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 # ifdef CONFIG_GENERIC_IRQ_ENTRY
@@ -8792,6 +8793,7 @@ void __init sched_init(void)
 		rq->core_cookie = 0UL;
 #endif
 		zalloc_cpumask_var_node(&rq->scratch_mask, GFP_KERNEL, cpu_to_node(i));
+		meminspect_lock_register_va(rq, sizeof(*rq));
 	}
 
 	set_load_weight(&init_task, false);
-- 
2.43.0

