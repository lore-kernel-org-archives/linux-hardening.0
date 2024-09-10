Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED65114D431;
	Tue, 10 Sep 2024 02:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725936604; cv=none; b=ToPQXVqr7WWPCYzx+AxQ11Tby9wT+A8XhFEGCyArqr6IJwuGBru/xW01fC5g7o5FAevtIDdEecxnKw3fyj34SORptP3+fUGQgujVD1+m9Ttr4smL3wGscaGbOt/A6b08DeNSPnhrsRKQkjc432TYjHV6SCYhcZuldmkPWu2zrp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725936604; c=relaxed/simple;
	bh=yYS7drh5IFtRVXz5crISX4kQJ1RdBmbN7F0Na7fF3JM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nC7W18c0L2GhneQJxdrDUa+bEHwb4H++cJAUbn6ai4IdOlQ2ujkjkGyOkAkiV0oRHaR/jHJNyfv5nhOBXv/KyOTe2g76zhvaDZFYcxWq7yIH1AyE1ku5ucKsGgw7aHkXhg0+ggwAtX2ClOiVhDcpjhsQWpcRH0GwNpuo6vXJSj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9Yu4TIz; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9Yu4TIz"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-718d8d6af8fso3086196b3a.3;
        Mon, 09 Sep 2024 19:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725936601; x=1726541401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=fdUcKCk2ZxjBk417GmsddeyQ7LIi7ijN2tAsbtpM67Y=;
        b=Y9Yu4TIznf4D3I+/ZIX2yfX5JHKJXHP0ZM0SOeXd0xMHeJpegSs8CqENcf2asheUg/
         YYq8/muBCkLgSFhf3gOLhn+IK3PlQbjdlevshUxJmlZ5iagQcMTXp14qVkZ7I4HJspXh
         S3DBXQIDsm4nvZiKU92RpHzmsNsyYNOANPOOqnzDvZddLyf+OYtpAsPSP+MBgoujW6H5
         zQKx7/wQfA1OUIy1zB648BtonPLOT0chOZHnei1UM2N/v6nyf68Lj+vtQ9+0PixCu7oY
         wxgM+AXMYOEl/40Y7p5MNZwl1JvrkIaGzZW2xr7j7TM1zZkDvFHkXbIqT1iZ3j0Wraop
         xaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725936601; x=1726541401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdUcKCk2ZxjBk417GmsddeyQ7LIi7ijN2tAsbtpM67Y=;
        b=Q2hbMcggTxZ8gSAHK8Wd6KEfgBOFdPFCEwh5id5au6K8ZGycyzOkT1BPrPVjZ+OPMt
         PXybeL6RdRc/bIAt1yka595n2alflM7Jrqxgk8pBqto5EaKuGS9pdH5vitOYqrKJyVmJ
         LbF/nICzH2eIsLwv9p23rSk87uNLadROYHusF/Wgnefrik8G1jPoAyF0rmjkIe5fKLaC
         /3uPX6eJEY2AGpgT11vScFqiSMHljLdfcxtmrbjQ78SaT+WY/1Fp8Uh1qC5tF5kw8DaP
         KUBnbe6XQ6x/IePq+GOWaOUat+K+pN6NU9Kyu2ZjJuZJ3eIYyacpwGOtFnNKNIscUKt5
         pJaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKCYwWY+JIDCXMJc7XYXK07ORH9hfXcNFPAgOZoi8oPP5m8CfWvH8lJR/PKMn14YLI3gUjKa3jJAHtO8rC7tI=@vger.kernel.org, AJvYcCXFpB4U61utrtJWMxl2VjQNKMpU4lcLOCoftVdPeEgedcLul7rRDVpPSagDGxQ631y7Tf74Pgk7badiUWLV@vger.kernel.org
X-Gm-Message-State: AOJu0YxY+qaGEsK0ORzYCKe/sZeSZDDU6BLYCKH3kR7P/ELqAPCpB1kg
	iO81+hZEhDX+h/fXX90ia3fmowfVqKmxOgdJkvrccfW5xuLfIuOC
X-Google-Smtp-Source: AGHT+IGQz8oL0l9MtcKB7+TxrRlPBC6NdrjyqLV+l1HSO3zAii6LniF9RMVuWbwCtYSGE5Gz8Y+wkA==
X-Received: by 2002:a05:6a00:1745:b0:718:d5e5:2661 with SMTP id d2e1a72fcca58-718e3e97bd1mr16107368b3a.0.1725936601064;
        Mon, 09 Sep 2024 19:50:01 -0700 (PDT)
Received: from XH22050090-L.ad.ts.tri-ad.global ([103.175.111.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71908fc8f79sm405258b3a.25.2024.09.09.19.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 19:50:00 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: Kees Cook <kees@kernel.org>,
	David Laight <David.Laight@ACULAB.COM>
Cc: "Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2] overflow: optimize struct_size() calculation
Date: Tue, 10 Sep 2024 11:49:52 +0900
Message-Id: <20240910024952.1590207-1-mailhol.vincent@wanadoo.fr>
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
  - the alignment of the fam is less than or equal to the penultimate
    member's alignment

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
the safer max() otherwise.

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


Changelog:

  * v1 -> v2:

    - replace max_t() with max()
    - change description:

        the alignment of the fam is less than the penultimate member's
        alignment

      into:

        the alignment of the fam is less than or equal to the
        penultimate member's alignment

    Link: https://lore.kernel.org/linux-hardening/20240909115221.1298010-1-mailhol.vincent@wanadoo.fr/
---
 include/linux/overflow.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 0c7e3dcfe867..fc6ea220bf17 100644
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
+		max(sizeof(*(p)),					\
+		    size_add(offsetof(typeof(*(p)), member),		\
+			     flex_array_size(p, member, count))))
 
 /**
  * struct_size_t() - Calculate size of structure with trailing flexible array
-- 
2.25.1

