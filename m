Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B592BD01E
	for <linux-hardening@vger.kernel.org>; Wed, 11 Jun 2025 19:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749671330; cv=none; b=VtgIiF+RU97egNX3cwqroc/5/wA8FYwXM6p72Hj0lg4Z8wbnntHER6OGoJBx9X8tU9OA6FNHA6r9Tat4Ezg+gDrl8UeGlJy9wizpq5jOIzeutdmc20oBmafCYlHdv9s8fzKNCLrMnJtNUeHYyHBpjY5Oq2cheNAvXwFatWUYTQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749671330; c=relaxed/simple;
	bh=yxESNOtykpyqNwOyhpU4lESBJpOCG0tD/LK4XS2LT/k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qQcQdvhvWOiA/maHIHVpBTWLRU9hF3/+P+4FulDL6+K4u85/LtOQg1CEmRTM5VXvg6OqOa4RDC4KQu1WpspoMTNfJYKWljJMwyTtY/E8UuaQe2SFg+M7PH7LjWjig6B4w2i8ueiE2GyIkH/ENQoIS2iSXMT1+wUhISvQgnHSnaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MqWs9W2d; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MqWs9W2d"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45311704d1fso690055e9.1
        for <linux-hardening@vger.kernel.org>; Wed, 11 Jun 2025 12:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749671326; x=1750276126; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sTV3y8Fu7j9OR9h6n9kLvax9ETqPo8owP/xJtYP+uAg=;
        b=MqWs9W2dc/S1Zn32GW3WhAu6Hv7r+A/4YRV4b0JGzw+8kakSJuCgGlebp4php2piWu
         v9HiDP9Kg0iN60x64D3MOJmQro170ofPcPgfKPNSCi/IVnuQN4FYO6K31VOfsOuyTgqM
         O4elZUsfKav2rQ86A9ijFUopHKowjMncvzxthdiwKz6ZC485HchVdPoLPRDg+qXG2kfC
         C55MZ3XJBHlH3TeCZBYDdUFIVBaRXrTBaXVO/GRvkz4iyjIHCGfmR3ujHhq9f4d1CTVi
         M/54vfX0rjFeL3imvGPZRNoZ3y3qsI4qk66ssRG7e6gH2Qi7/u8xH7zv7FqnHtww+Emd
         3YSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749671326; x=1750276126;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sTV3y8Fu7j9OR9h6n9kLvax9ETqPo8owP/xJtYP+uAg=;
        b=uWq+Vq45dO3bnGgvU9w0pW+CVmqPaMgAE48GIhU+Pa0dyaNus8w7cwJCW5nGkZA0bz
         c0NtPTZcPj9F5YfmKzRgTqhZUTQIKTs1krsYC/Fazl+D0oyRPRjTC95rc9mg341Co4JL
         etdzLdwWT4hGWyPi47HkYdeORQv0fM63EOhUY4zE+pAWMdrlmQkqowvMFKtLsoemXN+a
         Kmxy7s6aNGMn+L5TCA+99u2zdyOsFYJ6rB+LZ5ihTGzNrynExlD//EeGY6fcvBloH/ql
         8o1yhCemxA4j9Cf7bZQ/vMjB90nrQEphTf2hifqJNlIiYS9ImAompw4uIbkozT5d2xA3
         7wdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN5KV45MbCPnAuuLLb5NvENonsGI64atJdyLj1CvjxjeG4zwA6ZhU1ZRWCvdqNPP06TtqbFnAcS5/U5mg7X1U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgz4UQ/QtDrwGy0z6QwWeHY25bAybH0JBOHQgsiUVcrCl92yqO
	nsdViP7m4L8RdGugDHOtwUb5zTTKN4kdE6Hea/XmgRC6SCXa88hHs++abrGQZuVT6W19Lw==
X-Google-Smtp-Source: AGHT+IFYGKJzmL1TvgvRPkFgxlem3rF3fsVAgduKbktLCSIgcSc0M1Jq2lNGKBLqm/PzDl/IuipNUvI=
X-Received: from wmsd7.prod.google.com ([2002:a05:600c:3ac7:b0:450:dc81:eec9])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:5396:b0:440:6a79:6df0
 with SMTP id 5b1f17b1804b1-4532b915f57mr9732285e9.22.1749671326669; Wed, 11
 Jun 2025 12:48:46 -0700 (PDT)
Date: Wed, 11 Jun 2025 19:48:34 +0000
In-Reply-To: <20250611194840.877308-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611194840.877308-1-bqe@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250611194840.877308-2-bqe@google.com>
Subject: [PATCH v12 1/5] rust: add bindings for bitmap.h
From: Burak Emir <bqe@google.com>
To: Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>
Cc: Burak Emir <bqe@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	Carlos LLama <cmllamas@google.com>, Pekka Ristola <pekkarr@protonmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Makes the bitmap_copy_and_extend inline function available to Rust.
Adds F: to existing MAINTAINERS section BITMAP API BINDINGS [RUST].

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Burak Emir <bqe@google.com>
Acked-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
---
 MAINTAINERS                     | 1 +
 rust/bindings/bindings_helper.h | 1 +
 rust/helpers/bitmap.c           | 9 +++++++++
 rust/helpers/helpers.c          | 1 +
 4 files changed, 12 insertions(+)
 create mode 100644 rust/helpers/bitmap.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d48dd6726fe6..86cae0ca5287 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4124,6 +4124,7 @@ F:	tools/lib/find_bit.c
 BITMAP API BINDINGS [RUST]
 M:	Yury Norov <yury.norov@gmail.com>
 S:	Maintained
+F:	rust/helpers/bitmap.c
 F:	rust/helpers/cpumask.c
 
 BITOPS API
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ab37e1d35c70..b6bf3b039c1b 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -7,6 +7,7 @@
  */
 
 #include <kunit/test.h>
+#include <linux/bitmap.h>
 #include <linux/blk-mq.h>
 #include <linux/blk_types.h>
 #include <linux/blkdev.h>
diff --git a/rust/helpers/bitmap.c b/rust/helpers/bitmap.c
new file mode 100644
index 000000000000..a50e2f082e47
--- /dev/null
+++ b/rust/helpers/bitmap.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bitmap.h>
+
+void rust_helper_bitmap_copy_and_extend(unsigned long *to, const unsigned long *from,
+		unsigned int count, unsigned int size)
+{
+	bitmap_copy_and_extend(to, from, count, size);
+}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 1e7c84df7252..92721d165e35 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -7,6 +7,7 @@
  * Sorted alphabetically.
  */
 
+#include "bitmap.c"
 #include "blk.c"
 #include "bug.c"
 #include "build_assert.c"
-- 
2.50.0.rc1.591.g9c95f17f64-goog

