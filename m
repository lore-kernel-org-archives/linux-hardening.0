Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F293A8FF1
	for <linux-hardening@vger.kernel.org>; Tue, 24 Feb 2026 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771952671; cv=none; b=cXjntJaQ0Q2EPQQGqP1j1hf0+CrMIOYc5wM3aCBRPI/clbcCLf4d9okofeCgWiPszpsF3HGZ7rFGuHjssaH5YDNq+RxJJbmQutp1S4xXTQyxeFJAIvVLFufd1XXDZ23vtD10VNBInwwzm18kRW6b/3dvrehMoR8v/Ah0mWV6fJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771952671; c=relaxed/simple;
	bh=kyJx0abKsM+ye4/sGjKOKOe8QO0KJKvhi9JvpmTKgFE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YGwnV2XKl42qm6ZqIGIFXoELWe1i0/jUQpQvhWxpGu9TA/6Y70gyQbQlDScCyRquZoCwhQ/8n/ds59io+BQ4NkF6beWCbXxtpPwAoOtd5mKA8ZPaNzzMq0J8gWNrMjjrLr8lpIC/3/aX5xXvwsgblkAn0KvPAl/jz4y5o9MYZKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NKdx6fRv; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NKdx6fRv"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4837c597cd5so6870875e9.3
        for <linux-hardening@vger.kernel.org>; Tue, 24 Feb 2026 09:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771952668; x=1772557468; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wEqFN9UUEKzcXYtb/M8n+iE3sou79Y04zVjpTLary3Y=;
        b=NKdx6fRvqciccoMzqn+K0vxJ8d437vwlykUyCFHYSSmFX55IU3G419J0nDtDZvGEJZ
         2JSiHHSl/kojyomM9sDDHoxeeD4N3WyXdbPu2shuSdOqy3zR4v+VGGVdrJBP0BZACm7M
         I4pNQFWiailpaU5DfVfT4EiWY4VjIKCFT0MRKUOVMBTzCIpjf4HHAP+bwfJDh12XT69k
         lzkZOdP7b353Isp8vqUnrKgJRcXxde8sW9k1CnesD8GX2YfUTseLXoxbYn9gM41kVtTn
         D0Cqoq0Bu04jG+e8N6KJqhlceOuEFGEaaFDBfwW0oFq1BJkHGLyZPzfUV3nVYRYaSfBJ
         woMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771952668; x=1772557468;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wEqFN9UUEKzcXYtb/M8n+iE3sou79Y04zVjpTLary3Y=;
        b=tbRs3pRHe8c4e+icYdY6Z2OyCCK42tVPf8ulT4HjQ2tMnV+1by9WuMOUdbhowYJ+9D
         7QJZO5QtKbF9or4n7pN9MxQnb6YzTvbM6+bx3vUWdJWkO69GqAHIOIm2HgyQojyBRK3G
         iWK8AnGooxa4YWoz/U4jOcO6Cj3oNHGa1x6QLVZY9ElZ1SV3GZhcRh5kVZUkNWiRYwlq
         WR6v/Seu0BSIyi2w8/DU2lUfX1eFYAIDBzsjFOOw987URWRN2JUJsTZeDWS3gAxIL9d1
         tC+kgVzjrCbQaTLpm929f/mAGiqwzyfamQ4F/Uoh9a4Ml7JAgPv0Z2fiX3aN3DUCmU4a
         r5jA==
X-Gm-Message-State: AOJu0YwdyK2bQphlk28Kw3Ym/xAV4IIoAdYR8I/2qlSNxhCnl37c8GVt
	wKQIElEAHeUL4xbX39BYMI1pn0pHCAc3CC60M0AHkeDajrzcb8Cp8MaAL6q8IqupZbV8r9D6Mlr
	lgQ==
X-Received: from wrbck7.prod.google.com ([2002:a5d:5e87:0:b0:439:8c91:524d])
 (user=tabba job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:5394:b0:483:6a8d:b2fc
 with SMTP id 5b1f17b1804b1-483a95b7162mr185229535e9.8.1771952668202; Tue, 24
 Feb 2026 09:04:28 -0800 (PST)
Date: Tue, 24 Feb 2026 17:04:27 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
Message-ID: <20260224170427.2296592-1-tabba@google.com>
Subject: [PATCH] lib/string: Fix UBSAN misaligned access in sized_strscpy
From: Fuad Tabba <tabba@google.com>
To: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	will@kernel.org, tabba@google.com
Content-Type: text/plain; charset="UTF-8"

sized_strscpy() performs word-at-a-time writes to the destination
buffer. If the destination buffer is not aligned to unsigned long,
direct assignment causes UBSAN misaligned-access errors.

Use put_unaligned() to safely write the words to the destination.

Fixes: 30035e45753b7 ("string: provide strscpy()")
Signed-off-by: Fuad Tabba <tabba@google.com>
---
 lib/string.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index b632c71df1a5..a1697bf72078 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -157,16 +157,16 @@ ssize_t sized_strscpy(char *dest, const char *src, size_t count)
 		if (has_zero(c, &data, &constants)) {
 			data = prep_zero_mask(c, data, &constants);
 			data = create_zero_mask(data);
-			*(unsigned long *)(dest+res) = c & zero_bytemask(data);
+			put_unaligned(c & zero_bytemask(data), (unsigned long *)(dest+res));
 			return res + find_zero(data);
 		}
 		count -= sizeof(unsigned long);
 		if (unlikely(!count)) {
 			c &= ALLBUTLAST_BYTE_MASK;
-			*(unsigned long *)(dest+res) = c;
+			put_unaligned(c, (unsigned long *)(dest+res));
 			return -E2BIG;
 		}
-		*(unsigned long *)(dest+res) = c;
+		put_unaligned(c, (unsigned long *)(dest+res));
 		res += sizeof(unsigned long);
 		max -= sizeof(unsigned long);
 	}
-- 
2.53.0.371.g1d285c8824-goog

