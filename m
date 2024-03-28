Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAB112F5A4
	for <linux-hardening@vger.kernel.org>; Thu, 28 Mar 2024 20:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711659260; cv=none; b=Kvj4qB1FNsQ6xlFtHySfuD89k0EoVAF7INsnRwdhEz2/K+dGNDdXWnN0lGElfquRD0H0TbBTXqZbPk5UCzZFt+MN8Out0lKFO82J6jIV6rSyOWEciSpcKflGlAcWNku4YAH5DL3cX9VONt+4q119vffUx7hWY+4YOhW3+uM8hSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711659260; c=relaxed/simple;
	bh=dxZ8bKhF+xsDNjClmZAMnCylDOfHbdXS5i6fIidiALI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YxWu0whLVyjwxy/WG09w6URUuz8hxsp5ysaYKmyNXAJraI7vwRUoxtB3yzeyM7TxQSFeYvdlJ/NAXxZXFlLsw0vstWGEP45EHRP6cb83sbXXNrE1ZGb8GimaM3+NkM56YOCgq3joLcRsU64qUrkHiUpApnss4F027pqRCyqG7Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ErPAJD+t; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ErPAJD+t"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a20c33f06so17939237b3.2
        for <linux-hardening@vger.kernel.org>; Thu, 28 Mar 2024 13:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711659257; x=1712264057; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oeh0VMbE9HOBRQtaIW93T8/UfTUlPooJDM6aAubdbLE=;
        b=ErPAJD+t8AnXK2ln282Y5dkbVgmUirXnZ089p7CvCBBu1LMm4naltRBRieYPQ2nt0O
         SzeOQGjJ8TLYDjkJ0mwq2Pk/IB8xUFFVwcCx9dczmFn/0vW7QeYFrxp0oP+3DRpQjMOP
         AFyXTO1Lh+KRjbdLkKDMGW3OsgwWysvzW4oZXkPt6/OyimhL37Ugqz88CK0UkZApghls
         Azuomt1oejEF0KyxU/ZQLlkC/QRDgToA1K3OINE3KWPjAN/JGDm9w8bufnDDFpdMPV8y
         hS5CdW4M347BqgNQhq6cMyWqOiJUDDjAfa3lo954Rxug/PMwPsxvLV5jUcWc8X7T9Okh
         k2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711659257; x=1712264057;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oeh0VMbE9HOBRQtaIW93T8/UfTUlPooJDM6aAubdbLE=;
        b=RWsqgZJPDZOoG7hZsJSPUVAXPb20gNL1PdTSp06LRebBFkHlGMGoJUZy4bwYyHOzmg
         bLPETEBn3f2IuUM35j47EgfUvzBBNpFp9UA/UWG/dgOAGYOeBdLf0rCM0rhNPBhSFawU
         44sEpCq0OE1j5oxB4vApxBfwNhGV2xNHhlMZ+nvA20Bb9BMJhTbzP232drc3kZjpNXre
         CzfRAN3Lg5V5yH/7KLJtWD+Ay7GcSdQJcZMPvo30WO5D1aYqjGbjprwDnUQhts5gxW6g
         5uAHGndMFZ6YM/torjDHXgFcIUTjlWO4kNfMJ9AQqNtHdc9sjFqIoP6J6JzDmt0AT/i0
         tZmg==
X-Gm-Message-State: AOJu0YzuNDhF3Xg0dllBiPKG3YqBfP5KhlRaFR4MwO+AdEaDoDuMqkAQ
	7GCB+FddUSY+zTlVxa8qpsc288NYBowhEUXzim0BSh8HtofPUVACeiHDoPs0Szi/bR00I/hUlOd
	XBT7FJlyeG18yyaELXQRJ0A==
X-Google-Smtp-Source: AGHT+IFAZ/FVFAQSXOFC7j7CtQVInEdn75Twn+yuFjapvh0FcmJJNWKvTbJUha8cYhBldw23UET06erMaMfGAVMUIQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a0d:d654:0:b0:614:3269:ee5 with SMTP
 id y81-20020a0dd654000000b0061432690ee5mr121955ywd.6.1711659257672; Thu, 28
 Mar 2024 13:54:17 -0700 (PDT)
Date: Thu, 28 Mar 2024 20:54:16 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPfYBWYC/x3MwQqDMAyA4VeRnA3UVlD3KsPDzFIXJrUkIhPx3
 Vc8fof/P8FYhQ0e1QnKu5isqaCpK6DPK82M8i4G73zrgu/RNk2UD4yG2bZVGafli4Q9NeQouG6 IAUqdlaP87vNzvK4/V04ddWkAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711659257; l=2073;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=dxZ8bKhF+xsDNjClmZAMnCylDOfHbdXS5i6fIidiALI=; b=zIOARQoHQqKQceMMP/mGFv16wBKPu7koX3eX5V0NPub4Y2ClElGj59hdpG3oCm9gy947zPgsr
 TmO8YN6n6M7AMfKABsMOZxkr3z/CWnc6yxjR+OQB1q2vfFdOFOOYMDD
X-Mailer: b4 0.12.3
Message-ID: <20240328-strncpy-fs-pstore-blk-c-v1-1-5748cdc22a53@google.com>
Subject: [PATCH] pstore/blk: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We know that info-device should be NUL-terminated based on its use with
strlen():
|	static int __init mtdpstore_init(void)
|	{
|		int ret;
|		struct mtdpstore_context *cxt = &oops_cxt;
|		struct pstore_blk_config *info = &cxt->info;
|
|		ret = pstore_blk_get_config(info);
|		if (unlikely(ret))
|			return ret;
|
|		if (strlen(info->device) == 0) {
|			pr_err("mtd device must be supplied (device name is empty)\n");
...

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer.

Note that this patch relies on the _new_ 2-argument version of strscpy()
introduced in Commit e6584c3964f2f ("string: Allow 2-argument strscpy()").

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 fs/pstore/blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
index de8cf5d75f34..65b2473e22ff 100644
--- a/fs/pstore/blk.c
+++ b/fs/pstore/blk.c
@@ -241,7 +241,7 @@ static int __register_pstore_blk(struct pstore_device_info *dev,
 /* get information of pstore/blk */
 int pstore_blk_get_config(struct pstore_blk_config *info)
 {
-	strncpy(info->device, blkdev, 80);
+	strscpy(info->device, blkdev);
 	info->max_reason = max_reason;
 	info->kmsg_size = check_size(kmsg_size, 4096);
 	info->pmsg_size = check_size(pmsg_size, 4096);

---
base-commit: 928a87efa42302a23bb9554be081a28058495f22
change-id: 20240328-strncpy-fs-pstore-blk-c-8c1c0c3079f3

Best regards,
--
Justin Stitt <justinstitt@google.com>

