Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6971F13B2BB
	for <linux-hardening@vger.kernel.org>; Mon, 29 Apr 2024 19:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419827; cv=none; b=HUfBSi8s4rP4v0P8OlF/yLBFrNg4jiLLB6Z+EaN0BLDHc6dyQfOhcdf3t7rg/rcnM2EV4pQasJLx+xSwbdh9WgdKHQmUYDFiQNEMbnWsOSvyBwyGoZzMK27pXnndJLovFu+e5+Xanp/fY50I1OZelhkwHhlZRTYZI0gNTIDg6SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419827; c=relaxed/simple;
	bh=VIy9QVTN2qcxjefTX2tH+Yz/iQIFnIJTdKGucOLxoMk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nRmTz+ky5+/BZx6f69RAVusNcwy41GJYkunC5YJblBU31Ytm2q06+hO4qLfeTM3z61iSSUoNDs3zs0dR5rGGOuPzdpjwkd/eIUJLYbENbDOOZQ9zqT2NAzhl+GrpTLpxVY/8u6scYDSv1e63OrHyHLdl1f5kHRriEMwRZ6zRbJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P0Xozhv9; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P0Xozhv9"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f043f9e6d7so5039921b3a.3
        for <linux-hardening@vger.kernel.org>; Mon, 29 Apr 2024 12:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714419826; x=1715024626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fKDr4fJvmSW109ZvoEEynaQf9bTi64PsX/IPJzqOlYI=;
        b=P0Xozhv9RS37ym5xZoGikRXXzF6BUvw0DwbemdHtvrjLOJqiDY4GPt88PKHzzWIR+Y
         j2aeg8Y8PnXxjiUdM+M3O2ZgXDoaqZl9DAZOUoqOxLFuXFiI+HVbDrbhnOfbHnJsT0Zl
         wTSIFhO0ITK8YcwFbumzZDus+C8g07vF/jloo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419826; x=1715024626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fKDr4fJvmSW109ZvoEEynaQf9bTi64PsX/IPJzqOlYI=;
        b=ZEradIIL25Yos10q+LIuTSfdHJE9u4KCgHjCLuxwWalwNHGvc1oS15Gu0ZtlJsADfN
         jznmHUcsp8EQKzO/tnuOf31FCQWv5pqhMqTnL0XMuzBOTlCv3sbXSbGoHv+OIaKHZMwu
         jP2AbYn0pTNoqoi/FuKki+4wLPdMcMIKqeFzTCLbGuSZpYSvbsbZt/ax/1BgBRjACWrF
         squSW+4y0UcJTzxqdM36MTNuJzNKPP+oWVbyijmLgo8IlAxP8bnMASDgI32Tkws1O7Jb
         j7CYtZlLdPjMR1hl79GOE2YJOrhkccJTIgJ1GgM5oxA8/GvWy0/1o0c0e9FE2rSiYYR1
         4/Xg==
X-Gm-Message-State: AOJu0YxgzXsXCC7SVyr4BA0vHJ+16HdQHmYPFoS4qiCwu9oDuomi72XS
	DVLKY4UzCDuffX9yJUdh04zh81pfqo+rQdhG0109kq0MC3WTrq7aUZOEtFRixw==
X-Google-Smtp-Source: AGHT+IFWtiHj8a1VoRQm0nq5ioH7+C0b5unkMry0uVptPw+otkKozDcxw0l++LwQvQzuijATx8uqug==
X-Received: by 2002:a05:6a21:1f24:b0:1a7:91b0:4f14 with SMTP id ry36-20020a056a211f2400b001a791b04f14mr627637pzb.23.1714419825750;
        Mon, 29 Apr 2024 12:43:45 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id px11-20020a17090b270b00b002ae071346a2sm13389365pjb.36.2024.04.29.12.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:43:43 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] kunit/fortify: Add memcpy() tests
Date: Mon, 29 Apr 2024 12:43:38 -0700
Message-Id: <20240429194019.work.664-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=604; i=keescook@chromium.org;
 h=from:subject:message-id; bh=VIy9QVTN2qcxjefTX2tH+Yz/iQIFnIJTdKGucOLxoMk=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmL/httbmsQItvMY0uFd6j4hYaYCstXS3BgqKHL
 p0ncvc8EceJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZi/4bQAKCRCJcvTf3G3A
 JhLKD/4w53qKNAGkHRjVUlL3JoDVZHy+a4JqhPXqb8GmjsPB4621MjVd4rsZ6XmiKcwk2fnqbvU
 CHS6xbdOUc1AC9N6Xwmghk9x0r0l54IHzLMMXm1MqQNIl4syp5uc0i5xcqjwMqzpkHC+3ORQqTZ
 OrASafSnHzJxAfEgOQpZO8x3vejG6/2xBt46twYfrddMXXcENntF2TYjrM0LMzZAdex20gJbKtg
 kkgB/j4LxAfKQAoioOafYY35vvRtpoGQkjQBc6qVDxSTg1qRqmjDRe03GiKtW4rYxxzIZziJPE7
 3d4e2V7wIjOIvjkIs+bpgPUIfGEbgonoQ+hVW2FZvsHdtOLuxxlg40j15ZM6le+MFMAnUTWrUen
 YQVUmTJHbWU5nl4QYNajhO8rmiezNiTGw6qkDpQEL3WaflIM41qzHlF9PHY2GgtleDA2ZB/gEKm
 pJP1d8SthelDtscHXc1yri6Ha1XHs0SM7kT7ZiAysCx+QKZt0HhpZYCq0HP4sfrEJvqOZcxCKMU
 rm8+rIz5i3GGrBR22svxrMoCNobGpwBl/6/pHgJBByu6o9gkLI9bm5JUf83f7Tnhxl01W8/XEsz
 nP9czNbmvxQDBov3/YqO2xukp4Ajn1ufJ+Nudhx5M7xhQFWv5V8+WEQ/7T8+6TSGmqNl0HLREoL
 r1PEON62 rLiag4g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

This adds memcpy() fortify KUnit tests, similar to how the others
were done. This is in preparation for removing the 0-sized destination
exclusion now that we seem to be in good shape now after removing all
our 0-sized arrays.

-Kees

Kees Cook (3):
  kunit/fortify: Rename tests to use recommended conventions
  kunit/fortify: Do not spam logs with fortify WARNs
  kunit/fortify: Add memcpy() tests

 include/linux/fortify-string.h |   6 +-
 lib/fortify_kunit.c            | 174 ++++++++++++++++++++++++---------
 2 files changed, 135 insertions(+), 45 deletions(-)

-- 
2.34.1

