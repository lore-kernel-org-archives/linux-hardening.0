Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29B21C2B2
	for <linux-hardening@vger.kernel.org>; Mon,  5 Feb 2024 12:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136528; cv=none; b=JHYKhwJkjd819tNujFaDS7KBVwEaCFEbnsVHIcanTUJt8ztNXz2/Nw47OJHDu9Ge6JBFuLWY8SsP5ov4zzWlgAC3sY1Im05xxOkAq68cOYThZmBiVGvv0eyBYvvjMJKeuFTzknxAey2f22gbKrg9s9VRY8nvcFZmgsXsDAXdN5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136528; c=relaxed/simple;
	bh=gb1pMezQom2o69/2/S4q14GG7K9g4wEflN/V7WqIjPU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HuPdudrfdarmUwMwgHZ2gAglVY8cnkNavxrEcSBghho/C6xPLoFOJqWiTTh/muBw1hdZtyf6UF27XKKqDmAUFAkR9QhDo29g+uZl2apaluR6gCrMMHJxin0IQJioDbuzSs1WaTG36Y7brKuAU/f/1XklR390iED/FuZ+DeD3i6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m1VeL4dD; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m1VeL4dD"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d7431e702dso35825335ad.1
        for <linux-hardening@vger.kernel.org>; Mon, 05 Feb 2024 04:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707136526; x=1707741326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LXCtrdF00SQKGnbl+QKIcgctTVGI/MnfqCbM8VG+D4A=;
        b=m1VeL4dDsfe7kqhwDS11YhF+4oWfrnRisdS5mUvKcaKlCN2umoh0AihiEetvCsRC1h
         8d0W2wtWqAbTbM4C0Wq4Wa5vmcCFrQH1vyZF7GHGUF2MppbXd6cakNSwHoeG8JyKs5Ij
         5kTlr7mEwsIc7XC88OpU7nwAbL+LjxxRdniT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707136526; x=1707741326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LXCtrdF00SQKGnbl+QKIcgctTVGI/MnfqCbM8VG+D4A=;
        b=E4JvPY3do6u8bJz7WJl7JAwFh/MzZRpn2t499aKH33E/LdZncW9REZFcELLvT7erNf
         kDOA4cwIIUAssv3BAQv3TZG6pFRG2qGYrZlzpbudjYW61vjC3GcufP5rd+jYz361aiKH
         jwycmFgsLVlI0r2sJyN9xkg6CmKqfTXoBIdX88jNOc2nqmY5vg95tTWB1JKhFNEDZt/n
         soCg0kLPPzTUlPshRJSIbHsT/p3FvRFmGh4vGAhBpEdf1faA4MXnjftkoNlNQePwn6ql
         Pw8LDWFwrXpiq5ouHVidsam8STbUB5nLwHOTNIGj+GEjmW2I1SnnJJdthfw+LOHEDW3G
         C51A==
X-Gm-Message-State: AOJu0YxDtRoFwLT9SBKGoDU+xnfFI8sRCYT/Sqyyw2IyVwYr3Cgn9YdI
	Zi2DCL6m4mPjeQ0I9RX94U2F1JQED/61hE8MIQGNGA0sD3x7VJTsy0fy2fg9EQ==
X-Google-Smtp-Source: AGHT+IFaLn+i8NopIbYaurvObg3Mn20y/WYSEUcqQ2DFqpELuc4XadIrAyrIdm1sTGv0KYjWUjYjGw==
X-Received: by 2002:a17:902:ed89:b0:1d8:8bce:4b47 with SMTP id e9-20020a170902ed8900b001d88bce4b47mr12130224plj.65.1707136526270;
        Mon, 05 Feb 2024 04:35:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXk5p6S6lfRKaUcKLL3y+54YU9665V3vplVUkWabvzhXSGG6cefCsS0fg0GmaAuvX1XpUjHN0kfhO74pge0p5RJOH6hxwrAHz9X2PKrTpFo5TTH2WcFxlRsai/zoG4JJ3e6aCrn+c8NQBf/dMQdjKq+i648dkBnTZBe1kUUcLoWAoMQgNxxiq7XomcNIZKW2JPUSf0hyWoHYURIYZu+o7kzUfF3IviwJXhE3Sfz9Y/vWXSnt1CUkxV8HIcBpnner4Du7lL2Fd3rgKViXbzi8M/K3jtVU2Q5UcGrDMlrouo+HaAv/jY8giE0zk6GIqe602cm+U/C0ciQwGawGSsUPBVd8zzhV+qZT7MkynDg+dqjS9gCuf6p/Vco8lbWLLiqggczSmy8VnxxInCkE9ZL3Fe7ca5qHcWYkc3JM06n8Up3VtI1GYxnUZJkd2Vs3GkmQKXjXTbUPV8YN+obyUZTiDz6
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jj14-20020a170903048e00b001d958a17e07sm6251149plb.294.2024.02.05.04.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:35:25 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Richard Weinberger <richard@nod.at>,
	Justin Stitt <justinstitt@google.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	kernel test robot <lkp@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: [PATCH v2 0/4] string: Allow 2-argument strscpy()
Date: Mon,  5 Feb 2024 04:35:20 -0800
Message-Id: <20240205122916.it.909-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1408; i=keescook@chromium.org;
 h=from:subject:message-id; bh=gb1pMezQom2o69/2/S4q14GG7K9g4wEflN/V7WqIjPU=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlwNYLbm8KrEo4o92C5K+vQbxvOEnNcE5pT/0OK
 FUyaNJ00G2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcDWCwAKCRCJcvTf3G3A
 JqjyD/45HaDlf2xlN86ZwY7uJDXkuQm1bipeu++EsScElkwHpim5eV9GxCdDzgGY8lgbSwOpZrH
 7CSbh2sTvX3KmGVqFxTPelq7eCz5QfcvMuorquo0AfoTAv7iMKIJqOvjKT30glEcQQvvkOBx2N6
 jPIJ9bJQ909bLSeitjbqDzFmOjNYcjH2jOR5Q4Y064FgXENp54B5UEcsA1RIXsIQG8RHhDPuwRx
 06+pU/hUKVuZp0TMIyOG1tvj9WKLqpjWhM5xo15Ww8o4kbJshg4MIYoMAu3/OHHE9Q2Fk/BlejD
 NRngSmz5BtCPRD01rgMGhUyeOLVmBFyWVmjOYihg8P7uVfL8YM2FDxN7kbIHcgMfvNVkX0gxkHF
 wEBWOxFsnkXQNn3/yeVIO0mUtY6fB5zeesL2iyth8nO7tLax85EjyPL4WEyijXQVjtnyTEHHqaI
 CYoIA8g2bzqshurlUj6iUmyOY4qMItiKIbgOkHB0NZiOkfbR6ErWjINDjMFoOIQokSF8JBPGYdC
 NNh3wlaDHktdGv2lDiPsmYLYpEpa8CmdGA+47gA80iuynBbTZIZuVI0eDGdDd0iqNyqmYXLChwB
 rbO4NR8AmDHbu64hE2Ejlnjmpdhy14BPmO+U8HYSfMkX9CeiPAq92XuusvpigykrxEDFOHVXbI9
 CcEroad bJ+I/gIQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

v2:
 - add strscpy_pad() coverage
 - fix up ARCH=um to handle the renaming
 - use __must_be_array() to validate sizeof() usage
v1: https://lore.kernel.org/all/20240131055340.work.279-kees@kernel.org/

Make it possible for strscpy() and strscpy_pad() to use 2 arguments,
making "sizeof(dst)" be the the default 3rd argument for the destination
size. This can make future usage much easier to read. Additionally allows
treewide changes to save a bunch of lines:
 1177 files changed, 2455 insertions(+), 3026 deletions(-)

-Kees

Kees Cook (4):
  string: Redefine strscpy_pad() as a macro
  string: Allow 2-argument strscpy()
  string: Allow 2-argument strscpy_pad()
  um: Convert strscpy() usage to 2-argument style

 arch/um/drivers/net_kern.c               |  2 +-
 arch/um/drivers/vector_kern.c            |  2 +-
 arch/um/drivers/vector_user.c            |  4 +-
 arch/um/include/shared/user.h            |  3 +-
 arch/um/os-Linux/drivers/ethertap_user.c |  2 +-
 arch/um/os-Linux/drivers/tuntap_user.c   |  2 +-
 arch/um/os-Linux/umid.c                  |  6 +-
 include/linux/fortify-string.h           | 22 +------
 include/linux/string.h                   | 75 +++++++++++++++++++++++-
 lib/string.c                             |  4 +-
 lib/string_helpers.c                     | 34 -----------
 11 files changed, 87 insertions(+), 69 deletions(-)

-- 
2.34.1

