Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF132E7186
	for <linux-hardening@vger.kernel.org>; Mon,  8 Sep 2025 07:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757316124; cv=none; b=kZgw5ZiDVgMERPLKNTETXhm8eyu+K2cODOeqXvAqSrMBnFRwXNQGwHJnUHeUbU5LsFS0lJ+qqm6Q8ys2KMdRPlS1acairCeVpA6mXfwID6NqMcK1/D7sdv92+GwlhYKb9Dw+05O3nLu+PGCiTpGKZlE7kVF8z0vhttQT8Gk9PP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757316124; c=relaxed/simple;
	bh=iv0V5sjDmP+G0IfYZFx/KWMcUh6euYWecr6+mvlV4QE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mx9m/CJ537/rXfNlW3CM0imY9M1J3NRr3L2gkxIAW7iCRBF9QcJdByBGj5+57Z8dxnIznMGjKxc/o+ZxXIdxPvspYT4XoYeeUriAsDaSduUtnV0PyghhXtXo38PorgleyaZeDcAVy3w90wAee1ZCKwb93cPLaMRdJWRjjUQrYbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KdJK25Sy; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KdJK25Sy"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-625b1922a37so1469157a12.1
        for <linux-hardening@vger.kernel.org>; Mon, 08 Sep 2025 00:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757316121; x=1757920921; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ysoQKff0sxHrJKhSrzzYE1E0RWSujnefH1ZX7oEQ0w8=;
        b=KdJK25SysnGxyaRHUn9WG4zsc/gDPVtFj/V0AawE5Uk8AUsrEKxNWSL1PP6SHGYk9C
         vf2835qYRb8LpCjqmYRmfu2rtOdIVgoDGjei838BbebOIvoxNn4XCHOL/9RwzmBTMI/M
         nwC9lS+mscJAnlz1RyYyhmVQt4ShZ0am89XC6vmhW+udUJuc+Gkupsd31olbOBA8RoiD
         SgZG6isWlZXXHdoOTPslTKa6mIyTB1vmECPmP37bGjRuJxbGtppeLIUfuiZvTM0w/oEk
         78EOBtVqvIH+ddZxBwzF6RohLwQZVN8jIE2pg0pX5o+7HOp6GO7vQcolcZMaXfjh8DaT
         L3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757316121; x=1757920921;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ysoQKff0sxHrJKhSrzzYE1E0RWSujnefH1ZX7oEQ0w8=;
        b=g1Con/uNNpnxjWdnJtRU2JFax+T0sNLS6ScBkTuulH7E/rBQrC2xiaXVn2nnMBv9Ly
         nrBermdiEuLtslZfNnb6sT8x+f8BLmpE0OxUHTNzX6l1dLCkDHb6PJ+Kr/Kcgn9zSNqq
         lr99ioBKrLbhf9VpyTXPAEU/GQGNMXhSTfcN7GNqiz/QpZnDsol5sPd7n7kGFHiMEBCm
         LOZMGtZ0sgzRl52PJ4efqAyfx4NgKTRc66QaTuJx8AWOhvASwXeEyvCBFXyM3UEnkFBK
         aBQGSgZeCymNAk4Qal4SH4rG7RMcGJnIXFutRH2JsC68qdQbp0RdHwFzx4WYdaGOAYEz
         bNnA==
X-Forwarded-Encrypted: i=1; AJvYcCU5qBPDZHNCBjSfnOg8OM4eOioK8UbKBuFKCbVPG0GyahZbtscLGgA2FyeE6ThHHdOJJYO4j8Gjw4JGKLneP4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YySUbE0leO7gsQqvZdYS3+dPLCx6txrd/KvnYEf0RXCliw2oprj
	yVne6/PyMkESllGnjWUhemD0B5uinH6CNH1R24daHnhkkrkq8iYmkibvwnQfw19xW4LhGw==
X-Google-Smtp-Source: AGHT+IG3O7KQTMkteqE6QaLliSIWj3W9rn30EeC9lqpPanaLx1WwtPnQKWWx4eZFplTweL/AeLsHHkM=
X-Received: from edaa13.prod.google.com ([2002:a05:6402:24cd:b0:61a:366c:d1ba])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:52cb:b0:61a:967f:55f9
 with SMTP id 4fb4d7f45d1cf-6237b972390mr5963632a12.10.1757316120834; Mon, 08
 Sep 2025 00:22:00 -0700 (PDT)
Date: Mon,  8 Sep 2025 07:21:51 +0000
In-Reply-To: <20250908072158.1041611-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250908072158.1041611-1-bqe@google.com>
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250908072158.1041611-2-bqe@google.com>
Subject: [PATCH v16 1/5] rust: add bindings for bitmap.h
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
index cd7ff55b5d32..0b2d800d8ae5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4299,6 +4299,7 @@ F:	tools/lib/find_bit.c
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
2.51.0.355.g5224444f11-goog

