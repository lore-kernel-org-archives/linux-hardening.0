Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7A02E7BB6
	for <linux-hardening@vger.kernel.org>; Mon,  8 Sep 2025 07:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757316125; cv=none; b=SaEeoSI+hr5UIAVCR8rY43EnBt7MPjdg5w/WkfgPMbwsRoodPlxuhSNvlTF5j+9Sm4uC0j8iEqbNEIvsFjw315qTosZI+j0nZKOL1xwGT2ZrMSWbYD8zSJJjg8O9dP71UpGi0WaxkVL5vYIKIAWKpjJto2lcHx2bopxC1qSqe7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757316125; c=relaxed/simple;
	bh=OOacAJVa68AaxUpHDVNtzS9UHSKeHeKC1dw93YZO7sk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JPYkGvWNKSr/DlQxPDp8YK11oqTK7eKaH8Vx2eaP/7gA2j0NhISCksvylC1lJCVjRbEj26JsDau02g5A5Dps3wgK9nvt4xqYPnt5dl+GmwsKZaQkx4oE7DK2UQWoT3ONeKO1CzAigHBZBmtP+ohrSB2gP7MfqhQlQBEC7a8oiic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XF9A7yds; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XF9A7yds"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45de59f92aaso4444285e9.3
        for <linux-hardening@vger.kernel.org>; Mon, 08 Sep 2025 00:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757316122; x=1757920922; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UqKOdD5po84tcrN8SKOhshxoNPwLNVkwMMwYt2v//JI=;
        b=XF9A7ydsF6bNlIsEBUMJ935TtEZMPbiXih+mh8uoaYZRWijvNKwC9hQC/i1/6vmbzm
         mfvnWVw2SlVEsXWOlNxCzP0+wfOuBtXgSw92IRWJf89TS/mVNOutd91M5ONwka8yixdu
         sngEONu+lQ6Sr/rH75stynS9QaCLEOnn+sqGyB25Brj7R08JB1cGhTPQFR/F1a9pLJjJ
         wfVbLF/JwH+k0h/Mk8U/ElTjybysWWsVr6McorAdUziDq6+mzl9FffQcY6UK50SR6NKs
         1frR/WPjxWanFJQK0HpJWWwzkUeFdPfGcn69HxGkuKcC41BzkC8f5zE28Jw945NWyTA1
         xajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757316122; x=1757920922;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UqKOdD5po84tcrN8SKOhshxoNPwLNVkwMMwYt2v//JI=;
        b=ULBt76WIUKP/3mjvgZKNY9KqcvQfJleDpMPYLdA6Su0vpf7xk2YCFOo+d8fLpaonOi
         OEO0TsRs8jQCC2LDm2TKwe2xzS09mMcCyDkG845aB2X4pKckuy6EWfzktJi/BwAeYAOt
         7kmBCn/xLABa50mPknjqMUR9cAZVOplmHXUE3EAmcMpM/wUghrsVKUwm6iITtr+/pYoD
         Z7QC6v3081BCvg/7ZecKz7WzRlD7IRrOMPXLmQaVs6dLtWICSo//L68oufgY4TZM3JN8
         tt592OwiPu22KakDfiZBysjW75VLuaKLpTTVM3K/QYcL1wywJ1JQBaD5uG6RAis2NUKY
         xJgA==
X-Forwarded-Encrypted: i=1; AJvYcCWkPlS2VMmNgcenInMpQ6Fg+uKWsNDHXEj282QoTCfHyIi6hoszD4MzRfG0Ff4Z/o9Ioe4uPa2xiEXpd0XnwvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGUttIodQ0Uxk2c7PH7rNcpzj5YHjXkgvM5hth9T/KYZCaUcFB
	FSpjH9Chxw36/aEX0PBr8bzmeeOwtldPva88aHDZwDI6PZrpauz56mbxdeiel7BARUFISw==
X-Google-Smtp-Source: AGHT+IEtnsRyHcoGTt+JZUtAP0WZUcirkzCVRs4Uj7nWACizvc97iPwwuy4TtxNpq1Hqrq5u4pWViRE=
X-Received: from wmbdv20.prod.google.com ([2002:a05:600c:6214:b0:45b:66f9:1aa1])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:45cf:b0:45d:cfc7:a16a
 with SMTP id 5b1f17b1804b1-45ddde9222amr40573845e9.9.1757316121795; Mon, 08
 Sep 2025 00:22:01 -0700 (PDT)
Date: Mon,  8 Sep 2025 07:21:52 +0000
In-Reply-To: <20250908072158.1041611-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250908072158.1041611-1-bqe@google.com>
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250908072158.1041611-3-bqe@google.com>
Subject: [PATCH v16 2/5] rust: add bindings for bitops.h
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
index 0b2d800d8ae5..5654a5277df0 100644
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

