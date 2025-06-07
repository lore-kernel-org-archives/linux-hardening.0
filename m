Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D8D1FBC91
	for <linux-hardening@vger.kernel.org>; Sat,  7 Jun 2025 12:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749300010; cv=none; b=Nd72rkE7QhZqPXzIL3qpdZBO9+3ZzItT+shY1HYwCMkhOyKaWEZwQc0Ulx0LeGSQbDcroDfjfS3q0iz8yrqgwd5UIfFcDW4OmaozgQBhV5rw8po+8fJcyO7NaQJlCWAV/WLTxrDGzUxKF6Hclgckgelx64DeVGF1194nuj/5++s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749300010; c=relaxed/simple;
	bh=yeQj14v+3nuBc3l/SGzK0NSSaWSkCGtjbmcnNOE4wt8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eUzjujBU0xsFZjFMekZ2TiMKdRntNVeFup/QIs91X3STUjALyLHvYHKMlMb092W7wgBsXWmdMkC2Z/VfsEXhmnzhleV4Rypho/4HOQaPI8wKaO/DocAVso2aPPW9j3CmZsyO4tGZU7XPCSWw0fnTFEHZ58Mua/hqstgMnLeBKFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=ZQUQkbnm; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="ZQUQkbnm"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bDySh0yMzz9stK
	for <linux-hardening@vger.kernel.org>; Sat,  7 Jun 2025 14:40:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1749300004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=CwOmOvnqvIxqjmr/o0FSySI1hvQNLDJ93WwjmX7IRHA=;
	b=ZQUQkbnmifkegsjHret723T4cLocjJy5rP7bYcNfPlWNbC8iYu2awimnIeYBbcftGI3WID
	k1EDsOVSIl4ej5UCXMS15gCiR4Uhn1PUAQ1EhB2G0d/dTEuYCEc9bgxQaiYs6WNt52HP4d
	emB6gX/t/JMAry95xomb/Er7r9ongbFqexX2yBB7EqgdPXBTUBonZEqKIRG15GcpQ6FNHJ
	g9AoXOaTvFWWd1AB0EdMTepF8B5FnftywMCw1Qu+CPYu9wqA66TrAMxwTVsKQcZMsDJcFo
	qpWP9lU17gsyUfyBGk2oVE3yaM2VHGG18zYA6XYNd13aK1Yf7OM5ORRorgcD6Q==
Date: Sat, 7 Jun 2025 18:10:00 +0530
From: Brahmajit Das <listout@listout.xyz>
To: linux-hardening@vger.kernel.org
Subject: Introdunction
Message-ID: <3ixl7mv6q7zzfhggh6pnkg7sm2qc5yd5hoasvdilrxf66qhdyy@ktbc34oestci>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Rspamd-Queue-Id: 4bDySh0yMzz9stK

Hello everyone, I'm Brahmajit (alias listout).
This year I got selected into Linux Kernel Bug Fixing Summer 2025.
This is a mentorship program (I'm quite sure some of you already
know/are aware of this). I was looking for areas to work and/or focus on
for this program, while doing so I came across the KSPP project.

I was going through some of the open bugs[0] and issue #336[1] caught my
eye. I would like to work on this issue (if someone else has already
started working on it I'm more than happy to work with them).

As a small introductory commit/patch to get my hands dirty I've sent a
patch[2].

[0]: https://github.com/KSPP/linux/issues
[1]: https://github.com/KSPP/linux/issues/336
[2]: https://lore.kernel.org/lkml/20250606204000.8156-1-listout@listout.xyz/
-- 
Regards,
listout
