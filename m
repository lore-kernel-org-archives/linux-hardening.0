Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB6916DC28
	for <linux-hardening@vger.kernel.org>; Fri, 16 Jan 2026 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768556063; cv=none; b=bpCWQ04mxzdDxvtWWcDTyHk9KFGXo0AQRcRl/bCq3uRV7tFnBWMps0CdH4Bbqv7jUKGt1FzJPvq1ng8LH9tX0P3eModAjDY3L+uZ3CF8lphR9Lmkj4Z2EhpBUIlDHKB9cVpopkhAY/lGHFJI/hzkJMarfCErul3MxWvQBdeUYkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768556063; c=relaxed/simple;
	bh=pbj3poqSA6w0rLBL9Xjc+o+0Qy8FGE4aZbcHYXFFjrA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=t1pMRdk4kDGxKxgzwygrbc1XUUz3Qx/NeDzUM0K+RFJvtpglM8TmQxnNYxfhJag6UcIhiySIWiXW7CRklovjHU8+e0A8iZ4G94znvTc7QhBWUtB2ylB2rVV3aq1aClx4dVxi4fpTZt+9DxF/hrUOg3HnLKzekkkTQUdhZ+dpt/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OHqUGt+1; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OHqUGt+1"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47edee0b11cso9207385e9.1
        for <linux-hardening@vger.kernel.org>; Fri, 16 Jan 2026 01:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768556060; x=1769160860; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SM6NKFa+8czj9hhtBF0xXJOx+gqzzPlF6ypX+t4zEPw=;
        b=OHqUGt+1xfUCMc++xzWDe3jQhdRFl8fI8g1rjZCFkBXSMGZfrmKJ6nmx0WWqz7qpzn
         o52fygM3kCEjhXRwMiDqhFxsMVXWORC/jt95agXIVV+kxxJ4Aydo+kHLYLCrwE6GNvri
         +4IB9eDcKbM9HO9ZrcoAhou7vyy0u5v+mntHx9TobjQsNGwRk7HIuqOGiLavKDkFNz+T
         KAck+khopMfgBylKjpsUgWNDbiWuMEJDjE7hAQOVsezOnzXJWi99XyhS1+xzJ6IPteWN
         6g/+AsskhBsq3eNs3G+JS3eLrHtv1FKtR0vNj29AEXRjGH1CLGOs7RUNRkEFBC7LfIpL
         nyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768556060; x=1769160860;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SM6NKFa+8czj9hhtBF0xXJOx+gqzzPlF6ypX+t4zEPw=;
        b=TV7te4zCniI1eGCuyxuZlVgsMJmJRNGgSH+EWFfhHLTDVnpiez95K79GnPiPCKbMTt
         Isg6R4dUFNaploxIe5h4IrnJDBbs2jQOxY4MfJJh6uCJyrDyDHdDq5IZAXMbhgO8Rmdk
         7+uwAA5HAQ8pxhGWHdtGEVqHX2OLZaTQvgrp+uwyvA5rd25tEQeLPUW2FkKxHE5E+V5t
         jVc0S/Q1vius+75ptx+RlPAgJhXdjthuQN7gVbTxFJcEllESvs46k7JOGK5G7ZHVq4vy
         /JAv8gMMNUaxWDNSHtFWpGeLDkzLerQT/SwWOhx2F2OYZMAsMkhXWI4z97rr5v5Kt26V
         06TA==
X-Forwarded-Encrypted: i=1; AJvYcCUWiKCCDUhr1cv8NTMNepqeGBRSRSn7O3nwEiJDLqmtGENwbKfBUPiWhocuLuZhlYax2qzpWCz0bJ6SvRKnuOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyIi0xGsrpKomHSlLyu4QtAeaqAqO2e15JcqlGdStJTouQ56af
	OxW2I7ClHni1vt52FSBROUmdj0tOo4eOxthDCmOHL9RZiK5GhGO747W1sCJc7qB6YaTUZCaObg=
	=
X-Received: from wmol18.prod.google.com ([2002:a05:600c:47d2:b0:47d:56a1:4296])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:474d:b0:477:7b16:5f77
 with SMTP id 5b1f17b1804b1-4801eab5193mr17103645e9.3.1768556059765; Fri, 16
 Jan 2026 01:34:19 -0800 (PST)
Date: Fri, 16 Jan 2026 10:34:00 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149; i=ardb@kernel.org;
 h=from:subject; bh=jkgJW8J3bxHcweCYNOTK5wmG7iWn+bGurzq2dxW/Ks8=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JITOLjd3oQEH61f11LpI9KzYYHPANVmiYrsv/3v7rZsYfj
 RZvMg53lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIms4mX479Qdzc256uPJqW3P
 9rDInFucu7B18r2/4n90uZf4nQ39kMnwT7/q+KQJdTaP7uf0nwvX2yLoXL9+j3jQOaNTjTrr37/ /wgIA
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260116093359.2442297-4-ardb+git@google.com>
Subject: [PATCH v2 0/2] Simplify kallsyms offset table generation
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Kees Cook <kees@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	linux-kbuild@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

v2:
- implement minimal PC32 support for MIPS so it can tolerate the symbol
  references emitted by kallsyms
- use signed decimal to represent the offset, so that symbols appearing
  before _text can be represented correctly.
- add Kees's ack

Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Kees Cook <kees@kernel.org>
Cc: linux-kbuild@vger.kernel.org 
Cc: linux-hardening@vger.kernel.org
Cc: linux-mips@vger.kernel.org

Ard Biesheuvel (2):
  mips: Add support for PC32 relocations in vmlinux
  kallsyms: Get rid of kallsyms relative base

 arch/mips/boot/tools/relocs.c       |  2 +
 arch/mips/include/asm/elf.h         |  2 +
 kernel/kallsyms.c                   |  6 +-
 kernel/kallsyms_internal.h          |  1 -
 kernel/vmcore_info.c                |  1 -
 scripts/kallsyms.c                  | 64 ++++++--------------
 scripts/link-vmlinux.sh             |  4 ++
 tools/perf/tests/vmlinux-kallsyms.c |  1 -
 8 files changed, 29 insertions(+), 52 deletions(-)

-- 
2.52.0.457.g6b5491de43-goog

