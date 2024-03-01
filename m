Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F9C365
	for <linux-hardening@vger.kernel.org>; Fri,  1 Mar 2024 00:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709252814; cv=none; b=D2+A0Ayoc7UTtc05kvWys+cEeExXErc8XPtG7wdsrTDWAmby70QsyYTxJkO/AO2+QZXtDen8Xu0tZjXGX4LNaLfkl8hZQ7/r3/D1zDHNljjERJhzEE0+s8wjE11U5slf3G9wHAdMhygWlcEz7WrVnwPLRW+/BMvM4cikUuXfgag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709252814; c=relaxed/simple;
	bh=moYrqqxo2UDnuGHZWzH0ODEv4jfFfQLJ2rNJTkxWGDg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eYQEwg1jTIpoBdKP4xwq0PBFe6VGFctlBEbGOLEuDdyds0rzrnW+EeQ/GGtFt5mBkdqKSU3OSYbUdehFBmTM5HcQnm2hFdN7EfA8Gh2KL3bpfH98WgJ+WbCKFD/Cjq5FXiN6dsxDjNlCFPRCO54hZpWEQkMzwQpYC6AvEonvZq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dH292u/1; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dH292u/1"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c1c7fdfe9cso881809b6e.3
        for <linux-hardening@vger.kernel.org>; Thu, 29 Feb 2024 16:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709252812; x=1709857612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QrA5UyLICMttuHo47AmdIq8RaxySGVb6p80fwiVlvuQ=;
        b=dH292u/1WWBJblIgtYZoIn6cRYLmh7BgnOEtQ+4MdItsmgDL1RXoCsQpGKvvz0L6vH
         qneVxIe1+N1ra1os89nGS+j0iZZrC+CFcV63s1r4IR2p6Q/LfkksTIJjveC6mkz+naf5
         sQTSfWAXVdQWy8LN3eXqBfHLyF7TqgwQ8X2/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709252812; x=1709857612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QrA5UyLICMttuHo47AmdIq8RaxySGVb6p80fwiVlvuQ=;
        b=bimysmOgei+/GPxuHTZFIc0oYuT/OB+G1nvp5lcUng7jmMLBJFnlb0GDpkqNTDBHzg
         GCQhubLLKMWrvP7NkcgmBMWL1tov0RFZYJvplRQJsW7iHrX7J8yWVPfqzp4irBYx23yT
         y9zSpM9KF2lgw8Wf+RcHvMHrxNc2s5zLMsczkygc2IawW8GrgS/NM567EHJ7LC7cs1B3
         AvghztbNj8fqJBL5tdqNtca1AoEWowLV+mFMzOEQ7Mrni5EnjWca3ppLSTErqCUhvv85
         2hGqU38cli1654EKTABHBN1UnYvpNAnKTIiOPCTeJCJo8333rUh9bbHlp+K0YUIkoBQ+
         usUw==
X-Forwarded-Encrypted: i=1; AJvYcCUw6Ni5XwOprfE6xoC5j3HKAB5UrUYaULYm6IkyxPsr4V+lhpZEUhmHOuNYr3VNoCSipLatcfzKPLVkcaTdqBwwxhDBgfWGPXaSUh17zrxR
X-Gm-Message-State: AOJu0Yws0wdjd7veip3crPn9sGd1ruNvPdD32g+mxwe4sD+3VnY9819s
	R/2h5KDxCZJ79HZ8TuopBYaLXpSwG1keOg5qd5daTp9zSmHOLPXCFka5gJAeGA==
X-Google-Smtp-Source: AGHT+IFTbmLNW/f53D7zdSesRBbXGfMhl15+6/jTYpyEzlfT0bpba3gTpNhwOVwa/Sy78AMal1HEnQ==
X-Received: by 2002:a05:6808:3c93:b0:3c1:41fc:d012 with SMTP id gs19-20020a0568083c9300b003c141fcd012mr247384oib.34.1709252811946;
        Thu, 29 Feb 2024 16:26:51 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d4-20020aa78684000000b006e4ecc3e394sm1841748pfo.79.2024.02.29.16.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 16:26:50 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 0/2] string: Convert selftests to KUnit
Date: Thu, 29 Feb 2024 16:26:46 -0800
Message-Id: <20240301002416.it.092-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=893; i=keescook@chromium.org;
 h=from:subject:message-id; bh=moYrqqxo2UDnuGHZWzH0ODEv4jfFfQLJ2rNJTkxWGDg=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl4SDIx+1hzENuYl6hlOaohCcjbErtMu6nYDGpe
 tlKDFUKztOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZeEgyAAKCRCJcvTf3G3A
 Jj8YD/9tmTSBz1IaC0rs2X8jkqHkNcS3dAM5KC6mzlItIbkMb2ZHf9M465ykfWmEP+2Q1wihYN5
 ptkoLrHxVV3arN+ciF1A/vkdxajkFcKlp8PSEQHzgT+COw2fgNBbTfZgRPl1s/u7x/K9MkEy5zg
 2tRLQ2dwT0g/OSw7naV/4f2+JlpCmhPslQzluJZoO5/hsuIUEhuqdSAEWTqPO52a6KdXXOKh9dl
 XM4glyth1t1Zu2ASU7rcBjYzq06bnBtLZHQJw44eA3eZAtH/MXlN7/de+DLcRTnaE4/GZiMfgzf
 hykOx05svh8WhAlwl0YjWMS2awUhhuhjQm7aIIhqzMomIldvNN+MxQBMC+KMDvjjOYhE54hmXKz
 tdezZPI0n7Vs2jSfPGZdOgccwILJefwZu6Ft1H5jlgLCE1qwPwgksrpf68+AqSX+57KxOGmbSSk
 7TWjRcr19DJIHp2ZO9Ck+U04XW5wuuRptge/eO6ztTAxsiCaE4d2qmlRCm9X42UKBG6JegT/ef0
 S8Nwsbs/rI90TkUFvhZfnZwh3dpl3f4/Q/Y/NffZtnuoC5GZvGU5n29zsdea7OeqjUwFE+++VNe
 TzAwT6XQth1oHb6iNeuOMxINtdY5JYTidKMFTy0CvYyy6HeZt9VnnGV9/hOZrvT1aAqtLIMJZx5
 knHIZ5A6 Q8Jq0Eg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

I realized the string selftests hadn't been converted to KUnit yet. Do that.

-Kees

 v2: rebase onto https://lore.kernel.org/r/20240229205345.93902-1-andriy.shevchenko@linux.intel.com
 v1: https://lore.kernel.org/linux-hardening/20240229233432.work.675-kees@kernel.org/

Kees Cook (2):
  string: Convert selftest to KUnit
  string: Convert helpers selftest to KUnit

 MAINTAINERS                                   |   4 +-
 lib/Kconfig.debug                             |  12 +-
 lib/Makefile                                  |   4 +-
 ...tring_helpers.c => string_helpers_kunit.c} | 177 ++++++++++--------
 lib/{test_string.c => string_kunit.c}         | 166 ++++++----------
 5 files changed, 164 insertions(+), 199 deletions(-)
 rename lib/{test-string_helpers.c => string_helpers_kunit.c} (78%)
 rename lib/{test_string.c => string_kunit.c} (54%)

-- 
2.34.1

