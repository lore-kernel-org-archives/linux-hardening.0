Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06C4128833
	for <linux-hardening@vger.kernel.org>; Fri, 23 Feb 2024 16:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708707590; cv=none; b=kck1sftSkVjyPlCIvAisIE6iNLXDF7T/rzwrbpdww+I6d6MFtHtLgW4xK3Dsu4S7TMbTwU/MVtaqM/2MPzP/amXPIxhFJ7F94C3vbTMF6VDf5vQbbrSB6aDzpOvTDsJqfrWP3lIAsTk+1Eh12x2xLsLK5WR2qBmPjZzqp25Vbn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708707590; c=relaxed/simple;
	bh=GFnd+uRgcZ5JE6+yaYSUeEigjBZZ5ehiRJbCdQFjMSg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ozekoIdvCTY2azSc2/ucZPKKWjmewyAOwP6c0RJ53waWnFutXRPQDkCiOLDFwaCSlFrKzI0IWHG2WQQEyj0eJbtpu3Sl2SFE6rNfnHB6ufIv9muiBoZPo8M9BtqfmFWD2l7Y7MY+hGpbxM+u0OAljmklIQvWisKF09T5xyJV4W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nitAuW0n; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nitAuW0n"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e4ca46ab04so363462b3a.3
        for <linux-hardening@vger.kernel.org>; Fri, 23 Feb 2024 08:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708707588; x=1709312388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FDMzDk/lBMFwiZnh7jtuEycU3dW7wec2i4CrQjkGJo4=;
        b=nitAuW0nEJXqcuwrvok8CkVkbfn2pnfOCTGqhqgni0qOUhvTAhltyrpkmRwSRrbh0B
         98mW8FxQhTkRddbNuvjY1OlR4EehYdeL0eARCJG8gW0y3gsHiuUVmVyOiDl/jLh1TF5D
         j58bfHK882zi2L5G6JAhTPLzgzIjkBqHE0PuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708707588; x=1709312388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDMzDk/lBMFwiZnh7jtuEycU3dW7wec2i4CrQjkGJo4=;
        b=nFKzF3Cl3KLnmAyR798Q/i3acTCu37vUGeqDFyt/ul2QJXDAnZFEiCTxVNg2ysB5Ik
         LW38xYVv46a3Ko+WEIgzXXirC3ne46Xes/533p36lH1ZC9aXHknxOqtK+I2AzPBJwxY1
         atXoEMUtdz8coztuGH6pnc1U8nHO6cZFc3/gu9G88/IzSuf6gI8yRIWrL3FLHla0yoo+
         4GjXpCPlqfE81i+vUvkg7MvjQTyixMLm99HlN/89FtDimFmLZTJapV5WkMAWDiA+c6ow
         qGA+qxBDF0bkzabp4UjkzG+9vrv9nSn8TytzvuatDh19j8N1wAS8h7x02JrmI2VCxkpK
         Swig==
X-Forwarded-Encrypted: i=1; AJvYcCXxvguUzLZNPGixpK8i2OAyqkdSb2LLPCPQLOvf/kimZEGsLT4c28gA/4XMS48UGmo8IsoRjRGCtIHCCuAsqrCT212bxh4BXBUEbjQZ4FVn
X-Gm-Message-State: AOJu0YwptrtPjQUb1Z1MTyV5/TrrZoxX9WHYLvl84wupkdGXmUur1cgF
	eSE00GHjsbghK4tKsPcWwtJByKfvi3h5CABPMyXnldKXzsgEpVFO59yJMCcN0A==
X-Google-Smtp-Source: AGHT+IHX/Yc4T9nL5wRR/DYkhblZDpzp2THzLbdrmdP4IR1mBZ1kcT2liaypJSpebHmorYbeiH+inw==
X-Received: by 2002:aa7:9d82:0:b0:6e3:636b:dd99 with SMTP id f2-20020aa79d82000000b006e3636bdd99mr331864pfq.24.1708707588228;
        Fri, 23 Feb 2024 08:59:48 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o74-20020a62cd4d000000b006e3f09fd6a7sm11865200pfg.85.2024.02.23.08.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 08:59:47 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: Kees Cook <keescook@chromium.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Helge Deller <deller@gmx.de>,
	Guo Ren <guoren@kernel.org>,
	sparclinux@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] sparc: vdso: Disable UBSAN instrumentation
Date: Fri, 23 Feb 2024 08:59:45 -0800
Message-Id: <20240223165942.work.950-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=997; i=keescook@chromium.org;
 h=from:subject:message-id; bh=GFnd+uRgcZ5JE6+yaYSUeEigjBZZ5ehiRJbCdQFjMSg=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl2M8BVTkPTYzeAtIdjSlijqw9uZvhDwrdnLvn9
 blIHXwVpeGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZdjPAQAKCRCJcvTf3G3A
 JoCwEACKVFAmUO4no0Qaxq8qbED2OYobHjEx8UJ+OGsvTvGLxdH8D7zH1Jm07MIB5qteNWszAPW
 mmeZi2C8ojqf8QZCcqjRXQJWlCBUm6nET1lK20B7bHNNenRsAU3f+oq4vdh143ne09ThQL0vycD
 GkDx6xhb0cdwF/fuoUugrYKfxI242MeUa/lIkLQMoxXyJ+uQvBLKYtshUKKs/AdBkdZ56fsAR6W
 WK/+Q26n6BKUSxtMnNvhGt+AiOe0ElsbAbAPLSAf/+ACWu34JMXSe6b3o6WbemF7w6zZSFfxx3L
 aiWCjVpYB49at5XwwkPh4ZiViM11V4RJIIV8Wq2Lj3Wn2SfL+xAfohSXysGvuiAxtXG7wgnWXCl
 YkaEHux6vs5pt1/gsv6WKr+/UpXZvWQJkqpYBmRJY502AnAbYg00exgRnJoCpHC2bgyAS+cb9Zu
 YqnvktgImg3XSAhBvOhxXMf/40ggBFstPwm6YOucNM1IdW4aKRktYWll8E0i3M54hNRCm8eREdF
 7CUN7Wo3pISsoJ5iWpsP3QdnuKVtUTXyu7XI5CcS33ZzxMMFpWTwMH1yZcEwM7e5+h4a4tSFsuK
 jSEdGEu1KEwGh3gepDThUCJTuVkHMRQLz80mbbn4/SrwStrx23fql2KEfgBMP0h30pfMsV78289
 Q67U30eW 2zupgVA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The UBSAN instrumentation cannot work in the vDSO since it is executing
in userspace, so disable it in the Makefile. Fixes the build failures
such as:

arch/sparc/vdso/vclock_gettime.c:217: undefined reference to `__ubsan_handle_shift_out_of_bounds'

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Helge Deller <deller@gmx.de>
Cc: Guo Ren <guoren@kernel.org>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/vdso/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index 7f5eedf1f5e0..e8aef2c8ae99 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -2,6 +2,7 @@
 #
 # Building vDSO images for sparc.
 #
+UBSAN_SANITIZE := n
 
 # files to link into the vdso
 vobjs-y := vdso-note.o vclock_gettime.o
-- 
2.34.1

