Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A225A24501B
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099358; cv=none; b=UxF+wPyT9PKjnaDXWXZ53ezJGIe95C6pwh/GXHmYBMAobl98sahLINgWIFfLWJaSVqazVgiur1rjwrXWKvhx9EmQDlXPuaUWmhrg3FqMaQS6Yq9b2Fthqy7MJkqVJy6b9+12FhwL59Lmw77a+wxGesuDkPpewVmtpfzvdJWMX4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099358; c=relaxed/simple;
	bh=2KT9b66Vpg7O1XgImm+s2jh7nuCN0RUQGXoqFyCFNjk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z1fdfQ8vi/whyMZCjWSf6MWTIB2PpxDxkoQveqrvYrL46bL9M5pGQLt1yxm1J1BWXZzrSENBd61499bUx3e6rk2zwHkGSmgMb9yfnC/q2c4ULZYHUmLiJpc+tTd0X2bKfMiUHRlTeIbCdKh2Dl9W3uMIEHABwWQhmnoaIyMnJEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PEavuCU+; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PEavuCU+"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-459db47f138so26142185e9.1
        for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 08:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755099355; x=1755704155; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E1zuyuW5ibidXnQHsNdkTLhAD2Ht6AEd8unQ15QbNYg=;
        b=PEavuCU+RIqHMc7OHilivwyGaiNvno7DipUpmPzwac0ojBw2ntttx3IeIQX6f5h/Yx
         bBzvM027guK+FRq1d5gkuPLN+rlgAAAyLURzS6HKanE+Yfz6XFcyqoHh5Npal2oR6hg/
         BUq3tQeXkUcreBGy9Lqez/oVgvx0vlJzCp4+bzZDxjuXfvNm1A0iw5qyTANr/QyKG7lr
         unISbuUFddBcBkR+SulIH8JQuNQS3Y5yeM3WmXBTIc2P0jL0vyHrdHwQAZ5QF3QuFxwa
         2nKUcHI+tHdpIZCigOZrAlyzuoAZpKJpnJ4dEeBM79y8mlHLnXCyNSlaNDXmMSDIoOWj
         pD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099355; x=1755704155;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E1zuyuW5ibidXnQHsNdkTLhAD2Ht6AEd8unQ15QbNYg=;
        b=jKtQBUd7j4UuFF8M1KsWQ0eoz87uXWaxHbrmtAH+VsK56g3CKNapvD6xxgSJoGg6ZW
         RU5Nc479xS0HB3r9Z4exPfpdt58OumdJsssJkiTabWc7BLcUkj0nKrQMMDajpLGe6vv+
         qedgDxVtvRltQUrAjQT+kRbMLixg7NuRntPlP7DaRtwxgV93TnO0Pqrdwndh21tFsfR5
         GPbu6bWRAFOrxKZjjXESw6xDfhEdy24kDx7Rso53a/yDfAaVh/rObX8nZHy9Y8LZvqWd
         0SVLp0k143zqwJT+fyly+CH5CDrX3BVKOQrGBCvH//ZyAu0LTn91/TafOPn/cz5AbsGq
         UpKw==
X-Forwarded-Encrypted: i=1; AJvYcCW9amK23QdqMwVWyATaTBOv2A0YBunI7IxFkWIbhx1/hxPX47aQLPuyb/bS0GtKqiJ7mO+a2OQS8NeKnQ1y21M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw71uYl+Z5WwMKWtPB5kiI1xgMCEjzEPGXnetxUEJuw3oXp9hsy
	qHM/bHXCLY80nLV89EuhvGyutAC4tG71+mAVmCeA0ZPO6ziFtbxGjQOFtSh4KmRXPfr0rw==
X-Google-Smtp-Source: AGHT+IE+ZSG2eAcaUH4f0r+LrEDrUC08HR0FFobmR0CDvCZLYCneSrtTQPGZWhGgBEeqiV6j3om+DHA=
X-Received: from wmbei18.prod.google.com ([2002:a05:600c:3f12:b0:459:dd4e:4446])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:35c2:b0:458:bbed:a812
 with SMTP id 5b1f17b1804b1-45a19769f4bmr18661845e9.17.1755099354918; Wed, 13
 Aug 2025 08:35:54 -0700 (PDT)
Date: Wed, 13 Aug 2025 15:35:42 +0000
In-Reply-To: <20250813153548.1650533-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250813153548.1650533-1-bqe@google.com>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250813153548.1650533-2-bqe@google.com>
Subject: [PATCH v14 1/5] rust: add bindings for bitmap.h
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
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Acked-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
-
---
 MAINTAINERS                     | 1 +
 rust/bindings/bindings_helper.h | 1 +
 rust/helpers/bitmap.c           | 9 +++++++++
 rust/helpers/helpers.c          | 1 +
 4 files changed, 12 insertions(+)
 create mode 100644 rust/helpers/bitmap.c

diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa4..3950f605dedb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4298,6 +4298,7 @@ F:	tools/lib/find_bit.c
 BITMAP API BINDINGS [RUST]
 M:	Yury Norov <yury.norov@gmail.com>
 S:	Maintained
+F:	rust/helpers/bitmap.c
 F:	rust/helpers/cpumask.c
 
 BITOPS API
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 84d60635e8a9..7bb575043c86 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -36,6 +36,7 @@
 #include <drm/drm_ioctl.h>
 #include <kunit/test.h>
 #include <linux/auxiliary_bus.h>
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
index 7cf7fe95e41d..8437736fdf28 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -8,6 +8,7 @@
  */
 
 #include "auxiliary.c"
+#include "bitmap.c"
 #include "blk.c"
 #include "bug.c"
 #include "build_assert.c"
-- 
2.51.0.rc0.205.g4a044479a3-goog

