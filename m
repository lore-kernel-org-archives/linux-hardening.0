Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A2C17A318;
	Wed, 25 Jun 2025 16:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867966; cv=none; b=gsTOfNrjasSYiTxKt7pESP+GQY68aXsCBgpVnrVnMExDUEId1LjFtbkduhc0Du8fZkXeLikZMPFQcbk8Vu+9CWdV3NyTQO1F8NsnhyjpHtuUqBwGbJHHr7myMzTgmdDXuS4PH46x+WzjzSyVASiILgmfaC4fS1+agG9soEyEUqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867966; c=relaxed/simple;
	bh=YWtMfRzqix6W7MGTaVg8D5Rh8GSRylpHNxGgmYUykwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cqkAshTc6AAP+2Iew6OrVXeWyZBqzf6288+d9Q2ZFYSTpA1VGMwINHXQhbcIf+T/2TczViQriqppypCofy0MQwqCioQX91TLeVIiqJboUa1U2Opo6WoXsYIe5jikcoS2AIIdsthC1W1+OOurM3/YqTsx7utIMtUzpHPekPsJv5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfltbnQF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfltbnQF"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45377776935so34508835e9.3;
        Wed, 25 Jun 2025 09:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750867963; x=1751472763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L00iBDFoQRjQF0Sjwnm7AidhvF/6qjGok0YJWz7OSCQ=;
        b=lfltbnQFrfKuDXuCtLk2zjDk9aMizOzD2DwsgKN6s24ViaveCsvOViLQFCZNAjom+H
         YLjxFKSc80h7RndmNcDzCSGjkbhOt1G2Lapm2Ceoxpup+dvRkGTuPKZjnIwhw1lnuns+
         YmV/fiDK8hSploNDVct4NmNPHwX7B+0drPXG5oZp2iaM7H6eHBooD61y9XxPVw0K+LcN
         WNCA7bo8GdGf59e/FTwdJJBGfz6398A+p6a2HPoGna0YlaqfPuvzDPl5N8aDkWDTDcgo
         OIjj6IRjo0UedvmUjW023nQat8ABUURFDx/H/qx/l6UfcbpvKmPioUet0tlU3i0oZt10
         fmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750867963; x=1751472763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L00iBDFoQRjQF0Sjwnm7AidhvF/6qjGok0YJWz7OSCQ=;
        b=hEy4yoLyy815bRCrtRHeeYFXlJ+sxDqooDq9BiM5tdbb2dplLLL8ul5UgjmkHb5IZN
         8mudJJs8/muspw95QbbrEl0KPV4KIm2H5Iy+3wORduQMUTiqDYLLHfBeCJwPPRRZQWqu
         jTSHvCh+8SVTpOIx2Ppzb3psdK1N6AvEH/Sp+1UnxiqW3A24AVMIhwz+stwDBgBm6FGc
         WE0ZRyEoBGHQfc/akpl3BkkLJ4duMEyFLiwQzQk7bktt141GTFQc0wVBGnsVkD1dFKDv
         hj2aHDRI5eC732VVl8U8OFuO6brsbTgPU+xgSBAyA824OSKjTnhgEozw6laS4Y7/vb0C
         s9Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUUYPFqe79x9TKLUljx2eENltQ0uhJ45v+8YQ8oKvaWclQPExxLdLecHCztTGsdGVUHEoDkqv6PgNmdzh+Y@vger.kernel.org, AJvYcCVFxcYkZ3JQDZadRVIWqUyPNlHFJHPtyxshw4RUNe8bhyRIxCgKmzD88+NTpfE1ueahogHT7mC3zSruPUmdjNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgI4CDqKLac5a2H27LvGLPkNu9zID6zhIEp0wwT03DjiM3k0pW
	tv/rrIR2h4T4NqdqfEWQADdiOeGXKGXcebyzUiSeO+b4JLBpI6DrPYsh
X-Gm-Gg: ASbGncs0287yZUl5OY8QpQdeomVraBDlRmmHBI0919Re35d+mN7E4OLGHqW2x0gmYhE
	Ro5X8Ecl1UcV1CDT4q5dxAc9HqdYpt3aBIiGyKd14JCwyNIi1zOt1KJjtubAkuBkwLW6oRmWlZn
	p8YTkwJVBdx4rOJ1Lkhs1jIkYrsGeO/CISn5aJaLZxfqMbr2KAPDqeK18Os98pNX8VUzinSBK5l
	mKDmZE/57iyI+1M0U7niAlcn/vfFHieh+1WWZvWjQmw0tM7V83i5b+TQW5iixiIgQ4RyImjrveK
	TFHLp897cgqtnNacJSvDJrV/YPsqWGS4ERj1KTPomG80NB/0lpNy8FAehRM/
X-Google-Smtp-Source: AGHT+IGgnrOznrOrXViQkoRiboW6W28KWLLSjZCidMf+LDGZfhuP95A5A4efNIup2du3aNHdxrx62w==
X-Received: by 2002:a05:600c:4f45:b0:43c:f895:cb4e with SMTP id 5b1f17b1804b1-45383906f07mr34281455e9.17.1750867962942;
        Wed, 25 Jun 2025 09:12:42 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-453847ec763sm16149175e9.36.2025.06.25.09.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 09:12:42 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] fortify: add branch hints on unlikely fortify_panic paths
Date: Wed, 25 Jun 2025 17:12:20 +0100
Message-ID: <20250625161221.295575-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Analysis with gcov while running the stress-ng urandom stressor
shows that there are a couple of fortify panic paths that are highly
unlikely to be executed for well-behaving code. Adding appropriate
branch hints improves the stress-ng urandom stressor my a small
but statistically measureable amount. Ran 100 x 1 minute tests and
measured the stressor bogo-op rates on a Debian based Intel(R)
Core(TM) Ultra 9 285K with a 6.15 kernel with turbo disabled to
reduce jitter.

Results based on a Geometic Mean of 100 tests:

Without patch: 50512.95 bogo-ops/sec
With patch:    50819.58 bogo-ops/sec

%Std.Deviation of ~0.18%, so low jitter in results, improvement of ~0.6%

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 include/linux/fortify-string.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index e4ce1cae03bf..2ab8cb641d70 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -593,9 +593,9 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
 	 * (The SIZE_MAX test is to optimize away checks where the buffer
 	 * lengths are unknown.)
 	 */
-	if (p_size != SIZE_MAX && p_size < size)
+	if (unlikely(p_size != SIZE_MAX && p_size < size))
 		fortify_panic(func, FORTIFY_WRITE, p_size, size, true);
-	else if (q_size != SIZE_MAX && q_size < size)
+	else if (unlikely(q_size != SIZE_MAX && q_size < size))
 		fortify_panic(func, FORTIFY_READ, p_size, size, true);
 
 	/*
-- 
2.50.0

