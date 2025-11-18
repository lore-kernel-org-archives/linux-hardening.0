Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5313413AD26
	for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 18:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763491825; cv=none; b=mNKdt9UerXtwByjabA+vvi4765nnyClcCBN1Lh3rKrx6516mPciFPR+Ac5XDJ4+4D6sZrX8E8ikhMjwKX9unhSef6Qn7CXfKkgvewTdAO98uiGSDX5KWeEJuZzzwrBI6bAm4bWOJydFHYyvs37msGGTHRHvdO3ePy5jqzMMfC6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763491825; c=relaxed/simple;
	bh=AYPrrrYZBTxt5Qn9qGRaZZ1p1f5BM3fWOXxV3cGpShM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GOT3n8mhpTCyW3ay4u9AwfKGy9gTx9cHPWCR9cOTL0rNlMcGaQAKma+kz5ZL1o50PEmzECY1ZKdRR01+N7m4PxqQeVbCL+ZaewKB5S6nyWKmzu4s6m4kj4l13iy8HCGZw4lsnQOMEochBncCAsCxYEe/vFYXBLopAWzbePeFiJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9LHAjAt; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9LHAjAt"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso4662430b3a.3
        for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 10:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763491824; x=1764096624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YoGkWLSjBjO1ypEJKf7VcOJ66Mr7RGgnB+IVecGlhdQ=;
        b=S9LHAjAtgU8vZGmuA+TnGihg82KRT7vKDld224XwtymMn4ATRS8EbfzqMG0R96a+j+
         J1az/Bf1rUsJCCdUuUXdBGoI8tEilXwICEyVlJlz6VVjSbYNQq5D8F0P1iKmegW1nX9C
         S4mVBZziCDH5FMafM/93OjFq13vMvnh1lUu+CZIUZ5zt+uY6MUCLGvLRD8PirWjzvBv9
         aeqLifT3HBr1QYJzeIb3gXOkGvu/hL1jSzzl2UGJzlUVt0zwwXjbY3g7VRrIYO+5/SZx
         CLyqB8NGqtJZn0pNSTag7UZI+UVABL31PVWTKFddLYPZz8i+9ACLbXaS0TbRFpot9+mo
         UNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763491824; x=1764096624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YoGkWLSjBjO1ypEJKf7VcOJ66Mr7RGgnB+IVecGlhdQ=;
        b=Bru9fohr6x8OCnkDH+ddPlZJqQo9/ZRZBfCQPrLZ7Rr1GI5M9e0LINzmvAQVbhKtV1
         jsDOMIemDGsboQn+odzmMW8mtmuwRd8ovw4mZQw/ajiF07smsKzMZfvw6MtgMhT5pJaw
         2CG6S7skI0nZ9zbU2W/MiBc1IzlY+7FkiRlG8IOXNFT4BUhzwE4yZ6D7ZZzkZXP9N4tb
         fQNc8j7zo6qi6GhqDaY/Y1hSgEHFFBisk2sqsJgbY50bqAsdpIAkQz2Imf3yd7iAE/yw
         qd6wjIuPT0AxjaH9+VqstPETjD5/bHU1rFB9qFIdzShdFA8kZPWcgJaaJno46fqHLwp5
         z3ng==
X-Gm-Message-State: AOJu0YwU1hKEe/bBSPJOs8mpdk/P5kp1oBy3XH19y4RY2RKyj+x9p8iH
	E5xQgBtT90xOrAzAl41XgpgUrqQLrzEHIycqG0vOzEVp5/oXx9l+n0MWV4VkMQ==
X-Gm-Gg: ASbGncvAKMbS0BsJO8k0TPvtKRfcmuZFVNLMC6v5558WVyCegGHmYxcbA44fzqLYSP2
	V2Av1T7cG5Z+u6j2W4v4eovcjx6Z6yNzdY+7MyC5UDAc1AMJKc1xX79zTxkI+sR9ItWp6OVSSvM
	7K0Ww/SQ2Ph+bA4neBrGOyLz1ytW7zHW/qixYVtBhyXjtchFROOiU1XskII8ZQdFqSFL6CK3QHi
	fTrf12zJm9zLIPDLU4qLtX54zNfQ5Z5ug0p4A2v+6kT52dWZ9KL7Uc/XrI1PmE2xRMsQ4li2Gpa
	gxuuJ/Lw5e2ZAxCfEvdNhG1tGANqjQwGIoerZFjLMBNYkVvo/pKDh5BPU+b5CgRqkGGwAELhJ2c
	vU70NpFjaP2zX+D4KLgXpRAad3kAmHD4Oo82tC/1zs1JG/jEb81W2aWFvu6kD1Ylidwf9dVd2XP
	VZ8tP+h6STIYbFKFFVftBDFxWUdRg=
X-Google-Smtp-Source: AGHT+IHKj0xN/ffzmo6eAaRuWy5yIRvqqs8XkJI07UqY7rBxfV+ZFN/LfvyZUCo2LwYW4KHQCYFyXg==
X-Received: by 2002:a05:6a21:3381:b0:35d:ce99:cc23 with SMTP id adf61e73a8af0-35dce99ccc2mr14545942637.49.1763491823564;
        Tue, 18 Nov 2025 10:50:23 -0800 (PST)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9250d24b9sm17197966b3a.17.2025.11.18.10.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 10:50:23 -0800 (PST)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: kees@kernel.org,
	andy@kernel.org
Cc: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>
Subject: [PATCH v2] string: Add missing kernel-doc return descriptions
Date: Tue, 18 Nov 2025 18:48:28 +0000
Message-Id: <20251118184828.2621595-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While running kernel-doc validation on linux-next, warnings were emitted
for functions in include/linux/string.h due to missing return value
documentation:

    Warning: include/linux/string.h:375 No description found for return value of 'kbasename'
    Warning: include/linux/string.h:560 No description found for return value of 'strstarts'

This patch adds the missing return value descriptions for both functions
and clears the related kernel-doc warnings.

Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
v2:
  - Drop strends() changes.

v1: https://lore.kernel.org/all/20251118180008.2620929-1-kriish.sharma2006@gmail.com

 include/linux/string.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 929d05d1247c..0eba937f441c 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -371,6 +371,10 @@ static inline void memzero_explicit(void *s, size_t count)
  * kbasename - return the last part of a pathname.
  *
  * @path: path to extract the filename from.
+ *
+ * Returns:
+ * Pointer to the filename portion inside @path. If no '/' exists,
+ * returns @path unchanged.
  */
 static inline const char *kbasename(const char *path)
 {
@@ -556,6 +560,9 @@ static __always_inline size_t str_has_prefix(const char *str, const char *prefix
  * strstarts - does @str start with @prefix?
  * @str: string to examine
  * @prefix: prefix to look for.
+ *
+ * Returns:
+ * True if @str begins with @prefix. False in all other cases.
  */
 static inline bool strstarts(const char *str, const char *prefix)
 {
-- 
2.34.1

