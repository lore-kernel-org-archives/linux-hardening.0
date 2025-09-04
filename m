Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327282D47EB
	for <linux-hardening@vger.kernel.org>; Thu,  4 Sep 2025 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757004625; cv=none; b=hfrTW4M2EvFp08+xfMuFuw4TTEvuBOVQZcvrFGXCarx+nHwMVvB3SBWOheITnY7WugbDGqlLrDcywPWP0n3mSehpCZRAuSH2NSd90MGcMT6R1BTZsJ1kZRqlpIX6T/zJoHNcMCCYozvLyO8fwcn3POMfB1aV4Rpkxtp4XouNgvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757004625; c=relaxed/simple;
	bh=JuXjSvRq2bke2g9Z+ucNdW08Rm4Mjk2MNdVdWHu/w8Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uHsIRibFPftfuwiomplfDQnE/mb9Hd3PPCq6V0UXo4acNHOxUVDN+Xy9YEPHIf8NylbC8gQgMVbaVCL4RDe2okBXRGHpMHTgg6Nd70nEB1x/Q5o4gBAEYtw3nBN+J7ZO6pIg9AkFMW6+nKBL4PgzzPsA2aqJm91Yog2bR8aXSWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zDfVSoFj; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zDfVSoFj"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-61d1327a8beso776940a12.1
        for <linux-hardening@vger.kernel.org>; Thu, 04 Sep 2025 09:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757004620; x=1757609420; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WX5CMXBBdv5TsEcAi84FOU9rA8CaHm/rH0SNKK7NnPo=;
        b=zDfVSoFjA2AoDwyVRxdyChMWquOYGb4eC9n4fDjThd1k13SN5FU4nKrk4giQLKjfbZ
         bmUW6KeIWhw7fBlT/1tCH9oNXG9bQ3pPXc7LI9Tn+FDyreevEjp2Lw2OxFygiOntJC5E
         n/BXXkexaMH4xvANLlOBCDzGcKCZGF+qRXg3trAQtlfP2+FJsIrxSjkUALpM93a+kh9a
         7dKuFSTdHjpeW65oeukxGhVIgPoms/gQQW4QB34yJ4mgq3ob+fG59zScQR5moOChnAF4
         lpd0XuPGPUYV3X+ZRiliTxnwATwReXGcQkIBA206SFzBqvRa1m1DfDgRWBvPsAQw4jL/
         D6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757004620; x=1757609420;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WX5CMXBBdv5TsEcAi84FOU9rA8CaHm/rH0SNKK7NnPo=;
        b=cx7q7TmKupC0OW4q0M4ZreLnTehtUZwMGmMFax9NY7WfXr0gIUAZQqu6jx5Q8EAw9D
         l6wJn1BS8omkMvj4NUbLrCtCXWU0Z5DRyE71GToro/m/ysnaJucP2OCHRh8j2YMj6OJx
         oSatHEBR60NXht367/c9ihsypIqnxjnRh6MJ6aHWicp2QJ6lhn0GsSk/5flTAE52DXD4
         Lh+jBo6LE7kf7tIERBw8yQRJCi3aZ4ThBA/CVLtDOT/zQdJ57746zb2KfaFVkOqO6MSi
         UzqxzbgW5YjaMCjirG9cchWqrxe43Nbn+BNHJroCdoz5d4I72OCe+TA/wZCW2vPqW0Q9
         fpVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWK7WMzRJZuVahmbkUYgECDaQldG7TbiiNuWIoghs1JaUXVzgejxnWj8uIXyiCiP/8UkclK1TvRAoJ+u6pEYnk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy53sPXkOrW/DWG9M/aA11dlNKlZkoKYxuS5AN1DbCQR15hLfzT
	OC6AK3u/Xi6ftRpPIGKq8MAOXRNMy6Qg31fLorZAlAUaKc/90uP7oUh+Iqa0hCeuwG2Ikg==
X-Google-Smtp-Source: AGHT+IG0/kxOajb64tOpYOt2ohZyPMFR5j+tWsB7/fP7CR2IFBAVKRyJbcmp01jXmSe/HV8IaE82JBw=
X-Received: from edg18.prod.google.com ([2002:a05:6402:23d2:b0:61d:a6f:ba0a])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:90e:b0:618:a4fe:d821
 with SMTP id 4fb4d7f45d1cf-61d269a208cmr16176843a12.14.1757004620466; Thu, 04
 Sep 2025 09:50:20 -0700 (PDT)
Date: Thu,  4 Sep 2025 16:50:06 +0000
In-Reply-To: <20250904165015.3791895-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904165015.3791895-1-bqe@google.com>
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250904165015.3791895-3-bqe@google.com>
Subject: [PATCH v15 2/5] rust: add bindings for bitops.h
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
index c1d72e26fba8..85d846a2ca5d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4316,6 +4316,11 @@ F:	include/linux/bitops.h
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
2.51.0.355.g5224444f11-goog

