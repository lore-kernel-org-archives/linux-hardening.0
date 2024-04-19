Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F6E12DDA2
	for <linux-hardening@vger.kernel.org>; Fri, 19 Apr 2024 14:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535319; cv=none; b=K9gClxdn9VH3NTy/Gkqlu36PIimYgvy6uemL9Ai1cn0IvUN5obhPiXT4p8LxKAXtB9RNz0B0k6ZNcS0Y/h5xIGNEmMvokDTm7T7J+Vt6pXqZvHOjqHdh9lYva/Lvo4bvEel3KNd8Czop4a7v/uLwj5vvmQg2cszCIVZIRsZOu7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535319; c=relaxed/simple;
	bh=GldqlCvmlruHkKQBpE0bNU0iavQG0JdnTn/3ZGPU5A8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q3tf5fzHM0FnNaOA0Xwjep52bDQe+wdOKwHBKhrDdtHQqqZmXWei/QCLYuu58S2yHZK8Kd5iuICzCe917T1DrbuZjsmNwkWH3hIWRomXavyoEM5zBV1R8PhTVitAgVnQ8OiKF3GivFggcDqcM7nfSkLKkpNNeHq4Dv/o8GOk9Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IdI+jK1q; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IdI+jK1q"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f043f9e6d7so2140664b3a.3
        for <linux-hardening@vger.kernel.org>; Fri, 19 Apr 2024 07:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713535318; x=1714140118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UPm6fkN1iYXlaDXVKllaNg4Nw5S8W2+SHSueAxLwIM8=;
        b=IdI+jK1q4QtwWYm7v6U/KV1J5ZIBeSY+GAYHi5ziLqMmL2ZCutwcmmrvh3oXOEHgVe
         4/M/83WN0go0qT/rt3NynhqSSsVx+W3IJKsCsD/a6EV+LfvDBUVloa3pym5mmBwMqVCI
         v27vms+AiL4zliPMHOngA/sUyWu3eCHTmh4gQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713535318; x=1714140118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UPm6fkN1iYXlaDXVKllaNg4Nw5S8W2+SHSueAxLwIM8=;
        b=O+wIh0FlAfw/WRW0RJbpEA27oqy7ZZMPHffV+xToosGmN1l9QvkRcyYUAnacjLHuNq
         wugFT0GpaZ+1oo1eTPTseL5QmFru6+uCAsTm+2bSVSMU5WxPTY0PBhnimhK0qnW0UeHN
         4p6ZcRR4NFwaNHKb0Q64paZLdsQTstRV8NNpqa0EK0Mr1OjISPoCuV7vK17PBXigi+KX
         qQzgeGng/TgpPG+3Nj89w5UX6AvFi/NSzYeVGJrQvV1noCMkUPfJuR3oibsRH7e3ETXD
         0i03HCPsJWG0Gfutp+nCVsNEgtvqxPMT6fRZm/M+k275ihQ8ckTxqZ6zov7FuCAqU5Wd
         K9hA==
X-Forwarded-Encrypted: i=1; AJvYcCW2GtYw4RWSoWfcYp0QMI1uKjUwICzgY0Mne73MMmUXNptA0oiTT3+BAXwZmPQ/6Si44XnWMLCzK9ePZRdi3jGH9Al5migi2I0KlNdpIVAX
X-Gm-Message-State: AOJu0Yy38j+KhpqcGeLdThyARvCJ+C4PmXQodgYIBgSb4gTl8IkN+hvt
	E9ukLntUZzFdAMHemBDG/GWg3z0jGZK4k2PEvLn8dhBfqgogsh5SdUmWOMXM3Q==
X-Google-Smtp-Source: AGHT+IGnyEc3GC14lA5NhGDHSR8a99lA00zYS+so28ole/wCpbuAENR8ABugbXYLOFjSA93NVniGqQ==
X-Received: by 2002:a05:6a20:431d:b0:1a9:8d1f:df84 with SMTP id h29-20020a056a20431d00b001a98d1fdf84mr2900301pzk.57.1713535317889;
        Fri, 19 Apr 2024 07:01:57 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fk24-20020a056a003a9800b006ed9d839c4csm3238088pfb.4.2024.04.19.07.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 07:01:56 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 0/5] string: Merge separate tests into string_kunit.c
Date: Fri, 19 Apr 2024 07:01:49 -0700
Message-Id: <20240419140017.work.012-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=951; i=keescook@chromium.org;
 h=from:subject:message-id; bh=GldqlCvmlruHkKQBpE0bNU0iavQG0JdnTn/3ZGPU5A8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmInlRcBERwrPJam6TUpi+MUNTcOLEOk1vAHhFn
 GrPyZN5CWyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZiJ5UQAKCRCJcvTf3G3A
 Js0rD/9LqSJcefGj/x8ivHbnZtQUT4ETomnU6kJE/YN7YsWgmL0gy90uKZXt38TlMqg5m90iZUc
 6n56CUUoCfYXsV+Il3A81p70aA1VO09mSbwTt62XgjpiaVhtuG2xzpCfH2uQIICuDrCaCoBbAyT
 4D/ooppsootEkqhPxxl/SxFgdMGYwRJh5foJtSVZ6QWn/q330kIZtQk1EpgkGpvUyy7siKM/KSD
 tPaMl1Qs+7k8a6pQ98HbZfXS7k8cT/oGwVl6tbB5BHSKtFJYPjHxtJsSjazsX7/d83+0ADM2hmm
 S2Ittey+7z8HFYhVCSz6wrOLSB03X+ETh5mSknEwxBR7HyarjdbPFEjWgyyMCfWbnbB2Ew8psLT
 dMvEDHpifYFq7Rh8iaBYTj8I2M3LF7+nPcwK/wW5SUOoUbs9hu37xSVbwA15SwP8ax/G1HgK4EB
 HLlZo2dZ1WeSfLLc7CPZVIxw7gG6NnVUXGH1/FYsF6r+1dY3zzS/oFNiWqJjsH0DolFdxiJsDxg
 T8Jq3IRuzvnt0186j81iW0QQ+SqjO/OH218OF23fmIB5L7N3s8iJ1VdnykYKOYtFZcUuKNxjLn3
 2degp0+6NeJeEGwIPdHgfGKvKqWOklvk8OfP+6FO31xtYknFqEL+vC1hjjX0QQez+ZpTV4Q6Fes
 +v7tIVUD PNINDug==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

We have a few lone function tests (strscpy and strcat) that are better
collected into the common string_kunit.c test suite. Perform various
renamings, merge everything, and clean up after them.

-Kees

Kees Cook (5):
  string: Prepare to merge strscpy_kunit.c into string_kunit.c
  string: Merge strscpy KUnit tests into string_kunit.c
  string: Prepare to merge strcat KUnit tests into string_kunit.c
  string: Merge strcat KUnit tests into string_kunit.c
  string: Convert KUnit test names to standard convention

 MAINTAINERS         |   2 -
 lib/Kconfig.debug   |  10 --
 lib/Makefile        |   2 -
 lib/strcat_kunit.c  | 104 ------------------
 lib/string_kunit.c  | 258 +++++++++++++++++++++++++++++++++++++++-----
 lib/strscpy_kunit.c | 142 ------------------------
 6 files changed, 230 insertions(+), 288 deletions(-)
 delete mode 100644 lib/strcat_kunit.c
 delete mode 100644 lib/strscpy_kunit.c

-- 
2.34.1

