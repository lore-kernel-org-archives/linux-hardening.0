Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794795607;
	b=OgWQPgVuE0cPrYM7SU5crKuuCGaBQ8fCeHLu6BFOQ8Zxp8zWmnhhnE3N4pT02YNcTdof
	 v32aw3w2W+4bfJJBZnO8eJIIPq+QhzR+DHin8EirV6Z8BTYyJMPb0/Nl+ZAFTmCGODTe0
	 ydh5Vp0U/5HYGoRrrIrQM32igxXhRs4U5Pl/Th1v2K9TgZIHCsIMtgV2SbBJrvuFa4ryO
	 lvfvNUwyi4ynecSn+EFqd6jchp9eebJJwpMqAqZCt30px5DyYVb6/XMu/lcSgmeDMmlhQ
	 0c2EFhJf/HhNmAtZFodACalxMcP1DT4ey85Yaj+M6pEtsMXSlRMjf375U0/rEroheUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794795607;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mtDsjVuvFX9+DhdSuhUXhkgY2YLwLBeTv+Zc0QOggoM=;
	b=en1RKu3PRxhimxIoc6AmbeLK33qRQN7PtI2+cb4a/+y+8MYIPwVNzY1am2vucWPQMOIr
	 0QeCYHzzacRanOnCfWnsB7nBRMx6sRa89iSTHUUqmeQki6KZtklV5P5W7rlb10MPEfbEz
	 b0Aq6Tw02Gy36dytKR167vl3u4Vsp2Fdt32Mn83CtydteiHf4whqXrXt8Sy41AM3ot71G
	 2hvry4/2pqTKNfh/QD7K8z6ZV/w5e8eupy/lLNPGabKJEK/pFtGwfkSxzveOW2XARXRQI
	 T7z1pxm7Gn/yGD9Iywie2rIkPc7hYV+tnca0z3txgm7Dvy3MBBFQixaKyDV0jJi4jMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pb7KS2wy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0D6606A31C;
	Mon, 16 Nov 2026 02:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pb7KS2wy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1561F000C4;
	Mon, 16 Nov 2026 02:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794795606;
	bh=mtDsjVuvFX9+DhdSuhUXhkgY2YLwLBeTv+Zc0QOggoM=;
	h=From:To:Cc:Subject:Date;
	b=Pb7KS2wy/gqEffBFXXEPx1uockJPskK0qgh3k+kVoMbsYtqE7WfBmGNR0uXxhS4sN
	 KD4ERbD9PrRfPIxIHQV/5tYnl8NoMkFUth61GhJLfiXWPi0oChtAUA+1ruM4/UZABm
	 nI7qioYflluwFJlaCTp2gPY5FQySUsUiEFjNhB+AOzkmH2yInRrIgdQ8UKlDeysSxT
	 6vjouI/VS54idmZCXIcxfq42XtiWZLrqVgAHbtI0dZK0+/Nckhyqvu91WWnpZHZade
	 eHYFEaLgsoHW9/NXhdbcJYY8ozVqgeRzQ3JodcoUNce1WTWsL9fyOUQEehBzhMzTTC
	 qSwHDtTpO4ETw==
From: Sasha Levin <sashal@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Petr Mladek <pmladek@suse.com>,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] seq_buf: always inline seq_buf_terminate() and the helpers around it
Date: Sun, 15 Nov 2026 21:20:04 -0500
Message-ID: <20261116022004.2373108-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 7b8cd26b6aab8 ("seq_buf: Mark a seq_buf overflowed when terminating
it loses a byte") made __seq_buf_terminate() bigger, and clang no longer
inlines seq_buf_terminate() into its two callers in
kernel/trace/trace_events.c. Both pass bootup_event_seq, which is
__initdata, so the out-of-line copy sits in .text with that address in it
and modpost warns:

  WARNING: modpost: vmlinux: section mismatch in reference: seq_buf_terminate+0x12 (section: .text) -> bootup_event_seq (section: .init.data)

Both callers are __init, so nothing uses the buffer after it is freed.
But the warning shows up in allmodconfig builds, and it is an error with
CONFIG_SECTION_MISMATCH_WARN_ONLY=n.

Always inlining only seq_buf_terminate() and __seq_buf_terminate() moves
the problem: clang then leaves seq_buf_set_overflow() out of line with the
same address in it. So mark every inline helper that trace_events.c
reaches with bootup_event_seq __always_inline: seq_buf_terminate(),
__seq_buf_terminate(), seq_buf_set_overflow(), seq_buf_buffer_left(),
seq_buf_has_overflowed() and seq_buf_used().

Fixes: 7b8cd26b6aab8 ("seq_buf: Mark a seq_buf overflowed when terminating it loses a byte")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202611110802.zPIiPSnJ-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202611120138.Fwm5Ljmj-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202611122226.vTBpAmtr-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202611122323.IvGv8FYK-lkp@intel.com/
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
7b8cd26b6aab8 is on both for-next/kspp and for-linus/hardening.

Changes in v2:
- v1 moved the warning to seq_buf_set_overflow() instead of removing it,
  as the kernel test robot found [1]. Mark all six helpers.
- Checked with modpost itself this time, run on trace_events.o: x86 and
  arm64 with clang 21 (allmodconfig, defconfig, defconfig with
  CC_OPTIMIZE_FOR_SIZE, and the robot's config) and with gcc 16 (x86
  allmodconfig and the size-optimized configs). No mismatch is left.

v1: https://lore.kernel.org/r/20261115153430.1607764-1-sashal@kernel.org

[1] https://lore.kernel.org/oe-kbuild-all/202611160835.RPhYOuAv-lkp@intel.com/

 include/linux/seq_buf.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index 6b915c67d2358..da69f2f09772e 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -62,7 +62,7 @@ seq_buf_init(struct seq_buf *s, char *buf, unsigned int size)
  * seq_buf have a buffer that might overflow. When this happens
  * len is set to be greater than size.
  */
-static inline bool
+static __always_inline bool
 seq_buf_has_overflowed(struct seq_buf *s)
 {
 	return s->len > s->size;
@@ -74,7 +74,7 @@ seq_buf_has_overflowed(struct seq_buf *s)
  * seq_buf_str() terminates it, so clear whatever was not written: a writer
  * sets len to how much it filled, and anything past that was never adopted.
  */
-static inline void
+static __always_inline void
 seq_buf_set_overflow(struct seq_buf *s)
 {
 	if (s->len < s->size)
@@ -111,7 +111,7 @@ seq_buf_init_append(struct seq_buf *s, char *buf, unsigned int size)
 /*
  * How much buffer is left on the seq_buf?
  */
-static inline unsigned int
+static __always_inline unsigned int
 seq_buf_buffer_left(struct seq_buf *s)
 {
 	if (seq_buf_has_overflowed(s))
@@ -121,7 +121,7 @@ seq_buf_buffer_left(struct seq_buf *s)
 }
 
 /* How much buffer was written? */
-static inline unsigned int seq_buf_used(struct seq_buf *s)
+static __always_inline unsigned int seq_buf_used(struct seq_buf *s)
 {
 	return min(s->len, s->size);
 }
@@ -134,7 +134,7 @@ static inline unsigned int seq_buf_used(struct seq_buf *s)
  *
  * Returns: the offset of the NUL.
  */
-static inline size_t __seq_buf_terminate(struct seq_buf *s)
+static __always_inline size_t __seq_buf_terminate(struct seq_buf *s)
 {
 	size_t end;
 
@@ -240,7 +240,7 @@ static inline size_t seq_buf_strlen(struct seq_buf *s)
  * After this function is called, s->buffer is safe to use
  * in string operations.
  */
-static inline void seq_buf_terminate(struct seq_buf *s)
+static __always_inline void seq_buf_terminate(struct seq_buf *s)
 {
 	if (s->size == 0)
 		return;

base-commit: 7b8cd26b6aab8cf147165610d13964f79200a5a7
-- 
2.53.0

