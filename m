Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B63313552
	for <linux-hardening@vger.kernel.org>; Thu, 17 Sep 2026 00:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604614; cv=none; b=DHLPUau+D/dPjOi6USGTk5HkstLhTweJq0FxFYGq4hfV935aPI5qd15UCqbc1zabHM57THu+sd9UYUvZ+apgYNO27bHyUbzRSa8FdaVb6vo4UnkkJ2lpk0RJC/2i/yHOJl6yTlCLDl86q/w6vIhmlDya6evHPMtIMlYyf4G1Njg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604614; c=relaxed/simple;
	bh=1Io6rHXBbQAS2LQOO/5LSEQlK1jJdLmeVxtJEufJkV4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=oEhWZHmFg17JxlW2/4tu4daS70wAOCA/h1Y2jb+IdgdUZv/A8dNQd9FSMs30Dthaq4Z7e7SOqorKg2CdNbFKRDPnfO+iXVhZMVHkM+JPs7QxEacJGjzVwQc+B6a5dKeABJwADp5eOKmGoDrsnmcEkUu1Rz348h/i9KjH34tjt94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NS050h21; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NS050h21"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC941F00898;
	Thu, 17 Sep 2026 00:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789604613;
	bh=8Nb5C6fpz11J+oKQpZl9xaLKScU4KAoBzR9Q7kdo3x4=;
	h=From:To:Cc:Subject:Date;
	b=NS050h21rP9nWvYahZH3YgNGRuy23ctc6Eeh/BdIN0igXI0OZszWtkqeK7kRbAg3w
	 QT+jXQfYaPCAZX16/fWZpOsVH8GMnRjfDrtHRs+kmUUoME1vGVTHgqYbWrqfFxRhvT
	 jrqBV7qI1lWFKb5HQywTEyV/uuKKFtzdckf7utOLz3Jqp1GjpKcRv6wmauRobrc4Qe
	 mk734GTdHFffbIrdwH9WBsNH5amQEjaDpzVfxGbbE/pCrE3aA1ylb8fsRhG0YqdXVk
	 G/LBit8NeoHH1MRRV3EUlQKyqdNNNkTlkfLEFP/HWT1cnPA8+BFnLkxXWfmEGe/c63
	 zQKR8CAh0u1PA==
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-hardening@vger.kernel.org
Subject: [PATCH 0/7] seq_buf: Add seq_buf_strlen()
Date: Wed, 16 Sep 2026 17:23:12 -0700
Message-Id: <20260917002312.i.923-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1228; i=kees@kernel.org; h=from:subject:message-id; bh=1Io6rHXBbQAS2LQOO/5LSEQlK1jJdLmeVxtJEufJkV4=; b=owGbwMvMwCVmps19z/KJym7G02pJDFmrjb74ZKr65D1ofsklG7P7tJTXxMMHz/479oqHY/qsk PaqbVosHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABMRkWRkeCouqL/3yv+YpykL xfKlDohdkLoXqJy4ruSW0bn4gJqlLxn++yvkzej8+OvQoZtH9kzwc0xQ/mlbdD0o8eC6gy4O2T/ s2AA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

While working on seq_buf conversions, we found there was a need for
seq_buf_strlen() (since calling strlen(seq_buf_str()) would be a waste
of time: seq_buf already knows the length). And while implementing that,
I found a bunch of other related things that needed fixing. This is that
series, with tests for each fix.

-Kees

Kees Cook (7):
  seq_buf: Do not pop from an overflowed seq_buf
  seq_buf: Copy what fits when seq_buf_puts() and seq_buf_putmem()
    overflow
  seq_buf: Clear what a writer did not claim when a seq_buf overflows
  seq_buf: Add seq_buf_strlen()
  seq_buf: Use seq_buf_strlen() for the string end in
    seq_buf_do_printk()
  powerpc/papr_scm: Return the string length from the sysfs show
    functions
  nvdimm: ndtest: Return the string length from flags_show()

 include/linux/seq_buf.h                   |  69 ++++-
 include/linux/trace_seq.h                 |   4 +-
 arch/powerpc/platforms/pseries/papr_scm.c |   4 +-
 lib/seq_buf.c                             |  25 +-
 lib/tests/seq_buf_kunit.c                 | 290 +++++++++++++++++++++-
 tools/testing/nvdimm/test/ndtest.c        |   2 +-
 6 files changed, 377 insertions(+), 17 deletions(-)

-- 
2.34.1

