Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8B63C46B
	for <linux-hardening@vger.kernel.org>; Fri,  1 Mar 2024 20:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709324856; cv=none; b=VIc6qNzmkKZIs+N9YCKgUNt+rO7ePCEwaok5Ueolo31rI2bv76p8DO32k3/bztkdLGIxmaYb1GDC4GQc4GHPLZ674bXNT31kXSjh2dCFF0M5lzfYtUMZL8BXk20+omch2FhIAoDhrqBzT8iPu9bY/hzlElYQzpiZsEtuGmAWEKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709324856; c=relaxed/simple;
	bh=DnUJs5+uISqN9crku1KoMOQ953Bxm+qboqKzjh/95IE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uFAkSPPjY0zbuSXI7Tff51RowCXFCTp/o7zIEDbZgYcE3eYL1a8A4GJWWPNelvdRCywmHX+ecMQnWzZOrolipS/bXloQ+FgCA5w7FrSnXlcix9zKpmgjXgNhiR+aM8kddcpvFJdW38/w6VNwmsdzq6R3G3vy243027AAjdDY5EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GCsC91Eq; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GCsC91Eq"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso2091433a12.3
        for <linux-hardening@vger.kernel.org>; Fri, 01 Mar 2024 12:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709324854; x=1709929654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FbfKK2EYH3OSU0GBIWu6lSnSWqW1KYjbvzvVhBb4gRQ=;
        b=GCsC91Eqgvyh4afFCuSz8H3qZ8QqrZDoprnVqDBINTy173L8fMqWw5rnkita0+fRmn
         XIbAYw1IFkWxA2iBOpwFaFKHUmVyKpSPW5l7Gt3titTuB37KZlgkikp0sO+iM/DEWHQ4
         qjDSly3WY52FReUEKQu+b+0P2uI5LiGS/+VwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709324854; x=1709929654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FbfKK2EYH3OSU0GBIWu6lSnSWqW1KYjbvzvVhBb4gRQ=;
        b=YMO5U8lIL44Oq1rVR6gpFLrmhY5de4deNjHi1fcBN2JM1hdHrqdJFuXtuD5lQACQ1B
         3jg+5H/LcDNGlYEobbB3DIf6TfNjz6nRMhiV1cinkNbpWfoZ4p6zhWp7gZ+lDEQGiJVp
         8ObjDKLT7BbJKwt8gpOMVrKKGjvqBC3nVKBL2lSKIt4VzAAPOvdDGcVRh7nEZex/UtgD
         Bn+B7rO/v28pL3GFFPwq27Dz4RH5oop2+263npIawFBlg1zFi7pDWzzm2Nd8iuDkBXx5
         rB/eIJcF/yglMNuDxmOpX6abuK988uO49Ak8nt+yWwgMlYohOsx4eQXA+31DqiS8N4wM
         +ZiA==
X-Forwarded-Encrypted: i=1; AJvYcCX+8gwUG7xSZDwcdweJl3nzFO5PNUhYXR5HU/wixBfRtoF6Lqqo8OhHcT0L4onshQThogVq6nOObu1z4IRe6guBxiT9fc63Y7yHD9Q3GEMK
X-Gm-Message-State: AOJu0YwNZtuErgwxiFhggbkn4u7eAgiP9nUo+tKVPED0MCncCWY2HGhI
	6PKJi23e5bTyj3802b3hxTYRc0Lv3sRdKMxf3ZuND460pSS69kz7qXtFdISKiQ==
X-Google-Smtp-Source: AGHT+IFCqqO7wZ18+05UaKVoS8w2IKK+O4ARDFgyorWuSmx3ehlO/p40sKlA9YJ91qT+gZfsdivgyw==
X-Received: by 2002:a17:90a:b394:b0:299:42d1:91df with SMTP id e20-20020a17090ab39400b0029942d191dfmr2788029pjr.14.1709324854080;
        Fri, 01 Mar 2024 12:27:34 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d23-20020a17090ac25700b0029ae07f56b3sm3668071pjx.5.2024.03.01.12.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 12:27:33 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 0/2] string: Convert selftests to KUnit
Date: Fri,  1 Mar 2024 12:27:29 -0800
Message-Id: <20240301202524.make.800-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=908; i=keescook@chromium.org;
 h=from:subject:message-id; bh=DnUJs5+uISqN9crku1KoMOQ953Bxm+qboqKzjh/95IE=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl4jozssJSDBeQ6SS3cHQIRC2M+sjmHVadtdbbw
 jC5BioxJFiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZeI6MwAKCRCJcvTf3G3A
 JgAED/wII/zyCWUkDErz/vQ6I40XSy0Zfa+6aIzCeKJUsXVuJMl2azaL/wTX76kzKuFWFI3Wy0S
 sTXJNJXeop+Q+XlCfSly/87MqGuRNs1C3YO1X6Eus9r5gHPoH5+dqrxsbatTlJWjdpNNAeV8XZ7
 fiR7J1Kxrt3YJvc/5vzyQWer+pJ1+4q7XEaGYhEAJC3mXP05xtYmJXPIT71g6SxLq1O4fSytCcp
 MHrb+0zvyD5TMvWWqnTMXF0tcMLbEN4R0RhLwaPVG2zAYk68AIATv3G07QIF7qMZO9VHZrojU+n
 B/GG4Ja8jOSkjDoxnrwKG4xPpTVVoTHBOlR9hBb8M77vEbbeAFPnTuleTZj7uJ5tcCqbT4Ilma/
 dCp+4insJmj/jnJDMzBy6h4BGlKnPETxb1p+pFF1fJUQC2vVkKeO0nupw2dn5Zw2Dfm4cWiH3u8
 2j/+HNJVh2/8piWORl29kMlyuWNkhLv11IwFyj4ZzYvMLguw2vW25dgEzLSCLRDgNe2SPp52J16
 O1vBXB2xfe9Z7ZojvMt3IhoT5yVHX4zGRjDRh0u9ZetvjNE4YyDz6EkOx7JFUcfOP8XqpeHWKC1
 HbiPUBPVFk6GNm1LgSQa2j8UiqVvhbQWvxEYXw8hP4IGGStOxyshAqpn0iju37SS6+lNWe2NOrQ
 ImSrpdg/ 4ST6TkA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

I realized the string selftests hadn't been converted to KUnit yet. Do that.

-Kees

 v3: retain all text context in failure reporting
 v2: https://lore.kernel.org/lkml/20240301002416.it.092-kees@kernel.org/
 v1: https://lore.kernel.org/lkml/20240229233432.work.675-kees@kernel.org/


Kees Cook (2):
  string: Convert selftest to KUnit
  string: Convert helpers selftest to KUnit

 MAINTAINERS                                   |   4 +-
 lib/Kconfig.debug                             |  12 +-
 lib/Makefile                                  |   4 +-
 ...tring_helpers.c => string_helpers_kunit.c} | 216 ++++++++----------
 lib/{test_string.c => string_kunit.c}         | 200 ++++++----------
 5 files changed, 178 insertions(+), 258 deletions(-)
 rename lib/{test-string_helpers.c => string_helpers_kunit.c} (72%)
 rename lib/{test_string.c => string_kunit.c} (46%)

-- 
2.34.1

