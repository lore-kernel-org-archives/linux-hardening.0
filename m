Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1C5137906
	for <linux-hardening@vger.kernel.org>; Thu, 22 Feb 2024 22:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708639260; cv=none; b=CGxL2cpJ6n3HSCPHxSd8k8Gmx6VocbUR+HQOAREF9p2OZmbt9prknEQ64ogTkUFlwquVaBCZoMV3LkItImLiuqzorRgi8+iLq/WSYSHKLu4kjzNBQfLLIZqedmsNDgcHUuXcVoKJ5cpfEOi0UWXBbMSRwFv146+0cCBXwAbTGbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708639260; c=relaxed/simple;
	bh=hbXGJ/YlyPpD27cmj4b3cp4Yzd2WD9bezI3PKuZsB5k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tHgzuaFEFj3deagsuaNacxRkPCchiX5QJjPEFhZDgXc136g2iltvFtsFfUgZyf1fR0bymwqgf8jp2WOudH0hIu0/1zI7I/X+x5NxM5KW4bs/4+YxXtNaBsu1wyUTABb6cXefKZS6alh3m1T0Tz+lLpXG5YujBDsxW6NquYIDP6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FcmFdY3L; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FcmFdY3L"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5dc20645871so184791a12.1
        for <linux-hardening@vger.kernel.org>; Thu, 22 Feb 2024 14:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708639256; x=1709244056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HPkEnHNu93Xut7ylGeEwx3NBgivyxIrV8yPaocBRkWI=;
        b=FcmFdY3LT5D1jofQv/R9pi1nPRUuDWfCX75k6RGwJ+EDuPhQcrTcuAVTMwEXgNMm3N
         r+H5jOzoOm9PkcLQk77EOZGEGAP1H9X515eN10NVjKTuFsc/JuYOUStkKVEc0PHIaa49
         tLdGo6IuZM5RJ2FTjGcC3VeMD4vn8t3akzIL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708639256; x=1709244056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HPkEnHNu93Xut7ylGeEwx3NBgivyxIrV8yPaocBRkWI=;
        b=E11Z+PJGeZFIYlHf56ZTxG12FPww23nFtEizTsttI6GL87o7L+kfNeefiZVUBvLTTX
         yppGPOoSZLZpvf1kZ2nZ6GDeia/apSB1vwY41Rk4olVLW5ZsrrXRhe5L4ENAvQJ/ituI
         Ux3FAMme5nV8jPtfWg7tPQoW0qJvc8ZtdU2lsUntlTNcqueF0WLMroibp8XXMKrTrsxu
         oOJeU2ZCmCb13y5R8iwHAv4IVIzEIGKFxjzY5d3SfI85yHecCDaChNSMR+eYHfH8GE8X
         mvBnjv5qlj15Ivmz2FJ9CC9QKUIVoBpJxa3q5vwF1H84dj4cU8FGLXNSGJsUrc+NNsRg
         OWPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLauAJ9hx8/Sv2ZVP6STtQNzY3Ayks9Uihw5t5tyC9GR7g8KZsPzMKoCWa42FfIbJzAC9nhkh6N0Y9A8mPFgiwZvr/+/rkpfj9vE8HGp6O
X-Gm-Message-State: AOJu0Yxus7YtweUczHzIM3k1zqAzcYl0eduKDaZqJ3RXKsZbDMemfxlR
	fa9xwfKLN4UKSCGumEwYIy7aP6tf+ma201ih9t75bAQnx+0X/4Ug0Drk6eN2pg==
X-Google-Smtp-Source: AGHT+IGs8zsc2Vp/WM60VQeWwc1+0/1fLHpMgn/G2tjc49F0xIKiuOWzyw0/UdZWXwdCJaTAIF0jVg==
X-Received: by 2002:a17:90a:5915:b0:299:d975:89ea with SMTP id k21-20020a17090a591500b00299d97589eamr5305831pji.21.1708639256302;
        Thu, 22 Feb 2024 14:00:56 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p4-20020a17090ac00400b0029a75101532sm86105pjt.50.2024.02.22.14.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 14:00:54 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Kees Cook <keescook@chromium.org>,
	"Tobin C. Harding" <me@tobin.cc>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guixiong Wei <guixiongwei@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 0/4] leaking_addresses: Provide mechanism to scan binary files
Date: Thu, 22 Feb 2024 14:00:47 -0800
Message-Id: <20240222215755.it.764-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=719; i=keescook@chromium.org;
 h=from:subject:message-id; bh=hbXGJ/YlyPpD27cmj4b3cp4Yzd2WD9bezI3PKuZsB5k=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl18QSB21XgR75CdHFMdboQm274FdSvsB0skHsd
 tLyagq8jnOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZdfEEgAKCRCJcvTf3G3A
 JlrCD/4rxBK5ZdiEM903WPKFmSyOx6fBKqejjipROUfR1COBQWejoVnMOCfp1s0tPxTsULjFbpF
 RkU85zfnuqSajfnklsFybDe67UM4J2zusweiQAKFCkuOheq49PQEgwWCL53IEKiY+/+oDyNJ6KR
 n1WSUKdo7rIyUhhEDQ9TpOwy8CWHILXTdcxTYd6VyNmkUQKEu+eClxqmgF4DqiVgxnMHzlET5l7
 nxVAwDEclFBUxE28ZQCtN253gsYPX/nnXguzciBxioQqEbbgpOu2KYjDjUKal8TrnX09mkZyvdB
 Uq3HpV285oa6TgcVIz6TxX50dgJQga5WmKjZpnexZJnLlGJvUcT7JUU7RRfZq23e739Aa47Zh5S
 8RFLvqZAQjfGhLEfviNmjlqobLLJnBsVz0v1ZsbSV8UT7yK4a6XTuh39F/bbj6hGRM1ZHH/+0lu
 dcwaZL1S6BpGjiFxahU0GJ53qikeiectsveucYA65vxo8tFbnXw3qqCyY4E+Ct2eh2W45HTNFvp
 BBbeZQybe529xNbzsLieuYQWZHPIyHZPGEav8iNlZ5W8ZGZBT0BwZI1IeszHT321HSIy7QKg80O
 E+jjr9CrJBd/hk+YhYilwmPAq0tcgnFGOtWkFcBd05P5znJb/jWF2PShRNApt2l8YO00QtPZsBR
 YxMbVGQE 26VLZMg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

Since I was in this script for the binary file scanning, I did other
clean-ups and tweaked the MAINTAINERS file per Tycho's suggestion.

Changes in v2: patches 1-3, move hex() after ^0 skip
Prior v1: https://lore.kernel.org/linux-hardening/20240218173809.work.286-kees@kernel.org/

-Kees

Kees Cook (4):
  MAINTAINERS: Update LEAKING_ADDRESSES details
  leaking_addresses: Use File::Temp for /tmp files
  leaking_addresses: Ignore input device status lines
  leaking_addresses: Provide mechanism to scan binary files

 MAINTAINERS                  |  4 +-
 scripts/leaking_addresses.pl | 90 +++++++++++++++++++++++++++++-------
 2 files changed, 76 insertions(+), 18 deletions(-)

-- 
2.34.1

