Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3AB221703
	for <linux-hardening@vger.kernel.org>; Mon,  2 Jun 2025 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748871424; cv=none; b=k15yEMKVBnheACzvJkYSBoi2zgYTKprhy8TmhEtC+LwLKQ2R+PNfEKVascJfFh5h6jFrysvA5i4vqK+tVy1je4AJwaRR6RGRn1wnKoPjFyU+9HNLOzk3RsolPt5yRMVuplGJQqeOVYCz9BMR0D+2pxA/112RZrMY2V6Cudrhh1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748871424; c=relaxed/simple;
	bh=E/w79vVPcT3Zr2nhL4Sj2w1AZemSgO2OaKw7xSVzVdY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oKtq4tq3Llmiy+fGXhY8ITq4sWkwCshPNIjCy+ZM6uvQGroAUAwSRSgVaE7O5LMikrY9cidIvuUzYt8aZfOzStBSNpQUfZwNUKxhHZEeviIqJwckEo/jDsYhdL/47XCsUmeb+HTxsFDrGH7t+ifHkOJWTqb6niAelzfKpvMEqdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AUEJXZK0; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AUEJXZK0"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a4f7f1b932so2390141f8f.2
        for <linux-hardening@vger.kernel.org>; Mon, 02 Jun 2025 06:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748871421; x=1749476221; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1xsZ3bzHWEHjMHqu05pw0LNNFT3NBkPT2T7RuaKPsqs=;
        b=AUEJXZK01RNf9xH8EiLdXaOSfCcK9g9pawjZ0+qk4wCAIqwAJwwivswUU1bBl1MLH/
         RVw1HlYqoHug7cEGLYOADJ5cat3ty0jbUo/tCmW+f8ycDE+CU441u2FKN8gNnuOZD/hB
         8jYDnBFANaoLzHv1XbsZtHtw/N6iQIrdTgtxIEcnxPt107CT3CUZg8EdhXGlQfCqqJpu
         mxIVYT2HPF4HnsfB82/o39bk6ZVxG67rJm05zEU3OCiPBBkv4RVL14kRZbGi11Lsiw4A
         7yZSpJBy4tcRZdsOpu3o6e5juAqEfmrt7MddoSA7DPR8MPU6PCTkHU+tw6FEGaDyFjTb
         FbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748871421; x=1749476221;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1xsZ3bzHWEHjMHqu05pw0LNNFT3NBkPT2T7RuaKPsqs=;
        b=GkFD5ahQ+r1jRIyq0VW3/eRgTwAcpObotUQ7Vn4cwW1CBMTNkwOdJzzQYR0lcdnbKf
         gfLwugmOapxnhCIuBKc1FtBjHeoEwTcBPqERfCYY0s1ZJ45TEXji//aDHNdo7Yvn775e
         g6V0wcsU7z5qI5QkVZf5zIzIwlSZZfffG1nSXYRIUYAnXUHg2MeEqMxRTMvuj9g0u5Gu
         sK7ZQf9nOn+G5FyiBmGwZuPRMUmD8M3VYVAXptiC/OV0gUtlw65cPTn/GUW4xsJ8FmNn
         ++F3//O13gVKg8u+QqQdTSd0lZ2GRLuDdcq0j82QZhZA7fj+gBUDJdd/rMIxNWLD5r0A
         745Q==
X-Forwarded-Encrypted: i=1; AJvYcCUKz3XLmHAkQvsUadHiGJ7KV+NX4KKMPOgtTd95M9PWc4KQMylx0L8hlgceoZCfsUFhCcIXls53DqC9yYXyuzk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx84ilmbKFO7GIB74fBM0EFvbx6c2njq+X3vAHO1zIqqPeii5q3
	6nKeX9wBh4uK76FOfsgm5gF5O/FPT8j8TAVnkp1rinnkfDEWXwa5QpCn7vBFHAhbfzYy9Q==
X-Google-Smtp-Source: AGHT+IFUd3/Au7r0/E7zO/NvqFb2d5LVWOIiZ8HD6Xtu76YAGOeLpsZQ2jP0GboADBe+dtG5nQN0HQQ=
X-Received: from wmbet10.prod.google.com ([2002:a05:600c:818a:b0:450:df6d:a450])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2586:b0:3a4:fb7e:5fa6
 with SMTP id ffacd0b85a97d-3a4fe154b3emr6667986f8f.1.1748871420861; Mon, 02
 Jun 2025 06:37:00 -0700 (PDT)
Date: Mon,  2 Jun 2025 13:36:43 +0000
In-Reply-To: <20250602133653.1606388-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250602133653.1606388-1-bqe@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250602133653.1606388-3-bqe@google.com>
Subject: [PATCH v10 2/5] rust: add bindings for bitops.h
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
Acked-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
---
 MAINTAINERS            |  5 +++++
 rust/helpers/bitops.c  | 23 +++++++++++++++++++++++
 rust/helpers/helpers.c |  1 +
 3 files changed, 29 insertions(+)
 create mode 100644 rust/helpers/bitops.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 86cae0ca5287..04d6727e944c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4141,6 +4141,11 @@ F:	include/linux/bitops.h
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
index 92721d165e35..4de8ac390241 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -8,6 +8,7 @@
  */
 
 #include "bitmap.c"
+#include "bitops.c"
 #include "blk.c"
 #include "bug.c"
 #include "build_assert.c"
-- 
2.49.0.1204.g71687c7c1d-goog

