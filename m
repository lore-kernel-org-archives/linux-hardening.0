Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F3D4457C7
	for <linux-hardening@vger.kernel.org>; Tue, 11 Aug 2026 14:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786457567; cv=none; b=JFJNVipCz+pkF7zrpPoqn/bYNy6D+cFA7vhdTHWbunTo6Ld/lCD3Kt2iaVINonWLwiVL7A6nVA6x9iA7Mnuo9hQcK6aLBCumHCHyBf1xPzhEZvoA0yFLcXULwktMKxTtatioUM7juQjpbafcRDrhe+A992IUAoi/f1VbPY38PTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786457567; c=relaxed/simple;
	bh=O4l6lSWrd7GbUn9t/Xhyu2+p1lAOhzIAdkcPdOotscw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BZHryVriPzqNe9Nn7bdMbEvyblyhQT6bkHgBlVUqZ93Jsvz0FJj3tBZVDLOcr9G8J3dDKGIVY0074F9WxZthc3ZwYP/+txz6uaH2PbOwM76WJPpuO3IP1kXmfWV9W7VAhanzJhZcZRW2w+vVD++npT7jLzaqNRdvVe0I0Cuu3VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0QtM5tO; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0QtM5tO"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49800c6a846so29960175e9.3
        for <linux-hardening@vger.kernel.org>; Tue, 11 Aug 2026 07:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786457564; x=1787062364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gUKReELtva+IRTqgyN0Xulu2tCFMOBx3NrOCV78F8dM=;
        b=O0QtM5tO4QQtWtLFibjPDkIYpCyJgJfkVRuLW486hzEAjpdHX4F8LpWupDvXPKI6I6
         //adUAHsxiVkCh3ehOGnocMu+Sf3ZqTVhQcJuui+zDwRjX6PfXc9sRkcarP8M8e7KAMr
         3h7d0/chv1gEDlujz6gIcwmUIfAgoY9vDFLlcKRM97nWQ7ZWsqF6tcB8IY+dsHOG5iM6
         x6x2y4a7x4cxgQ4+tjCTNIRxkfbDGZmbFI9PvsXFno6LyKWMlk/aL1bPTvQkx9MnExbO
         5amQ4MTnQnLbAhkQw8Gpae4UBxYaPd/VJiyTUbFqfy/5btVMgIY4uudt/FZZlrb7TXmb
         MK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786457564; x=1787062364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gUKReELtva+IRTqgyN0Xulu2tCFMOBx3NrOCV78F8dM=;
        b=GEpirx1wlvOybkLUtiBdT+0kqTQlWaMIDci4i8zfovy+xH1eEwspKlEpN9//Q5oZ5Q
         y/ytP2OdexoeHk2arXmVis/1Qz4VruVqQ31pTUTyTmslf+vb4yFjHo4xFy5pfYOfDcov
         aMbIvPgSSjkRnOqfa706tsyVb88ffqF3vkvgS4H0nvTqtgCozaacECYEkWIN+FBuxEw7
         j3+urEnMj+UntTU+01acHATkFqTDH5tH7uptd3RF0LpPhhnfgiGMMaNIVWsLxGjXZAab
         hpofyhhmZVUU2EoCAOdvX0HClLadZhFdOMfTRT+T83vXEJRpUmBqfK8eKH0vzrhETLly
         9ohA==
X-Forwarded-Encrypted: i=1; AHgh+Roo/div/WFl0ff0ugNDAf/lEaI8zTfQNu1N2EbqIAN3H1SDfe9Gjovppdp3M2DStfRz66A/xz2Dm4QLFHZyir4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuW+8pT9iRe62MD0ysC5HfFwv/AHvNj3UeGxiJncz4WMC6dff7
	vTKDDJaoWT7I3lEyB4GW8eo1L6OL6YVxTB6agqrOfK9oMHnfkm3ExbWI0oMonGCc
X-Gm-Gg: AR+sD13hI6wOaZJbLRmVvU7eZsP2e6RS24BZQcH5CbTpL5qFYbz//dK3Ve3557wNr35
	k68CKPV/sJp45GOFE6FL6jGq9kbC2UnY6RIITT6sVNAAk+8Gmq0GAr1FzkbqTK5ZQizHwVNmRGe
	jypEwGyYuc70qol5vEY8rBELHUXpTkHAKqgVWT4HrvXsFq3QO4wCaoa3/IpBu1jXcTzAb+gVGn8
	70upEuuaLZ5nJ44lZOjfIU06uwekIoidyfvwm5xX0EhcEj6Rv++csW+cxkQgNLUZBGsIkZl1FYp
	Dpl1daUdVPsqPWBd6Pj2o2+DQmdoL53eCmBPDOG30yjam6jLkuUidpX0BPBOtQnQZdm/+/l+Zl5
	50iF6z0MmusBF31NN0ccDINBUKB2m4dk7CwDWuT+lgqsuz6aDyUDFdLFKoQFo8n8b9KWLTE2M3q
	Noz4Vq+xa3r2EeEZjCR80cbkHeNh1z4qpKZ9jF0Yo6/nZRJLeOkJyjNnSB9FTRYvKPr46hIQsSf
	jeG/gVb4Iht3JsrYQkDBQY5bPC2hz5/pYxtaPsbZFFcNzhycSW5Tg5/iVcUExwf6MPhU0be5bcW
	GzCggL4IeFBWjwJ3Tm0wGovk1Omo7lxQTw6fD+pRdGd3YwgNEt5UHo/DDIbi8QvSWkbR
X-Received: by 2002:a05:600c:8b4c:b0:499:593c:3384 with SMTP id 5b1f17b1804b1-49978434835mr57851385e9.6.1786457563927;
        Tue, 11 Aug 2026 07:12:43 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a133-e401-bc8e-d36c-2d08-c5e0.310.pool.telefonica.de. [2a02:3100:a133:e401:bc8e:d36c:2d08:c5e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4814a5be29fsm4464099f8f.12.2026.08.11.07.12.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Aug 2026 07:12:43 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2 0/3] slab: ZERO_SIZE_PTR alignment and exact matching
Date: Tue, 11 Aug 2026 16:12:37 +0200
Message-Id: <20260811141240.62519-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kmalloc entry points promise ARCH_KMALLOC_MINALIGN alignment but
return (void *)16 for zero-size requests. Patch 1 aligns the sentinel
to that promise. Patch 2 makes ZERO_OR_NULL_PTR() match only NULL and
the sentinel, so increasing the sentinel does not widen the set it
matches. Patch 3 adds KUnit coverage.

In hardened usercopy, patch 2 changes check_bogus_address() so nonzero
addresses below ZERO_SIZE_PTR no longer cause its null-address abort.

v1 -> v2:

  - express the poison-pointer bound as 0x100 instead of 128 (Catalin)
  - make ZERO_OR_NULL_PTR() use exact matches
  - add KUnit coverage

Tested on bcc44b6785f21 with the series applied:

  - GCC 15.2 QEMU boots on ten configurations spanning sentinel values
    16, 32, 64 and 128, all passing the zero-size allocation selftest
  - the x86_64 test also passes with GCC 8.1, the minimum supported
    compiler
  - the new KUnit test passes on UML
  - Clang UBSAN_ALIGNMENT is clean on armv5 and the generated code
    retains the exact sentinel comparison
  - Clang builds the macro for 21 targets at -O2 and -Os, with single
    evaluation confirmed in the generated IR
  - patch 2 changes vmlinux text by -2 bytes on x86_64 and -72 bytes
    on armv5, and arm64 gains 44 symbol bytes

v1: https://lore.kernel.org/r/20260808105622.62026-1-kmehltretter@gmail.com
RFC: https://lore.kernel.org/r/20260712120728.96628-1-kmehltretter@gmail.com

Karl Mehltretter (3):
  slab: align ZERO_SIZE_PTR to ARCH_KMALLOC_MINALIGN
  slab: check for ZERO_SIZE_PTR by exact match
  slab: test zero-size allocations in slub_kunit

 include/linux/slab.h   | 20 +++++++++++++++++---
 lib/tests/slub_kunit.c | 43 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 3 deletions(-)


base-commit: bcc44b6785f216eb939226ade6e3910baa30516b
--
2.53.0

