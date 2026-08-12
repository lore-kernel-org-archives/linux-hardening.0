Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FE633065D
	for <linux-hardening@vger.kernel.org>; Wed, 12 Aug 2026 18:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786561013; cv=none; b=A01jxOfujQO9OeovqfTAa0+dzz4pPXISauOL30NnPb2TEQvgLwMuAYh8OClQa5ALunkqz61TcpM13T+pnPJ2q2fSqsZgkdksVqHFoWE+l2rVVT/189K89QHgDQNJp/UYSlr4xvsMNiUqVNTtBBG8vnjgjE3TPhLROIXnlWcDToY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786561013; c=relaxed/simple;
	bh=+QMVCJH8bPTvUWHRCiToVyn/WTsMTx9D1b2BJjMhFK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hbQTNmQf69blIhY8VIUOwzG/yxTtj+fpyY8D8ISvtmbCRmRCLAE3n6OFprrnaS2NvXCow6rnMfFWRlP0Q6PTO9t50nVAc49CztxQDeFviS41wPRoQCXrc5ByW7XL84LcpEwIXBdHafTgwfFJeE3MPPpnQogV+tcUZ2Mv2W/RISY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MUipLnh0; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MUipLnh0"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-495509b08ebso7095e9.1
        for <linux-hardening@vger.kernel.org>; Wed, 12 Aug 2026 11:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786561009; x=1787165809; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YdYpVqzTOdd84iiXSjf42t3ppGRhGp792G0ZvvGlpuc=;
        b=MUipLnh0wfTomH59kj+gD84RrLYFintHRiu18MO/TLYkieOIBU3TSwolh7RFkfXvsj
         FJKwQXrRFUeBYPkeUXX+qGmZ4iT5I5dqAmwcZhifmpXsCWhYcnTRYTrG79YbFOoOePgS
         O22xqZ0lG6RcvDBmRHbOiVZVOMt+XFCSLJoLf1i7DwnxKd0u/z1JHEZsRYGgzG5NpTxu
         WQWfmZVL7bQ7t6HTn3ZQME2khmeI2YYSIBgWGi2hmXSEPBnaj8+yPdwn8eQr893z5Jjy
         lAFgPKw4t/NOAHU/B5Gv1247UykRrf9pVRuAxNPeRX23BoVobsJRH9E07YoEVsENMHz6
         Cmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786561009; x=1787165809;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YdYpVqzTOdd84iiXSjf42t3ppGRhGp792G0ZvvGlpuc=;
        b=pvtMNOmPdUsEdTmucMX0UbVABPoyUqUisN5fmlegfcnpUvhY8xomM5FsG1o1j/I2qy
         czxj7LZzZye1wJem5e4oddQpWM+bhhJFEPN04bClzYoStF8Tjxsua1U00fCReLAYHd1t
         4JdGcKMF8Ts/Hbw1370seHKXEtAmsD8YpO4iSVxqf0/x+GVMuJRDLEyy3YOSjBqtb5Iq
         QELiHqy0Hrj0OhVuzTqmpf527MwEelIWRfySgfm7IrtOEcN71ntuPBqGWxhyWRxG/izg
         wQAZmEPpnaF0qmjtX4uhpfqnFyxRlr59IuuSI2h0q6tCNH0jdNi0DfrHK/KDaFlCyalo
         GxYg==
X-Forwarded-Encrypted: i=1; AHgh+Rq9QJiDHwuXsKzQ10eiKZpv5qw4ce1oJEsHNioopXxEzfuRDdwEkIBQ2XTzZTonZ+3z+rucsrCnVldfrFOXGww=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqKrCs0/pffGmPsW1T0nGM7O3WBxvRXdg8+CUYdnlCXPMnuDbl
	ewnBRF2rp+66jeJk/Bfo1xJp/c9F2ftzlkESwcaUZ7SnHK+fCGo6hPd/cfO5usXRSQ==
X-Gm-Gg: AR+sD127ho71Rlycz21Z0AUPFxLLOJjPgIEZgjpYkcU2ynT7R2PKdrlfyrcBzY5EfcY
	HIG4MWPNQV82MObdO/GEA9p8AbKLH7A0fWLn/MQpvzyGZxaoD4zBS9hGMiBNfY9pI82Io+NjNn2
	a8gCwynSHo6M7RRojN4JzgtxT3PVqmOoTeUQ0zVwUQEw8Lu69b8+NJS4dO+axuTr38vZ/qxc5/K
	y6m3hI7TChFkIosEXVYd4BM9pGGYlkVWThRlxp0Tp1R+gMDM5omnvE+CUattYaxyJeDwH6zZzT9
	0VjrUXoK8arCzjpKxqiAVi7rGzg/c2N9AHVsJXmLKmh5T4fWr1lH5By/niA3dRqwVg5DR/TXW4p
	D8snu5A+KSxICPxguf19Uu2NSliUl1yO22lqOvwbr+EjUJ8RlTOFbsvDnUAUXioc6BgoskEq2J7
	kCPM02ghVHhTKy13PcPrhHBfPqIqIq7W+LscfD3EuTC5z6qwdlCR4I0YMtvRhH3OO8VowFTdSt9
	l4Cpwf4PsbbfQGW7qjYjWi6S/gDee2Nz2/SlLLIW4/2cYF/
X-Received: by 2002:a05:600c:4ba4:b0:493:aca0:32e2 with SMTP id 5b1f17b1804b1-49981f3f17emr38325e9.4.1786561008456;
        Wed, 12 Aug 2026 11:56:48 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:d358:790c:76c6:1a58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981de6a05sm9612245e9.1.2026.08.12.11.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 11:56:47 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Wed, 12 Aug 2026 20:56:38 +0200
Subject: [PATCH] refcount: Use CONFIG_BUG_ON_DATA_CORRUPTION for
 UAF-related errors
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-refcount-bug-on-data-corruption-v1-1-c6da63566101@google.com>
X-B4-Tracking: v=1; b=H4sIAOXBfGoC/yWNQQqDMBAAvyJ7dsEEGqVfKR5i3Nj1kMgmKQXx7
 922xznMzAmFhKnAvTtB6MWFc1IwfQfh6dNGyKsy2MG6YTIWhWLILVVc2oY54eqrx5BF2lHVxWj
 8zbk4joYcaOVQgd+/w2P+c2nLTqF+s3BdH3D4hNWDAAAA
X-Change-ID: 20260812-refcount-bug-on-data-corruption-f1a566f771e6
To: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Boqun Feng <boqun@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Gary Guo <gary@garyguo.net>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Ard Biesheuvel <ardb@kernel.org>, linux-hardening@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786561003; l=2463;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=+QMVCJH8bPTvUWHRCiToVyn/WTsMTx9D1b2BJjMhFK8=;
 b=iJV5hd7r1t+k8hnMWN5j15OtM/uxBt4WCoQLise8nLniVoJvgF+PDSfvYUnNXx2DW3jA/6UcY
 n9PDsyxQVXQAn1K4A17j0HVtiNBGYbuSQWPFQGXoMW4gXLqV/6XS+d4
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Some refcount issues are not necessarily associated with memory corruption,
but REFCOUNT_ADD_UAF suggests that a UAF either just happened or is about
to happen.

REFCOUNT_SUB_UAF is also an indicator that reference counting is wrong, and
suggests (less strongly) that a UAF access might have happened recently.

In these cases, BUG() is appropriate if CONFIG_BUG_ON_DATA_CORRUPTION is
set.

Signed-off-by: Jann Horn <jannh@google.com>
---
MAINTAINERS specifies no specific maintainer for lib/refcount.c, but it
does have an entry for include/linux/refcount.h, so I guess I should
route this patch based on that.

I decided to send this patch after wondering how exploitable it would be
to have a refcount_inc() call on an object which has reached refcount 0,
but is not yet freed because of something like an RCU grace period.
---
 lib/refcount.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/lib/refcount.c b/lib/refcount.c
index a207a8f22b3c..c0f0dc5296eb 100644
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -10,6 +10,15 @@
 
 #define REFCOUNT_WARN(str)	WARN_ONCE(1, "refcount_t: " str ".\n")
 
+#ifdef CONFIG_BUG_ON_DATA_CORRUPTION
+#define REFCOUNT_CORRUPTION(str) ({		\
+	pr_err("refcount_t: " str ".\n");	\
+	BUG();					\
+})
+#else
+#define REFCOUNT_CORRUPTION(str) REFCOUNT_WARN(str)
+#endif
+
 void refcount_warn_saturate(refcount_t *r, enum refcount_saturation_type t)
 {
 	refcount_set(r, REFCOUNT_SATURATED);
@@ -22,10 +31,10 @@ void refcount_warn_saturate(refcount_t *r, enum refcount_saturation_type t)
 		REFCOUNT_WARN("saturated; leaking memory");
 		break;
 	case REFCOUNT_ADD_UAF:
-		REFCOUNT_WARN("addition on 0; use-after-free");
+		REFCOUNT_CORRUPTION("addition on 0; use-after-free");
 		break;
 	case REFCOUNT_SUB_UAF:
-		REFCOUNT_WARN("underflow; use-after-free");
+		REFCOUNT_CORRUPTION("underflow; use-after-free");
 		break;
 	case REFCOUNT_DEC_LEAK:
 		REFCOUNT_WARN("decrement hit 0; leaking memory");
@@ -84,7 +93,7 @@ bool refcount_dec_not_one(refcount_t *r)
 
 		new = val - 1;
 		if (new > val) {
-			WARN_ONCE(new > val, "refcount_t: underflow; use-after-free.\n");
+			REFCOUNT_CORRUPTION("underflow; use-after-free");
 			return true;
 		}
 

---
base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
change-id: 20260812-refcount-bug-on-data-corruption-f1a566f771e6

Best regards,
--  
Jann Horn <jannh@google.com>

