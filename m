Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A19213E83
	for <linux-hardening@vger.kernel.org>; Mon, 26 May 2025 15:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748271713; cv=none; b=R2sd1jWikOvdDweAXaJQzGCfpE2UfKu6z1jhjj6IRck/e/S7/rKsKVS8Qeo2YshZsaNvcAyJRRghoLCsn3WD3fV2qZJYGaODvbxLHQF1bIhN9EmsfcusoHkIH7OzdOxfOUVmllxoa2jjRlK/0SBEENghvEr6l8nZHOePsKF0Mw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748271713; c=relaxed/simple;
	bh=Q/2BsgKz24Vtl8wIJjkgERERw7Spq2sdcAdXYaotMo4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mJxBpRhVKbFks0EQMQCYC8k8ddw+gBpxU4hoZUMi/rVxyPjLtBH+d+3RXse7MklTkB+/xOvMeUTXiWGgscEtZC+Dc+lfOJ4wiqSnPuqlq/DgxX/LUBA5VmMTLUb9xQXiU4h9S0bc1XG8FhtaXNQJermyGLIhZGFNNgCj759Ey7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rXpMXMNC; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rXpMXMNC"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-44b1f5b91c1so17700955e9.1
        for <linux-hardening@vger.kernel.org>; Mon, 26 May 2025 08:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748271710; x=1748876510; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SQP6Td3kWKuKqRj2KRN0QM8NzsKBYR8G0PzCVMLQtO0=;
        b=rXpMXMNCRtVViQQQRMQzlPtVX83D2sQySp8RhV4IFmLEePQCctFa56rCyH360pRzrR
         iSWOuZyVnUX5bEgVKIAgDdcOGxqfdJJBZDsuWDaPut/5azKJx3aKoDgQPlituOJjfYv7
         oQCay5O39mI8dkBY1Tuw70Lcu4Yfa4F7c3CQbvLrNtLc/Ipjknbnmg0MyXNjSiLVQHZf
         XJsr16sJJ7GKyzBUcLsfAhLevkmUfimA8gqrVkddKEIgZPKTLy2LwFXoHOIbWLjJWUPY
         Z2c1Kg8VDi97RPpyUrnwchuUSFFIKVYkgZD7zHOw14EHLfn2dnO/8O2+kemAipFRfsM8
         8LVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748271710; x=1748876510;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SQP6Td3kWKuKqRj2KRN0QM8NzsKBYR8G0PzCVMLQtO0=;
        b=JPMryk0LAXjH2Q5BQibeTeZ2YnJArI0nZUKSKRg+o66xzYYz53RJbi5xS/I0fI3OlG
         1mAePQ4zkA/cy6/8bzVmfDvIzu7pslKky7N64eHJHpS0hU9801o/5CfHSRmEROQJmHW/
         opL894gjp7bOktwaEEuVnXLpVpdlMXTI7PGPmLmWAfm8LhX8MMGnQPqLqXCipby2mbm1
         E4qPOtYbecpIwTh6WirTF2pr0nxrgiYMjId5e3eD41XcrJ3b04niOd1C0z3nwphdeirM
         5w4MisIXV4U8rQSO3iC823fzvVIHhmrhVXv+R/KgJRGmDSHaITdv0ynZyXPjMS6eV0Fk
         DwFA==
X-Forwarded-Encrypted: i=1; AJvYcCUhDaafwUYMryO9Lv0qvYpFfT2ppquGc+jlppdDfbtuwg6R4qlRe3lz9Lilig9rAp+58UjPxHeyoSEFBXsaglw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj8izRuRyCljc6qNc0PjyJri9mukxwBnCV6DCCtog2+jCj9aKp
	TqoXzvWNDZgYj6DaNvfUmjhL9giV24vWPrRVcc18uW4WFf+GeRFu+V/kHu3jO0lfcla31w==
X-Google-Smtp-Source: AGHT+IG7bMDz+nyV21aR+cR9rz6T4gu5RRq0QfvbqOxOM4k37bGT04jZzRz8bA5euIEZI5NyPC9+hsM=
X-Received: from wmrn43.prod.google.com ([2002:a05:600c:502b:b0:43c:ef1f:48d3])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:5396:b0:43c:f63c:babb
 with SMTP id 5b1f17b1804b1-44c91607264mr72968455e9.1.1748271708454; Mon, 26
 May 2025 08:01:48 -0700 (PDT)
Date: Mon, 26 May 2025 15:01:31 +0000
In-Reply-To: <20250526150141.3407433-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250526150141.3407433-1-bqe@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250526150141.3407433-3-bqe@google.com>
Subject: [PATCH v9 2/5] rust: add bindings for bitops.h
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
index 000000000000..1fe9e3b23a39
--- /dev/null
+++ b/rust/helpers/bitops.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bitops.h>
+
+void rust_helper___set_bit(unsigned int nr, unsigned long *addr)
+{
+	__set_bit(nr, addr);
+}
+
+void rust_helper___clear_bit(unsigned int nr, unsigned long *addr)
+{
+	__clear_bit(nr, addr);
+}
+
+void rust_helper_set_bit(unsigned int nr, volatile unsigned long *addr)
+{
+	set_bit(nr, addr);
+}
+
+void rust_helper_clear_bit(unsigned int nr, volatile unsigned long *addr)
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
2.49.0.1151.ga128411c76-goog

