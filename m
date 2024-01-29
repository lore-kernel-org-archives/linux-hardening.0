Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2E04C63A
	for <linux-hardening@vger.kernel.org>; Mon, 29 Jan 2024 18:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553254; cv=none; b=qJmg5o5S4L6e1nI/Y/c8wjFOvmNzVMuehiDpiFkfXdXmBCNy3Bq4/YSZjAk1r5TygZEgT46ZW8T+kokvqo3/306ILtnvIS38M+tqbfZULIvJm6SrtTk2OaRoZgDqz2/oiMJFc11TuoWTXtBUzJq34eKz5q7VzGE2zH3rSiR3iXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553254; c=relaxed/simple;
	bh=6Jgp3vxxK3Vk/XDvje4qMUZMER6LkaJQhb8c5Sf9IQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o4rydBorLdm5kdT9nqSb9g7WMngUO3QYj2OMwCGKCu3vaN7BoAxM0205cEOHaM2gPvvuWfWiMWMRXE2vhO2ANmwiyuwg+h0u1jNjcZBy+MA0TtVzEBGJegnMswZwSUCpzHXKDWgL7qKjrDruZfiX6+RbVX97NrqusGLXuPrbMYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JiRiCnCg; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JiRiCnCg"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d76671e5a4so22392085ad.0
        for <linux-hardening@vger.kernel.org>; Mon, 29 Jan 2024 10:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706553252; x=1707158052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QphZTJ2YkJ63c2lk2h3jm8PAaMKsJdXhMlN0zVjn/Jc=;
        b=JiRiCnCgFNHNKSHI7rBgINafeANMqHnlJrUAVU8xsnfqZ6O3ZSDN3pir0FA1IaptZ+
         83FwJJifXOSMfIdOopIJJbK1VUBMBU5qWy0L2FVZdm5wgNLnGDi+a0Fmx5/N1cxGc4tJ
         B8KCNW0GGx4EnyeXj/diwFXTC4FPkxtRZryl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706553252; x=1707158052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QphZTJ2YkJ63c2lk2h3jm8PAaMKsJdXhMlN0zVjn/Jc=;
        b=MXZOubFUy96y2cgIUyQD2hKRxuWORoxPhjRAEhqBjzKY1K7PAXfoACZ7fNuGEj9fY2
         WivGp11H6ij53ZTZoC7hqgm2RuQveFQjBDLRS9fx0ZQHcyE51TnWs7k4AecIKUpifhEx
         pVHJ99hleVjSLIf5wBxmBN2RaUfW4Ams3IY01bGW8kpfhySvWoXI5CZlwOg8rgohD8q+
         jOyUVZh/WOwMxrPZ3IARTlazrlnEU302nTdHSZIgFs1vfjxAlklhboRSQ2lDqArJpMpy
         e/lMkjHuc92NYOfImQRZBtTgVOKFW4TJ1yWPkNZstFwRJ9PyQh7rOLOALe1BPBJnlz2c
         MGuw==
X-Gm-Message-State: AOJu0Yxio1/KvCsblQrGF1yPPWKLz+dS4Jt/JOJIZHC7hkQWIpCxVv8E
	OFb30qtj0BWI9+tThfKXc6Qj1MkfcPatTJaTrnMCrIquTGJJiUWwIyimzEe7qA==
X-Google-Smtp-Source: AGHT+IFkfsTJuyc6VSFqltQEsdoXgVdT6JIueK/hTDd7PLe3N8Wvj5djQPYuaTuP7CXSst2xU1wTZQ==
X-Received: by 2002:a17:902:7ed6:b0:1d6:ff27:7627 with SMTP id p22-20020a1709027ed600b001d6ff277627mr5287552plb.50.1706553252431;
        Mon, 29 Jan 2024 10:34:12 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id mn6-20020a1709030a4600b001d903829914sm56692plb.67.2024.01.29.10.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 10:34:11 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 1/5] overflow: Adjust check_*_overflow() kern-doc to reflect results
Date: Mon, 29 Jan 2024 10:34:05 -0800
Message-Id: <20240129183411.3791340-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129182845.work.694-kees@kernel.org>
References: <20240129182845.work.694-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2673; i=keescook@chromium.org;
 h=from:subject; bh=6Jgp3vxxK3Vk/XDvje4qMUZMER6LkaJQhb8c5Sf9IQw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlt++hMG0B/D0l8I3Zre9ccIWewGWghw7fRDA6+
 Ex6geHfWP6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZbfvoQAKCRCJcvTf3G3A
 JkMjEACtkoX03lg3Jmy8Ga4tceMh604TeIOz1HEh3I69tq8Ys3CbrzL/72xjZYFPFtNrjVEuPkq
 Ko72xDDJEiA+rrI6jKN8OcajxkR53j0QUaDrysbuaPbgqeHWAU+I3oNkuw3r46yz7P3BhP1ZKEJ
 9Wvvqjth3mecY2sWN2fMh86iUzj5nGAy+9kKZW+9tiIINMTw2t+ycv7GS/H4wNepTBuH1K+Kj7Z
 ExU9e3YnRKP4idKPGdT6gRPf1NJUqyG6bNk1pMdb/v7JmTvtDdqlKeO0pc599KZhDhgy8bVDhW0
 IfwPdvIzfnEJgxq+RxVewguOQTDNziuVGyfODemvoPt3h/NIKw1t//OIVxnHIGm3hDDGZqeWSuW
 izcDaPZsRcPpCMCnqAaqXLjJkLdcr4/EU+W0P4U5BRhzAAnZvNP0WxVKF0tjcpJyQFf5W4kbRMC
 rum7N6/CzfjM08+AidymYkLNo2ukkEdvKkqHZlB9dHn5/vd25df4RX5jqkeVw8nZazkrlnungs2
 a8Upd5wyDchHP0vkUssROiao31lOk2FEcbS4JhjBVRRIrEEakRBjFIyBkNsuQy1g/eOgRIi4g9U
 MjqKDDKA1xKUq7wsYf3joaSEsbUuIj5dYlnGUayFL2reQSrt3gPSXqnYr3J6qEU7BosjW1PwyZd wObgyekVlKgl2hQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The check_*_overflow() helpers will return results with potentially
wrapped-around values. These values have always been checked by the
selftests, so avoid the confusing language in the kern-doc. The idea of
"safe for use" was relative to the expectation of whether or not the
caller wants a wrapped value -- the calculation itself will always follow
arithmetic wrapping rules.

Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/overflow.h | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 7b5cf4a5cd19..4e741ebb8005 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -57,11 +57,9 @@ static inline bool __must_check __must_check_overflow(bool overflow)
  * @b: second addend
  * @d: pointer to store sum
  *
- * Returns 0 on success.
+ * Returns 0 on success, 1 on wrap-around.
  *
- * *@d holds the results of the attempted addition, but is not considered
- * "safe for use" on a non-zero return value, which indicates that the
- * sum has overflowed or been truncated.
+ * *@d holds the results of the attempted addition, which may wrap-around.
  */
 #define check_add_overflow(a, b, d)	\
 	__must_check_overflow(__builtin_add_overflow(a, b, d))
@@ -72,11 +70,9 @@ static inline bool __must_check __must_check_overflow(bool overflow)
  * @b: subtrahend; value to subtract from @a
  * @d: pointer to store difference
  *
- * Returns 0 on success.
+ * Returns 0 on success, 1 on wrap-around.
  *
- * *@d holds the results of the attempted subtraction, but is not considered
- * "safe for use" on a non-zero return value, which indicates that the
- * difference has underflowed or been truncated.
+ * *@d holds the results of the attempted subtraction, which may wrap-around.
  */
 #define check_sub_overflow(a, b, d)	\
 	__must_check_overflow(__builtin_sub_overflow(a, b, d))
@@ -87,11 +83,9 @@ static inline bool __must_check __must_check_overflow(bool overflow)
  * @b: second factor
  * @d: pointer to store product
  *
- * Returns 0 on success.
+ * Returns 0 on success, 1 on wrap-around.
  *
- * *@d holds the results of the attempted multiplication, but is not
- * considered "safe for use" on a non-zero return value, which indicates
- * that the product has overflowed or been truncated.
+ * *@d holds the results of the attempted multiplication, which may wrap-around.
  */
 #define check_mul_overflow(a, b, d)	\
 	__must_check_overflow(__builtin_mul_overflow(a, b, d))
-- 
2.34.1

