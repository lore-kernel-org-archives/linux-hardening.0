Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768831B5ED8;
	Mon,  9 Sep 2024 11:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725882779; cv=none; b=TlTn1aOkFtLaJgwGyyZbex1tM0KAUHOZ6UNioJmOznoeIuw/HvCQP3oMy60XgOJ/CEOlSCdIl3JjffP7ualZYMmo+Q7vKp0+JCybMvsjqq3df6iVe0SP+wIluAnfLaYzVGBpSwzUqb2VmfRIHPCfNJCat1bXkFKHFl5Weqvglo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725882779; c=relaxed/simple;
	bh=iKO5cKYG5fdS5jT5sp0CsoK2vaOm6IX/jwHsmDYwqTY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kAxVDtRrafrcSYnxCb5j5anRcqmCsNXwdJYvkM4XBg4c8w6ETP7aqv/kzlt8ynOQ/KkohFmUSDHMJGRqdDOj2EstCKoegy/4V5dDK0ax2+O8jebFOlfVlcZgAkGnwXLWU8Pn3Z8TK4jVEdIj6z5MqT+PzRQp6PfAkttzPYQT5V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOcHa7kT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOcHa7kT"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-206aee40676so34587475ad.0;
        Mon, 09 Sep 2024 04:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725882777; x=1726487577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=a1hlGxq4Sy4VLXBTxJjiZfV2OnOm9z9n70bsEsEtYNQ=;
        b=XOcHa7kTwBZi5L2PW6mpMVpzxdMjEjeFycGIVBxn/+N/VnnBpe2kOgNHyN4337mt3k
         b5pvwPFUy93aHkLCViOxYN4OXEyq/F8RfmqZqbmRNQUgInHy8P0cJ/QRctEeaaFhKM+K
         Cd+KIRXp06ZZRB+bL7fISdC04glmClSAjKuSZzWhTjTvgAIEgJQiU20tsaHZzHLtzM1R
         htBq4jdQLcK0rCBXzWA80JCqzJSClKbn1DOQRuk9sYo6Hv8F2VMz7QKMtPEAGi+yigG5
         8oHB0m/BFsh4vqSsbNlk6HegsUA0TaH9JO3da43ZfPELItFZiZ9DsKwC5q+sQeANi8fo
         W6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725882777; x=1726487577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1hlGxq4Sy4VLXBTxJjiZfV2OnOm9z9n70bsEsEtYNQ=;
        b=c+2IFM+54UtimemCg0GFJ6UYizqhGWA7mneWYghKqr8SEriiw3zViL7yCWsvLWnDBy
         F5UUWQUMf7UnJtc6rvPJ8WfCuFeT3PUCJagiIOZTpu/UeCDPp07Y6L4bm2PF7mou+2j1
         obnqMjlX9UIBQqF64x/ENNPKREHtA7bbveQu0HKM2KuQviwQ+Kd6F9JsZc2uD3YFUzkh
         k0I/lQ4Hpt4YntZEyIPEqlEUkUGzxS55BruYV9BynWvO9ppQFXowzRnebRpsMgJ1uM76
         ctiCuVtPRIHzwJyH1Lz/z5HpgCjVkQgxF4DwlfxbXU1NwOZg8dr/zRvs1E5v8t/8lY6Z
         M82g==
X-Forwarded-Encrypted: i=1; AJvYcCW4kiRDOedDCjs8SQz6pCYNPOHMBkDtRuGS1N2DhhO2dRmco8NgRNVicgAv5YQ5cpJMAI3BmEw0TeQ7dUA31i8=@vger.kernel.org, AJvYcCWIIJVLIU/RC+Uu9rOlc0YYtWfSfQ5OsOK5NBKVzFwGsmmempYcuGoTEdVa7pMzwJAEpBcY+a+kjjunUDZl@vger.kernel.org
X-Gm-Message-State: AOJu0YzihYjDhsBziv5JhB6wxflI+kMd7YQ4XGy/K+Si4JTO796ajp+A
	gD8Csm9Jl5uEVcAzHaW9HLtWDO6/I2rrqxZCTb9qdJYwSIFbBaTJud8h7g==
X-Google-Smtp-Source: AGHT+IHyaJtMU8urJ3KQKLy2J0YEpSN0bzKeYyeQ8BNexR1HFkD12B6L6isHyR/D1/89L6tw1Ijgzg==
X-Received: by 2002:a17:903:18f:b0:202:cbf:2d6f with SMTP id d9443c01a7336-2070701f045mr63675245ad.57.1725882776591;
        Mon, 09 Sep 2024 04:52:56 -0700 (PDT)
Received: from XH22050090-L.ad.ts.tri-ad.global ([103.175.111.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f3552bsm32596505ad.289.2024.09.09.04.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 04:52:55 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: Kees Cook <kees@kernel.org>
Cc: "Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH] overflow: optimize struct_size() calculation
Date: Mon,  9 Sep 2024 20:52:21 +0900
Message-Id: <20240909115221.1298010-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If the offsetof() of a given flexible array member (fam) is smaller
than the sizeof() of the containing struct, then the struct_size()
macro reports a size which is too big.

This occurs when the two conditions below are met:

  - there are padding bytes after the penultimate member (the member
    preceding the fam)
  - the alignment of the fam is less than the penultimate member's
    alignment

In that case, the fam overlaps with the padding bytes of the
penultimate member. This behaviour is not captured in the current
struct_size() macro, potentially resulting in an overestimated size.

Below example illustrates the issue:

  struct s {
  	u64 foo;
  	u32 count;
  	u8 fam[] __counted_by(count);
  };

Assuming a 64 bits architecture:

  - there are 4 bytes of padding after s.count (the penultimate
    member)
  - sizeof(struct s) is 16 bytes
  - the offset of s.fam is 12 bytes
  - the alignment of s.fam is 1 byte

The sizes are as below:

   s.count	current struct_size()	actual size
  -----------------------------------------------------------------------
   0		16			16
   1		17			16
   2		18			16
   3		19			16
   4		20			16
   5		21			17
   .		.			.
   .		.			.
   .		.			.
   n		sizeof(struct s) + n	max(sizeof(struct s),
					    offsetof(struct s, fam) + n)

Change struct_size() from this pseudo code logic:

  sizeof(struct s) + sizeof(*s.fam) * s.count

to that pseudo code logic:

  max(sizeof(struct s), offsetof(struct s, fam) + sizeof(*s.fam) * s.count)

Here, the lowercase max*() macros can cause struct_size() to return a
non constant integer expression which would break the DEFINE_FLEX()
macro by making it declare a variable length array. Because of that,
use the unsafe MAX() macro only if the expression is constant and use
the safer max_t() otherwise.

Reference: ISO/IEC 9899:2018 §6.7.2.1 "Structure and union specifiers" ¶18

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---

I also tried to think of whether the current struct_size() macro could
be a security issue.

The only example I can think of is if someone manually allocates the
exact size but then use the current struct_size() macro.

For example (reusing the struct s from above):

  u32 count = 5;
  struct s *s = kalloc(offsetof(typeof(*s), fam) + count);
  s->count = count;
  memset(s, 0, struct_size(s, fam, count)); /* 4 bytes buffer overflow */

If we have concerns that above pattern may actually exist, then this
patch should also go to stable. I personally think that the above is a
bit convoluted and, as such, I only suggest this patch to go to next.
---
 include/linux/overflow.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 0c7e3dcfe867..1384887f3684 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -5,6 +5,7 @@
 #include <linux/compiler.h>
 #include <linux/limits.h>
 #include <linux/const.h>
+#include <linux/minmax.h>
 
 /*
  * We need to compute the minimum and maximum values representable in a given
@@ -369,8 +370,12 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
  */
 #define struct_size(p, member, count)					\
 	__builtin_choose_expr(__is_constexpr(count),			\
-		sizeof(*(p)) + flex_array_size(p, member, count),	\
-		size_add(sizeof(*(p)), flex_array_size(p, member, count)))
+		MAX(sizeof(*(p)),					\
+		    offsetof(typeof(*(p)), member) +			\
+			flex_array_size(p, member, count)),		\
+		max_t(size_t, sizeof(*(p)),				\
+		      size_add(offsetof(typeof(*(p)), member),		\
+			       flex_array_size(p, member, count))))
 
 /**
  * struct_size_t() - Calculate size of structure with trailing flexible array
-- 
2.25.1

