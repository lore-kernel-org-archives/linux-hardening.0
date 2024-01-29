Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD6923754
	for <linux-hardening@vger.kernel.org>; Mon, 29 Jan 2024 18:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553256; cv=none; b=aJUI0z3/9MEseeGZXQ3drBC3pY5pwXV8+MXRd+pjBz27QRjke3to0ShS1MoDi1JKtzKvd/CZdg1yLsqLCd6j2AKPBu59qPDT+jDyqgW/o884pFZxQjcSBbnK4otPdNRAAZUmlEhyX96y/qhZ+AgEiUIevAUA6XGpAtleHWJq7OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553256; c=relaxed/simple;
	bh=sykIKnnrM/Tq4GsiYgDxejFBimKJxMarhf8XS35G4kY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=urZLRCGl6BhGMIFwLJCwLaSB9wg3H5KUfVxJ+AqqLnkRsEzinri7BXG9jLHhabrFGa+gIpAMXi41xGPY2CGcRYTavip9nnp8jEqdb/m/Wts6n9jwQlXhQQDupYfLpZ+rZTgKvCDa+UvrcL25h9m3NGNglwbQgCl1kEaYVWMTvus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=N/+623SB; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N/+623SB"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e0f43074edso1634364a34.1
        for <linux-hardening@vger.kernel.org>; Mon, 29 Jan 2024 10:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706553254; x=1707158054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tQZMalWykTk3vgtbbEE7gYZKbUCrVNjRysAePpbg1wY=;
        b=N/+623SB7aluoP8pSVtnMQcYXPZ9EUOAxT1uLt5wTwP+BDJzBIb4pWZMm8kPOUxuCO
         4KxDO1JkR41FzeeUjQd3cDeHt2i+KyNaHpPW01fm5YYlGIRMLCW2aNOGcm+IzhHvD7TP
         kjOxyPZXq6nu63d6IRBmACDmIXbn+bkx/HjAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706553254; x=1707158054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tQZMalWykTk3vgtbbEE7gYZKbUCrVNjRysAePpbg1wY=;
        b=hnODXJ+5J0QPFsLEJNzcVIe1Ni58P+NczYi4kBo/LosmlSyLuk0IqGQmB8erblE5Lk
         fohg2X6rG+O/c1OLqxslEaWk1Y550ZF6IWqGt5xej4snrgU3A6PxhsfhPiSx/Z5KK/4d
         UPlCWQW94KS3IpLrzf8AzqloRyW97o4f4QUiJsRAWXAkYet2YOeEk9kRYJ3/E5iDWJHu
         vNJ1pqsNN6ZYppDjfPQG2ZOskWD8nth7uwS5NbelvCRQAoLX+SEmOmStWr16BId1xvZf
         p9E0OLjg732e/0k+DqIj7MGkXZHIrWqiesjBiu9fqd5Ng1klQoV5/ZPTJwSoh4QyO5k1
         9zIw==
X-Gm-Message-State: AOJu0YyDjaCdp5uyGwuBR5rtwr+rg8rieQC+SMHhOt+ukPcDL6jNWgdE
	I9YN6NZHsPiTdxIgdaTOy4hLaFnJTv0m4ncxCH3CdsVLRtno1/Wl6OVSRpDOsQ==
X-Google-Smtp-Source: AGHT+IECBsbS7u7XFHZmnkWqyadB34otpS52vGei0xLV1m4FuHE8ysocX+XH291pfSc1gBPJjyrtDg==
X-Received: by 2002:a05:6830:4c2:b0:6e1:1501:58a5 with SMTP id s2-20020a05683004c200b006e1150158a5mr2470636otd.13.1706553253796;
        Mon, 29 Jan 2024 10:34:13 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u13-20020a63454d000000b005cd86cd9055sm6444096pgk.1.2024.01.29.10.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 10:34:11 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 0/5] overflow: Introduce wrapping helpers
Date: Mon, 29 Jan 2024 10:34:04 -0800
Message-Id: <20240129182845.work.694-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1333; i=keescook@chromium.org;
 h=from:subject:message-id; bh=sykIKnnrM/Tq4GsiYgDxejFBimKJxMarhf8XS35G4kY=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlt++hEJVKpFdvCiAx8Q/mObx1CgrX0Lw0G78CF
 DG+RYHob8mJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZbfvoQAKCRCJcvTf3G3A
 JubpD/4uRX6VWoyTmO/bqAhPykYcb0ySLPFMApmFO5Iaubx5mG2oUdJM668VghQpIv/0cjKMfSo
 RUxnR+dWYSUgf9EzEIhvSKIB65MD9SLIOfri4IUimE/NZg0sYPPCG/9gSGwrFh2GA1sPMCZ9U+i
 9yw/YXFoX0NIc13TV2nr5aDk20+AyGKA7kujacCfZUNsGD/eg8gXb8t+79xoeYJyL/itFh3DsCE
 v4wmBQCihgO/HmtxsfSgzhLGzEC/m/UqIzgcZnWcqEWyKsJefKsBC4YHayOr6zsiozCxmJkEKtq
 vtNagEbkVgUvp72KgRGjXaRuFPW1Bcx6B+XGXgUT9UpQXB7jz/gFlTsexIGI9I9ptNVDGOOK8K6
 5Y34FNYRVpUPpeG4WZ8IWFxwc0r07D5yp5tYmrpIWBmuEIBo6K2Uc1Pp36Zz2m8yGba8RjxXdCP
 9JZZIbqTUYUpQwxdykmFu/cjCLRtuH7RX+R6c7JBqumO7a44/wfuU4zx1JpGy8Hgy24WXCYn204
 WYkbECDYnf1VQhOINJuJPoR6qziknXMfdbew6RlPR6ZSNkBFk8ngRo29gcSd2Y7++1WiJ7zllT6
 REpmSDuaq54hmvH2OixfMppYMymkGJI9rEn8QKfSnNORdL1ja4V6wnGCTOwfRpKT7vRZJ/NCvM7
 ObdqLaG AqGQSPDg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

In preparation for gaining instrumentation for signed[1], unsigned[2], and
pointer[3] wrap-around, expand the overflow header to include wrap-around
helpers that can be used to annotate arithmetic where wrapped calculations
are expected (e.g. atomics).

After spending time getting the unsigned integer wrap-around sanitizer
running warning-free on a basic x86_64 boot[4], I think the *_wrap()
helpers first argument being the output type makes the most sense (as
suggested by Rasmus).

-Kees

Link: https://github.com/KSPP/linux/issues/26 [1]
Link: https://github.com/KSPP/linux/issues/27 [2]
Link: https://github.com/KSPP/linux/issues/344 [3]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=devel/overflow/enable-unsigned-sanitizer [4]

Kees Cook (5):
  overflow: Adjust check_*_overflow() kern-doc to reflect results
  overflow: Expand check_add_overflow() for pointer addition
  overflow: Introduce add_would_overflow()
  overflow: Introduce add_wrap(), sub_wrap(), and mul_wrap()
  overflow: Introduce inc_wrap() and dec_wrap()

 include/linux/compiler_types.h |  10 ++
 include/linux/overflow.h       | 164 ++++++++++++++++++++++++++++++---
 lib/overflow_kunit.c           |  77 ++++++++++++++--
 3 files changed, 228 insertions(+), 23 deletions(-)

-- 
2.34.1

