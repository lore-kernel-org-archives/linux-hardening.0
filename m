Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6BD139CE3
	for <linux-hardening@vger.kernel.org>; Mon, 26 May 2025 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748271711; cv=none; b=MmdPEep0fBjws4w1tH/VUlZWVSmBdqzOmfiqJBc7cdiXv8kiHf65r9QTvmwF2bLrEqBcuJhrQ9lWw6ctmDRWjNCwgOujg1oFve2hLJVBwWc6bYbys0iruYxqPUcmV2Yy7ng4PS1CQNhREikeL6SI27bfszgsgsP4YZrKDw0tAn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748271711; c=relaxed/simple;
	bh=rCRXTHiAgtKu3dsFNLxOBHNNzDWRNYIKX6JbwfEQaok=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hPPFcg5It7YY8TNjljsT5mRNdBUFt3BRUBgVQiiHofVo4AUhavK3gXzFbOYrACsZjzUcOOq4qmzDEhLVN/DjCql4sDGf8X0Li84MrJzb0Fc3+21LU8PNNytuF2WDfj6QbW5q47AR56b6opvNvPI2B9HB/jhZVNeqaTXpPwzj6ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WRfZMEcT; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WRfZMEcT"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43cf5196c25so13745565e9.0
        for <linux-hardening@vger.kernel.org>; Mon, 26 May 2025 08:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748271706; x=1748876506; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NHkjvhIISCSHj9u0ZO7czldP5cDtBrvbmLtc67N+RWM=;
        b=WRfZMEcTJmTBZAvYYUSgVOlGFLHwQ7DqEo+jLdIypERwTT7DD0YjX2q90EHRzzKgsq
         vL7dOwUnnSWcSEAGCvVu6/RAtPCNk2RgvFMZXu2Qfy17TZFheVgHzKgz5Ewehpc/GFdo
         t8FXVYQzi+EkAaWp5CTIWmkoR0dmoXVU5P8S3EN/K/9GZ77ISVKIf/7+48fzcTHRQE7U
         jZSWgMVH1YVhCkGb7H4LM/arOUc9YG+/UlGeKSjKJKWZGib3Ks+Aoxen3yxiqA0/vN0O
         gVPaoSg/nC2fezCVCxbjeMNGjV8pylTtqBjjpSRZMwEayLEjhCw734/NaEgD3ieGAE9F
         tsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748271706; x=1748876506;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NHkjvhIISCSHj9u0ZO7czldP5cDtBrvbmLtc67N+RWM=;
        b=rR7KNnFPzKGN2opPAZZyvs7q+xsFUJJjFhPy6jGE8cN1n3VAVhNfWIogImpA65ZKVN
         EUiVSlkEObCWQitEtpTSUO2Vg8cos8fruJbGUnOrQPlmv7COgmGAwHmeDchxLiq2Zwee
         9m4QDRhvbi5xdgoKFclEwP3gRaYMKOWkIhs5p4iDSXeV6odTvgToHOi8+ZIsDEAmTLbN
         QT4oF9k3G3rD0sg57D1tNvdn4tgSOdqMToCJyiV7in13rpcnnmFD++5BtIB6c2lybAl/
         SFLf/n9KY8H5uDIUUzTpi53+TW33+iUcZr6OQbclu4/O1fn6epr0+fFxqCNcIEUPT0ee
         MF/w==
X-Forwarded-Encrypted: i=1; AJvYcCUrppoSXn7nWoX8gObpi7Yd0XjuwLHPhJpfukGD0MiaDlcZVMviGnURg/ttgB/10ZRRhqSmzhv32VUvXGf5gBo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2B8AkXeDsiwwnhkmjvzKHzEN05bo1bVbXk14mLxFLLm4+5Ucg
	pQTX0F4eXbDJNZjJ2pOz5hZzFst5zep5gZk/zoOQXYMhIA/TF4q/+mVOhqvhIqQOV6uNsg==
X-Google-Smtp-Source: AGHT+IGPo8nUzY2Rj6nkPhVFDqh1Zc0DKoHnIQDw9+T3ld33w/KON4X7whx9IUxnJRj1Tiiw5NGdXf4=
X-Received: from wmbez3.prod.google.com ([2002:a05:600c:83c3:b0:442:f8e9:a2ac])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1c1f:b0:43d:300f:fa3d
 with SMTP id 5b1f17b1804b1-44c9141d8a2mr73618805e9.5.1748271706538; Mon, 26
 May 2025 08:01:46 -0700 (PDT)
Date: Mon, 26 May 2025 15:01:30 +0000
In-Reply-To: <20250526150141.3407433-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250526150141.3407433-1-bqe@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250526150141.3407433-2-bqe@google.com>
Subject: [PATCH v9 1/5] rust: add bindings for bitmap.h
From: Burak Emir <bqe@google.com>
To: Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>
Cc: Burak Emir <bqe@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
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
2.49.0.1151.ga128411c76-goog

