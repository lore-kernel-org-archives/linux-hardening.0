Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139DE2848BE;
	Sat, 19 Sep 2026 00:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777639; cv=none; b=sI+2CHj90dGF5DX8N9Sgz0wT5XsZkvG6bZJGoP0m3BvHeIQCiDphAjv7gxgUnPF7Nvn8Y0yX10sVjVhAQHOPbKi3OKsSs3UDEZ0WvSlvrnaZ1xqVNqIMfXfMhL3Qczk1jdyWQEPWaGPcKtWl1UJKDZEOwhWA6go74CQWxjChzcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777639; c=relaxed/simple;
	bh=uRCpFcNsXWaddrapn5SkrIyGKjvHsPU/cznZLzJgIzo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Gd3+/PdPjyAMLmro7jiy9rWvn089CUMPpuiMVnJd/f71Y9RKtBQh/zCPF/sWNG68iynxFzlMPDSV0r6FMvm9kn4pk6OHmkW8O8yBLgpPM7Xb7KzPVO1uoCC/GK9uX/kNXVPp4QtWV0Fy7TiCw9DR+8aO2E8oeocQG2Ic7t62Vvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxGTxZeV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxGTxZeV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2411F00899;
	Sat, 19 Sep 2026 00:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789777634;
	bh=J+x8FFsUkC9iRJGPRIk/B0IV7LAA23MrAgbBTD6/xIs=;
	h=From:To:Cc:Subject:Date;
	b=QxGTxZeVZNNDtP6KaTTUM2VNLS7BtJOO2dlpytr/ocwMqQavrpzhtFUmKn/0OBxnJ
	 K/h5aNHXj5176q1Snl1bxQbu9IbBSzvrU4kSSk7PP8LVHttXtvIorYthw8Q2pn/8vX
	 d4JM7rgotIJ5HjbE0ORQsts1Pj2CDAyV4ezLt1BsU0vFwt2Po1e15L3hbFY2IfRzgY
	 6iAOaOad9zC8EFGTTeVBAjkOZ1PvqbXy4qujy9SeAJvDSJZfUMb8pS3pkzVPjyWH1v
	 PzuBPe4cGlDkwO1PI9uJMWcDKs7OFm2TTo2lLbR0uhhL0inKdfO1d29MVWDP0lP3pH
	 +u0cXmPgzv8sg==
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	nikitash.mariiaw@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 0/9] seq_buf: Add seq_buf_strlen()
Date: Fri, 18 Sep 2026 17:26:58 -0700
Message-Id: <20260919002658.stay.929-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1823; i=kees@kernel.org; h=from:subject:message-id; bh=uRCpFcNsXWaddrapn5SkrIyGKjvHsPU/cznZLzJgIzo=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlrr11v6Q5ZWdrlF6Wh4SqVc3OaoAXTrZsK9rPP+x1Wq T/XI3C5o5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCKKxQz/g/TcNe82TAgwat7q Za95eNeEFws+eDoYxU6a1f0vTsWQl5FhY8XnRWUsH5M+6GqdW3Rp08x7DEL7J5yWDu0+9s5e/fE LVgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

While working on seq_buf conversions, we found there was a need for
seq_buf_strlen() (since calling strlen(seq_buf_str()) would be a waste of
time: seq_buf already knows the length), and seq_buf_init_append() (to
start a seq_buf from an existing string buffer). And while implementing
that, we found a bunch of other related things that needed fixing. This
is that series, with tests for each fix.

 v1: https://lore.kernel.org/all/20260917002312.i.923-kees@kernel.org/
 v2:
 - seq_buf_do_printk() simplification and more tests
 - add seq_buf_init_append() and tests[1]
 - finish documenting seq_buf[1] and link it to kernel api docs
 - test improvements throughout

-Kees

[1] https://lore.kernel.org/all/20260917011359.1585961-1-morbo@google.com/


Bill Wendling (1):
  seq_buf: Add seq_buf_init_append()

Kees Cook (8):
  seq_buf: Do not print an empty line from an overflowed
    seq_buf_do_printk()
  seq_buf: Do not pop from an overflowed seq_buf
  seq_buf: Copy what fits when seq_buf_puts() and seq_buf_putmem()
    overflow
  seq_buf: Clear what a writer did not claim when a seq_buf overflows
  seq_buf: Add seq_buf_strlen()
  powerpc/papr_scm: Return the string length from the sysfs show
    functions
  nvdimm: ndtest: Return the string length from flags_show()
  docs: core-api: Document the seq_buf API

 Documentation/core-api/kernel-api.rst     |   9 +
 include/linux/seq_buf.h                   | 103 ++++-
 include/linux/trace_seq.h                 |   5 +-
 arch/powerpc/platforms/pseries/papr_scm.c |   4 +-
 lib/seq_buf.c                             |  35 +-
 lib/tests/seq_buf_kunit.c                 | 471 +++++++++++++++++++++-
 tools/testing/nvdimm/test/ndtest.c        |   2 +-
 7 files changed, 607 insertions(+), 22 deletions(-)

-- 
2.34.1

