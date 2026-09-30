Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E24B417BFE;
	Wed, 30 Sep 2026 23:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790812368; cv=none; b=Y/fXo3i0lnmU45cBEP/SqECpawxCeyS27y7wWK8c4wjWit0FGZSDf/OJ6ilg9ywm2GpXgV8slAb10FO6dVyIWnjoLdQvQ8aEChX80szfJn0LSb+cqap3DUErly+zkP8bXwxyVyG3wOY4ddoU4jWcd0NGzK4WvfEUQHitqpnedgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790812368; c=relaxed/simple;
	bh=7o9zsIQajzZWie354gy3yARRko5nnleQl1adyzcJB2c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=COXlU+mVi9q1YRDPX3OdqreC1dLf8Sf+smMNZnDO4QRVezpPeRuPXR8duS96gEBsLWdI9QUO8d0txoYFyfdJDX97v3bU1IzXHJmP1xpyhofOSl9Sswop+sQjJxZhsO0R3/lUZe6XlvUJTPZ+GfvHFUDSbX1axb0O5yGCJVy7VNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbHZgm3m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbHZgm3m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555C71F000FF;
	Wed, 30 Sep 2026 23:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790812367;
	bh=BgL7zYXpHP4Sbalmza1vWIBotKGzLwMqQqiqxTkovU0=;
	h=From:To:Cc:Subject:Date;
	b=QbHZgm3mvq+6y+yMqr95Tng19Edtnx+oBFH1uxwo2i52OqW2Ry9nnhH6JBsiHeCzk
	 JgaNXYYWsASLXXX21+92fd8UuW1ks4aJmyOGOYNmSg6YDObfGt1xphwNUaCUmD7boF
	 FkMisZY5VeizUP5Hwa9FJdSXFUghT9VQORxFpcPCMy/CgxcLUdCO2HiT1YUW9vJciW
	 1NlfNuXen5BtKNtpTS21U3kLn9WsLIqdSlpqUnQmb5HKS9bkCfyHFT80TpRPPnqbSp
	 sBLwdKL1PPrZLkjJoxmRE0IIu/xDG001TN0lLDBccu815Th/3ayL3FG+gnc3euApTd
	 OXoFReR2X7W6A==
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	nikitash.mariiaw@gmail.com,
	Greg KH <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 00/11] seq_buf: Add seq_buf_strlen()
Date: Wed, 30 Sep 2026 16:52:28 -0700
Message-Id: <20260930235231.out.387-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2191; i=kees@kernel.org; h=from:subject:message-id; bh=7o9zsIQajzZWie354gy3yARRko5nnleQl1adyzcJB2c=; b=owGbwMvMwCVmps19z/KJym7G02pJDFl7Fxy+9nvD1xvukafuuvyY/+r1lTm+7A/En7a5zvkdP YFV+7lNX0cpC4MYF4OsmCJLkJ17nIvH2/Zw97mKMHNYmUCGMHBxCsBEFJYxMryS1zYRSU87cPCm wI0vbm8T+4+K2004f4L/v8eUxe7VXWwM/2srDD8lG8W86AxmnzPrwTeBoyGOPUUXHA2W12YsbM6 M4wEA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

While working on seq_buf conversions[1], we found there was a need for
seq_buf_strlen() (since calling strlen(seq_buf_str()) would be a waste
of time: seq_buf already knows the length), seq_buf_init_append() (to
start a seq_buf from an existing string buffer), and seq_buf_terminate()
(as there are many callers using seq_buf_str() just for its termination
side-effect). And while implementing that, we found a bunch of other
related things that needed fixing. This is that ever-growing series,
with tests for each fix.

 v1: https://lore.kernel.org/all/20260917002312.i.923-kees@kernel.org/
 v2: https://lore.kernel.org/all/20260919002658.stay.929-kees@kernel.org/
 v3:
  - add trailers from v2
  - add seq_buf_terminate()
  - drop redundant bpf termination

Thanks!

-Kees

[1] https://lore.kernel.org/all/20260917011359.1585961-1-morbo@google.com/


Bill Wendling (1):
  seq_buf: Add seq_buf_init_append()

Kees Cook (10):
  seq_buf: Do not print an empty line from an overflowed
    seq_buf_do_printk()
  seq_buf: Do not pop from an overflowed seq_buf
  seq_buf: Copy what fits when seq_buf_puts() and seq_buf_putmem()
    overflow
  seq_buf: Clear what a writer did not claim when a seq_buf overflows
  seq_buf: Add seq_buf_strlen()
  seq_buf: Add seq_buf_terminate()
  bpf: Remove dead newline stripping from format_disasm_line()
  powerpc/papr_scm: Return the string length from the sysfs show
    functions
  nvdimm: ndtest: Return the string length from flags_show()
  docs: core-api: Document the seq_buf API

 Documentation/core-api/kernel-api.rst     |   9 +
 include/linux/seq_buf.h                   | 134 +++++-
 include/linux/trace_seq.h                 |   5 +-
 arch/powerpc/platforms/pseries/papr_scm.c |   4 +-
 kernel/bpf/diagnostics.c                  |   8 +-
 kernel/trace/trace_events.c               |   4 +-
 kernel/trace/trace_events_hist.c          |   6 +-
 lib/seq_buf.c                             |  35 +-
 lib/tests/seq_buf_kunit.c                 | 516 +++++++++++++++++++++-
 tools/testing/nvdimm/test/ndtest.c        |   2 +-
 10 files changed, 688 insertions(+), 35 deletions(-)

-- 
2.34.1

