Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794756874;
	b=0x7+tbb8Q2C0Bxsb0kK+4qv8c0EJBVnS3DfKSm2i0FvvpBaz7i7G1FErVHmi0pOZI1re
	 SS4XdRiBWXkJIkCV2u1ygyao3oQa+xbeOTiyN+DKU+Osrosvltgjw7vJj4NvQj+lZALPH
	 hBPPsEtmFH+yCCsDz7r94Jm9EhmEbvkPZjsMEIidFaQMDScFNPKRnBVYMdm8A3NLF99lS
	 LeRsCpHc7V30KvLTBtlgG9O7rUvCK147SJtpQFe1ikmByX2VjptXdwkzg5AX8T3KF8FiU
	 pAm0k5NLj+ZKmmrip19U9UOdfDbhnkJtSHbxlTjWJ2eYbRPzteko58Mg/eXNS2lR/TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794756874;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fgl4RblzZJ8So9KBu3tfGKhQR2hNoBDCy44F1/CLS0c=;
	b=Y2g5MWS9zwax/sv2F4LE2PDFvXusp7ZFEP1MELYcAd0AT4tLTo2cdq4PqMJFAl7JOgcD
	 vX9QpA5WLJ4Lokf6n55KqprJRuGUZ7jrXUz0cw/C1+MX+YNHQILZo9tR3em6vnxHI04Dv
	 g5IZMPwoALZVMHPLVATKdlkPKQwftsPTIU3l6Z7uw0n7xTNEMKmHpqC1KADnN1qD0Huz8
	 +5ToU5jLdibcxb5HFIa32LknS9oGG9YmN8QAqdCTTfe3Vaj4FpsbuoCILbTUJUAmY0sNL
	 mjsfd855pmXwx47rfbQQ9HmgWaAMdQ1NKF/04KTCWlj/wuTjFUMhMY2nzlC31DsNTyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="WFV324J/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D7F606A334;
	Sun, 15 Nov 2026 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WFV324J/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BC71F000C4;
	Sun, 15 Nov 2026 15:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794756874;
	bh=fgl4RblzZJ8So9KBu3tfGKhQR2hNoBDCy44F1/CLS0c=;
	h=From:To:Cc:Subject:Date;
	b=WFV324J/Xjc7fwLn1nE30tsmFLUDWySOdzGUwijIhPBX52FjhkrGnzvUS4x7W8dW9
	 LrBxap8M9GhwHvWB3LwoZbcWQcAwB8BI7stIIzBVdwCOmvN3O0Mq3KB04v93E2sDfW
	 F6BekJwAm1s4CrMxJ+a9xmp9AK86l8LUSlcn/q/gVcdpUbwvNFRpfFvibNbq3Pl6yI
	 v524esditEE9EKkgWxOzz0zZkZiOikAI8PsaLfPoNtUTfezSd8kohpOa8vEzxNeisZ
	 3KXwFFBHmJLDJQMZkhAGMVTktxdHbsgj8APn4xhlArnha4gb2mbuMi5M/V4Sr7o+hS
	 wXsQfRBEQKuug==
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
Subject: [PATCH] seq_buf: always inline seq_buf_terminate()
Date: Sun, 15 Nov 2026 10:34:29 -0500
Message-ID: <20261115153430.1607764-1-sashal@kernel.org>
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

Commit 7b8cd26b6aab8 ("seq_buf: Mark a seq_buf overflowed when terminating it
loses a byte") made __seq_buf_terminate() bigger, and clang no longer inlines
seq_buf_terminate() into its two callers in kernel/trace/trace_events.c. Both
pass bootup_event_seq, which is __initdata, so the out-of-line copy sits in
.text with that address in it and modpost warns:

  WARNING: modpost: vmlinux: section mismatch in reference: seq_buf_terminate+0x12 (section: .text) -> bootup_event_seq (section: .init.data)

Both callers are __init, so nothing uses the buffer after it is freed.  But the
warning shows up in allmodconfig builds, and it is an error with
CONFIG_SECTION_MISMATCH_WARN_ONLY=n.

Mark seq_buf_terminate() and __seq_buf_terminate() __always_inline.  Marking
only seq_buf_terminate() is not enough, as the same thing then happens to
__seq_buf_terminate().

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

 include/linux/seq_buf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index 6b915c67d2358..f72dd258206fb 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
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

