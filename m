Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BF4327214
	for <linux-hardening@vger.kernel.org>; Thu, 27 Nov 2025 09:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764235376; cv=none; b=L5ExfY1/DofanofSaJTgHjOn6Bs2p1Iz5tNW3I2pDmWSo9ToNEZ1K5VWeJZLmnlAYnjIDKa/5rRNXHujEqm9CP+H8oytVBwt3eeMmlwueW0XED0odLR5EUP++MU//kxEcidvG2BqGKq18CoSMwjW/hISgePBL3xRA6sL+wB+UqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764235376; c=relaxed/simple;
	bh=kXj2PCs7wQI8j3c8aaWqFV1r9CjN121+2Otk0ssMEb0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QVjBwUXtni9NxouQLehH8V+Gjxg8fBNqZUxEyRtI0uBSBUR48A4hx68IP/gNGkbAo0aS4FpNyez0MNH8DjaEY7ioxE3pknaDqVqHzJmrnDtF9PT5+3gSWhAtDjlEE+4DfC4HS+nOiXapNi3EX5tVIdfpeAL+IlA/MWzuSD6uqrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xHYYsqlc; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xHYYsqlc"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47106720618so6195315e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 27 Nov 2025 01:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764235373; x=1764840173; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8k+F0GetRpiG4yeaeJZYzrwTgndZIgQnhjJYwqn3Z9M=;
        b=xHYYsqlcrzFX0S1rY6Mi7iFAVumEipepy2LWlCaozmAsTWgkJd4BDzbv5gPyg0tGei
         RXKXglt0JaLg8ud34869jBHNiXQIIHOvHy5w1rSh1ng2pEPf64U4Q9iMKHHEh5Y7XFFi
         uJULGqMIY1cQ+776Ftu8Vpiqyeaoq9y7PgC+D2aS9+qQKUXi3C5iyjmyzs8jyfP+qXhU
         GvoDLajUxY2L6QNjfp0AYX2DgsCXXrQ+YV4uiS27xh5VeJTve0uubYQmQLN6Lmdgqpmw
         5bSCSAr/G6zVgk65cNlHb+IpdDxpaikp1ApGuL0pPmNLqxyLYGE+UY/f9gy1eayAxIe3
         lVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764235373; x=1764840173;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8k+F0GetRpiG4yeaeJZYzrwTgndZIgQnhjJYwqn3Z9M=;
        b=thfbMT4/FnDCsDSYgp0OSFGmMw97GTJHkzlttq6xlaRw36BroiuJF7fAS6yGqV9KBd
         Cz3iSD+eIvyR4x/rFiaOLundO1o+7ggM8p7uY8tzyAfOz372DU11zH7tKel/AVknp4ua
         Bl/NJ33lpDRF9fqZ3stCIZnXhGC7c8PpVyBLFGqzTJY6cS58CEH0PaPZ/V3rEM3KBhnQ
         eORmz+oI0CEMIh0C4v2jItpbfKjHkoYZeyWZOELMgA1VuaR52why9ok0Yw6X7PF/ZGhJ
         XZsjdZgfvNnEjgilxR8bRGI9/mc9Me9X2MyXV43Z2QOKiIhidZCT6mkBtEy92abVfpPI
         m23Q==
X-Gm-Message-State: AOJu0YwWuv7RUPHgp5v0OS8YkzBBWt1o/6I54CPKI3GoInyhIermwUcy
	QDzxPdbtJzJTgHj7H7DJXnBWPFosgFTlKXQ0Vb1iDY7uG+6V9KSBi9/jmLI2T/djFd651MPomub
	eL9GMICtLQnMlHKx2wnBh+v4DRZ/e4ZSZ8X7mYFapm6u8zqSZwjvbWnNgjPHuaiN+4NO+ssFIij
	P4agYyzCoGrfgVUW58HYQ7yFh5TPzXBmS4jIRhBA==
X-Google-Smtp-Source: AGHT+IGfvNKR+g9XaWkAB5dq4WcVViwMo8HeCBTI8nv+mxDAvIwxYs0Hqc92CpBwKzvNXIgLV5xTxErv
X-Received: from wmbz27.prod.google.com ([2002:a05:600c:c09b:b0:477:9b53:8816])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:840f:b0:477:df3:1453
 with SMTP id 5b1f17b1804b1-477c01eea66mr213141915e9.28.1764235372847; Thu, 27
 Nov 2025 01:22:52 -0800 (PST)
Date: Thu, 27 Nov 2025 10:22:27 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1810; i=ardb@kernel.org;
 h=from:subject; bh=GVwhZRAgf3/OeRmqAQsplmNoFkzur4kYLnMaWMHGxBc=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIVNDIjjssTWzZKbJxK9fUrdHx0111Cq1Zn3gl7nMhI/B/
 jrbBt6OUhYGMS4GWTFFFoHZf9/tPD1RqtZ5lizMHFYmkCEMXJwCMJGwbEaG8zZViycp7mXK630g
 uzr8p1CxSAODFX8+z+fKR5P/rDf8wMjw1C1rXqkNQ0+GsmhXdWzjhsMPl7/6c0bz/cJr79OPnVz BBAA=
X-Mailer: git-send-email 2.52.0.107.ga0afd4fd5b-goog
Message-ID: <20251127092226.1439196-8-ardb+git@google.com>
Subject: [RFC/RFT PATCH 0/6] Improve get_random_u8() for use in randomize kstack
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-hardening@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Kees Cook <kees@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Jeremy Linton <jeremy.linton@arm.com>, 
	Catalin Marinas <Catalin.Marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Ryan reports that get_random_u16() is dominant in the performance
profiling of syscall entry when kstack randomization is enabled [0].

This is the reason many architectures rely on a counter instead, and
that, in turn, is the reason for the convoluted way the (pseudo-)entropy
is gathered and recorded in a per-CPU variable.

Let's try to make the get_random_uXX() fast path faster, and switch to
get_random_u8() so that we'll hit the slow path 2x less often. Then,
wire it up in the syscall entry path, replacing the per-CPU variable,
making the logic at syscall exit redundant.

[0] https://lore.kernel.org/all/dd8c37bc-795f-4c7a-9086-69e584d8ab24@arm.com/

Cc: Kees Cook <kees@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jeremy Linton <jeremy.linton@arm.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>

Ard Biesheuvel (6):
  hexagon: Wire up cmpxchg64_local() to generic implementation
  arc: Wire up cmpxchg64_local() to generic implementation
  random: Use u32 to keep track of batched entropy generation
  random: Use a lockless fast path for get_random_uXX()
  random: Plug race in preceding patch
  randomize_kstack: Use get_random_u8() at entry for entropy

 arch/Kconfig                       |  9 ++--
 arch/arc/include/asm/cmpxchg.h     |  3 ++
 arch/hexagon/include/asm/cmpxchg.h |  4 ++
 drivers/char/random.c              | 49 ++++++++++++++------
 include/linux/randomize_kstack.h   | 36 ++------------
 init/main.c                        |  1 -
 6 files changed, 49 insertions(+), 53 deletions(-)


base-commit: ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d
-- 
2.52.0.107.ga0afd4fd5b-goog

