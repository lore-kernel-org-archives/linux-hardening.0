Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E441221FC6
	for <linux-hardening@vger.kernel.org>; Mon,  2 Jun 2025 13:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872382; cv=none; b=s8kt+n3mUj/hBA5V1Xipse26/cfQWLPYEpW2xU/54gyS+Iz/HTsYLw7+KDo7VPvxsyCBunXQTMWgibfTz0qoqAnYTBn0/H92XnNSKHXosXznHIwdgi91+JSTrJogQs3Ckn4LhiV19BWXfpGwSfZCtqY/xn2sRSHYB4S/A2+jv/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872382; c=relaxed/simple;
	bh=E/w79vVPcT3Zr2nhL4Sj2w1AZemSgO2OaKw7xSVzVdY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qczSUNZCdQGxG+GdT7Knsh8j8p42OXHr/TvlA0ziJG+V9SoQbdrl9yqjPY4tVPylgtt2ewR9K4DwQgRk8FWaOUsfLVPGU/oAlF1X4BYr2xlFQPGKvg147JC14qTYQEkcsY0TtQdDrcvMSjjM/wx4/R9Wr1Orf4pJVc1JWj+tCEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uBcLQbx9; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uBcLQbx9"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-451d30992bcso13068985e9.2
        for <linux-hardening@vger.kernel.org>; Mon, 02 Jun 2025 06:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748872379; x=1749477179; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1xsZ3bzHWEHjMHqu05pw0LNNFT3NBkPT2T7RuaKPsqs=;
        b=uBcLQbx9FSNGir9grmKF2rG6UinFWYUznPM7Ayfon1IloGfeb3ATeSYYMgO+nR+uOr
         slrBWGTRbuXNnojA3wd9sNILOB7EDTzdSZYbPvTttlcbK8sJiMzlpEeJZ4Zn14SQ+F5h
         Hp1Aq+U3694HUKpcOKncUus/Sl9vYsLS+iMlvS11iCTs/5z59EHqX1Cd8W9nuGNyVAe5
         d3BLXB6cKvnUDfUHpqc6mmFknnk1sj7pM+NUk59Te1u1KGtKXaXNK4DywCAF4Vr5u9dT
         1DsD7ikwvoMGiXOBE06zr2YlJr5FqG+wnWX6UpZ6ch3qqunof+NTJ1PGOh0ssca4WMQ2
         u5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748872379; x=1749477179;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1xsZ3bzHWEHjMHqu05pw0LNNFT3NBkPT2T7RuaKPsqs=;
        b=Vs5GSlQFebU8uC5tFTn5kqGjHyYoCMe4BdKEP4gAhkw4HJjmtgc8GhmHFAbLyfNUuy
         FEQ6FSL9MuTCVkFtgSnhn06g73CqqDn/lS822rdBrcRy3kXcto7dkFqyVW2aBhfCdGdw
         yVdfRwZPunl5fgmEdeecXlN4wIMaV28Otei179VogYQ2p5QQNJm/TxUsgxX64NaTfLPp
         jXoHrRlj7f17kEswhkryR87vX1zS8GdO8STpKpnrQI4xDn9PjWan6YbHjJIsAVusRpy7
         DJ/d6a35fI4s3aNZ/o5NgZsssXfqCq5QNkhipZTR9n+VkvrmrSL15ZV8zEtZC5YO++Z3
         o96g==
X-Forwarded-Encrypted: i=1; AJvYcCViL80kDRHxocUkTLupjTpPzUaSn4Gto5q8mB4pD0WvSdRYQBf7ymuuCC5DpEUPAmBibI5mfXND2vQn2PsJC0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/x1e1DMmnKSQdM8LWzDskAYsKiuc6sHRhEApvOazItcYDiPUO
	VDYpcd2zCZ+bchqw14+z4WzjXTopSqVSNSYCHL/j/ZUY6fhqf/eW+fiTKFGzIsLG/RiW7g==
X-Google-Smtp-Source: AGHT+IFmvmpnVAdK+2e8GSPcIsFnZ0jz4m/Gy31Tjyp6KvkwcGJYEAf0zgXtlzRPd+l2zDVho2/khhM=
X-Received: from wmbeu8.prod.google.com ([2002:a05:600c:81c8:b0:43d:5828:13ee])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8b81:b0:439:643a:c8d5
 with SMTP id 5b1f17b1804b1-4511721466fmr87336075e9.0.1748872379549; Mon, 02
 Jun 2025 06:52:59 -0700 (PDT)
Date: Mon,  2 Jun 2025 13:52:21 +0000
In-Reply-To: <20250602135231.1615281-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250602135231.1615281-1-bqe@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250602135231.1615281-3-bqe@google.com>
Subject: [PATCH v11 2/5] rust: add bindings for bitops.h
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

