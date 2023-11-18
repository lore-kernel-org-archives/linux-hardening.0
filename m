Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IxlGyFRW"
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1E7D7E
	for <linux-hardening@vger.kernel.org>; Fri, 17 Nov 2023 19:32:29 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6ba54c3ed97so2737364b3a.2
        for <linux-hardening@vger.kernel.org>; Fri, 17 Nov 2023 19:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700278348; x=1700883148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yiER6+GNhM8NqF28QHJqC7UhszFlWWtCYJC8eU1ccH8=;
        b=IxlGyFRWhGxkHRMcp73W9+Iv+1K2kyWlOMOFcN3vVwUE4MgCsmMoJERdxTfouup9kl
         O1w+yjn0vvDANgJqaJvGQ5GHEZjsFhqR5TPNLWxpiTGi/Odhsyjl+sPABnXXq3L1GE7i
         fjwEZMxwc3eti1RiOKzzpjYYtlGwQEeXjrg+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700278348; x=1700883148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yiER6+GNhM8NqF28QHJqC7UhszFlWWtCYJC8eU1ccH8=;
        b=v+urHZIyBX3OWzGSH7dxt596m1Y93N0YjPFjx69QW6HRAfLx4XKkmPKN9gf56rq9WS
         o3lyhjtmdzTb7ZQZLwDTxVDswKIm17cb4LMeYrYgnO+d4XRJz/wGfG2Pa2AM3DL/0Kk0
         i9KCrHDYmZa56GXntK8gGvFoh0p1jQljwkny87+6/TlpGXKVCjc/2oFZV8U6vnaHiu0c
         N35h6SxAlh8PtcgP+SvNLH2aAQ0jU58IVBJKHfUVQaH+cCYbshwL/2Zm2Nb54eH24a4D
         0cNOK50rAE5bWS7Gja8OH9vhKPDcojF6F3/4KBAzwis+PHjWRadLTCnIOUO4CaMreMBO
         ghQA==
X-Gm-Message-State: AOJu0YzkdHWILpVR2+Cb78kS+jp+OIbrLT0fcgfrs96VY9l4Z3r1Rebs
	S/J3PKaNz0TTc22AyimTNx9WbA==
X-Google-Smtp-Source: AGHT+IElC4nlkdRBYCPskViEJXuZO3rJQiaQ0pjZMGGYDmFJR4zN8M2X3/kauDNjipobGyDxda48Sw==
X-Received: by 2002:a05:6a00:93a4:b0:68e:4303:edb8 with SMTP id ka36-20020a056a0093a400b0068e4303edb8mr1659893pfb.30.1700278348601;
        Fri, 17 Nov 2023 19:32:28 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q2-20020a63cc42000000b005657495b03bsm2145144pgi.38.2023.11.17.19.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 19:32:26 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Anders Larsen <al@alarsen.net>
Cc: Kees Cook <keescook@chromium.org>,
	Ronald Monthero <debug.penguin32@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 0/2] qnx4: Avoid confusing compiler about buffer lengths
Date: Fri, 17 Nov 2023 19:32:21 -0800
Message-Id: <20231118032638.work.955-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=649; i=keescook@chromium.org;
 h=from:subject:message-id; bh=OMCLpZGQCXtDrFtSkwPrEvTz65pZ01+xbtIVOPQFtnA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlWDBGj6KV93xXmd7bqlrjS6DRqhDkK533J9F4U
 Xqp5Vjhc+mJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZVgwRgAKCRCJcvTf3G3A
 JsaID/9LJTAd4OyUK7Sv5F2BQlJx7xBQDMCck87P/+EqLsaPZPhMgexI14/dvnE36YR63MTGAQe
 jc/WTfRpxi2vn7T4S3+Y9xpqIkqT+6t0DuKZ+lG8LMPuaXfH4FXKf0qJ3jAJ45kpjW6dqQW8x38
 pd+1DpMh2/sXecHgv1gx2BuUgnUX2O0zCq1mllM61OgKVdtB1U2eq4KFNdixXU/GaozjiRz6dWg
 w/q0i32LumgYnN0cIecZKr6pfp7eIluXBkThjMkMC6h+o8gxr1w2Wrd+KPsayJt2M9E9tqJ0Tpi
 CrhQa68PUZpk0GM1aPXalSarCaJxDK/ox13vvUOnNO45uHzFRuZo0+I4jilsWujnDeUDp6E6cpz
 o7ynfot8hgByy2p3LpIQqblI3G/q/vnrNHUlFg9HUI/ZevijcXuaop+YrTI6tSiNo9IpiHl01r+
 uqaZsRL3tsJNkJ453t8c9Ww+4uUdBzozmeW9w+6/Csnsvm4qW9wRQGaVrLmJTB1ZSYEpdb3hbjk
 /cyPUXIzwZn9/dQnSaPBOpL1LZt0oMkqQXeNWBKG57loKutLemyJk1WXeaP8CbsGxSo8xVqlTyL
 jb2C4ENFU/8s50B6Rk20z8Rxwx83pzMtjiHqyPTXnbTg6hU7RM4/s+htVPwaoosHrzpymFRwyqT
 6wpwAow2 k+a2s4g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

This attempts to fix the issue Ronald Monthero found[1]. Avoids using a
too-short struct buffer when reading the string, by using the existing
struct union.

-Kees

[1] https://lore.kernel.org/lkml/20231112095353.579855-1-debug.penguin32@gmail.com/

Kees Cook (2):
  qnx4: Extract dir entry filename processing into helper
  qnx4: Use get_directory_fname() in qnx4_match()

 fs/qnx4/dir.c   | 52 ++++++-------------------------------------
 fs/qnx4/namei.c | 29 +++++++++---------------
 fs/qnx4/qnx4.h  | 59 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 63 deletions(-)

-- 
2.34.1

