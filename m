Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DD013B7A8
	for <linux-hardening@vger.kernel.org>; Wed, 14 Feb 2024 19:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707939968; cv=none; b=BKjusM6TTFDYxohkL+mkClIpQAtYR7x267KTAO6jXhx9TMMUiJvxKXQfWUmyXki0sdJtaLgC1s7JEF1ACGpgrn9D39H+SveS1D7j6wHWrxWXopVEZnqrcFxDK+aMMA+Efvod3wX7OlDbghYDzpf8Qj6RDZVtX/mQ5oNjn90elP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707939968; c=relaxed/simple;
	bh=uQwFw+Mvb5FS+5R3O7Kh53oqRz4mjeatqrTjC8hEZtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oaFZxg+sphFxEiu4uJWX2nnLiV52k/1VuIC1IbX5jdPhJmCfLcOuJlo9ap2A9UmztxuvmbILrjkP7moDuqZKOAijAHD8v72vUJhNaiTBSqlBef3kp8VsYYb6WqLYDMOYpAAMKNiCxqTTOOEi0yuR2XMhgpg8pNbkBBJdyf6A36g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=D8xuBx7I; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D8xuBx7I"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-290b37bb7deso149317a91.0
        for <linux-hardening@vger.kernel.org>; Wed, 14 Feb 2024 11:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707939966; x=1708544766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RQAKDqTR0lInodj89i/VDK6/vi1P72VYaaN3v1N7SL0=;
        b=D8xuBx7I48V/7OH6w4xZnEVtQbXRC3j0733USZL7WMhODA5jIUVts65t01IL2BY1YW
         Oewqdf+mEgrWBtiA7ENKCnz7Q9HXYiWYsMgDneRW3PaKjOnA+Rm4DkkuqieGSBcdEcqA
         AELFNBNXNt59AARNxYSfIkNgOTxholfTyljuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707939966; x=1708544766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RQAKDqTR0lInodj89i/VDK6/vi1P72VYaaN3v1N7SL0=;
        b=C8/RYhS63q7GeUrQ0TRSxZRj72hFGaSBagiOcIvporp0OFgQdDT61QsD0OlZpUdOsT
         kywrvzFv9GalaTdLICE46j5peYdCvZQ76QvBOKLtZ6mxPZjxBoKAPrZKm03lYYziQ76l
         htetVu/MeuFrkYLnDP+pxXJIprDy2Q/6loQaK87ZJn/EHAi4rZ4x/5uOPgxUeKy8cgzg
         icIfansCdA6otIRHnnIzJgbRPhjdFJbDhuoY+s+L1FLI7r+wnNGNE+2Dvlyh+ovdPYsa
         TV8Yl5tnVkU8AxNH20Sa/Zxb2SBa37DvxUQ3cj9YaQnrKT1YhtTSWoCLxur7LrGNEmsN
         hHzw==
X-Forwarded-Encrypted: i=1; AJvYcCXRFQ8HKzrJ7JCCUQ78x4MJdm870iTXtAnCCnIhMUc/7G/rh7UnmKT36n5R6hIGrYL+zRkpZ93Vu0I4CVn+AQ9T2uTvJ9zxNQ/WBTuojRQd
X-Gm-Message-State: AOJu0YxvdpCnsYYeZxAmP7nBuDdfnWd0thg+r5dpIIRhth/1QduRoOAB
	cd9ujd+MCN2tCNOh5KEN9Aliya+xR/pFN9B1rK/EW5SUCnKNDJnCNjWz6X1UMg==
X-Google-Smtp-Source: AGHT+IF9qlzQklsSyZNtmLwxche6bOfOb3xCXDfoNNolp4ROMfcVflxY1nID27Av2N8l3L+CYXzzZg==
X-Received: by 2002:a17:90a:c204:b0:296:e2bf:3936 with SMTP id e4-20020a17090ac20400b00296e2bf3936mr3585859pjt.36.1707939966221;
        Wed, 14 Feb 2024 11:46:06 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m6-20020a17090a34c600b00298b9f662ccsm2035619pjf.1.2024.02.14.11.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 11:46:05 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Marco Elver <elver@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v7 0/3] overflow: Introduce wrapping helpers
Date: Wed, 14 Feb 2024 11:46:00 -0800
Message-Id: <20240214194432.makes.837-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1708; i=keescook@chromium.org;
 h=from:subject:message-id; bh=uQwFw+Mvb5FS+5R3O7Kh53oqRz4mjeatqrTjC8hEZtQ=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlzRh7JItobawvLT4rE2d1cpdHERzHGwXC9I9xs
 qRALXG1AQSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZc0YewAKCRCJcvTf3G3A
 JhrrEACQsJK01x9xNqIWqiN+g7wsA5PyZYBoCWe2XUFapCLB759/GdDKBEKBcOJLG45k2wkbClT
 ImuFShGbsHTl146bYDt+tB05yrXftONqA2LJ4PO88nB+0Y8vhYjobHFU41qPz0ga5E5Dcv/7RpB
 1Rl0vZ5gNzI50wj0G8/f2sb1MYCn+b2zcFbbL2mowb87QmXk8GYNsGxVxWkX4QpDWIx+5hwtUeD
 JQ6heHQ4X1MtO5XLu3c755Wc/OhRBR1ery6Gj4fjZVX2+up4rv9Jjqzz9Bil9M00+rBUjjMS9CS
 bjSX0twnUU3vicu5H/18FPuYE0hoG5t0UMtabOtaKWFfl5P63QS1aJwR6tjh7vi9dOuz7zYkrdy
 Ylrnr2sRbU+XlvilOVJiC45SNabbgBIugLp+3tVTt5WARekcIEKEzG9y2klvWErdKSQneNaIqOL
 D2RVGimkB1Pcc95fKDWRN0J9xiChzvjy4GS/dLpcIT/uD6TfGnc1Dg+AaHcdhYIDQXsSNKLe8WW
 DmsGg5ISbmZrIDEhxttKAjxG5eheHZ5SPW67FSXFiAcahYfV1uwvu7HnZb6KFivGz/PZNTUmNbp
 nwxqFLc52D28c6stg0+IbBh8zrtIAWOLkSjrU5mMSIexoPyujbeatubSBQKbeStf9oZ2JJhCvt7
 vFL0ycE knLSqdrg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

v7: - further kern-doc cleanups (Mark)
v6: https://lore.kernel.org/all/20240213220844.it.345-kees@kernel.org/
v5: https://lore.kernel.org/all/20240207152317.do.560-kees@kernel.org/
v4: https://lore.kernel.org/all/20240206102354.make.081-kees@kernel.org/
v3: https://lore.kernel.org/all/20240205090854.make.507-kees@kernel.org/
v2: https://lore.kernel.org/all/20240130220218.it.154-kees@kernel.org/
v1: https://lore.kernel.org/all/20240129182845.work.694-kees@kernel.org/

Hi,

In preparation for gaining instrumentation for signed[1], unsigned[2], and
pointer[3] wrap-around, expand the overflow header to include wrap-around
helpers that can be used to annotate arithmetic where wrapped calculations
are expected (e.g. atomics).

After spending time getting the unsigned integer wrap-around sanitizer
running warning-free on a basic x86_64 boot[4], I think the add/sub/mul
helpers first argument being the output type makes the most sense (as
suggested by Rasmus).

-Kees

Link: https://github.com/KSPP/linux/issues/26 [1]
Link: https://github.com/KSPP/linux/issues/27 [2]
Link: https://github.com/KSPP/linux/issues/344 [3]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=devel/overflow/enable-unsigned-sanitizer [4]


Kees Cook (3):
  overflow: Adjust check_*_overflow() kern-doc to reflect results
  overflow: Introduce wrapping_add(), wrapping_sub(), and wrapping_mul()
  overflow: Introduce wrapping_assign_add() and wrapping_assign_sub()

 include/linux/overflow.h | 101 ++++++++++++++++++++++++++++++++++-----
 lib/overflow_kunit.c     |  67 ++++++++++++++++++++++++--
 2 files changed, 152 insertions(+), 16 deletions(-)

-- 
2.34.1

