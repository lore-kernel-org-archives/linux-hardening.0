Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3F41632DF
	for <linux-hardening@vger.kernel.org>; Sat, 12 Jul 2025 19:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752348263; cv=none; b=mP9RHEyWbWlXt32QRVbqC1oT+EKh/CvvbYD+OjN+KwPTfjjnYM/XcSyhrYz7m1hBnQakPg9O4SJvTYAh1uwvOsDMIaEmhVgBqJwCME6+wX/h8ZuFyoIgrosuaqe8MRuomqd5ZMEzVg1polvW0u1u8SVFF0fLSrCt5YemzweDu7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752348263; c=relaxed/simple;
	bh=sdUbu1YRqDUs2YPPiQLLqXEU9fTC6OTl1SV5VJDGyhM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s/boB3GvDerKwKarvN+5GvWmoXKuA4TlIAbPbzCvcMGEv+KNHXWagpktGyQxhBE/jVHdXWZhDirlje+UoiQp2a9DB8F1C3JInvckwpCLowCTFn2hTkO6/LPmJrLmb7uETFiOugfFq0xrAF119DnXw4wQsREItmBtIyvDHM+MSMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFllZ+Vd; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFllZ+Vd"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b31e076f714so3401273a12.0
        for <linux-hardening@vger.kernel.org>; Sat, 12 Jul 2025 12:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752348261; x=1752953061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SoPp0m6NDfn9EhCIVvyFZSquihJhdByRxapR8tKG8mM=;
        b=LFllZ+VdnVSvip/327ggiIaV5DxgN3A9O5GQwe8Rj7LkKZ+HHzsSKf+jzgIco52iK5
         QIsBx3mPI+GP4gNodCRYdp5EMulXt5KOzKBo/mphYW17z4bQBQPy03P84bI9FubadSxd
         BOFNyLcnv/jMIQzN4cQboUWai8aXBQvGYMAR0thWGcWe0CbiBGPufazWorQ3/E3obccY
         /wyKY+X1V/L6o7J2LFlmy3lTseLW2yW+ZOBPWn/C9dU4rOZP0XAfcBfJSpSAwFJFzy4p
         NepRuEcdWo7EcGrkAHyaN8k/q/iGee+eltndu6iaTUHJco2hg56gSv2fAgkaB5S5tPXZ
         r0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752348261; x=1752953061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SoPp0m6NDfn9EhCIVvyFZSquihJhdByRxapR8tKG8mM=;
        b=pNk0uR9Pas2V95ImMn8Zl+Ibv1L3d8Im1AIi4pYCS+6VCEiSxn/uAbf/YdEHSyKzmp
         4FeDaq17StYsO2GipgTIeC/zE2+QjfKoEVvMVefRr8j4V1Z+pWLddFXryMFlcnWyzLV8
         EgSUE1R0rZyeDBcbo53Ci75oETuZEHR7OwIAeSMkLxBtVqafApa6m9drL98ZUfEtrbym
         zfTjbn4HbCGsaz6AxUIjQrYkvEjz0Ob4pc1eNg6mXYMxotECxdtE261+4nr7n3vChZfr
         PjtDlEU8uEYzP5nF2+lAyFGRmvwpI63f2lzKSt7bDwzjzGHYy4JdaVd+ehrE7iAJvxnK
         q99g==
X-Gm-Message-State: AOJu0YyjU6XOYgOzv7xwQYGUff7EnhkJuu3YQhTRhGW6uf0a1qIZOFIO
	2sBo20PPA0gCcR3JLGFtJjQ+teE/BXhcyMEUL0xsLm6Ntm2sblLoDwmrlMKhze6I
X-Gm-Gg: ASbGncuV5tHkUwtC5gG14diWMGhzG559j4xGMGmBjanHFlEnuTkqVpfyTAJfByYgaCw
	PQ+zSRsHZhKhhEMGRlrAJhuOVqeJOIR71BORSqxK5POTUObnMQpSy+SztxZBiz6RYRtNL1VPOPF
	P0HHmr8pEndMId+ck/1AV0n1ZkboxaG3BJq7NzOE7yDiqEKCI41qZokZ8iJwhTWda+aaTV5uZc1
	g0LWr5EfNfP/MJZnz0KdyM6yIY6ohpH316ZjDRML71cUT7Su83qmi4GNWchqFwd/Dt4Z2STkuZJ
	eHeRB/iI00LHZ1iU3v7BjKO4MrBrhkDekf6qL1wzszgJSZF5VNk87wzfZDxEb4dfaUjJrJlS5b3
	hfOtsIFs5DqXKR3LbrHqCe5z799ziOmOHmNLiR9WrydUahSYTbxHlACo=
X-Google-Smtp-Source: AGHT+IEWpUq4sha0hHMR2gsrqwTI/KpViC5eciGuwx+vUK1B1r73pz+zxMg+Ac/4utX4ta3nnwo0xw==
X-Received: by 2002:a17:90b:5292:b0:30a:9feb:1e15 with SMTP id 98e67ed59e1d1-31c3cf2dbb0mr18620127a91.8.1752348261255;
        Sat, 12 Jul 2025 12:24:21 -0700 (PDT)
Received: from localhost.localdomain ([147.182.204.210])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23de4332b0csm66013645ad.149.2025.07.12.12.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 12:24:20 -0700 (PDT)
From: Gatlin Newhouse <gatlin.newhouse@gmail.com>
To: linux-hardening@vger.kernel.org
Cc: Gatlin Newhouse <gatlin.newhouse@gmail.com>
Subject: [RFC v1 10/17] iov_iter: add SafeFetch pinning call to copy_from_user_iter()
Date: Sat, 12 Jul 2025 19:21:55 +0000
Message-Id: <20250712192202.707192-11-gatlin.newhouse@gmail.com>
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
 lib/iov_iter.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index f9193f952f49..8997272481c3 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -41,6 +41,10 @@ size_t copy_to_user_iter_nofault(void __user *iter_to, size_t progress,
 	return res < 0 ? len : res;
 }
 
+#ifndef PIN_BUDDY_PAGES_WATERMARK
+#define PIN_BUDDY_PAGES_WATERMARK PAGE_SIZE
+#endif
+
 static __always_inline
 size_t copy_from_user_iter(void __user *iter_from, size_t progress,
 			   size_t len, void *to, void *priv2)
@@ -52,7 +56,15 @@ size_t copy_from_user_iter(void __user *iter_from, size_t progress,
 	if (access_ok(iter_from, len)) {
 		to += progress;
 		instrument_copy_from_user_before(to, iter_from, len);
+#ifdef SAFEFETCH_PIN_BUDDY_PAGES
+		/* #warning "Using Page_pinning for copyin calls" */
+		if (len >= PIN_BUDDY_PAGES_WATERMARK)
+			res = raw_copy_from_user_pinning(to, iter_from, len);
+		else
+			res = raw_copy_from_user(to, iter_from, len);
+#else
 		res = raw_copy_from_user(to, iter_from, len);
+#endif
 		instrument_copy_from_user_after(to, iter_from, len, res);
 	}
 	return res;
-- 
2.25.1

