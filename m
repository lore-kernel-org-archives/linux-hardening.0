Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBFB23B618
	for <linux-hardening@vger.kernel.org>; Thu,  4 Sep 2025 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757004623; cv=none; b=sYTEuarAavtxlXEzXFVL9xLo8PmbldNGe62nkSZ5vHOPEPkDMgONirk38/WWPizbFCWukmA4ZeCMu2end8HkppOiF9LADV08BwyT2wdhN7J83DZ8Ix89aZRGc/OfDROju6rd2Owyi7UiAwRxP0WeSvFuPmhLasHf8iYKxwvxdJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757004623; c=relaxed/simple;
	bh=UTmCdn/FzjnodmTcSXD82eo8JigSTdbjwunFXeJNyqA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EKcwGfpYsaHx7bG/HQYLNhf6ghlZeK/aiB/b6JDHhT49SlxCo2vECaGgYeBDwzP9t7gfwscmD2SCanL3TBSxm8GcHlqztUNENVmW0vCazpnWXbLhjFMr5Jo3blks6Wju0ZHWbYI3UPrmu9r1Yli/VNz7lCJMumhwxCmNXtasCCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iGysncjB; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iGysncjB"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3cd821eaac8so696552f8f.1
        for <linux-hardening@vger.kernel.org>; Thu, 04 Sep 2025 09:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757004619; x=1757609419; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BOSnFe1ei8q7hQMHyNdWmjuvcJ60+O1jk5lk1vh7ZRY=;
        b=iGysncjBzFmAn421fFKHs+npwjb9SAZbKaf5lJB/lDK9iwdsGSe16PuHNar3KUarRB
         yaha578JjkR2vxeUTCo0LS+tv2sSMNetQj1WsOh1xhtkGEqeiwiVzMji4yCuI/Lphgl7
         zthonpE2PKxKfcQLysb1yer+uecWHe8xuAvvjn8MWo5VTpuyd7qOWsCFwIfRJ4y06DMY
         1+OmEgDUUc9hnbi7Q2CrmnwEEUUhGNEZL2ct4GqF9Kh3FSr0OVRRhra0BNpUYgkdenzU
         4mJvheVk5CFM70GPTEYkJ7U/d02lb4hAJWbjpytukS5nLu9uJnydMZ/UokEISIlzBWQQ
         64qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757004619; x=1757609419;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BOSnFe1ei8q7hQMHyNdWmjuvcJ60+O1jk5lk1vh7ZRY=;
        b=Nm2kks4ogE4fW46yWFIAbch2GP2zL1cMALQ0XCtTg/ceWmYyKY9rzzN7750rxphyhG
         DDtjMfFfobbsJwgc7YnOXysFu5V5vzlsW4v/h35jQIp0WYoZdI1I3b1wQE0jsF0X+REE
         aoUW7Jx+HdBlaXPS3M2dw8o8D4D0HCZMLdKcC1+Eh1qVYF7mMOBrF1sN7Gajcf62rLhz
         sr6jb+9Hv0r+5C5urNqSVmzJQqqsE2iXsgla+hDiE+kcVweaQAG+8wJ56DjJxLdq4wdM
         d+lZzAMP9QOfbOI9Ri8OYSpcOwlrixjcwNaDavWrOvUWmc4qUl7cUy2KeARYYCuOIIBK
         WdvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0dmdNpSr5NH6LVcnsl9dsQwbcTVHOr8IonE/Z0lQOTzgNqE7GfYtkLQcYqFjZauZwA2hyxJKHil5zFfoG5BY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqrhZR51Sd7PJnHq1kE/9ejmF0mn1nCSTpl4dPnn0lS8QMLfUa
	4u07ZBnCo8vTcUZsmjRRw0YPBj9YfvRe2sCKPVT+SscUEN32I8ipnd1bX9+JddvTYiniog==
X-Google-Smtp-Source: AGHT+IEb26DBkGhwW+Vc5w8DUd4B4+rbVfmalUYAE8JPSvISa1+76GowtJNLQIYYdwkd3FvAJD9WwFo=
X-Received: from wmbiw7.prod.google.com ([2002:a05:600c:54c7:b0:45b:8a9e:b2a0])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2481:b0:3e1:219e:a74a
 with SMTP id ffacd0b85a97d-3e1219eaa1amr2329986f8f.21.1757004619513; Thu, 04
 Sep 2025 09:50:19 -0700 (PDT)
Date: Thu,  4 Sep 2025 16:50:05 +0000
In-Reply-To: <20250904165015.3791895-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904165015.3791895-1-bqe@google.com>
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250904165015.3791895-2-bqe@google.com>
Subject: [PATCH v15 1/5] rust: add bindings for bitmap.h
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
index cecb0419a537..c1d72e26fba8 100644
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

