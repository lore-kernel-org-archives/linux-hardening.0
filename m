Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20946FD2
	for <linux-hardening@vger.kernel.org>; Tue,  6 Feb 2024 10:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707215526; cv=none; b=SqPjcTiL36V3R4KjqAO4l92IQ5LyqweiW+F0qKKoyQV9Lgf4YYwWKEgW4lIE9+S0Gce5Ed+Q2lcPN9hZ/uaemfM0+RPECDemqn7wwlKUBuhcFXMN9ITmKluqJfImdOiF4w+9Ao39Y1OTC/ROHwHocbokluZcu6TqG/4UdfmyfH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707215526; c=relaxed/simple;
	bh=kiRSpPb7qR56evGov/TFLUsMZxZJdezDcNwq43rF6pg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BKWnwbXC9ZpADf4mXGLayHMqUIM9sMutH60EXNM64WgWoE1NZC0pmloU8f7EAEYYoDtIBa//EVySaDKn0o6Yh8nc3LJqmhBGlbzXcvo4vP2gJNFp/z+hx5UGStDz1gU6jfe7ke7AldKEYJiZONj3wIrJwZ6sS73YDwF3pDuLmPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e86mUHy/; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e86mUHy/"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e03d97bdd0so451070b3a.3
        for <linux-hardening@vger.kernel.org>; Tue, 06 Feb 2024 02:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707215524; x=1707820324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zQ+KMLOIBucmuLqPz5XCakMsgk+2h4tVlSygmuqFevQ=;
        b=e86mUHy/sq62nWtMvJS7uyELcNDjJG3MdSTf2FCf7PGB6/t3RVTnb5m2nI78FwLTC9
         FwnBU2wVLQcidEh5QKwVkzNKxEoI/9He/WZhl521DyyEy/G/eOwA5DTnwuCsZK9k7EbO
         tzM1wq9+UfcxeKGWMTDmruIyAZpYkd6JUihSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707215524; x=1707820324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQ+KMLOIBucmuLqPz5XCakMsgk+2h4tVlSygmuqFevQ=;
        b=kugOO3z9i8kdwTX6F/KE5DdcFcGYlvLzvrST0hDGdPaSFc2OHkwd8V9/xE4N2qZnrg
         GkrcvnufUmPkq7x5dpdVG6S6WpU7K07suAPeHF1pbzDECJ7WCZY7frWexgfCMsXVUa33
         vaiakCrVu9Y15UE6M+XCBMd1zMdm/4kfC7L4ZupVNg4uADA/qkrwvrECc/01c9yhhi+4
         /VpOZrekfpOX3aiLHzMw+dgL2Vvk5mO43bYRJyPxOOTebrBRsYX8bf4xYuWfTWPuiGTO
         f7IyNYZ8Iuz2wV4fhryiLXJA7K5Dox4UcgJd3bIq/SCyVT1dQTrYFnlFJZUqw1azNTnh
         RSrA==
X-Gm-Message-State: AOJu0Yy3U56oiLLLU82lC1xwHdmXTMFY4f0i2N/KDaRCKluG4ecwtVAF
	TxuPwhCnY7oJmuKkCl6li0HHN4n7lavxX4pYcjHyIWhIRjAVioIxN/8z0ASwyQ==
X-Google-Smtp-Source: AGHT+IEVlnv3WAUyAEMUAVFP9gZysMYCPCkDMDC+UIkBB4VQi3hgxDJoaj+ulcL+tByt1vnfymDUAQ==
X-Received: by 2002:aa7:87cf:0:b0:6e0:4196:da11 with SMTP id i15-20020aa787cf000000b006e04196da11mr2086406pfo.14.1707215524200;
        Tue, 06 Feb 2024 02:32:04 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVVVcRimY30Q1lRCDXW975o9PrxQkAvR8f3BCi7Ns5gidl+u4J+8HO8uKnXiU7awPrejqzEG877kCqESFZHp4dJ35YlOl3MMhe2GgGeFEU5nAp2ujP0k6ip79x3Io8+soSe77wR5dFt3/iY5PXet/2rUzhzlC3cOHSRmhRyDNw2xPHrhV12dXLn5McMWGvf4btQWJqhTlHDomjrwsDstToL0/4hPfbyXB/pQY53k+o4p3RKJ3vuatztFH98J4gXj34aBYTlEmIAo5TpX+I7yEcLuO5NJHHAfU1GaC+n
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a13-20020aa7864d000000b006e051fcc0f4sm1526528pfo.47.2024.02.06.02.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 02:32:01 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Marco Elver <elver@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v4 0/3] overflow: Introduce wrapping helpers
Date: Tue,  6 Feb 2024 02:31:53 -0800
Message-Id: <20240206102354.make.081-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1535; i=keescook@chromium.org;
 h=from:subject:message-id; bh=kiRSpPb7qR56evGov/TFLUsMZxZJdezDcNwq43rF6pg=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlwgqb/ILUW1w9vPjUr5+Fp6mjsqCUVn9JQG97G
 AHIN2wYJieJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcIKmwAKCRCJcvTf3G3A
 JoLYD/9OnNa75do3aUJb2A0V+oJw2ZQBwmtX3LpMsOjwOpcfBl9/A+pLQzFGqo7wD4oRCrJyVUy
 tkJyJbsnT0pC+RCXl4HNRsid4HoGm3ZBOXd3COHvrHx/HzK8K6quOwcIjBa1+JBsx7hrKvtI67+
 fjUdgJ9mmEerJD4/I6u7RU1mmfXjBqMXAMNss76j1nM+YfTHQM5SXykH07rC9RszO3L4qSQergY
 WatUePHEHDVdYoiqfjrU9KX5xLhVgFqdBDisK43EDrndagzphzNgJGgWkKyg63Mmce+3KMPRFrL
 ScJxsVpfl+KGkZIwv1+vsOBGOKxIiFzxqKNgleBUtRru5sKLIrDqlDBQxGj9lTViiT1Os1106nW
 WBkKwYYjqRl+vye0pMB+s1FoT/u5Wrtsi3GXL30mf9yDtsHGmK7QTlRmDVYPqKPfnyzAO/nmFa9
 +sDW08adYon8NWFjf7pjNGRzjvJsSLmg2tnqUgKT5G5EDrQF0ekTJOhg5MS3npN+rtPWEDnlroa
 VtcAJkoHRX80JrkAg0G023qgUdaaO4Ei96SbLgmVF1354tfWAb+diJGpGlVaOU+jfvRWcjK0Opi
 /Z3bQ+YeEMwmWwVLTNrncGRJavuXfnPCGmkV4GVOboCVAW599fqgH7ZI4CUv6J4eubCpb8EKQXh
 4k5ISYQ ZKbcrK4g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

v4:
 - use __builtin directly (marco)
 - rename to wrapping_* (eric)
 - update kern-doc (rasmus)
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

Link: https://github.com/KSPP/linux/issues/26 [1]
Link: https://github.com/KSPP/linux/issues/27 [2]
Link: https://github.com/KSPP/linux/issues/344 [3]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=devel/overflow/enable-unsigned-sanitizer [4]

Kees Cook (3):
  overflow: Adjust check_*_overflow() kern-doc to reflect results
  overflow: Introduce wrapping_add(), wrapping_sub(), and wrapping_mul()
  overflow: Introduce wrapping_inc() and wrapping_dec()

 include/linux/overflow.h | 104 ++++++++++++++++++++++++++++++++++-----
 lib/overflow_kunit.c     |  67 +++++++++++++++++++++++--
 2 files changed, 155 insertions(+), 16 deletions(-)

-- 
2.34.1

