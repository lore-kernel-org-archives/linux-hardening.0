Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E6A2E8881
	for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567128; cv=none; b=i/mclbiUCCNySJAZk2of/rtiEzBpSFKTcoYXRsgs3+fWn3eUd14FAXQP01hIE89yrwT9mud7b3HJLMqD2nMDNnKidI7WopaCEruubd0vZ2dDx4h5R+87upu6tnOI96iTuPBJ2XOlO95Kb7YIsSbmpgwIEmTcPkyso11OWJdlMl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567128; c=relaxed/simple;
	bh=xVX5vMoWLhUppTQAzGqUyciUL0HvTWD+fRU1g1HFtlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUCInn1eiu7vxa6HDff5IPY1MQ74LZgxbINfHQ7N6JhpTVfIs3XtwA5aQT1sX6BrurHkOPmjqTqoDQErglQQZGBijgasZb7xqGWaagHBBBB0KdyGubOmDXGeaL1kcxo9w90m+qySKtk6hVOnHg33jVUZUIFGrj4nAk3Cvi6TRRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s77ePi5V; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s77ePi5V"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477632b0621so45535895e9.2
        for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 07:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763567122; x=1764171922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0blJpzJVpLViS6yP++1+Q3N2n4IWObMjESar9bHwcO4=;
        b=s77ePi5VwhAc5RdCjyAb302P4Ka1p3s03BC0V2FspdVUm4i7WYiQ2/MLytX6QDfaGN
         kK0mUXAjWAWky+BcR4OpUoRFi0GuLC8Jj5SFvNrkKqqTO0fWekjRVtmOv5IQvQfdHEQK
         TgXteXNfAy3vUVfU4mt5qaDa2qJFDh+l7TG550TjqEsNBBo3aCcHsKC73Ycok+9pbhk4
         4qiYo9F/ku0uKX/a+S6dfpVvgv0UCLbmIZ6q2Z3sPsILWyDBj5OUEh6kQHBhCPh7EmVD
         hwar1tExtLfqrIQdYXQl1vj4KnszoQmpLBQ0hyx18qnEvaC6g0olZ5w+plmslpAGCUNT
         kFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567122; x=1764171922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0blJpzJVpLViS6yP++1+Q3N2n4IWObMjESar9bHwcO4=;
        b=AJui7k4XlxhHmeKp3OodExWnkYSqVvmfCuVEayabVR38N0+BJrTASPjRUi/1JmwbOb
         2MMxZzeAsoGqY2iLw/Qm2rnF5ZblEReYPD6xgaymWJED7iShQeH0gFsQkXMA09Xr8C34
         cGsYB0i5QnG4HYCG3zRbwI6KbjITYupmguUU+1a9Xchyd9UMHCELyCgFrGDCzNdHdMkg
         MO5NRZQ4LicChvcPqk/hEDEP8m9U7Tja+5nFcT7Nm60I6LXMZHBSk86CF4i8qNbTQM0a
         w/PzfJdtqoFww498yY1I0L4sLZTGc+0t6f7mq2Sqje2Y8NAdfRMuAM8QtN9RG2EEep0C
         9YlA==
X-Forwarded-Encrypted: i=1; AJvYcCXT8T3tac+Il2JnQvkm3cc/tXHYwAelnKWyrsspz++Q+WLPVCs9LlM6vPekKEi01EdDGtgQBq4WBcTaDQ7At5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTbQLqMOfQawIPXFg6GIW1B6AOKTDM8C5blG/QDjVQ9z4nz2NO
	TrdLL3jv/X1c+AU+tMXDA348yvVQSFquwO8/EcKE5XP03GWYtQS3hbYtGlfOEDHHu/w=
X-Gm-Gg: ASbGncssFNajrzgDsu1bMHH3Q9l1m2beoDtnlWqGqk3qFjijJSdGMor1BZGcXV0BUBS
	FzijvA7so6f23NmvUFVctCqIW4BhPMS96OGl9cdiqTWZuyMVfP+Ke4M9SMTNJGF65aPTb5O0y2f
	i6Brr+Zyr8KDhJ5KZHM7a2uVUy2tMytJfzGvdY5QlwmVogc2n+aJLcZXhSfOO4xZXupp4b9UgmX
	yN+NAvOqeCHVxVrrge2aWcDYTGrtQepddu5bxEMaOWsmkDbNaAmSW3AITdkSYiAyY3+6VDxvG5N
	7aPC4KyM0iLu993K5Gy/IV1fI/r1wxcycfp+4LRp1uj9DecGUxNRbxbG5h7TCZgIIY7V0OYLufe
	FdrWTcXei9i85UJG5WM+C7uWrOmNvMUR4Dox4E+bLQkv70Nourp0QMo+74QoTVX6ntN5EvQEOrP
	l2cnND8SaL9GwvParguJk=
X-Google-Smtp-Source: AGHT+IEf0A8SfCPAIU5Y+01ECXL2jbadglpozgNAZPe+3fJhQYPBk8r7h45IbtadEb3Wt583O3k4NA==
X-Received: by 2002:a05:600c:3587:b0:477:58af:a91d with SMTP id 5b1f17b1804b1-4778fe522f3mr209598755e9.5.1763567121930;
        Wed, 19 Nov 2025 07:45:21 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm38765632f8f.0.2025.11.19.07.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:45:21 -0800 (PST)
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
Subject: [PATCH 03/26] mm/percpu: Annotate static information into meminspect
Date: Wed, 19 Nov 2025 17:44:04 +0200
Message-ID: <20251119154427.1033475-4-eugen.hristev@linaro.org>
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

Annotate vital static information into meminspect:
 - __per_cpu_offset

Information on these variables is stored into dedicated inspection section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 mm/percpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/percpu.c b/mm/percpu.c
index 81462ce5866e..cdc5b30f6a99 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -87,6 +87,7 @@
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
 #include <linux/memcontrol.h>
+#include <linux/meminspect.h>
 
 #include <asm/cacheflush.h>
 #include <asm/sections.h>
@@ -3346,6 +3347,7 @@ void __init setup_per_cpu_areas(void)
 
 #endif	/* CONFIG_SMP */
 
+MEMINSPECT_SIMPLE_ENTRY(__per_cpu_offset);
 /*
  * pcpu_nr_pages - calculate total number of populated backing pages
  *
-- 
2.43.0

