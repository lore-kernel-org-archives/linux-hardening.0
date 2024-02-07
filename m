Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C2F7E791
	for <linux-hardening@vger.kernel.org>; Wed,  7 Feb 2024 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707319466; cv=none; b=TbMf3DqNb9hx/HZxf3WV/lkPuJb+MR1hMvSZe78Lq1Tb5uAc89IqVHCafCSLRbGSVaJz64UbD3kRavaBP5CLuFfquQ5mnZFnDXxgUy0SB8hQjIy9OawM3A4MxBPmjkDPc0D/Rv+XGPegcBIdQqBukqnMF05LHrF68VOZcRKSLkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707319466; c=relaxed/simple;
	bh=4p2EQPheTGW1muNZPNy/adJj7bHOmG0Cp4WlpE7Yd4c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m0JhiHcGKDqJLeDJPG/u1wdiCNn03x9uIr6jz0dRinJ88sT6TpRa3EGBL9jN8PtKBkIybqWgVSniSOOOAgl6OeM0MhTuyw+iDeM7gx1Qn8IRylLhC3wS4VX65TcbkGN81+0+jtyfMaZlGGk6C8si6MlmifMSEEEFPB58zFrOtx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hvJLEGYi; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hvJLEGYi"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e071953676so96390b3a.2
        for <linux-hardening@vger.kernel.org>; Wed, 07 Feb 2024 07:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707319464; x=1707924264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oAK9OrGZjXzm8EXOs5XutKZoyM3A9aclYEfT/WMb9pc=;
        b=hvJLEGYil06EihX0tnY4bKR2kH+f+mQjw4biIheIErsG9Jup/9uCuOPe63WJ1IozTE
         Ji3sB8O96i562co6d0PnprOrXEPvinkEepVUYWYfIEY+URrYk6PprGSqa4yPtCMnu9fS
         pAYn97BeZZm3fg+AbcB1zjarb7NNQicCchyAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707319464; x=1707924264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oAK9OrGZjXzm8EXOs5XutKZoyM3A9aclYEfT/WMb9pc=;
        b=Q5Je5/AuSa6VUHGmidoQ/VDNTGmNBS9X75uWY0jd3X1nihfCyb761tbnyJDQs3UwrN
         pK0fNlT1Mr2/hXeeupiGYtEro2AfmPf/5OaKo7xT+6urVvzsoYcAdj47PVFzcxIOWuSh
         Sr3x68bj3+yQibImD/7OBjON2YN35WR2hjRXXA1MfVu+sojoxPuwWqDW3cNrZDmN3LTh
         wg871uQoBi/qcirZon/h02CtXhHsD8l7Fgg6LCn8h+8/5Zqas8AMPKGuHynwPWpuWZMQ
         w6Oh152o2hD4bRpvPTGmoHNnPy9o7v+Vd2M/TdXMrg3CfxOxIwNtRVOHKaa4w0RQ58eT
         PZKQ==
X-Gm-Message-State: AOJu0Yw0RGtjpoL6ijaPAlNSsAjNR/LRrPp94UXmBMYKq5DpIl4L5QSA
	AH62LB6HZOg+Z4ZliNlPH+xYNP632IqwP9ATrk/C/JQzIrVRen43kASNGmj1vQ==
X-Google-Smtp-Source: AGHT+IEqPprkNVwhpI90CTw23T3Feu+GFWYcLUcAy66o4nQicEfnZ99g1UrYPJVGkSE2t5mVX9Y2RQ==
X-Received: by 2002:a05:6a00:cc6:b0:6d9:bb2f:3a69 with SMTP id b6-20020a056a000cc600b006d9bb2f3a69mr3441777pfv.28.1707319464108;
        Wed, 07 Feb 2024 07:24:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW9jFJsT5ownCtSUmO/shqpRpWsX9ZXP2HyGJcyowQ/DPHBFvs7CeclJdTC6Mz6utqy0Lz/mrymx/Wui/2twMrt55RBtTQkDaKXzQJ42Hp2rqYhQ4/6qsLTUoVm257UqgYDT+jHs1G62/RcDfIpGC6c971GuqdtoCajHBTJrJNQ1Q0gjrkPx/JSisGWwWA/ElK9ZDUBRS8JQEG6OHIObUTQKjPWEhf9qpDGzCgwvdHrzIV66lWssSncI3+KXs+gm24b1O/fqbfwWP0KdBBAA+01cK0IpxOV6Q/KOEbnQNnCDc+8vJPdAxpLBrEjNRLtsp3C17yZcrm1RA==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id lb4-20020a056a004f0400b006dde18ed7dbsm1762170pfb.170.2024.02.07.07.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 07:24:23 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Marco Elver <elver@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v5 0/3] overflow: Introduce wrapping helpers
Date: Wed,  7 Feb 2024 07:24:17 -0800
Message-Id: <20240207152317.do.560-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1282; i=keescook@chromium.org;
 h=from:subject:message-id; bh=4p2EQPheTGW1muNZPNy/adJj7bHOmG0Cp4WlpE7Yd4c=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlw6CjkfkdfRS6eRsgDPzLkc+pAsOKiFWEGvoZD
 bRHJ+LSx4OJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcOgowAKCRCJcvTf3G3A
 Jm99D/4mEeW8nnw7WOCR71kBtI0IIM0RueXokgZGNjpwAVOWPW86MPEI6byvsphrXynFdNYf3u2
 zUDukAaJYiixTumjPpQBy2nZjmlyRMaUJN1j8pQUUlES8MnVH2iqf2e26wJzEjDrKoPZtNUn8Lv
 YA7GQchdB/JS6FFzak5OgrIUP5gPmcfirpmD9qJMpGU+MBa/YBx0TVEswGwuE3xNLs85FJy9PpU
 ih36Jov7LjkzKgZeWWF7aHluyCZh9RZ2SnNCKu6eT15cGzP5/DzV/YDngxGAOMTUmnsnv10CVCw
 EQAqWX6LAd/ikWkMBZiscvFLfiBWT2DPU9TW75QcgETILt0qowsqXPawhz7NLgzwsTIFvZ4nik1
 FCUhtkZOuk210Eh1lTGAYpyEl0D8dCd2LZVFLoQFZedEXFMagXjpTlNY3g40xjfwhoTLoLfkt2V
 /DQoQRGemo93jtG4ivHvYezH9huvo5wesYjrLju95KEwyEAFtBEJS5ZE7qpY9HoLZ/PwYfVBwe8
 X46lQKAk0DtOhcRigkTb8tBM7nRKw6vZNcB1DAG0GHcVO05cgvsO3/RixOCsQaWmPrFjPyc8W+X
 9n+2JWJ3niyIMW7RyZUJGOtgdREsshrRlhB4NFa2iCY/0UhNqXFXrTqmuyMekiEUjEOgENccD1A
 PCZ0QPP CI6i53NA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

v5: drop redundant checks (gustavo)
v4: https://lore.kernel.org/linux-hardening/20240206102354.make.081-kees@kernel.org/
v3: https://lore.kernel.org/all/20240205090854.make.507-kees@kernel.org/
v2: https://lore.kernel.org/all/20240130220218.it.154-kees@kernel.org/
v1: https://lore.kernel.org/lkml/20240129182845.work.694-kees@kernel.org/

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


Kees Cook (3):
  overflow: Adjust check_*_overflow() kern-doc to reflect results
  overflow: Introduce wrapping_add(), wrapping_sub(), and wrapping_mul()
  overflow: Introduce wrapping_inc() and wrapping_dec()

 include/linux/overflow.h | 98 +++++++++++++++++++++++++++++++++++-----
 lib/overflow_kunit.c     | 67 +++++++++++++++++++++++++--
 2 files changed, 149 insertions(+), 16 deletions(-)

-- 
2.34.1

