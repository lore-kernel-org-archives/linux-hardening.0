Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7694279FE
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099359; cv=none; b=pvy8XCafrJSxPAMHlrn+SAwUQgH4g5F673EeNzwcqNKxAOF3juwsrMQK+ikEDy8BdOteEB7Bff8vM2SvZJrMyTHlMzTiO6E5P2Io+1gosLZYQ8Piy0GvgG+Gy/etM4PtsgY0QvDW1FGIncg6uFf6vh7KvPYSzX2wrGqld6Pv0S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099359; c=relaxed/simple;
	bh=I77vfuLlWBPCt14LYZ8NtrBQVu12DONLwfRtZcKx0sw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MSFRyu3pesiTkabWKAsTlvARAXJJneHw3l6DovuYqt5d07VsTNrsaCApNWZ3TTzMn/J/4Z2x2Cdeg6zGQ395kSZBz/Cl+hb7DQpqFGoGB/nSj+p+xu3QpkCR3Ow4to5IFSu4GostrdEhL6gxLtxGidaqFjZ2O6ywuhOOGaEr8ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OYeG69vv; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OYeG69vv"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a15fd6b45so4186665e9.1
        for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 08:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755099356; x=1755704156; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L4WS8GvYue7559uQTybXRBqpjFVSzlkpZmS/XMzMhb4=;
        b=OYeG69vvFXZObry69u0edLqOk7l9IECTg4QSEUosZ6VsJeE3a7adcqFdep0Ae8U30z
         08RPzT+eEG3c86Qlhb3t5X/OXUt0cKOUj6+KyBmF4bXgsifVunwJ/Nub9oGgE2moD10d
         AYznJ0lqyM1JQbpGmSBjR/WSY05R2wRgXrdpedOKFDRnZ3dCMVRGjUjaP9PPVfKhllOk
         DnvSR+tKCW+Sdh69QLjXW7adAPfQDN1PhqQjxnKb1JQdANbHGIg/615h66VhA3/fxOWP
         Y+UUO69O9iVBjRwdVuoQDLAdX2QFBIzFYx1dwRbcrcMzVR8NR0LOm/81EO4lrsFCZ0cV
         MM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099356; x=1755704156;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L4WS8GvYue7559uQTybXRBqpjFVSzlkpZmS/XMzMhb4=;
        b=PBXhamUjOYZE+zquW/pgAEDnVtS47kmcq1Yr3Ljo0ibbKkQT+TDVnBJGE2or2Z0Wod
         7I2TPuBxHo6DjGmlvPHeBEhJJo2Y9MrfhuhLykUlW6OpZRsqVgs8mHHeto7rBcZ4T+/o
         f1Z5RgBgjMC6us0+J1iRf4QzCIsGI97ouvZgTAcRXsaO7IfNS2V5jb6UPCBxD7jeqzmC
         FUDUSkbZvUWoPGBx9sdBRhyC204mXgN3gVhPIAgW5lryLkJvCX6VOSSVvA0/Q9h8o0zV
         XH+8r2vnt4R6+HDvAb57VeRuVz69drWEkHUAoACqLl6TgBvJll3VBdXt1NmA5PIzc59w
         W6Cw==
X-Forwarded-Encrypted: i=1; AJvYcCV2VkoFJg36EExi4O6jnfOQPy04qUgMXvzkLR88D7cQThBaYiolkMLAmXf4gTYvy5s0AixhL+KcaYNpmDABZMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx22vRiy10puX2UVRZkw/Oq+8Gf6D7lDguyH1aSEN2bZAhTDE9T
	/LnsL/ufsvtHOE79BsnF+ipZtIWgtpVnKAabx2NWwbhn0cn75zBzGyZlPJZgT9RB5Abr6Q==
X-Google-Smtp-Source: AGHT+IEe3dz6q96KeNmchrPq1cz+rF22A1Bsx6DhEle2xVBOzYq6ivW8h+sNse0JlVP+6oJyR4izDtk=
X-Received: from wmbep10.prod.google.com ([2002:a05:600c:840a:b0:459:d8e5:aea6])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1d1f:b0:439:4b23:9e8e
 with SMTP id 5b1f17b1804b1-45a1acf4a5amr167855e9.3.1755099355884; Wed, 13 Aug
 2025 08:35:55 -0700 (PDT)
Date: Wed, 13 Aug 2025 15:35:43 +0000
In-Reply-To: <20250813153548.1650533-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250813153548.1650533-1-bqe@google.com>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250813153548.1650533-3-bqe@google.com>
Subject: [PATCH v14 2/5] rust: add bindings for bitops.h
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

Makes atomic set_bit and clear_bit inline functions as well as the
non-atomic variants __set_bit and __clear_bit available to Rust.
Adds a new MAINTAINERS section BITOPS API BINDINGS [RUST].

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Burak Emir <bqe@google.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Acked-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
---
 MAINTAINERS            |  5 +++++
 rust/helpers/bitops.c  | 23 +++++++++++++++++++++++
 rust/helpers/helpers.c |  1 +
 3 files changed, 29 insertions(+)
 create mode 100644 rust/helpers/bitops.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3950f605dedb..a9ebb2d49dea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4315,6 +4315,11 @@ F:	include/linux/bitops.h
 F:	lib/test_bitops.c
 F:	tools/*/bitops*
 
+BITOPS API BINDINGS [RUST]
+M:	Yury Norov <yury.norov@gmail.com>
+S:	Maintained
+F:	rust/helpers/bitops.c
+
 BLINKM RGB LED DRIVER
 M:	Jan-Simon Moeller <jansimon.moeller@gmx.de>
 S:	Maintained
diff --git a/rust/helpers/bitops.c b/rust/helpers/bitops.c
new file mode 100644
index 000000000000..5d0861d29d3f
--- /dev/null
+++ b/rust/helpers/bitops.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bitops.h>
+
+void rust_helper___set_bit(unsigned long nr, unsigned long *addr)
+{
+	__set_bit(nr, addr);
+}
+
+void rust_helper___clear_bit(unsigned long nr, unsigned long *addr)
+{
+	__clear_bit(nr, addr);
+}
+
+void rust_helper_set_bit(unsigned long nr, volatile unsigned long *addr)
+{
+	set_bit(nr, addr);
+}
+
+void rust_helper_clear_bit(unsigned long nr, volatile unsigned long *addr)
+{
+	clear_bit(nr, addr);
+}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 8437736fdf28..abff1ef14d81 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -9,6 +9,7 @@
 
 #include "auxiliary.c"
 #include "bitmap.c"
+#include "bitops.c"
 #include "blk.c"
 #include "bug.c"
 #include "build_assert.c"
-- 
2.51.0.rc0.205.g4a044479a3-goog

