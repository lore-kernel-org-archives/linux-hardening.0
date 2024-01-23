Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B645FF00
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 00:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970170; cv=none; b=O1TBDBoQcJ8Y4LR1S8/TeNlL3AwxaLidYPYPD2Mdrk1+0axOKvQvj0CvVX/F/L6UmpMUqZI6ZQ8kty/pkiLNi2qoTaaGd9olNUwk/pW9E7WuBAvJ94s7xMtYDyptx2WJ3t255u7yKDQWjlh+5ftYxHkMj6n8kKgDhJBZvZryisY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970170; c=relaxed/simple;
	bh=t5NjTIyb78Owo8zdIrnO+cNPZQCmas8okHDaZcCW+8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rIuzpxNqSDfbp3DJI0PVg5ppP2Db0ihLxs97K/k1AuxmWXbi/FHw+d5dFi+7JTy+ClrpGdaCe0ac/gd6Gr4yymoqLMI82aB2w9RsmPfAu6b+2SbylCJfcypO0qXrK9R9FFx/Y+L7vIV5KONGPs75I0M5IMpFNRKBVjSVErdrxzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RAxgGIe7; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RAxgGIe7"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d71e1d7c78so19773055ad.3
        for <linux-hardening@vger.kernel.org>; Mon, 22 Jan 2024 16:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970168; x=1706574968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7ZTM5SgKNIL4BhjlzbkN6VUe2+U+pKLPfyRCBZRraY=;
        b=RAxgGIe7WpZkyy1/QIFTkVXwi6QA8CPIs5r29T/otOrJZOPxH21Qa5Tj8m3RlYy0bs
         3LN+MybCVhxFdCBWuEQyLGQZ/VVkh0+mpkQn2+Zf2avlmGyhq/G1RjywwWg7kgyv/4Km
         RMGLGV/nM5b4HYjpBLnA9FUGjnX4+z+2w4Ni8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970168; x=1706574968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7ZTM5SgKNIL4BhjlzbkN6VUe2+U+pKLPfyRCBZRraY=;
        b=n15k1uPUtG5BjHp7yM6v+jbLNIbvVhzXsp7vO2q09Emw76avR2cJTvOFECNcq9E/iV
         vqLQeyCg6rVD4/32TzFyy0kQhWadjr2yErLKC/4x4T7bf5x95c5ACB8fc+2JWWBeiD6k
         b2csgHMknUQnC1yZiMxRqa3KMcnS9CAZ+/foCLWljt8Wy1o77VVp3ruQ/gOkl7on7ndV
         j8Zq7C656fsZyVY394gM6DUmmVoU2EpF7mh42RlVTQIXdTNwVm43oSz1aF6wZ6D7JuwY
         FpjoUTAv2LBuQHhSTbkecglUFJDQadpIr/wYQADoR+RvfXxctrjeITUD9N1XqCiKPRuB
         0UGQ==
X-Gm-Message-State: AOJu0YwhwkqyNsg1/h1rCUUODeXShzQyaCd2obYC59H+dxwHJ0HjNvtG
	x97jJHY0c+Ur0ROSjttpfcvnjyOH3AQFUBqDWl1qGIQcbC1XRzh6Q+rN4MEHa/degBkzoA+p0AA
	=
X-Google-Smtp-Source: AGHT+IHma0YydFHbhFfrWsggKZl6acEMucYTfJQJ8bR7gd8MhZKLGwEpOVissYArHVSd6tQkC7YMdw==
X-Received: by 2002:a17:902:f80d:b0:1d7:1df6:4511 with SMTP id ix13-20020a170902f80d00b001d71df64511mr2230166plb.136.1705970168258;
        Mon, 22 Jan 2024 16:36:08 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bc1-20020a170902930100b001d6f33c6541sm7744955plb.285.2024.01.22.16.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:35:59 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 38/82] arm: 3117/1: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:13 -0800
Message-Id: <20240123002814.1396804-38-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1869; i=keescook@chromium.org;
 h=from:subject; bh=t5NjTIyb78Owo8zdIrnO+cNPZQCmas8okHDaZcCW+8I=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgIgNjftYd6KqWOKIJFbI/lZsVWsVXrAIYuR
 7MY5dEcPb6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICAAKCRCJcvTf3G3A
 JsJMEACd02wCA8LfA0u8syRk4/Rp0JpgNpsiW+94NxRf9Xb/Oa1P5P/23a62lAN63yHc33ODE4L
 M3ih112Dkk/GdYQYFQoseAYyd9wEwaRrK6OoELlJ0Ze4FwF5E9bPBzZBN+AToRmXDARPSePbk6Q
 HZi6hgbD4OnzpQBqRmCSRJL0lJyo2ziVbh5BXwDaxazgKG1QvTQQhuL4CBsH8QymXeO1WoobbQk
 26Lf+jshILYsRLrtCn0FlcZsh6mlBSxO0KJ4CUeMdPyXb/n97DlDo9ZRsMvL5zEVKBIg+JxLLAB
 eiERpGMH5u8wbAPvM68kknVE/5x/EhJxjD/72ZmB8fLPsBwqyfIi9/nCtDWqnxR+s8y62/FagId
 vKwupeZJckFZhlj3FplDpT5AgCdjiYDr04S5TE2z7ZeLF88go9lfifcAgNHiaMV2wVUow1AxKoR
 zhpXpqgauLnNTNDDvyIpLRyEB2bYOzXIbRViZ4g9pC6cZ61woUKFcXLKdlAzNydxV8+S0EGFsPY
 LlHwmd9SZ6ywdnnVcm7iVBZb85cRIWlqIuvHSZrpSZPbpuYmgm1uUl3D6tLwHejiVVkF8Aj/osn
 muUmAXMDNq1t61UekRGqmWwWEgZp9DdjcwBm/v9dRMK2z0ksyJYYhrFC7XUBmm6XVbRptGwp9ZQ Cpx0SvAPk2bRjTg==
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

Refactor open-coded wrap-around addition test to use add_would_overflow().
This paves the way to enabling the wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/nwfpe/softfloat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/nwfpe/softfloat.c b/arch/arm/nwfpe/softfloat.c
index ffa6b438786b..0635b1eda1d3 100644
--- a/arch/arm/nwfpe/softfloat.c
+++ b/arch/arm/nwfpe/softfloat.c
@@ -603,7 +603,7 @@ static floatx80
     roundBits = zSig0 & roundMask;
     if ( 0x7FFD <= (bits32) ( zExp - 1 ) ) {
         if (    ( 0x7FFE < zExp )
-             || ( ( zExp == 0x7FFE ) && ( zSig0 + roundIncrement < zSig0 ) )
+             || ( ( zExp == 0x7FFE ) && (add_would_overflow(zSig0, roundIncrement)) )
            ) {
             goto overflow;
         }
-- 
2.34.1

