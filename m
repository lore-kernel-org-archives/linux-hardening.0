Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359F2221FCA
	for <linux-hardening@vger.kernel.org>; Mon,  2 Jun 2025 13:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872381; cv=none; b=AlvfEBIiSFGD9idC2lp9RT8TLuoMaMKoQyux70X4ATSeMcyaIqQQoA5ItK+0yq7+o9mzCJFzZTMP9jyuh81/as3ZOaMxVvt96DI1qtqt12Axjf4x2TAPmkNWGfYVlr2IGESCTBquDNHEWC3Gfk6iXZOdH5zAmlOyQ6gYUH896AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872381; c=relaxed/simple;
	bh=Rzcn2D1R7zSupN/1sKBCkj6sw/WKyT+A5UTnYCzGiiQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DEWHAWD3pAq2rIzC3/EzYDnmoYsBNRPJNQkSqtnsR+bIBlkRBO5U+okYKk/jL1t+21dOytooR3Jq+wc60GBSD8u3kRbcUr7x9QkPgV0BhnslsRfyNjDF3Z3a+kZEqzktehzTldpDU3D9Q4FrFM30Bryj3Cwf/8+4VoY8amoEdHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pGBqElk2; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pGBqElk2"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3a503f28b09so598962f8f.0
        for <linux-hardening@vger.kernel.org>; Mon, 02 Jun 2025 06:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748872377; x=1749477177; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rXNjx/GHWFg5i/sgYd5jVrVVV/q/iAdZaBE+RX63LUg=;
        b=pGBqElk2v49G4+SacrakeXDC/NiZ6cxud524VEF/lEz0OOEQR/JeAunSaz2ATjP7I7
         lj/N6rv6LcJGWsMb3IA1QfPvn43uAVPhoyeX0nYaGyOcSG6mWmAO7RSD5PlJQsXBLVjB
         LB8iokylh96jLQliDTptsSpaQC5uw0ht42CR/e9OrZJ4bJ1g6IesP7eV17Xw3GRNq9M3
         miKaJjPIT9tK7pdTw0J9nl5zq8vyuLbHUqux1Y6VPXSWatLzt88C2j4YLSu1YJhteAxv
         UHKDnwsoIJ/kj+EZU2km3xPprSqGbxWcAxQD4P51vVL0B2z3SO4inkLlSXQTAeLKBcu+
         DH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748872377; x=1749477177;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXNjx/GHWFg5i/sgYd5jVrVVV/q/iAdZaBE+RX63LUg=;
        b=H6cAQE49Qjdfmop9bTxC/elZn3/UnNngTcD9Dx7cRcFLWxJLciQR4fv5MiMhU40h/P
         j1VZloxzSRITW06iZabRjs2DgNZE1jATO4o4spIcj6ErGtaIU8bSt6A1z4UhF7JAKN4N
         KkPuKicnRmhL4HC8PodopUyeYsGHo6lSUDHI6PCig/ufqngwWtnRQM6r/Aqae0Y44ekV
         kE39yLvOj3k4smaAi3KG/mIbSZD+gyOlD2GvgX4Yjcgi25AYJ9XtDs4uqdTSL5ga/rs2
         b2xkBA2zsPFt9aoQBAIB1nAb57fxbi6BVM7KDBivUT40lCKJ2G3jE6dQ7kA/gmlDVL3W
         gjag==
X-Forwarded-Encrypted: i=1; AJvYcCUPzo0QdaCanIC7I2MsLGLj8heJp+gdNg+2BjN0ZX+RngTbmbdvIzd09kTeurcBzaC6eLf7gZVo0duelTQffcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoAY6eiQAhIdOa8b1awY2HPUq0A/wxjtJrQbBdyK3S7a9eK0Hd
	27E5lvLFLKfP4oIiIPWRYHbs/TpBvmm25b1aH0y0SkFCq0aRxU/gzWTCPRXAEDBwiA9YNg==
X-Google-Smtp-Source: AGHT+IFXSR7yLrgDuUf99wUiH004jdEvk4SpFIjaVNQ381qGAnRIcmZ5tsfnHhhpTc32kJl2ZlMotUU=
X-Received: from wmbeu8.prod.google.com ([2002:a05:600c:81c8:b0:44a:3354:5dfd])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:5252:0:b0:3a4:f607:a5ad
 with SMTP id ffacd0b85a97d-3a4f607a7b9mr10561741f8f.19.1748872377699; Mon, 02
 Jun 2025 06:52:57 -0700 (PDT)
Date: Mon,  2 Jun 2025 13:52:20 +0000
In-Reply-To: <20250602135231.1615281-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250602135231.1615281-1-bqe@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250602135231.1615281-2-bqe@google.com>
Subject: [PATCH v11 1/5] rust: add bindings for bitmap.h
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
2.49.0.1204.g71687c7c1d-goog

