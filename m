Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B61148310
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 00:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969724; cv=none; b=IZu9lQDlE745GphfErq6DKdMgZNisBQp9eAuZvff4NhLaNQxRfSLOhpeYJb4aOud1OxMEl5mPf1C7vSWBXQ0OJYX7gC5Qyd5d+Mp/Ru3Zy7GQuxh49YhoO7jjM6QCgEpCYlfe3l7IFtr2v2EGnns+uybw6whb2h57HdZX0gT3as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969724; c=relaxed/simple;
	bh=NL4i6bTrYINnZ5CxcbHpw8YCfhRtLA5nCGl1fzFiRXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i4oSDDR6Jam1tmKFOLj1nmhdFlJD7R+DzNr78GkJXW6l//Wz8qMEoyseTUc5p5DeKqwLHlq3Q5v52wU/QpCohWL3Xmealq6h1TufjA4Essr2DO9WSJfOYgWLTbYEqupCiBxwKIExIiBdRuk/nMCpl736OoHk2gpWRD5nP78OU3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Y8S9QdP8; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y8S9QdP8"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d75c97ea6aso8722595ad.1
        for <linux-hardening@vger.kernel.org>; Mon, 22 Jan 2024 16:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705969723; x=1706574523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ba+SJRXi6zigp5yNKxV6w56BvmmlI5rW36eVy3OGs8=;
        b=Y8S9QdP8DgqPUnzAiLlxiMBNfBsuFwXYSulxpTZqqNXQYDD6DQR3yK8its2d1GJ/+X
         xMh0/0KydNdEQ/2cXW5f2AlpRKtRo9yHorGdqjCPXdhKXSxAg5XVocCYHE1gCqjZtagA
         U1g68YwzIDaFUDA+ZfLMq0UA2nS2XRaY4maIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969723; x=1706574523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ba+SJRXi6zigp5yNKxV6w56BvmmlI5rW36eVy3OGs8=;
        b=Ky8gABlOTcqwlQoOmqyXc2D6CRWogyHkLWXcynqZug6C8SyvrXtNsIYS/UT9Cfu+3z
         uVBtVqNCdMgrKZajqx9TSKsEr3sSlSmtBcuhIV/iB5vzgJI91zHEXE8uW8wtjkJUIe1N
         JiYBd/Fw0Cy/sLsRgscq89lX/cOIq5pPrviVD4f6abMoOyOIIcojbBlOUZmzH0Luv4mf
         mJLgNjrlA/JTgPixMIFmxOYcIp5vrVNHfUoUWO0n9EIKUX42U5a9NpLU5K9CzwAm6rxW
         Rb9SK79uStrxQdO6eui8venYd1H+bAJW2zS9l3iwRl/tV7Um8qWBpIRC0CJqHWVo87H7
         gMgA==
X-Gm-Message-State: AOJu0YxJf5u6QAg36br0pOq7LXdTcbbqzUW8vmXtvulnxL/VjLGdx2LA
	8+m8fAY9XXpzbCyAOZPmbaIMxBqtYlBHIkJiB/mFJ2iVj7xz8W7/vFGApdW0NQ==
X-Google-Smtp-Source: AGHT+IHQcrX5UyzgI3Bm4vvQyCphFgwNS1v5TuPH/cr2wDJrrcl4aZywV9TGXqEEG1hudUlUGDMIdA==
X-Received: by 2002:a17:902:eecd:b0:1d7:6c6:9fca with SMTP id h13-20020a170902eecd00b001d706c69fcamr6811474plb.30.1705969722956;
        Mon, 22 Jan 2024 16:28:42 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id mj6-20020a1709032b8600b001d7057c2fbasm7670974plb.100.2024.01.22.16.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:28:37 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/82] locking/atomic/x86: Silence intentional wrapping addition
Date: Mon, 22 Jan 2024 16:26:45 -0800
Message-Id: <20240123002814.1396804-10-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1192; i=keescook@chromium.org;
 h=from:subject; bh=NL4i6bTrYINnZ5CxcbHpw8YCfhRtLA5nCGl1fzFiRXM=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgEtlYLVvMON6u8nAd+7f45eDDaD4MUEJz3n
 57bKZbOnZ+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBAAKCRCJcvTf3G3A
 JlP6D/4u8pYwPHBrl199KKA3Xl2ZV9zqU8Mw8Os7Nd8y33hZwj6LsS01wPP6z6jSiddM3/hGchv
 rQHONauEIxmyByTRV5HT85mPCm/ncSaT719PWXFKVjyUXSkiKjO3QQdPfz2MfOyoEW7WIva6W2t
 Zd35j2E0rg0u2zkGqPAAHzmhK2/nD+c93RmUgoR2tEko0m3iEOnQFdzhw61Nm3YlbYUH3xKPbGQ
 jW0TXuROEnkxi/GOtXU82d5qC1xM2yk79p0LknCPi8iSgDQguTeMOg2LJLrKIdG6NfkeFYWfqFg
 yGPUiPtzOwyZnbHfUHNwOW3r+Ncg0xVW10JrHniCo5XDIzPoncXKJBzHri1+EaHKRvBTERunaZg
 05dn1owdZtkZAbaVP/ALiduc9RkerbYaQFv/xruC08jnijnw/6cGUzo48MfOi9J0TobE4ffCtAU
 udL/itLTV39/A+dHftTu0mT6oxKO8RfiMXPEhKG0eVjHoxp8HwETwJ4aqqKzbhlToIXkRhP7MP6
 Fytnvxr78dbMrfa3vQ0NPQHyZOl04u/dSGBORaKVBkA7mkn2kh54bggtXaWmvkPmnOiH4h0LbLi
 kfJw/tV2RV4idwY9ZVRu71pPQSZd7OqBz85j8Fy5dO7RGDrTsjRVDEnjwhtW8oxa70vIMYx6w66 f0o7nKMznSYPssA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Annotate atomic_add_return() to avoid signed overflow instrumentation.
It is expected to wrap around.

Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/atomic.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
index 55a55ec04350..4120cdd87da8 100644
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -80,7 +80,7 @@ static __always_inline bool arch_atomic_add_negative(int i, atomic_t *v)
 }
 #define arch_atomic_add_negative arch_atomic_add_negative
 
-static __always_inline int arch_atomic_add_return(int i, atomic_t *v)
+static __always_inline __signed_wrap int arch_atomic_add_return(int i, atomic_t *v)
 {
 	return i + xadd(&v->counter, i);
 }
-- 
2.34.1

