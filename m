Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3405328B62
	for <linux-hardening@vger.kernel.org>; Thu, 27 Nov 2025 09:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764235381; cv=none; b=C0gT8MB/+KLe/XkuaclK8KwHEa2yZC9XP9kjoZaJ/GOLDOVqazn4JGrzBLZnmWU5+rh8C7NORGY1f3BFUqp9/zVBN8qDjhUjOcI3iltdKtJYKUUiQpL05aRE9++HtcW+O3V7Ft5DkH2b4VB1PnJ+6wmql0sx6tIzob3Czs08RTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764235381; c=relaxed/simple;
	bh=F2UdfCjShiQuHh3oQQRYHB4xtYfaoIt5uvb/4ByzDno=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k8b01QOijwI/DmRWr14yKIK2k4NuiJrki4abZUZ3ecu5mg4zx4omv5NNlvYz06+9Wg0YStG/NMjC4eI89gHUVYrtt2KdWBRElg3AjFm2CwEOUq82TW3MkyvXovyQ9B3QwRbJeEx5IaFeeNChHXyHhFPDRZ/ZrJj1rah/+O5Iec4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pZJ1u51H; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pZJ1u51H"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-429c7b0ae36so445347f8f.0
        for <linux-hardening@vger.kernel.org>; Thu, 27 Nov 2025 01:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764235377; x=1764840177; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wzVFhaCJ4tPvEzjzVh2/FLJsOENJe5tM82eV69ICp3w=;
        b=pZJ1u51HYn6Z3mdEJPllCXyHTdraMpcNmsUTdxW5UpdYzALZw1y2IIvsfLONEd4/By
         uDl87otuD/09t6oCtKMHYvurg7XLzJ31NICBwmXCrpf/x7LKBeRtVy9bcVLr2yEIZc+Y
         ac50xRUpzj7piw3ipk/PQGLtsX+e6yuWaNTfFBnOvwPJM5h5b9FKdoj4dYZzujx5zje6
         kV1WvglHSomVB+9liVn+3R1l3HPJRbt2/8qDO9lw49o5RFnFllLPfC+B5U4znHNJ00LH
         it1a6FJAilaNT6OEkVo4wJnbX031MEbascrDIbPoH3AZDHqXCXfh4R7MLcn/k9TE5nyL
         eWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764235377; x=1764840177;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wzVFhaCJ4tPvEzjzVh2/FLJsOENJe5tM82eV69ICp3w=;
        b=EOvmJ4PP4HxQ9gqis9ttiRRuqLU4kfKLGGVr8yxmcdfhhNtzif1pANghvTPaXoMpch
         QBI+pSyxfj0daIQw6nYwR+m2Cg4oE5w8odkuuHPS2yc5ySJnC7ZnqpEGiygP7cIoelP4
         4Dtu4ovq7aQKl/mdRIDChiYxrJ1vzzZvZhr1peaIzco/aYLWXzqgFz3mOt5Jg1wXXKNO
         QVOtCKxI9OXS4AOUCMHOXaaGX4M+zuTY1Xdg7ikoiI5Vp1WXiPBm/KzKR18TRO7/d3Ve
         jNN3qKGJJRgPCqTn5X/mYuXOMYL1iDoa/AX2+aGIaTR1rCGsz14bsva2B+uTkXM//xxu
         m58w==
X-Gm-Message-State: AOJu0YxdX3GIO0IlySNozUDG083A93vLDvt377twp796bGbNmlbywt5F
	6kL4z9nO/XcPh+VTTVJkUE3Hw5fsR/ZXS8BXVeQqQQ3mBHlAmPzFf7wytgZxZqPteplKRfcn8zz
	V35iGM0N+RXXABLOYBSzrdoGwP7RBedfVSUrDqMwlRQNU82vKj+zjmPH0aw0TL45n/H4rlj+jBr
	Uj46n3k8UBWbVOVbRsK4+b868f8LCUe1/xhcxHvA==
X-Google-Smtp-Source: AGHT+IGd+iJrVyefWu9xcpdYdKEXoxro/lG9n2ewRU/WJbCL+3bUle2bLSXZHjm1+EN52LuTQiG20BfQ
X-Received: from wrqr7.prod.google.com ([2002:a5d:4987:0:b0:42b:b28a:6746])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:4010:b0:42b:3dbe:3a37
 with SMTP id ffacd0b85a97d-42cc1302285mr26345067f8f.10.1764235376919; Thu, 27
 Nov 2025 01:22:56 -0800 (PST)
Date: Thu, 27 Nov 2025 10:22:31 +0100
In-Reply-To: <20251127092226.1439196-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251127092226.1439196-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4605; i=ardb@kernel.org;
 h=from:subject; bh=2kdRtRT+6jrXGVJpTsN6JRllZWlsEfiMzJMbIKIwLig=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIVNDItKrV2/nxk2T1FL2Pt6aq6pVO+2PRuinE8KPNTo6a
 3nj3j3uKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABPp8mFkuDohVFskVsdiR1zu
 wmdCi5KUPl1VU7Fe/dFZccnmV/sc3jEynJLJaUjTW3hYn2F3RubPpNRt29cIn9B6cfPQJ+dKTzk BPgA=
X-Mailer: git-send-email 2.52.0.107.ga0afd4fd5b-goog
Message-ID: <20251127092226.1439196-12-ardb+git@google.com>
Subject: [RFC/RFT PATCH 4/6] random: Use a lockless fast path for get_random_uXX()
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-hardening@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Kees Cook <kees@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Jeremy Linton <jeremy.linton@arm.com>, 
	Catalin Marinas <Catalin.Marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Currently, the implementations of the get_random_uXX() API protect their
critical section with a local lock and disabling interrupts, to ensure
that the code does not race with itself when called from interrupt
context.

Given that the fast path does nothing more than read a single uXX
quantity from a linear buffer and bump the position pointer, poking the
hardware registers to disable and re-enable interrupts is
disproportionately costly, and best avoided.

There are two conditions under which the batched entropy buffer is
replenished, which is what forms the critical section:
- the buffer is exhausted
- the base_crng generation counter has incremented.

By combining the position and generation counters into a single u64, we
can use compare and exchange to implement the fast path without taking
the local lock or disabling interrupts. By constructing the expected and
next values carefully, the compare and exchange will only succeed if
- we did not race with ourselves, i.e., the compare and exchange
  increments the position counter by exactly 1;
- the buffer is not exhausted
- the generation counter equals the base_crng generation counter.

Only if the compare and exchange fails is the original slow path taken,
and only in that case do we take the local lock. This results in a
considerable speedup (3-5x) when benchmarking get_random_u8() in a tight
loop.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/char/random.c | 44 ++++++++++++++------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 0e04bc60d034..71bd74871540 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -496,6 +496,12 @@ static ssize_t get_random_bytes_user(struct iov_iter *iter)
  * should be called and return 0 at least once at any point prior.
  */
 
+#ifdef __LITTLE_ENDIAN
+#define LOHI(lo, hi)	lo, hi
+#else
+#define LOHI(lo, hi)	hi, lo
+#endif
+
 #define DEFINE_BATCHED_ENTROPY(type)						\
 struct batch_ ##type {								\
 	/*									\
@@ -507,8 +513,12 @@ struct batch_ ##type {								\
 	 */									\
 	type entropy[CHACHA_BLOCK_SIZE * 3 / (2 * sizeof(type))];		\
 	local_lock_t lock;							\
-	unsigned int generation;						\
-	unsigned int position;							\
+	union {									\
+		struct {							\
+			unsigned int LOHI(position, generation);		\
+		};								\
+		u64 posgen;							\
+	};									\
 };										\
 										\
 static DEFINE_PER_CPU(struct batch_ ##type, batched_entropy_ ##type) = {	\
@@ -522,6 +532,7 @@ type get_random_ ##type(void)							\
 	unsigned long flags;							\
 	struct batch_ ##type *batch;						\
 	unsigned int next_gen;							\
+	u64 next;								\
 										\
 	warn_unseeded_randomness();						\
 										\
@@ -530,21 +541,28 @@ type get_random_ ##type(void)							\
 		return ret;							\
 	}									\
 										\
-	local_lock_irqsave(&batched_entropy_ ##type.lock, flags);		\
-	batch = raw_cpu_ptr(&batched_entropy_##type);				\
+	batch = &get_cpu_var(batched_entropy_##type);				\
 										\
 	next_gen = (unsigned int)READ_ONCE(base_crng.generation);		\
-	if (batch->position >= ARRAY_SIZE(batch->entropy) ||			\
-	    next_gen != batch->generation) {					\
-		_get_random_bytes(batch->entropy, sizeof(batch->entropy));	\
-		batch->position = 0;						\
-		batch->generation = next_gen;					\
+	next = (u64)next_gen << 32;						\
+	if (likely(batch->position < ARRAY_SIZE(batch->entropy))) {		\
+		next |=	batch->position + 1; /* next-1 is bogus otherwise */	\
+		ret = batch->entropy[batch->position];				\
+	}									\
+	if (cmpxchg64_local(&batch->posgen, next, next - 1) != next - 1) {	\
+		local_lock_irqsave(&batched_entropy_ ##type.lock, flags);	\
+		if (batch->position >= ARRAY_SIZE(batch->entropy) ||		\
+		    next_gen != batch->generation) {				\
+			_get_random_bytes(batch->entropy, sizeof(batch->entropy));\
+			batch->position = 0;					\
+			batch->generation = next_gen;				\
+		}								\
+		ret = batch->entropy[batch->position++];			\
+		local_unlock_irqrestore(&batched_entropy_ ##type.lock, flags);	\
 	}									\
 										\
-	ret = batch->entropy[batch->position];					\
-	batch->entropy[batch->position] = 0;					\
-	++batch->position;							\
-	local_unlock_irqrestore(&batched_entropy_ ##type.lock, flags);		\
+	batch->entropy[batch->position - 1] = 0;				\
+	put_cpu_var(batched_entropy_##type);					\
 	return ret;								\
 }										\
 EXPORT_SYMBOL(get_random_ ##type);
-- 
2.52.0.107.ga0afd4fd5b-goog

