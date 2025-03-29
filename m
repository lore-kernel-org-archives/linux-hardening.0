Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A004A156CA
	for <linux-hardening@vger.kernel.org>; Sat, 29 Mar 2025 00:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743206635; cv=none; b=M69sMcV5BOs+Gpp423EonRSPVEhHbfqJXhXccg++YyieNSPR7dm0f8PG2qQUdw/nT3Vh/qwCngGt2yEmu4/FfOZ/bb7/VMgEwgLJ26zgj/51A6e0irco34q8RvKP/QgqhxEkg+9xc3YnuIX/ALrTysuvTcbaJ2cNowvAN67Uq0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743206635; c=relaxed/simple;
	bh=0GH03YEIRBHpcTs5EQTf5tRjGOZhfj5ycrE7WqRiMdo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=duOnLrHc2PeDn7ZAIXa8kehSEj37MJDgE6IxyepmbNdlZnnC7i/T027Z4bXAI/t4qZmnlF4EGG1Hdrb9uWXSHNoP947Ym0VYDi79kmrfZIgtreM6q5ct3v4tF+D+XkwFfmuAwk/PuF8gsI6Qm9xzI9Qp1+FTwXQVWmUIfiz18nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uRxFww+t; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uRxFww+t"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2241ae15dcbso57944825ad.0
        for <linux-hardening@vger.kernel.org>; Fri, 28 Mar 2025 17:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743206633; x=1743811433; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tGMonBDCtHbGxccj+//vlpjOsUsbEFJEDLrw6ctd8aw=;
        b=uRxFww+tlYNsYYB/x9abq3jT5BxzIRaJUYOfFllDJWB4ChJ2ynmwPT58DCh+oCPC0f
         /AGtzjTIL16uwwjjac9W8WKj80GqUMTR5U1Xa/JL30HNwCzN5Po2ReqW2JpYsah1BT2X
         bV8C99W9UuKAtbUgsJC7arwnbsTmvOGe756H+JQRtw4tjfrCt1x266jtMuPNkHFGiHbl
         7x6Vbij036Kgwn5V/vxuKXks11Dp5feiddn8rEQm0WKaHjof3tqdLL06kTtbUii6avWh
         3W+hnXJbZuIKCGnefvmF6gOIlJDLYDlTeb2dvCXoJUYH1p8xRfAGuBdTe6rV/sosUQWE
         KUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743206633; x=1743811433;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tGMonBDCtHbGxccj+//vlpjOsUsbEFJEDLrw6ctd8aw=;
        b=K+Y2imFfH7xPZA3jjEJOiAkmlxBqaG5xAL13E0wkGtRtYaz/JN91Jus1m/gtEpXRO0
         lQGbM2pIBAZ/MelvEi7DtwQCpNnej3MxnQNiIZDEDWcYcZR7O7Bm2poe8xF3A7HCNHfy
         xA6oIoXEGM62pCB/R0ZE1QU7gFxJ2VvuDoYzh346Vl4Csgi5Of/wGislW7eqxR/+bPof
         L+5oN+zWB/LKlTGSsJ3NT8BrugkHXdEbXHDQxj9uvF3Pi7SJJHqrgLK0UylF0WNQZn+Q
         AwHrV7mc9Uk4/5MIrLY+sApslVcVZrkV3NPAJEINuhERxMENwTRN2+cAhwV3QWy/sbcP
         ov+g==
X-Forwarded-Encrypted: i=1; AJvYcCXcltsRpWjkHugdqIhEtSSYGQg/lmPsXfdixsMVr8cDF/KfLUpXj1dFEefNwApXbDKS7A/dmydLb75ZxIxIZkI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/UtvemaY8C3pRHK3/+e9yeWEpFcChfjxXJvucNr8/nMPnylSh
	ehjjy2oAZ7NKzxttd2I2yTv7YoS5O09U92YpN/0eeOnFOZP0FypjZY1XWqhLikxXlA==
X-Google-Smtp-Source: AGHT+IG1OCkWK6ACc2gjb+axSi3OGauLJByZEq2XzaKVmUmtuGmaBnSVPaf+lB7MT0QcfgqXjpACp1o=
X-Received: from plrc9.prod.google.com ([2002:a17:902:aa49:b0:229:2f8a:aac5])
 (user=pcc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:eb8d:b0:21f:564:80a4
 with SMTP id d9443c01a7336-2292f9e5139mr16353845ad.33.1743206633220; Fri, 28
 Mar 2025 17:03:53 -0700 (PDT)
Date: Fri, 28 Mar 2025 17:03:37 -0700
In-Reply-To: <20250329000338.1031289-1-pcc@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250329000338.1031289-1-pcc@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250329000338.1031289-3-pcc@google.com>
Subject: [PATCH v4 2/2] kasan: Add strscpy() test to trigger tag fault on arm64
From: Peter Collingbourne <pcc@google.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>, 
	Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

When we invoke strscpy() with a maximum size of N bytes, it assumes
that:
- It can always read N bytes from the source.
- It always write N bytes (zero-padded) to the destination.

On aarch64 with Memory Tagging Extension enabled if we pass an N that is
bigger then the source buffer, it would previously trigger an MTE fault.

Implement a KASAN KUnit test that triggers the issue with the previous
implementation of read_word_at_a_time() on aarch64 with MTE enabled.

Cc: Will Deacon <will@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Co-developed-by: Peter Collingbourne <pcc@google.com>
Signed-off-by: Peter Collingbourne <pcc@google.com>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Link: https://linux-review.googlesource.com/id/If88e396b9e7c058c1a4b5a252274120e77b1898a
---
v4:
- clarify commit message
- improve comment

v3:
- simplify test case

v2:
- rebased
- fixed test failure

 mm/kasan/kasan_test_c.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index 59d673400085f..655356df71fe6 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -1570,6 +1570,7 @@ static void kasan_memcmp(struct kunit *test)
 static void kasan_strings(struct kunit *test)
 {
 	char *ptr;
+	char *src;
 	size_t size = 24;
 
 	/*
@@ -1581,6 +1582,21 @@ static void kasan_strings(struct kunit *test)
 	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
+	src = kmalloc(KASAN_GRANULE_SIZE, GFP_KERNEL | __GFP_ZERO);
+	strscpy(src, "f0cacc1a0000000", KASAN_GRANULE_SIZE);
+
+	/*
+	 * Make sure that strscpy() does not trigger KASAN if it overreads into
+	 * poisoned memory.
+	 *
+	 * The expected size does not include the terminator '\0'
+	 * so it is (KASAN_GRANULE_SIZE - 2) ==
+	 * KASAN_GRANULE_SIZE - ("initial removed character" + "\0").
+	 */
+	KUNIT_EXPECT_EQ(test, KASAN_GRANULE_SIZE - 2,
+			strscpy(ptr, src + 1, KASAN_GRANULE_SIZE));
+
+	kfree(src);
 	kfree(ptr);
 
 	/*
-- 
2.49.0.472.ge94155a9ec-goog

