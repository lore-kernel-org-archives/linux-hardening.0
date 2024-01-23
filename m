Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE7D56466
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 00:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970158; cv=none; b=rBILd4vE00eV3gDl6OU3zrp6ThwS8/aMyulfxCHVkp2LN+/Zgym2CduXdSKVjZ/ZbKijrWDnFIFHF5W1X60dbvbF06QDqfkC637mRoQwSzu2lJ5cutNKAZ9R1AYDCpno7rTm0O46O4/FXQpeVvIdFa4ECim4aTB6361lk9Ca0sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970158; c=relaxed/simple;
	bh=KmdQOHR2wQwwvdbCWLH5gPumh1btink3RoAuAjMZ63I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TS7/LvrcPF5t1GiJ1Fnz7ll1UAx6dsriisbqHvGhZadHGwNpBGkS0QdWypFKcCWxf/Cg553tNGx/J6Di5+roz4azNkK9ZO3SyNQG9DrowTUD9ROY75uttCWTaRhh6+1kCEazzXHkQDfOC7JrcqgfzlNO1FBETr5StizyQwx6uoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G90jh2L+; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G90jh2L+"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bbbc6bcc78so3236613b6e.1
        for <linux-hardening@vger.kernel.org>; Mon, 22 Jan 2024 16:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970156; x=1706574956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfrGPV0IGkD+5oY5bzUA1O2ZP/m+4NsFlK0DOdMmkOA=;
        b=G90jh2L+n9IhjBKBpZf0pPfzVXtpSh1dWGVHPuGIZl04FHqrvqkSlesk/0TLOecojH
         MKGt8WfdHofrlcrhJPaXLwrfxHKhlujiOVf3A2bMQJj6wxBFrSEw9k9gu3IFWPslJa0i
         o+3Ya/WsJmeer1l2r52ZlX79PVUPTngoMjuzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970156; x=1706574956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WfrGPV0IGkD+5oY5bzUA1O2ZP/m+4NsFlK0DOdMmkOA=;
        b=xADB5nvp9KXTXaUOUrpIdD85vgssK+A1ykgwxVju9V2+WKzyE4GR4mGpC7Q45d0zKr
         fhHpp+cFz0TQlK00jvBM7bDloAyfFYkChBYkiKUQk83ydj0VU+ytPuwMLXGPzRgaPYY5
         WcVRB9zQx68Lei+LFb4BPlbhNV91yAiPJFhJ8mBxcLqlOPocTWm05b1naeLO8VKEo1Yt
         YN7L8yNpW7vBaVNFb9PVay1801QiLWf+N6oCSvdePAV8Is65i30hryAC89ud14/+DmLI
         poc2vHT+zbV1Cx/HxHL4dtlmJwG+RBvtMab5HRD9opqr3f4IeyZEEJ1NF/GfOjbwqRjK
         IAXQ==
X-Gm-Message-State: AOJu0Yz0efOkHGlyK3JyN7vaJULI5ZukGHgedhyWu5OHJKdgfiv0d1p5
	mXC1EVWHLWEbS2lJKghK9VKJDLg6yEDkpt9FTwy9CnTwOiQrZP6mHyRX5EmgOQ==
X-Google-Smtp-Source: AGHT+IHZHo5Egp2kEgcDRX47HvbxGI43oLvJO2iYgsq7tj7lGeM9SaYtF2xT1UoPBae4y/00ds7/rQ==
X-Received: by 2002:a05:6808:1211:b0:3bd:a8b3:f5f5 with SMTP id a17-20020a056808121100b003bda8b3f5f5mr7279920oil.75.1705970155779;
        Mon, 22 Jan 2024 16:35:55 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p24-20020a62ab18000000b006d9b31f670esm10499254pff.143.2024.01.22.16.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:35:55 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 26/82] buildid: Refactor intentional wrap-around calculation
Date: Mon, 22 Jan 2024 16:27:01 -0800
Message-Id: <20240123002814.1396804-26-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2106; i=keescook@chromium.org;
 h=from:subject; bh=KmdQOHR2wQwwvdbCWLH5gPumh1btink3RoAuAjMZ63I=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgGUCr427Bvhdd+DlIEQSmFuOB0zAlGUaRHx
 sXqW6qzQiiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBgAKCRCJcvTf3G3A
 JqMUEACIPH6rM6cY2SMBwnodw1rMMjn1JdKktj9Iu6aGJquJ2fqWV4hXH3eOfqqDWhhLtRIx10m
 MBgFqDepBiW1bwcx3qy8doC7ieSHcOvFKOfj6KMywgUGVwFHQpkhWF/fz5lrUTSYFdaxZVCa+lr
 e3yfwjXsiGYJcB8O2lAqBoC6T5Oig7vnfqNw+lVTcicTSmEapNfiAbtUZb55sB7NxPG7D6nUH1c
 ZRLU4Ed2XedDT7eOfND6jgaGtqlz56GVi0q1U0XnAgqXTUSRm0+4M6NuQGAjxKba0EwMU9l5aJI
 8csxMMzpzLOtrQra/ANMvMry6yeTEIoX2ldbH8axmAnuD520xWjWuYemFLjrYagKmZvZqDe82yy
 cLA7vG0VaL2NfXpAY7mfSztcg+9pzQkXvPF7pzzTMp/vt10UubjGIRs65XTH+eDOO0+hSJwJ8sG
 /gM1k9uOf4WaHXlTYZMn73i0DMxquh80d7Y9FlpKCRlv9dJO3bPjk6P8rev6K/2fwda9vjRmFL0
 0nKVXJz/WtxTMgx0sDxb2a5++FGHN2HZSJUgTSvLynOCZmjqhh87r2gUM933h7Jd65s8MuV++rw
 ZS3P74wcMAOQPOljxC0JL6wdM5IGMy1pCA5rTTJpa+IG0h/fhYHD+aQ7rCOa9E34+wvfmdTPWGL PMoqRQ3lq/unYNg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded pointer wrap-around addition test to use
check_add_overflow(), retaining the result for later usage (which removes
the redundant open-coded addition). This paves the way to enabling the
unsigned wrap-around sanitizer[2] in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/buildid.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index e3a7acdeef0e..d0a310cb9b57 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -54,12 +54,14 @@ static inline int parse_build_id(const void *page_addr,
 				 const void *note_start,
 				 Elf32_Word note_size)
 {
+	const void *sum;
+
 	/* check for overflow */
-	if (note_start < page_addr || note_start + note_size < note_start)
+	if (note_start < page_addr || check_add_overflow(note_start, note_size, &sum))
 		return -EINVAL;
 
 	/* only supports note that fits in the first page */
-	if (note_start + note_size > page_addr + PAGE_SIZE)
+	if (sum > page_addr + PAGE_SIZE)
 		return -EINVAL;
 
 	return parse_build_id_buf(build_id, size, note_start, note_size);
-- 
2.34.1

