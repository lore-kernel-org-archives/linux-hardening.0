Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F6232936E
	for <linux-hardening@vger.kernel.org>; Thu, 27 Nov 2025 09:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764235380; cv=none; b=VEChbmRAV/0ydXLhZOEdshBXFhdiORkwwfsmt9fJzxQimO8ntFfyuc4tJ5pOl+0v5F5sz5zTN4jWhia2B8kWpRqvoG+fvqMFctYARMd8IxTJKd9aB6zbKd00WXt6f6du6LzsDe2YWUm1q7EAJl1mgs3QW5dxXY4xwhK4PILntfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764235380; c=relaxed/simple;
	bh=ICrszCMtJ1LPXNd7C0Ih5tX9jm2ajTy+fULG6068eLw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZY/Fel9nJNqCPvgGSlbSYr8zNZvBOZvAreFaFFpykVYSf1aATaIJWXZ5vyPgsyh4jGAeiylXUDCnQuOhfRpGiRgyO3bRNxg6O++kwnu/rje6JZxZNJT4jrOI2TtM3UrWm5994ptV4UA58gM4Qd5QyV2b086ExCwBkNg51eecIaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s2ejCHsB; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s2ejCHsB"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47775585257so3819545e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 27 Nov 2025 01:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764235376; x=1764840176; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G8PUYE65+35CiVgD1jp+ggIop/9/H10ihf2g4jePZBk=;
        b=s2ejCHsBoK0nHEX0MpvjncNiNr7/MoflMgFd+uukCn9mClhqfERv5hqpbY85yejr0m
         3z2by1Sp+1ng3A3mDm4HWKqtsG87lE002JTUCNbsQq7ESvuLspsAY1twreWya4ENid6R
         r1HXcPQ8r9sjI0MOQrq9FXEoEme68dn8cpjjkPgP2Au4Xg+tLtRvZkwMDjQ03gwNh0+m
         qHgms78BcXA7Ixopb3EpeLjEqddnhZxha7hLp2yrauONE9kFh/obOTxbZfQkDd+pB4oo
         aM9my8px53pKdv+3u1Kqa76OBpPkxSSUGjJY9BCinXc9loS+oM46/N2ys3Pfmxoa93GT
         xkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764235376; x=1764840176;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G8PUYE65+35CiVgD1jp+ggIop/9/H10ihf2g4jePZBk=;
        b=nA7vrklZI6CCW0ttjxa9lrOgk6HFIlShifRQWzr8WJLQCqGZOGxyt6jcuw9Cg5kcF3
         B9J3Md5q0nyt6ybPqxflob1ML1JQHXJqUrgrAB5fCrlXhQ3DndxJXHIi4RbMpt6d8z+1
         5JP0X1MuafIK6iqibaViZQ5LJjMu2vuLLMEMJx+XLsbmz0Ni6453JlaEXd7HRslXlog5
         cTeVG+p8exnGVV1PZpDT+Ey2Xb70hTaHlqP49dEivwwWsIQvAK3EhMhm8P4k6t0aitcz
         fZ6AXN9quQMIwd+tkdmZxKSoyHeDO09YkTNKYz3VNmYA+SpZQo0guJ2MR5gxCTRvelGe
         dBmg==
X-Gm-Message-State: AOJu0Yz0tNWZdAzC7FXXKNvuM0MnMW+rh20fyn901v6c9cd/Yh9+xZ0b
	/37gvwP+koigTh9++gi3RrjiIe5XKvhETa3rv/zBFZt8NwYayOMOT+SArLxMUuRCy4V+rTYDh/L
	r63S6stt5Kg1Np3E7nr7pDj2CBPzP9dFyNfIvkMECPw4jZgQTVj4hiPPCD2TBk2wxcba6cbVD/z
	j7ExI09xzyQgYoPOdVMSQjbgdGqckdH1wxURmRGQ==
X-Google-Smtp-Source: AGHT+IHGmStaBw0kw+zywe3YOqYeTN7JkzcsA1+VS2rjrhQpPUmECbRNT13sfo28k0MCm5UyvTanyD0N
X-Received: from wmbh15.prod.google.com ([2002:a05:600c:a10f:b0:477:988a:7675])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1382:b0:477:a977:b8a7
 with SMTP id 5b1f17b1804b1-477c1117956mr205200185e9.19.1764235376129; Thu, 27
 Nov 2025 01:22:56 -0800 (PST)
Date: Thu, 27 Nov 2025 10:22:30 +0100
In-Reply-To: <20251127092226.1439196-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251127092226.1439196-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1946; i=ardb@kernel.org;
 h=from:subject; bh=39kBqCzlZF8SLfFJgWsjj400jCEDRYRkq2STbPbbenE=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIVNDIqI3ZHbml073v/KHdtpnHfpRm/Py3LMdqh9Sljd+f
 rhn84cNHaUsDGJcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAi7oYM/0M7zlcnzJvAe846
 80bGvn+b3uxjbs5YvCouYfXjnXIBr/4yMixpPnD96cT+y7kXZlzTaJTelrqtrYVD1/PozHcXtNf yb2UEAA==
X-Mailer: git-send-email 2.52.0.107.ga0afd4fd5b-goog
Message-ID: <20251127092226.1439196-11-ardb+git@google.com>
Subject: [RFC/RFT PATCH 3/6] random: Use u32 to keep track of batched entropy generation
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-hardening@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Kees Cook <kees@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Jeremy Linton <jeremy.linton@arm.com>, 
	Catalin Marinas <Catalin.Marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The batched entropy containers each have a generation field, to keep
track of the base_crng generation from which it was last reseeded.

This use case does not require all bits of the unsigned long to be
stored: storing only 32 bits is sufficient to determine whether or not
we're at most 4 billion generations behind, which seems ample.

So use an unsigned int instead: this will allow a future patch to treat
the generation and position as a single 64-bit quantity, which can be
used locklessly in a compare-and-exchange() operation.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/char/random.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index b8b24b6ed3fe..0e04bc60d034 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -507,7 +507,7 @@ struct batch_ ##type {								\
 	 */									\
 	type entropy[CHACHA_BLOCK_SIZE * 3 / (2 * sizeof(type))];		\
 	local_lock_t lock;							\
-	unsigned long generation;						\
+	unsigned int generation;						\
 	unsigned int position;							\
 };										\
 										\
@@ -521,7 +521,7 @@ type get_random_ ##type(void)							\
 	type ret;								\
 	unsigned long flags;							\
 	struct batch_ ##type *batch;						\
-	unsigned long next_gen;							\
+	unsigned int next_gen;							\
 										\
 	warn_unseeded_randomness();						\
 										\
@@ -533,7 +533,7 @@ type get_random_ ##type(void)							\
 	local_lock_irqsave(&batched_entropy_ ##type.lock, flags);		\
 	batch = raw_cpu_ptr(&batched_entropy_##type);				\
 										\
-	next_gen = READ_ONCE(base_crng.generation);				\
+	next_gen = (unsigned int)READ_ONCE(base_crng.generation);		\
 	if (batch->position >= ARRAY_SIZE(batch->entropy) ||			\
 	    next_gen != batch->generation) {					\
 		_get_random_bytes(batch->entropy, sizeof(batch->entropy));	\
-- 
2.52.0.107.ga0afd4fd5b-goog

