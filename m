Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5170130E3C
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 01:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971822; cv=none; b=sOrZDojFclI13iEsZ4j/0/l+B4ECELKnI/Z7cJgn3APu/viyE1Am+1/Tfjr7GUgpVKqkarW9Q86hxhtMpHNtd+vqf+LAm0qIIiejs4sdpSa0wBlXEbucNLFDfQHHJm8xnxR4+SutE/JBs9V/1G3yXRB8/tx/z2UPyNwDJFesk5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971822; c=relaxed/simple;
	bh=nJ/Dbne7d4x17jpkuEGwBkY4HOJHaHOZVri7BDLojVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h+kNQhsijcFh5rYTDXuIG24GJ4Ia2hDv6nuX3S74wRzgRaJ58kvXJBmS5Jla5hAO9FyH936TTe6UA71ofL7q564lcfguQFba4kVFgUduuXxxNcLwfbtqrKu7ZhPMtu0hyDiUEodE0OZQqbt/CI5ayIhxxbdGMKafQIMbD7EEbDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V5M+Mvm5; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V5M+Mvm5"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-29080973530so1694913a91.1
        for <linux-hardening@vger.kernel.org>; Mon, 22 Jan 2024 17:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705971820; x=1706576620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnep1Nz3UUWk+A97sey3opJKdGJPhXQxINirZ47tsts=;
        b=V5M+Mvm57yre8XBDEzda6xuGtZ6RGabnHELPj7SkTCt9SlOT1ifjf+c+4BGHy6XtFB
         WjRzq6Y9Y4hn9QdwJt8L7NjqqlOFfdoDik+QB5AuAyD9nx7itsBkYb1M7vA+DFKPV4gX
         G72HYf/sVMwxOSCIKhuhQORHU9uPNuJgBpP6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705971820; x=1706576620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xnep1Nz3UUWk+A97sey3opJKdGJPhXQxINirZ47tsts=;
        b=FX0inMit0oQ2KoGON9LuaVIO7EAnxhpCdNyiCjINQZZaAXMFESgyUqfNwfdTcg67wv
         94/SvN6u8PunUCt+QzSndlJpHd0nHzqsHlGIW74bDZojN2HCZVVOU2eVepkI+iU2XVzA
         ItMVFgucmhtMgQ4pY7kgfPYmtuZtr2yCWM7AJKD3TpSaeJLs9hrShp8Gb3vqQHhYxETm
         xnboNheEtueFvW9lHgXXBZBkt2yZhn3xeVEnz21I6uRtacOcD7AszWeOMfNkv7nPG3qX
         D4jcDDkrfasvln2sXKlpAUCPDejma7nmnqnWKVVkGQIRJ7YY1kPYTmTKTUWKIjrtg14X
         BLtg==
X-Gm-Message-State: AOJu0Yxo4M353n3R4Io6vHLHUyrBYIdpAlQcnr4oPd5yol+1u31KfGIx
	p2YE5/ttWl1MdSsmRLdchi4FpufkQ42yKxXzknsUi6kXC2lc+mi1zwtZal3U+A==
X-Google-Smtp-Source: AGHT+IHtDT1yrq6PLJdBjifV6sVndraNqQcRTaZ6r3kszvNUHhuC9VOVEAQ7fl/+G79Q0TkuxmIxEQ==
X-Received: by 2002:a17:90a:bb85:b0:290:2f93:610 with SMTP id v5-20020a17090abb8500b002902f930610mr2563687pjr.43.1705971820287;
        Mon, 22 Jan 2024 17:03:40 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090b068100b0028d53043053sm10363069pjz.50.2024.01.22.17.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 17:03:38 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	linux-mm@kvack.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 78/82] mm/vmalloc: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:53 -0800
Message-Id: <20240123002814.1396804-78-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1848; i=keescook@chromium.org;
 h=from:subject; bh=nJ/Dbne7d4x17jpkuEGwBkY4HOJHaHOZVri7BDLojVU=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgMYqbiC9CfEEv7H4hKDed0Ckaf1Z1VbaYnE
 qoWkPaOgCiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IDAAKCRCJcvTf3G3A
 JoAFEACV8xbsMUxa2NDUN1xXMDrXI740/x4qynm76Y5yHDXd8g4dDNlV6TgPgaKrMcZxegbZ2QU
 R5cRYG/J7JglC10FqOIhwD6AtUxi84C/xDwgUdTjMekuyQtf8oDx7YLLgAKw8bq0t4X3rpW6CvQ
 789Dm5r/bO09y037XiiADu+c0Kfca0kz4l4hsD3wqzySP4Ha6OvsDs8CBNbY6tRlGGUthfub7II
 tb1WtKY1ZinjdC4ghifbgFhlRrCOgj7biFA8ou8CciPsdg7rnA7965zlYbuVFdMDC7AsDA5W/0t
 iCmgY4z2UsX2FErJx60tBeyjU5boRyhss2AYcsWP/7W0bNE3DeDbwIi91im5pXaPnnnh++xW9ie
 viskQzEHVGCp9fzX5vKIf8jWzSJ7kshlSMNsQ0O4SzwcFPvVJk/escQgdR6K+1QBoVAorEWDOhx
 EsxeHB0NO1Ze8mw6jGQTqe83Ccv2wJrRp3YX2kRVqeK/+4OnQ/uXFWUnnKJD4RNds5YD7tAxgIQ
 3J2yAO+sh6kXYGC+2QQd0JG9eMTxuQbNeW3l6pbJpV4Ar0Hkhq3u7dOEqgZrnciBM9n0pEUPmza
 VmlL1fSQYFD2oTO8q5g9EePyBH83lEZSENHLTs6nrCpzpCdeFQQTfsTySvMG6AFuxAd+iNZc0Q8 3j9NIiBzvjukfKw==
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
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: linux-mm@kvack.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 7932ac99e9d3..3d73f2ac6957 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3750,7 +3750,7 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
 	addr = kasan_reset_tag(addr);
 
 	/* Don't allow overflow */
-	if ((unsigned long) addr + count < count)
+	if (add_would_overflow(count, (unsigned long)addr))
 		count = -(unsigned long) addr;
 
 	remains = count;
-- 
2.34.1

