Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF1D182C93
	for <linux-hardening@vger.kernel.org>; Tue, 14 May 2024 23:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715729880; cv=none; b=IhHk0FSP8TFrykei+7NHkE8TqhWXsI3vwLnw9zBKsp7hV52o0iAUpFNr4QifRe1jfdtfxj+mJ/UgfToYVLgogQjSi9j4AWUOMXneB8rPgsevZNBrsUfbRqg2btBcdqN/+iM04fVgprboqRmx1uh1rpVNOI8nAXrCaMYskqwERI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715729880; c=relaxed/simple;
	bh=M0ojsRsGu00hlS+3D/N7mtRoW2fXDtGb0dL7Dj9nSEI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BbGgiNcyQTBMX0kDA46Q9BNqQOBiRpVdYXKMSXC3ul4VfmvRHeNNO8brQSydqHwDElGgY/1vBSYsPyE7RFOELRwZKg3Snb2wjiHwkHMMRAqNB3NumoFJxxICeOXidOXKC1fKottEQRh9WZ6FaG7Bcent1rsDd+Gfht7kuDAOYX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XMRYHZwv; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XMRYHZwv"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f44ed6e82fso5451014b3a.3
        for <linux-hardening@vger.kernel.org>; Tue, 14 May 2024 16:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715729878; x=1716334678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U/46gzPRjfsjywIh4JZDG9x4PubRXzjsJhZrxZRHzS8=;
        b=XMRYHZwv1mBGvBcx6lSEfGBbDW4MMi40t3slgMuu4Pp7Wt3luR+mizh03LmcSf85ak
         0dVF6s7MQ6VoRzzYEJCkcKS45zOkai1q9OCU4pp+2FqaeaW18bI+ZN9TjjuODgCtMWIy
         U28Z+B7RIOrtCDbP1zF1L5ovEGmzzBPApfGLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715729878; x=1716334678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/46gzPRjfsjywIh4JZDG9x4PubRXzjsJhZrxZRHzS8=;
        b=Nw/elEcVi66ph8T0vrtkyqPW0XUY89QPSatea6O+kR6zKIkZLN3CJTd8zY//ppnywa
         quYrry9QTb9fTyuqnZMDwfIsEcrHBQhH2vRVAwh/Fv2kOnPMk+1E+YKhhYQ78X8VT4Y7
         VbEFd35suL2yB0dZoGThny9oa5xYYq3yT3Cxx5q9izHchZ7RH6dPfWafBJbvHmkv9eEB
         iPpVT2y7UUHYUxqX5x/LNQumTwoe5N7lyhCyP2hHLr6HiU/jyIOZvOYkZRqc7EF8KQFg
         jSyLPAMPvWtLlbtukR9q5Gr8Hdbn+e4L3KSRBiV2y8QBRNhBfWgL4UjRuSJ0sLUH4dgv
         suxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpX6C5dWBhVW3Ae6dzJsOuXKcajhr1MEGl2rzHwWGDRf4vBy/CVC45I3xqMc5vI0Sdk8sU/QFw1BmpblDO6Wy5q2yCqypGiyqjrp3BbDL/
X-Gm-Message-State: AOJu0Yw/bFr27j1E49nEdLSWvpGBVm1oNDpBca1ofkGGadVda5ahc7nY
	Lyxupin0ZpvtB36G1ExWn+sXOxqzxi4wmtEImOSWGv8JH4YnfC5/ZnKKXdtlgA==
X-Google-Smtp-Source: AGHT+IHkWP0liojNW9LtVuhI4Z2GrRahcPNwxeY6SopHSto2NofFRMQtA1v0XzpbwKOEEaFOcB1wng==
X-Received: by 2002:a05:6a20:9782:b0:1af:ab0b:1c08 with SMTP id adf61e73a8af0-1afde1b6f80mr14140701637.46.1715729878103;
        Tue, 14 May 2024 16:37:58 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340b76e262sm8858679a12.35.2024.05.14.16.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 16:37:57 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ubsan: Restore dependency on ARCH_HAS_UBSAN
Date: Tue, 14 May 2024 16:37:48 -0700
Message-Id: <20240514233747.work.441-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1157; i=keescook@chromium.org;
 h=from:subject:message-id; bh=M0ojsRsGu00hlS+3D/N7mtRoW2fXDtGb0dL7Dj9nSEI=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmQ/XL0cMiBAzkKwdeLzy9N0TrgLVfExeGQZ0JN
 BHF7seFPsyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZkP1ywAKCRCJcvTf3G3A
 JgcVD/wOawyFjlRnf29/qod98RqXmvKGYR/z9gCakCBi8CxR4/Svp5cc0T+1pQzJxoBBpejCMg0
 pxH/ab2G44oXnSULaNGapGZ9ntp42d7DnWiaGdghDJs4jq3mBvhU0185EFH6k8FjNeio8qOlkzv
 LB+qmxeol6rTzNUICQEJtpC7MjGXDrI/JUqDk1fZv6ff4wyQo98trBnhME4QDzoTGzodcr85+MK
 seSwVJg6ecBebIIFhz3DVVzIJnNxeMxEnZpTEssJLlImhYpeycEbBFSR2zDyTvse/FGdwy0pUFK
 QM4cI+mh8yFa/+zN3C68no7tg2X4sBU9dMnRmQbj9mASW8Sb0QSnWVxY3v+5RlMTtESHi/17hNW
 rrv7je0gK4u7WSLM2ayMhcVuGBo6QNx23Jl4PnB/3ONTkgDdcPszSp0ZPMC+ZxifMJF1myji/kE
 JhrrIhEKljsD6Di1P0ATy6w3ZgKnqu0lFKIGkOetXWIFTOYefwC1q4MH7b3xDklAqAlIsBvEaR7
 1aQCDkbTy/0YQCvK0n2IUMBrFXZR3VYLlbk9MzllZAeApJm3Hv9Kw1O7MDrj9bViSqrlzXNA2H7
 OBDGcCh6D4DMvDBgFJO4rmlnrgsvq0AgWoOTzGdS8A0pH9fGFC06u3z1Jj9A2K/lntAbCWi1qKp
 9P8N+ld MNH39rig==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

While removing CONFIG_UBSAN_SANITIZE_ALL, ARCH_HAS_UBSAN wasn't correctly
depended on. Restore this, as we do not want to attempt UBSAN builds
unless it's actually been tested on a given architecture.

Reported-by: Masahiro Yamada <masahiroy@kernel.org>
Closes: https://lore.kernel.org/all/20240514095427.541201-1-masahiroy@kernel.org
Fixes: 918327e9b7ff ("ubsan: Remove CONFIG_UBSAN_SANITIZE_ALL")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Marco Elver <elver@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: kasan-dev@googlegroups.com
Cc: linux-hardening@vger.kernel.org
---
 lib/Kconfig.ubsan | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index e81e1ac4a919..bdda600f8dfb 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -4,6 +4,7 @@ config ARCH_HAS_UBSAN
 
 menuconfig UBSAN
 	bool "Undefined behaviour sanity checker"
+	depends on ARCH_HAS_UBSAN
 	help
 	  This option enables the Undefined Behaviour sanity checker.
 	  Compile-time instrumentation is used to detect various undefined
-- 
2.34.1

