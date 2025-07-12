Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B3C28A3F2
	for <linux-hardening@vger.kernel.org>; Sat, 12 Jul 2025 19:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752348259; cv=none; b=mkcQ7sQf6INGTEPqdqn6oYbRRdROYJtdXXk3EmDEU+7g15+z/qRZJmDhkZEMbBNoYa+mUu4SUZRvhThVS/f0id30dHzdBDdi6HvdTuoI7UCtFNtiz53UQ0QkyN51+ZtWQbjjAkjyTH1QnG5V+QVLFsB7SI2dqnQf2nx/qGIMQSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752348259; c=relaxed/simple;
	bh=T4ev1myiJNlrSVB9uy6eES+bFsvdJ8U52jra2DPYfpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=airDAt25OqXmpPrQTu5L1vLPFCNpJ71BUl2/r1wy0jOitf75cZMhdxK51cUpSvbIhm0myirLKv7YfgRRvNMnBZG8Xf5UMIThjeGUEqVRZwgu/9Sk18hRQOr9I+DvIaY2B8xDztDxe26b0ONU2Yz58CDrBxIOxa0OCo/I9YUVOXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3qgrC3n; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3qgrC3n"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23aeac7d77aso26018125ad.3
        for <linux-hardening@vger.kernel.org>; Sat, 12 Jul 2025 12:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752348257; x=1752953057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmjU9c7XFNhzBgv/SPa89jdt4dtsCwoIEITxjWS2MXg=;
        b=S3qgrC3nbHZKXoMdbV6r4Sy6Xd6P07+ZPPQrSC0aotLX5igClbuTZz6l/OQVhhZ1Wk
         7YitMMdJfpHH8tv2W9jJQC+KB0VW5FXFW2yJWCHyIZOWoVQy033tyweLAdabJW4FXKyE
         t4dyT1kWRo3JjPjBm1JzO6+c5lmsg/tVwocXsT69a8qvElmdnqjw49DX8DVWpUAUFl3P
         k/8IvSv7ptFxLWd537at7SAutNjoHmY5R5Uaqucm1NK0/iqlFprLSQOaYVcmRxF3csMZ
         kraAtPJgOOOeGmcSZHraHuU9GGgVV9x0Ek2VO6SneUrdiL4vFRZ9B2aydYveZf2liinc
         8MWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752348257; x=1752953057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmjU9c7XFNhzBgv/SPa89jdt4dtsCwoIEITxjWS2MXg=;
        b=HOWYzHToYl4rZL6ncaIBAJlQHxIcSZaZpdg+UodwnCczAEB3ABFRj+/VhYX7WS/gxt
         1ZI+QVHL59Ovkl/vIuucb9h4DuwURYmUTzmmVc54rPMJLiv0LdNRdLI2iJrqbBa8tlrH
         PlY3yob8DEVy506CTZpKYM7u7R6ABYmaR1s8LL0+B7pktGK/oP5zQicylAdZBTNlgUOY
         GajhhbC1IYHjJBBNAiG5QmBXl+caEvjgj+ynmLA9gfsmm4FUgIdtg9ARjBHencjwA9as
         eSCspzi7tjbf5KGAyba+d669y5Uc69BoqF48Y3pg27dhNSrcvYEzpCSnXt5Qg4EsI7ro
         Cl2w==
X-Gm-Message-State: AOJu0YxDU+6DNO/ye+jpeuRroOZrdRrBHymMs9/UGf/xe9LG2DiTfcaH
	QgUWcdpawg+4aJYb/uYb9pLMw+g+AzTDsD8f6o3TxmiaWSaB+ZHQkjuUma4badlS
X-Gm-Gg: ASbGnct9F4iebZSUXYSgRs9xsoIwHGPKdYc0MfNvMXH8JrYff+rTYoUDjnk+ekN3EXw
	oxUbhLp7tP2lXSwCHQBxvfm63IO6VA6fR7l5ZEfccZ5y7ZVXX8jtri+RkYT4Ub/GZeXNnPYDqrm
	iS9VaOOS51aBOVanwmvA6CaSREWnhZcULxr3aDVa470V4+2T54qJGZlLl7mRdeqHprGd0Hz6X2q
	iLH5WBf98M5471Z+8LbwdxQ1NAC2Y1evOJSu6+EntPNv8/Q7sIy8ECcYn4xRNEwloe3v/v/7fUf
	wP6TE0hPZpWVd3qrm/blbbrtrbL2sVVs21XqfC0tjXU75cinN/bH2eZz7pwsWLsLJsJVa1Iiknt
	vWCmzpCrbNmCtPrHfDbxDOnsNVQI+DzM2y69yI9S84ualReQRp8Ofopk=
X-Google-Smtp-Source: AGHT+IGbMbHBIS8Kq3dqUHNIDRCjsLM6lPSN3a9NaZQVnXhGjMRORDY3ccDj9jetW6AGKkioZ85t8Q==
X-Received: by 2002:a17:902:cf0e:b0:235:e8da:8d6 with SMTP id d9443c01a7336-23df07db1admr119664735ad.2.1752348256651;
        Sat, 12 Jul 2025 12:24:16 -0700 (PDT)
Received: from localhost.localdomain ([147.182.204.210])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23de4332b0csm66013645ad.149.2025.07.12.12.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 12:24:16 -0700 (PDT)
From: Gatlin Newhouse <gatlin.newhouse@gmail.com>
To: linux-hardening@vger.kernel.org
Cc: Gatlin Newhouse <gatlin.newhouse@gmail.com>
Subject: [RFC v1 05/17] uaccess: add non-caching copy_from_user functions
Date: Sat, 12 Jul 2025 19:21:50 +0000
Message-Id: <20250712192202.707192-6-gatlin.newhouse@gmail.com>
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
 include/linux/uaccess.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 7c06f4795670..d6d80bb9e0fa 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -186,6 +186,26 @@ _inline_copy_from_user(void *to, const void __user *from, unsigned long n)
 extern __must_check unsigned long
 _copy_from_user(void *, const void __user *, unsigned long);
 
+#ifdef CONFIG_SAFEFETCH
+static inline __must_check unsigned long
+_copy_from_user_no_dfcache(void *to, const void __user *from, unsigned long n)
+{
+	unsigned long res = n;
+
+	might_fault();
+	if (!should_fail_usercopy() && likely(access_ok(from, n))) {
+		instrument_copy_from_user_before(to, from, n);
+		res = raw_copy_from_user_no_dfcache(to, from, n);
+		instrument_copy_from_user_after(to, from, n, res);
+	}
+	if (unlikely(res))
+		memset(to + (n - res), 0, res);
+	return res;
+}
+extern __must_check unsigned long
+_copy_from_user_no_dfcache(void *, const void __user *, unsigned long);
+#endif
+
 static inline __must_check unsigned long
 _inline_copy_to_user(void __user *to, const void *from, unsigned long n)
 {
@@ -213,6 +233,16 @@ copy_from_user(void *to, const void __user *from, unsigned long n)
 #endif
 }
 
+#ifdef CONFIG_SAFEFETCH
+static __always_inline unsigned long __must_check
+copy_from_user_no_dfcache(void *to, const void __user *from, unsigned long n)
+{
+	if (likely(check_copy_size(to, n, false)))
+		n = _copy_from_user_no_dfcache(to, from, n);
+	return n;
+}
+#endif
+
 static __always_inline unsigned long __must_check
 copy_to_user(void __user *to, const void *from, unsigned long n)
 {
-- 
2.25.1

