Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5D228A705
	for <linux-hardening@vger.kernel.org>; Sat, 12 Jul 2025 19:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752348265; cv=none; b=oML6Duff6RG2jCe9iE9t76XqLNbJwlXvnO8VDbUNBfjdL8S0l8sHWsT3CDadqXRmPqnJWP/fuYKUeNE+Oji7aSfQ6YsCbsyofd1LQ/hJsrDsD6zaSd/iJ0l7JQYK3mYi1Ss3U2uT+pEnjjt/OMJSaI0BjZMUBCnQ4jxM4vJPNKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752348265; c=relaxed/simple;
	bh=sXkxHihvvZau9PoJK10ZCpXrBe5PuvvmXkY2bpfemvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xe0xamUCwr4ktnmpjPaxq1pdREKn4E1FToxHCBr6BWNtbTCq+RJAbjogxsc8ZlpVf/QHyYNk2hgXwQCYezT11am9rtOoGNLh35JuaQPfdzQT+EJduJm5sMe14rQv3jXuspAr/hCeYbKU0ZbMcUFHn1kVzRE13xuYk3ZF8NoMlRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXeEfPkJ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXeEfPkJ"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-234fcadde3eso39675035ad.0
        for <linux-hardening@vger.kernel.org>; Sat, 12 Jul 2025 12:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752348263; x=1752953063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7n3xVRycZIK+5PwUIoEkPRDvZCVi5pgZwzHwLCu2O0=;
        b=XXeEfPkJl4lrgAIiWWKdBH2YT3XseocJAFkZ7OzgS15BWTooXxXd0hxPQ3zhOED1y6
         X7OrgkR1ObjEQbGUWMjnNk/eyB9O2IN8tAmbFASbvkkQoqCankaeZrV7fX9ahQCT2rKm
         DMUtuw6DhcBwz2VHBhHUNn1ercKIQy41+jdIQ3MpNK5/SDgtbQ2OsY2PwGHWpRmIVQNW
         guhXjFWPzi5OqoHB0esN0AGU5DdvLc8G21O3Gj5E3dGXHLDL9BmbdyI/usTEfqZHfrXs
         /iItXWRSY7ChVriEqNY67p7aTOunRq2v8Yono6xDf4ZK8HV6hoRtOgFPApCTTJ47aBM7
         yLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752348263; x=1752953063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7n3xVRycZIK+5PwUIoEkPRDvZCVi5pgZwzHwLCu2O0=;
        b=IecYFmIRA3u1T+I16b++wJs5Q+J8axdBVpcsfJ3eFiTbH9infT3X/RjL2kzNPkuVkX
         4Fi9A/lCHTwOqnH8Ffq6wP/PtzqfdS0+a+yVBfkvx/Y/CVgQ5OzTtjkaF2S31dNOMKKM
         yHCLQ2kt/AOH+dxbcdG8kJe9C1LAGy+t/e7EE5JKY/UxxtRnD7e6ugfefAxDbyfPheL4
         cCbqg5Pj4NymhDR4AQP4DW5n9tzghSH6zUBWfyVoejhvfx3Tp7VWVpNxct2vR/75D88T
         cQTmOsnQyGFpqTUPiHEllREwMhtreEy9lfmL6zHJEwWKBgmflfcEDs3l8+X64395bh6X
         P6gw==
X-Gm-Message-State: AOJu0YwkdkCiAUgzAq7VrJiAGPZaFVkyboekMXHVilZlD7mTj1jFNybY
	m/rtaeksvjqKr83g+jrMgCwr7/GXGA5VElwv/ESFL/knrdyfNNQZbHCD9a9gkZ4u
X-Gm-Gg: ASbGncvH6ZppWdMeH6avOaUtEtWIj+FOoQn2pE6fPgkxWa5NGrvld1S+mE8bGbpZyOx
	pIF7coJ0zBU/e9+LYwLZ5Qyu/ILp/ccXMoV9UHzvKpYAJ6kOLKkbC6hbnZhCdccln+IBBTjp1Jt
	JiS6c3y1GUOl0l7Xlml2pf5cqvuKSVYhRkqO42KoQ2w9mQgAWp/O++yYFbZqtk/epXaGItT+h48
	RAy7FEK2DS5FO+D6O5ZXNI1Fv7G+LTNXm+eiqwWPMBHOMaDfxO9+71PK0eElO6R1g28RZN5QgPS
	yAh0r5S8kwfUpHK6qCsr0M05YAZDGfipgXsABb8zoJ0+NenEaNMkKh/7nsUPN92rsz8pRMod4ZF
	fRZUhPFaCZSdD1zYtKPqSwOrLOddZfUY/Aa5yklii2XEyEQ9VQB1j5aw=
X-Google-Smtp-Source: AGHT+IEeCoQHLHszPowCA8EEqxpodgb8NLFZgimI5dSxhlLgbhCjhrwhwBFC4t85uYOXCaNEW7TF9g==
X-Received: by 2002:a17:903:1b65:b0:235:1966:93a9 with SMTP id d9443c01a7336-23dee17b746mr117066565ad.3.1752348263289;
        Sat, 12 Jul 2025 12:24:23 -0700 (PDT)
Received: from localhost.localdomain ([147.182.204.210])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23de4332b0csm66013645ad.149.2025.07.12.12.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 12:24:22 -0700 (PDT)
From: Gatlin Newhouse <gatlin.newhouse@gmail.com>
To: linux-hardening@vger.kernel.org
Cc: Gatlin Newhouse <gatlin.newhouse@gmail.com>
Subject: [RFC v1 12/17] bug: add SafeFetch statistics tracking to __report_bug() calls
Date: Sat, 12 Jul 2025 19:21:57 +0000
Message-Id: <20250712192202.707192-13-gatlin.newhouse@gmail.com>
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
 lib/bug.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/bug.c b/lib/bug.c
index b1f07459c2ee..d1007c1b3dda 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -155,6 +155,9 @@ static enum bug_trap_type __report_bug(unsigned long bugaddr, struct pt_regs *re
 	struct bug_entry *bug;
 	const char *file;
 	unsigned line, warning, once, done;
+#if defined(SAFEFETCH_DEBUG)
+	current->df_stats.traced = 1;
+#endif
 
 	if (!is_valid_bugaddr(bugaddr))
 		return BUG_TRAP_TYPE_NONE;
@@ -194,6 +197,9 @@ static enum bug_trap_type __report_bug(unsigned long bugaddr, struct pt_regs *re
 		/* this is a WARN_ON rather than BUG/BUG_ON */
 		__warn(file, line, (void *)bugaddr, BUG_GET_TAINT(bug), regs,
 		       NULL);
+#if defined(SAFEFETCH_DEBUG)
+		current->df_stats.traced = 0;
+#endif
 		return BUG_TRAP_TYPE_WARN;
 	}
 
@@ -203,6 +209,10 @@ static enum bug_trap_type __report_bug(unsigned long bugaddr, struct pt_regs *re
 		pr_crit("Kernel BUG at %pB [verbose debug info unavailable]\n",
 			(void *)bugaddr);
 
+#if defined(SAFEFETCH_DEBUG)
+	current->df_stats.traced = 0;
+#endif
+
 	return BUG_TRAP_TYPE_BUG;
 }
 
-- 
2.25.1

