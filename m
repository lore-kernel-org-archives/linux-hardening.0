Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120302EBB8B
	for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 13:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365413; cv=none; b=e8Y/Ccw4NUPNGxfsyR9jA35MJUV0wPaclnHTw6Ka9Y7GKex2HD4fi24k3dAqqgInlwDTV5DZBf9ORkwLAhkD6hmHXlL7gQNz4o9j4cJsCMUWHnhF95HvnNx+D5ENHXeyEk8Kgd+z0rVZ8HZ9+j1Yb2JctezxFjOWaSatv0cVvzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365413; c=relaxed/simple;
	bh=SQxu0R+MOijEBbbV34mwRJA/GN24qy3N7mFo2kprDqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3zOaVF+TpZRVWSw9HSC3JqGGrBfkJbX+DebGPQCNTWEwMjzOvNAh62bDUI1dpx81UPDLP8n4zyR8Sr94FMGC4+zq8X3J4/YTK4GO9X/sBG5lVJrc7U0+WAX5bkKCTPyGAtuM4KnIlNicXkCGDEPvyL90xK7LuYgFVkwGglS6Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V+yP+DjN; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V+yP+DjN"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4538bc52a8dso7185165e9.2
        for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 06:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365407; x=1753970207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVVaZTfA71hNG0BSuf2xrM/AfoVAw+w3Csdp+8nmO5Q=;
        b=V+yP+DjNiFBdmZX0+X+1GT/0jSDVJQdpQWqF0ppRaNQzc49toUn7rWNbIPLNzBTV3v
         wNWkiexWDjY63ikTVsoU/ILyqacQjZ8QacKphScsC4/f5U/YePpcxYSjHSY+u+V5+Ltx
         sskxvykF7Bu6ijU8AFPBb6/AO6OoNgxwzH9F4MeY4v26sSuSak4sPl62uaKzjx8DkVRd
         jLbvBD4ef/mS8ygVvLqsdORg8bSZCWfz5Gmfn7oatkWV7HvTa84xItdTnRbb2envSyQ9
         LHRe94Xf+/ggX86LXMsDhr6R4dQIHDZ2xL7nhc31q42I1RLqBZCiOXI8TCGbKrwR9TTW
         712A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365407; x=1753970207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GVVaZTfA71hNG0BSuf2xrM/AfoVAw+w3Csdp+8nmO5Q=;
        b=CCvR/eSbMPNoCPcYpjekzUNsAyZKE0URRm0wXyAx1L6oliuVbqKYStAuC0cYiLRi1S
         zF9REAKIqX9U9Nrfvwp7HdNxcgLfHcbs3j70a9Ij8+9+dVdjvxODapAceIF2Hq00wRFj
         zGzpAw/dUmshHYILeZWdWkrtGby4dvIs1oqC6E3V0CXh36Aajt1Vac6fbIbK+tK2CYM7
         IRhSGb1xjAFZLCLV43m2RuxibTTCEhK0pekavXaG2VpBM6xJ6CU0tmWn1r+AYEWBg2nj
         Er/dojKuTBV79O81fVF8e+tN5SHA4fjpYAgGFtl9wZTiuVIbY+TKqf6CPh2FBFneYxw4
         z+iw==
X-Forwarded-Encrypted: i=1; AJvYcCXocYPtWjk0u906LNLWeD/UCKMPtph1v9GrgN7N+eVjVzoHF+NF6I6VYMDm4+R7NfZ9Tg4Z2hIDPtVRZVHWja4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyblcHlVErnkuOqtWdzYa8Xh+Zig6pmL3/MRt7ilwiphvmfT48A
	c6sc6WsuSE2j8EO2yX/sag34dBikOdjZ5G2j4ArHc5RcP4HWG8ErkmtiXweBSJm1s0g=
X-Gm-Gg: ASbGnctyccPahUA2iJYbfTd73DQNZwRH7UJOMLjMAfSw/asiT2MbeKRCgik98dEFj0G
	LRQ+gaJ4LSThOtOkrojCfhCmA60J98ir6Z9DIsFdQbLAuN2iJ1wKTeOevEiQKs9HQaD/J2NSTPX
	MIu0FO/+FIKKH0QMmAFJQ3r4AgYK0+7jwKZmI/tb+3XhNWo/iEVbTakrNys2bBRozsIJfagi3mp
	Vv6QZH6sg/X1xQLo3iNY7fXiFCtwRkucVeGi2WgEUkrntDLltd4kdLC6+XZ8qMgOvU6LmaOxYm8
	NfVrjtvc8EaKUxFAYbWmCgXJtXqu/bl4cY7EAwUszwVyKCq8zcY5BirhmhRkeIkCTD8CS9UZT6y
	VGoGjEqDZJdgYbGdhI6SmQFiHikMzczET/V2tViK5y30cuSWgFFoS9Id0FV1X2CihULDn89Iw4h
	nOMNRCaKOOvSnO
X-Google-Smtp-Source: AGHT+IEY/sSxRS3Okztem0YstmxIRhVbZi0Ba2eKMOhhVazzTllUuYgXqZyOH8eoFni3mxJ7gmSmCg==
X-Received: by 2002:a05:600c:630f:b0:456:2bac:8f8 with SMTP id 5b1f17b1804b1-45868d485b0mr79331075e9.16.1753365407522;
        Thu, 24 Jul 2025 06:56:47 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:47 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	eugen.hristev@linaro.org,
	corbet@lwn.net,
	mojha@qti.qualcomm.com,
	rostedt@goodmis.org,
	jonechou@google.com,
	tudor.ambarus@linaro.org
Subject: [RFC][PATCH v2 28/29] mm/init-mm: Annotate additional information into Kmemdump
Date: Thu, 24 Jul 2025 16:55:11 +0300
Message-ID: <20250724135512.518487-29-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724135512.518487-1-eugen.hristev@linaro.org>
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate additional static information into kmemdump:
 - _sinittext
 - _einittext
 - _end
 - _text
 - _stext
 - _etext
 - swapper_pg_dir

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 mm/init-mm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/init-mm.c b/mm/init-mm.c
index 2dbbaf640cf4..01ff91f35b23 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -20,6 +20,13 @@
 
 const struct vm_operations_struct vma_dummy_vm_ops;
 
+KMEMDUMP_VAR_CORE(_sinittext, sizeof(void *));
+KMEMDUMP_VAR_CORE(_einittext, sizeof(void *));
+KMEMDUMP_VAR_CORE(_end, sizeof(void *));
+KMEMDUMP_VAR_CORE(_text, sizeof(void *));
+KMEMDUMP_VAR_CORE(_stext, sizeof(void *));
+KMEMDUMP_VAR_CORE(_etext, sizeof(void *));
+
 /*
  * For dynamically allocated mm_structs, there is a dynamically sized cpumask
  * at the end of the structure, the size of which depends on the maximum CPU
@@ -51,6 +58,7 @@ struct mm_struct init_mm = {
 
 KMEMDUMP_VAR_CORE(init_mm, sizeof(init_mm));
 KMEMDUMP_VAR_CORE_NAMED(init_mm_pgd, init_mm.pgd, sizeof(*init_mm.pgd));
+KMEMDUMP_VAR_CORE(swapper_pg_dir, sizeof(&swapper_pg_dir));
 
 void setup_initial_init_mm(void *start_code, void *end_code,
 			   void *end_data, void *brk)
-- 
2.43.0

