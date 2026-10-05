Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF7E4AE109;
	Mon,  5 Oct 2026 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215831; cv=none; b=EV6taURtrP4YFKUsfHdX2CxpI+dcFWYTkLO45TrgjxApe2pJjGSATRQUmWdQNUgHpP0MOlJl2FgBIPWHTl92GWIkKjiaJ7Yt9HnxKLCSVX6wxud5LRISEGdXeTYAfkLBfQA9Hth5PykbrpG2eRaYDBQt5zu4Nv42VCvWl9cqV0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215831; c=relaxed/simple;
	bh=YAwuJkV6+IBZ4KddTOqMtNqcPDunSitw5KnwjM4TahU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lqtllx1+mNy/3eYinOgZDkUx8MSTGxCAuMivK8ongve4RSDGzsL+mNpF3oM/+xsusxCmNSqXbbgb0gYVdGRRrGMHBpbh/SHjjMp9AoFBPT6LqS/L9K23K2r21w5pwPJ3jhVPxiasZZcmokaD4S0vjtanP73Y9Igiml9rjm8QuTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJgJ863r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJgJ863r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214961F000FF;
	Mon,  5 Oct 2026 15:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791215829;
	bh=1zCUeAacCbuYMfNGIyx+QrBOykwFR09cO7grUcW2Noo=;
	h=From:To:Cc:Subject:Date;
	b=mJgJ863rS4RJJy4+jgsUTNUq886acBo1ADI1ThGUVnU95kp7m5hg3WxqheTKYvENI
	 HVMS1gf4UWZR0p5sCpbUg+ehhP1ywz8qg9HKHC++ghpqRdHTaCczNj434pg14M8nG6
	 WdrdfVijpA/v23kIWjzNg9nDWLm0E5RcfndeUbJSCz4lyDD/WGOHHR8L9zmPjwxll0
	 uCiBlvh/FyEgIxY1LdCuzKWAn+KuDPBM/1Nthd+t+N749l/rL5kS9YsunZmk0nD+y6
	 beE4AwmCt+JkzUkfbNFYP3POafLcDmLaIGrKwGf2rURpzjs7KDhY36ME7b0bd1yhN9
	 3VBwtI49aMj+g==
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Gow <david@davidgow.net>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Shuvam Pandey <shuvampandey1@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ian Bridges <icb@fastmail.org>,
	Justin Tee <justin.tee@broadcom.com>,
	Paul Ely <paul.ely@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <mkp@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Thorsten Blum <blum@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Ira Weiny <iweiny@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v5 00/12] seq_buf: Add seq_buf_strlen()
Date: Mon,  5 Oct 2026 08:56:50 -0700
Message-ID: <20261005155653.late.426-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3559; i=kees@kernel.org; h=from:subject:message-id; bh=YAwuJkV6+IBZ4KddTOqMtNqcPDunSitw5KnwjM4TahU=; b=owGbwMvMwCVmps19z/KJym7G02pJDFmHT5y6myEQlD99suT2yzsr3hWK3XLyKbe42q3K6qD6R m+XxdYTHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABOx62H4K7d3a/cFsYmPpyZ8 8fDnig80ajo2s+tY+tFncU9i/3e4dDMyHNqweYpR5o4b/xM78qvVuUyKVi4JE3W/9emN18a5B00 XMwIA
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

 v5:
  - add Alexei's Acked-by for the bpf bits (07/12, 08/12)
  - 03/12: new: lpfc_rx_monitor_report() drops a record that does not
    fit itself, instead of relying on seq_buf_puts() leaving it out,
    which 04/12 changes (BPF CI)
  - 04/12: note the audit of seq_buf_puts() and seq_buf_putmem() callers
    in the commit message (BPF CI)
  - 04/12, 05/12: drop the inaccurate "unlike the other writers" from
    the export notes (BPF CI)
  - 05/12: drop a duplicate #include from the tests
  - 06/12: note in seq_buf_str()'s kernel-doc that only a zero-sized
    seq_buf returns the static empty string (Andy)
  - 07/12: write the seq_buf_terminate() test data with
    seq_buf_putmem(), which leaves no NUL, so the test fails if
    seq_buf_terminate() does nothing (Sashiko)
  - 09/12: fix the commit message's description of seq_buf_init(), which
    empties the buffer rather than setting its size to 0 (BPF CI)
  - 09/12: check the length in the test of a string longer than the
    size, so an unbounded scan fails it (Sashiko)
  - v4..v5 diff: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/diff/?id=dev/v7.3-rc2/seq_buf/v5&id2=dev/v7.3-rc2/seq_buf/v4
 v4: https://lore.kernel.org/all/20261003035906.too.263-kees@kernel.org/
 v3: https://lore.kernel.org/all/20260930235231.out.387-kees@kernel.org/
 v2: https://lore.kernel.org/all/20260919002658.stay.929-kees@kernel.org/
 v1: https://lore.kernel.org/all/20260917002312.i.923-kees@kernel.org/

Thanks!

-Kees

[1] https://lore.kernel.org/all/20260917011359.1585961-1-morbo@google.com/

Bill Wendling (1):
  seq_buf: Add seq_buf_init_append()

Kees Cook (11):
  seq_buf: Do not print an empty line from an overflowed
    seq_buf_do_printk()
  seq_buf: Do not pop from an overflowed seq_buf
  scsi: lpfc: Print rx monitor records straight into the seq_buf
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
 include/linux/seq_buf.h                   | 141 +++++-
 include/linux/trace_seq.h                 |   5 +-
 arch/powerpc/platforms/pseries/papr_scm.c |   6 +-
 drivers/scsi/lpfc/lpfc_sli.c              |  45 +-
 kernel/bpf/diagnostics.c                  |   8 +-
 kernel/trace/trace_events.c               |   4 +-
 kernel/trace/trace_events_hist.c          |   6 +-
 lib/seq_buf.c                             |  37 +-
 lib/tests/seq_buf_kunit.c                 | 537 +++++++++++++++++++++-
 tools/testing/nvdimm/test/ndtest.c        |   2 +-
 11 files changed, 746 insertions(+), 54 deletions(-)

-- 
2.55.0

