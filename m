Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27C5363C57;
	Thu,  9 Apr 2026 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775749127; cv=none; b=TyY9EMKLG6epD0HEvupvurpXr7o62M2BkEkiYh3OC3LtVUHLg8qZb7GXVd0YEs50DrYMJwBV9XGEYyBqgqqxZtLjTLx2k5rhCyqu21mGzc6b1hRz0MbvCG+CXxyY8ufamDzdNiQtPIBn7x9GqHj/nhxfsbBXkTY/h79gvQT6ZD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775749127; c=relaxed/simple;
	bh=chAKNLPLAttzpVdJa5JgVqGBl4a+p94v6O5ilL9jwxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hU91PtAJxGaVxyu11/p5KjeTRHedLXKGyQ3YNQcdDhYqrVoAb+FI16jeYUpFoVxOmSEieyNWXzJji2VDoHTvA5xP3DnaRX20nNfpQrXf6QdXRdpfNjwVONNhHI5aZaLXL/j8SiXJACiiF+vNM1DuezTPURpxL/hTxTLyQerlpk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=A4UNh4XC; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="A4UNh4XC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=PCa60mjFX4oifWz/AszVEoh5OyM5fGxPne4L2M5whh4=; b=A4UNh4XCmQ+JTlrt/QVEDSgZ7d
	v1bDyizqdVsUQ1l3aX4VkiMWfFQREkSPB5egluCT+YeJQBqvSETjv2OZEP4wc50FMxinzRWtZZVN/
	aWzGKyQpZbGp8+YFE+jDVjxd0yU9q/wtHKYpCHQ30ICMUsO+JE1Se4yMa7HA3+6EdWWANJk+49m7k
	w2sL+dvW0cAfD/qhovbWrKNtmbPX5WGD13lfE7J3uXglWy+mZgq2llJTIBJ9j7mNcpBlfoLa88KGk
	4VUsOZEaX6pdKx8mJjuIYgXWBRqzE4KzALW+I21ZOLnMW6Dp31gmkAc3MGf2v+ZOUKfblRdEwj+Du
	+dEGyUqw==;
Received: from [177.189.74.94] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wArSp-00E07N-VX; Thu, 09 Apr 2026 17:38:40 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: linux-hardening@vger.kernel.org,
	kees@kernel.org
Cc: linux-kernel@vger.kernel.org,
	tony.luck@intel.com,
	kernel-dev@igalia.com,
	kernel@gpiccoli.net,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH V2] pstore/ftrace: Factor KASLR offset in the core kernel instruction addresses
Date: Thu,  9 Apr 2026 12:12:29 -0300
Message-ID: <20260409153830.2560633-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pstore ftrace frontend works by purely collecting the
instruction address, saving it on the persistent area through
the backend and when the log is read, on next boot for example,
the address is then resolved by using the regular printk symbol
lookup (%pS for example).

Problem: if we are running a relocatable kernel with KASLR enabled,
this is a recipe for failure in the symbol resolution on next boots,
since the addresses are offset'ed by the KASLR address. So, naturally
the way to go is factor the KASLR address out of instruction address
collection, and adding the fresh offset when resolving the symbol
on future boots.

Problem #2: modules also have varying addresses that float based
on module base address and potentially the module ordering in
memory, meaning factoring KASLR offset for them is useless.
So, let's hereby only take KASLR offset into account for core
kernel addresses, leaving module ones as is.

And we have yet a 3rd complexity: not necessarily the check range
for core kernel addresses holds true on future boots, since the
module base address will vary. With that, the choice was to mark
the addresses as being core vs module based on its MSB. And with
that...

...we have the 4th challenge here: for some "simple" architectures,
the CPU number is saved bit-encoded on the instruction pointer, to
allow bigger timestamps - this is set through the PSTORE_CPU_IN_IP
define for such architectures. Hence, the approach here is to skip
such architectures (at least in a first moment).

TL;DR: let's factor KASLR offsets on pstore/ftrace for core kernel
addresses, leaving module addresses out and also leaving out the
architectures that define PSTORE_CPU_IN_IP.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---

Hi folks, after the question/suggestion from Kees in the V1[0], about
using a global to hold the KASLR offset vs calling kaslr_offset() directly
in the code, I tried to do some performance analysis and started by looking
at the assembly generated in each case. And ... I found something very
interesting (that should be obvious to many of you, but for me was a fun
discovery): due to ELF relocations, when calling kaslr_offset() directly,
the kernel build system would add a kind of placeholder in the form of an
`add/sub 0x0,reg` that is handled at boot time, after decompression of the
full kernel image (and having the KASLR offset known at that point).

In other words, this is patched dynamically so, performance-wise, calling
kaslr_offset() is even better and of course, safer (as pointed by Kees!).
With that said, here comes the V2.

V2: Moved from using a global variable to hold the KASLR offset to
call kaslr_offset() directly (thanks Kees!).

Reviews / suggestions are very welcome, thanks in advance!
Cheers,

Guilherme

[0] V1 link: https://lore.kernel.org/r/20260313201010.1622406-3-gpiccoli@igalia.com/


 fs/pstore/ftrace.c   | 28 ++++++++++++++++++++++++++--
 fs/pstore/inode.c    |  6 ++++--
 fs/pstore/internal.h |  2 ++
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/fs/pstore/ftrace.c b/fs/pstore/ftrace.c
index 776cae20af4e..4778737cff40 100644
--- a/fs/pstore/ftrace.c
+++ b/fs/pstore/ftrace.c
@@ -18,11 +18,35 @@
 #include <linux/cache.h>
 #include <linux/slab.h>
 #include <asm/barrier.h>
+#include <asm/setup.h>
 #include "internal.h"
 
 /* This doesn't need to be atomic: speed is chosen over correctness here. */
 static u64 pstore_ftrace_stamp;
 
+static inline unsigned long adjust_ip(unsigned long ip)
+{
+#if defined(CONFIG_RANDOMIZE_BASE) && !defined(PSTORE_CPU_IN_IP)
+	if (core_kernel_text(ip))
+		return ip - kaslr_offset();
+
+	__clear_bit(BITS_PER_LONG - 1, &ip);
+#endif
+	return ip;
+}
+
+inline unsigned long decode_ip(unsigned long ip)
+{
+#if defined(CONFIG_RANDOMIZE_BASE) && !defined(PSTORE_CPU_IN_IP)
+	if (test_bit(BITS_PER_LONG - 1, &ip))
+		return ip + kaslr_offset();
+
+	__set_bit(BITS_PER_LONG - 1, &ip);
+
+#endif
+	return ip;
+}
+
 static void notrace pstore_ftrace_call(unsigned long ip,
 				       unsigned long parent_ip,
 				       struct ftrace_ops *op,
@@ -47,8 +71,8 @@ static void notrace pstore_ftrace_call(unsigned long ip,
 
 	local_irq_save(flags);
 
-	rec.ip = ip;
-	rec.parent_ip = parent_ip;
+	rec.ip = adjust_ip(ip);
+	rec.parent_ip = adjust_ip(parent_ip);
 	pstore_ftrace_write_timestamp(&rec, pstore_ftrace_stamp++);
 	pstore_ftrace_encode_cpu(&rec, raw_smp_processor_id());
 	psinfo->write(&record);
diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 83fa0bb3435a..62e678f3527d 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -105,17 +105,19 @@ static int pstore_ftrace_seq_show(struct seq_file *s, void *v)
 	struct pstore_private *ps = s->private;
 	struct pstore_ftrace_seq_data *data = v;
 	struct pstore_ftrace_record *rec;
+	unsigned long ip, parent_ip;
 
 	if (!data)
 		return 0;
 
 	rec = (struct pstore_ftrace_record *)(ps->record->buf + data->off);
 
+	ip = decode_ip(rec->ip);
+	parent_ip = decode_ip(rec->parent_ip);
 	seq_printf(s, "CPU:%d ts:%llu %08lx  %08lx  %ps <- %pS\n",
 		   pstore_ftrace_decode_cpu(rec),
 		   pstore_ftrace_read_timestamp(rec),
-		   rec->ip, rec->parent_ip, (void *)rec->ip,
-		   (void *)rec->parent_ip);
+		   ip, parent_ip, (void *)ip, (void *)parent_ip);
 
 	return 0;
 }
diff --git a/fs/pstore/internal.h b/fs/pstore/internal.h
index a0fc51196910..079284120db9 100644
--- a/fs/pstore/internal.h
+++ b/fs/pstore/internal.h
@@ -9,6 +9,7 @@
 extern unsigned int kmsg_bytes;
 
 #ifdef CONFIG_PSTORE_FTRACE
+extern unsigned long decode_ip(unsigned long ip);
 extern void pstore_register_ftrace(void);
 extern void pstore_unregister_ftrace(void);
 ssize_t pstore_ftrace_combine_log(char **dest_log, size_t *dest_log_size,
@@ -16,6 +17,7 @@ ssize_t pstore_ftrace_combine_log(char **dest_log, size_t *dest_log_size,
 #else
 static inline void pstore_register_ftrace(void) {}
 static inline void pstore_unregister_ftrace(void) {}
+static inline unsigned long decode_ip(unsigned long ip) { return ip; }
 static inline ssize_t
 pstore_ftrace_combine_log(char **dest_log, size_t *dest_log_size,
 			  const char *src_log, size_t src_log_size)
-- 
2.50.1

