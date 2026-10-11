Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D604430D404
	for <linux-hardening@vger.kernel.org>; Sun, 11 Oct 2026 16:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791734924; cv=none; b=tZTfr1+cx7SW1vw6+eP2qKK03Y2jjjkBvbw1aA1006ETnXmnedAMFUxosOCnTNcsX0dw7fR7Jerrhs29/ydKG9mYQWOBKUPyUoMJDJ39mF98FwIaxpYeZT3sT+MKNhbyaEc+U4zi6iuHlR8ThnU9HdW3AFpP1UJltxrQ9vik++g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791734924; c=relaxed/simple;
	bh=xGkv+QyRtzfFa8DOkQXBFjFB4C9QaDE5uM6fgtyToPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QWH5hn4Wh2YI8FqFL8o0sn6i+6I3sel1GbjU1azLLYfRXWl7mpyoCtKbkpNY7D5YcTIdYhso/C9hnAOqjc1G5NCLfpkxRp9DNzhbmTAhc46CJ8IVtcLEi19QDmwlzVwTYL8weyo/3xjQ3Ap1ub9ry33iLLxQIyCcHei5oX7np0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=nb1kM73q; arc=none smtp.client-ip=84.16.66.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="nb1kM73q"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j2lrd45y9zKbv;
	Sun, 11 Oct 2026 18:08:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1791734913;
	bh=Aj9Wy4UKfp9ppxpb4/jueoPyJ0lzJkxrA4oPAEY9ADA=;
	h=From:To:Cc:Subject:Date:From;
	b=nb1kM73q48ZKU5oLMD08CuGF4XqQhjsnQW2LZKel9qqrbpuVwS/wgyE+Zkv1rHuR1
	 9oZiOtYq83DOyo3YbCrQQy8StEiD61rOxXUNDvHUEd3heFvOPyNQx4BmlRPmBbVGOQ
	 nxaqbsadAd8Hq7+L+pC8a4XTiLQlBhvqePuRSkJo=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4j2lrc0LrTzpdc;
	Sun, 11 Oct 2026 18:08:31 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Alejandro Colomar <alx@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Mike Bommarito <michael.bommarito@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tingmao Wang <m@maowtm.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [GIT PULL] Landlock fix for v7.3-rc7
Date: Sun, 11 Oct 2026 18:08:19 +0200
Message-ID: <20261011160819.1376118-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi,

This fixes a Clang bug by removing an annotation, which was introduced
mostly for documentation.

Because this is a trivial patch, feel free to merge it with v7.3-rc7 if
it's ok with you, otherwise with the v7.3 release.

Regards,
 Mickaël

--
The following changes since commit 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e:

  Linux 7.3-rc5 (2026-09-27 13:55:01 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-7.3-rc7

for you to fetch changes up to 3d8cc52db2f86b624308321c58513019f6b21eec:

  landlock: Drop __counted_by from landlock_domain.handled_masks (2026-10-11 17:54:21 +0200)

----------------------------------------------------------------
Landlock fix for v7.3-rc7

----------------------------------------------------------------
Nguyen Ngoc Thang (1):
      landlock: Drop __counted_by from landlock_domain.handled_masks

 security/landlock/domain.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)
