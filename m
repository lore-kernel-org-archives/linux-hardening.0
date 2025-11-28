Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614982D63F2
	for <linux-hardening@vger.kernel.org>; Fri, 28 Nov 2025 03:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764301128; cv=none; b=uJSBn9z+Ulmwdm3cguGqNotL7Fmn02dYbF/rth4JdxMEzPaDTt/awF+4aASXxP8+vsWa01I69qAOd//XnsCfQaVg7acImKsD8+k8HlipTEI84qKbJzeAa0Bz5rYjnik16cnZRytONH2tCUHXGbz00Io62Ve9i4vkCaz8ydMSWyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764301128; c=relaxed/simple;
	bh=sMBKDRD+YrHinlsLvurDgItZTjpQeHNXx79vuRmCgYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B9mnsaewyMsnVloNsKxZopkKYocPPJKrbQEbXB8XgN9TAmTTkeiGGq9SFyhjS+CLfyd0/AkZbw8t/8jJxBwzlXaQ6cNkdomW2lvyF+w6k56VLYVsp9xHOv9wgqzHTb3fSOSkrLUwf8iQjgL+/1arLZI7JDDQ8sCTEQBL7Riu1uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsE9pO7+; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsE9pO7+"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7ba92341f83so2236522b3a.0
        for <linux-hardening@vger.kernel.org>; Thu, 27 Nov 2025 19:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764301125; x=1764905925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ziPHSW1BGt5FHNc124Rg2eHBj/FnR6+g6Xe4TDQvAMs=;
        b=XsE9pO7+3hC4OUrS3lHJ1mcWQzciCp8FxN5yTW6fQ2zOmHGQ8M4oH8fuXsVJnvPpy+
         l+jZczkVnHGCrcMtMK2riiEK51+JVoo/HJT9M2K9YLAX8FdOvYONfeAHTDB4UZI94FTj
         EGrPs4eFgprrDVautjaQJTiVvCtD3P8XZkKXpxkY40rjS71FniRPfzFuWyCu4e51M287
         eDUXdYjQdY4ZTxQSwEivf465WFHBqFqRufrLYdK9W7jIALozHKVj51UopAJ+2zHrLQoa
         W8bUmBlY0BUQCMwSiIY3NVlwZFCqOGrQxyhwE5oKmdm2ySwoi6MBgkEDd15CGPAl8J7C
         U6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764301125; x=1764905925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ziPHSW1BGt5FHNc124Rg2eHBj/FnR6+g6Xe4TDQvAMs=;
        b=okdQHiKYVPcgHEkwxWiz/29JXPaDtCmkWGr3iHYdxfXAiZkbRLLfoP1+bkt6YY1Ah9
         KHqXYgv7NeHNFDkwd/LP62Jv0zlcBztLARQpGmxIg8cgcLtdDgfK1WGeKbL7v6fllRxf
         +XgXL5+/1D5EbgDAjzc9WYJrk1JIAVqRnv42MvC7yU2LTrrH2uNG7r6+Ocw94OEFIxTN
         YcMeRycHvT/w+aarbbBhcExSmyMbZ+LmnMiyE6kUtl+O1Yi161r6O1ZhrdQ+2BtAcdFT
         1nPcmzaf6EfiZ8OQU2EIWrYQZCr++i4c0yfU+/et1qJPdeWj59T3eA+Q7xrSmWL2nErx
         CF/A==
X-Forwarded-Encrypted: i=1; AJvYcCX7U97nh6oQDUkgb56vb9yn3EOXbyzLs0JwVgFbo7iHtqeFN9o+WVLQN1D07tOGbORWPqMUgSzp+iVyZWgUwbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBjip33r9YH763aQBNATuPN23tG6bXeZ1I5z9nCuWVWwJSXFhJ
	5ybpkNxv2FNjqVgdX+NxHVmPQ97aSFbBdCTgH6Ko0DidcrNIiMCoau88
X-Gm-Gg: ASbGncvNWgXEAVvE6CtngUudXHgKzjlz2MVazyIBlBuMOi1xq2t8dxj78kMOtl03/oZ
	6/Y7lsII9BzaQa/ZE0H7/Lt97FTFL7soALjDZ6NXo4hOEjqfWDSLO4gp05/wmaWiFt5efq1Snrb
	DPDU/plqkJJJsynidUqnP0SK3fYubhbg9lbUXXq2bU9GkE1o/zRbVngJuc4HI0D2svL8VXKlKlg
	iYnLL0hG+YTF3W2Cmh0CYAAb7RXPp2YuHJ0uz0kHKvLY6nqNyfM0U2/3uMx3f3O1V5B3S25OWjc
	c7Ysq+xNMi++4MoT82kq/vIRuNSFF2q1ugnLbYnj88hreELV9bg2O5mLPomnfCb58O4r1AuNWxn
	aFpavSq2U77ASCEjhMz6WlQW/cXKulJVwZXEQQ3JqgcO5xNWGiDvYyTmu+WmTOwrfglI0CcYpV8
	Y/z+lG5Thk2R6M9qQ8zThx50SX3IjBWurQk12cbe30Uxo=
X-Google-Smtp-Source: AGHT+IFt9EDm0A4kR/jetSc5ONCPPaPv+xOssujZest1xVvCRUMsS+sNCTakUIo6Ju1tul/uNkazaw==
X-Received: by 2002:a05:7022:62aa:b0:11b:c1ab:bdd4 with SMTP id a92af1059eb24-11cbba4ab67mr9193598c88.38.1764301125421;
        Thu, 27 Nov 2025 19:38:45 -0800 (PST)
Received: from ParadiseLost.localdomain (lohr.com.br. [177.69.253.233])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcb03cc7dsm13999469c88.5.2025.11.27.19.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 19:38:44 -0800 (PST)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: "Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
Subject: [PATCH 0/2] overflow: extend shift helpers and add size_shl()
Date: Fri, 28 Nov 2025 00:38:28 -0300
Message-ID: <20251128033830.331426-1-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

while experimenting with check_shl_overflow() on an architecture with
native __int128 support, I noticed that the helper always reports
overflow as soon as the promoted type of @a/@d is wider than 64 bits,
even when *@d is actually able to represent the shifted value.

The current implementation always evaluates (@a << @s) through an
unsigned long long accumulator:

    unsigned long long _a_full = _a;
    *_d = (_a_full << _to_shift);

When @a is __int128, this truncates it to 64 bits before the shift and
then checks for overflow against the truncated result. As a consequence,
the helper cannot reason correctly about __int128 inputs.

A minimal reproducer looks like this:

    __int128 a = (__int128)1 << 80;
    unsigned int s = 4;
    __int128 res = 0;
    bool overflow = check_shl_overflow(a, s, &res);

On a toolchain and architecture that support __int128, this reports
overflow even though __int128 can hold the full result of (1 << 84).

This series introduces an internal evaluation type selector that widens
the accumulator to unsigned __int128 when available and needed, and
then builds a size_t-focused size_shl() helper on top of the
existing size_* family.

Patch 1 adds __shl_eval_type(), which chooses the accumulator type based
on the promoted width of @a and *@d. On CONFIG_ARCH_SUPPORTS_INT128
systems it uses u128 whenever the expression is wider than 64 bits,
otherwise it keeps the existing unsigned long long behaviour. This keeps
code generation identical for all current 64-bit users, while allowing
callers that use __int128 for intermediate arithmetic (e.g. 64x64->128
products or wide offset calculations) to benefit from a wider accumulator
before eventually truncating back to a narrower destination type.

Patch 2 adds size_shl(), a saturating left-shift helper for size_t that
mirrors size_add(), size_sub() and size_mul(). It computes
(value << shift) and returns SIZE_MAX whenever check_shl_overflow()
reports an invalid or overflowing shift, which makes it easier to build
higher-level size calculations that must treat any shift overflow as a
hard upper bound.

Testing
-------

  - built and boot-tested defconfig kernels on x86_64 and arm64, but with
    few drivers/modules enabled in kconfig, and
  - exercised check_shl_overflow() with 32-bit, 64-bit and __int128
    inputs in a standalone userspace test.

For convenience during review, a small userspace snippet mirroring
the change is available on Compiler Explorer:

  https://godbolt.org/z/5dq413d73

-------

Feedback on the approach is very welcome.

Thanks for your time and review.

Best regards,
Rafael V. Volkmer

Rafael V. Volkmer (2):
  overflow: make check_shl_overflow() 128-bit aware
  overflow: add size_shl() helper for saturated left shifts

 include/linux/overflow.h | 41 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

-- 
2.43.0

