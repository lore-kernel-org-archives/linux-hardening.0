Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA67160899
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 00:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970182; cv=none; b=c4feBy7sI095+W+RY/Wmq+mW4tginDqNEy2pIQX0IbC+VD10F3NBbgkaV9OT5vBlfFT+l8BP4zLYVUzmBIccexeoqYxIM5/WfEHywBbe9DcxBespOWXHQeYmNuMzwPQ6rLr7tXJT+Hj/Zo8VTXDkxh5wvHDwU+L2rTdX0mNF1OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970182; c=relaxed/simple;
	bh=X4KPC/UgpHzHjLm9oqtA3x4JymqJVZ0DUnLq+Paa7ds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JYLiM10FEGaWSSljU8nEhG4NGjzzuk9IpKA3cPmwdV9gVyhuo4VYYRcVT5HjWusbnOLgs8RWVq7B4id155bsZr+DoiD5Mze4SeeXwtGSBdg9LZMelT5mD/M4cSoRmzUVptlCVHWHt8DkKW+qgDpiW4pWhk1E9tlQLMoUPStrONw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ftJiLXY9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ftJiLXY9"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d50d0c98c3so38138845ad.1
        for <linux-hardening@vger.kernel.org>; Mon, 22 Jan 2024 16:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970179; x=1706574979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEc2d2rSfjhDoBoq9fLjQenSkCLNzDWcQ8adwJB0hG0=;
        b=ftJiLXY9mCM9agVXh7u5DCh6zmbHD90qFASbREWPWGQxFL9HD4aC15JYGrJDAgKAJa
         YFI8ZvEBfAV7Jwl9eIT3LEU5hhqdyUU2/3SsuCAk5JCYk6fNMSRXyKFERn7ikxpzUzdZ
         r9KM4Mx5HtpAYZwRWciPGHMr930UQsRuilDNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970179; x=1706574979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aEc2d2rSfjhDoBoq9fLjQenSkCLNzDWcQ8adwJB0hG0=;
        b=ZowHeMGgc60KNz78loDqiiJSIxJanrEQl/i8ViIpK5JMtNFE5G5XxNJNR5j+j1KhUO
         4ksju+7ayE1j1u9PCqEOsYEQ+5VO5jopEy7ERbOwWfkaNMl1/mmKGZq/1anLL0Z1rtEv
         dxdi2BtMU8cdjRvHkUOoNrbvBDgHefhKTsNJWVEcef9SPI8HDOMM+IzNI+zU929fQ3be
         w6NDAg8DA3nZsMLaidZyPGX7e+B8WIz/jt6/9JI7DmbXyRwYTZ8b+tb1Fethba446wjp
         KZlFAsuupUGOgM+874TTduxeNZ7ZDJ6xeIyFGX01zDS+k2RKebCUdDvedPQysEdd3nBI
         xqVQ==
X-Gm-Message-State: AOJu0YxrrHGPwV6z41nWNbI1EnYi/rw8WLNG2j+z7Rw/+PUB7K4nnnVx
	HPILgjEMFfsnfFlqOchypUh1OMHYrvkt4yQEHgoc65wD7UUaybP3ky03qFdGew==
X-Google-Smtp-Source: AGHT+IHFbuHpc3vAdI6yegvV/L9r1Yb3ls3L9cW7fTD9Yq23EmXCVPkJqYozC29KOqZKziH+AAq5Jg==
X-Received: by 2002:a17:90a:ee42:b0:28f:fa9d:ebdf with SMTP id bu2-20020a17090aee4200b0028ffa9debdfmr6732264pjb.3.1705970179438;
        Mon, 22 Jan 2024 16:36:19 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id dj7-20020a17090ad2c700b0029065f70565sm5824388pjb.41.2024.01.22.16.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:36:17 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 59/82] lib/scatterlist: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:34 -0800
Message-Id: <20240123002814.1396804-59-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1669; i=keescook@chromium.org;
 h=from:subject; bh=X4KPC/UgpHzHjLm9oqtA3x4JymqJVZ0DUnLq+Paa7ds=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgKl36vVZG1nmdlZHD5EeRVSkhvMUsUGq27H
 GGTsQQr0yKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICgAKCRCJcvTf3G3A
 Jko4D/wLOSdJgcYUIEXEWyZ094Wxs/bc+vFZ1200/hCn8653ZUrA3GFBQlNpz2j4KN4SGZaAUwx
 XwJbrwaPYj5jQDHGgEpePQTxEQUZO3iNMJarAxDNOV8Jp4y7Z8D58Mf31v/9HugXKic4tf8wXbd
 2z7mUpcMaG2/zFyfcuVCd5nuP6SGOfw1qSMdqDdEgHAF4lJuOPMi3jORDXoKcY1016c01JbQFzG
 PyzDWakatUQn3fG/IurRu8FlgDWXY0nfhz/R+ZG5YLj0KJ+FIceKRbj+fdDgDXUfYsbPBiSn7Kv
 cyv4nHAzcFSeV6kggiiFvczA0o+iQctKOUObrv9u8LzDKPU/gg72Yy1yeHoItbt8faH08EQGpHN
 IOFLAykVxVuBAhxbaKjqC8CiMDLtjlf56mwXKZkI1dGqzB2t01l1K/M/NU52aiJsd+pjZcfOPHy
 TqFEHvtJhzsPQXZag5/nu6I1yqmaIhbwCFDIJ7BnFuJYgvqUctQJFuJipD3T7jKZhAEyjUdFvDZ
 GULJFLehEJ3dGgLpoBn8tpWS/rVuuHQ4JF3zdxUPpoy2rjXbWm7xoXLCiiey4bCZK21q+OHDJCH
 8dDMZazDyBgAiPwQCGHfaAHulyiW6eEJe7qpDt5dmJHGrR6kOEELOyqY78LX7F7ljWlSML1tfWH lPasxNIE4hn6XbA==
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
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/scatterlist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 68b45c82c37a..121905119bbc 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -624,7 +624,7 @@ struct scatterlist *sgl_alloc_order(unsigned long long length,
 	nalloc = nent;
 	if (chainable) {
 		/* Check for integer overflow */
-		if (nalloc + 1 < nalloc)
+		if (add_would_overflow(nalloc, 1))
 			return NULL;
 		nalloc++;
 	}
-- 
2.34.1

