Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4563384258
	for <linux-hardening@vger.kernel.org>; Fri, 12 Jun 2026 19:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781291281; cv=none; b=NlKXLeBzLCn0MMN3ovPWJVPWm8IW0G8eO+oi4q8CtMgf5+0/a9zpTWe6kB+Csh4AV1gjLWzFdXsKVN/+IqGTFXVwB0d+AeUEH8/62KMDD/+7+68azdJS7e7IFL5U/+4TwfOXjRUKIHLU5oMZl76JLgs/Nxt4w9I4lj7VKI3+WsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781291281; c=relaxed/simple;
	bh=PZspnF4rv+mQ+37X7tsOKHxRSFAFBUvdCHtCbApEfQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ct+5hJRa/qjVPmoV7iCpc42Y876wo+6ytOrUO2WAKwKTTrw6dbXbplqaHVw7fZlr5WOxGhSr78+k1lDZDO9ZFhFG4a20Jg6pAZnk3XYEPjdfsv+8HxaG3zH3w1JJ+ZRm9csoopMiAbYcWs8o1KERVeUH/0NoHvsoEE+Lylu0c6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apCJP6X3; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apCJP6X3"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36c68964315so813594a91.2
        for <linux-hardening@vger.kernel.org>; Fri, 12 Jun 2026 12:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781291278; x=1781896078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwTEg4XBjlq2gqrpSaNYbmX8jrkzkowNm264wvHp61I=;
        b=apCJP6X3IVEwpHQEWQC44x7bZzeR3GHFTOxj6fqypBd0THk01lo3/SkDhy/2K52Bjx
         Rt+49R4i1mCh1xKFrvAJOmJa78GC1dW6PKhchJR20mv+Pcl8uVPJmGqe+jpiz1wwh3n+
         zvIQjHokhjUZK44l/pAFHFBkytZo/3vmqyl+Tv/hlsJ2SZHxjtTIFlC+fpG7e4w3lmfk
         6QN9fln720dgIQQ6ic+BCWs5QncgpQgusLHybd+BWKKJRlpiGbKvPETHN04VfX3V330p
         TASUn79hz5vA5cR3ldWNN7meAlDgp1oBC2/0oF0xn/50ctDJHH4n+WAtlHkJzD3Sei3A
         cfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781291278; x=1781896078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UwTEg4XBjlq2gqrpSaNYbmX8jrkzkowNm264wvHp61I=;
        b=Vih+V1vrBSGcw8eGIMZoC1fEeTw/Xm4QQ/CChE+6kivJUQivA8bNk5ZkD8AkblXmww
         HPOmBGVbf5LWWPaPG73QztmlkAUhDACVQztYWsZ10n1MeLRRHFw1/EjD3EDa1IB2AQev
         QhE6xJRXJDiIr59w+8kQ4iVMZX3atTeTfSZdG0/oIzaz/9l2zn02+BlmlznRDa1exmzp
         TQm/mExU7YFKGSn4mhnbTK1kbPwC809GHSLZnV5W+61JI2jidOBiarKfVUmEhnL0Zc6Y
         H2/WE8QBVwD2mABITcOMCVDgjhq2utWPqBeWS/FPjDs5l9LRQ1goAQJTwwGcn3XB856f
         dtiQ==
X-Forwarded-Encrypted: i=1; AFNElJ9IpJXgW99FIuEl3YnYM6Xz5JaJxzId3LRRTN0b7jUnuQtcyE49j66jP1sd5qZOauu8UCFYNtjavFm4/NtfMWs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy25NvDT18sjZmhbPRJP7ntgwnDabRONRGlvkGVup/lHefOW/pJ
	mPaAkrKc+gmEbt7J6i3OZX9KSS2X9UoYRtN/KniyvOZfsnogtG3wTtVt
X-Gm-Gg: Acq92OH1C21k7klptOemhLgliMBB2r8/RmK1E0OjgmXh8TYwCq1H0uU0HHUkT6XeJv5
	M8PiHnTYotMTFULemISp/gOzbOv3u/WVLOvT9jBKTvEh4XNUmOHagClMu/MtrZZpfX/k5S1/FRP
	OD27PPWpN8//4DMT7NRC7lz86M9671OY4tBk8NNvITTk0Rlv0rxGLzU8Hc/1XeqGs26sjwgnGdb
	zlquaOiXZa3XOT396AS3gPHXd01Xg0mrHrXbusSh9JqlzRoR6Hnm4XkFX1ByiUkT1YTSc4pzjGg
	5FBWs3uCbNIPIhJkLx9Kxz0m0URI/DfC8hHFSbvOMJrsgseiDvfaArSAgftgLxppXPxKHfP2SsS
	82HsSehJ5b10mhSjxU1HkgZbGZ+U+E5Dqglgj5bQCSbIH3dWqTIc7kz+WIMQUVmJr+Av98cGczc
	Ri9mAfSj6jigeUFC51zGrDUFFRdZEhzD9/Zq8u1ihpvxgcYZkmnOarsw==
X-Received: by 2002:a17:90b:28cd:b0:36a:95c:7613 with SMTP id 98e67ed59e1d1-37a0202ece8mr4596847a91.10.1781291277427;
        Fri, 12 Jun 2026 12:07:57 -0700 (PDT)
Received: from LAPTOP-97G9G880.localdomain ([106.206.15.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a1eba8e9asm2748485a91.2.2026.06.12.12.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 12:07:56 -0700 (PDT)
From: Karthikeyan KS <karthiproffesional@gmail.com>
To: andrew@codeconstruct.com.au
Cc: joel@jms.id.au,
	andrew@aj.id.au,
	Kees Cook <kees@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Karthikeyan KS <karthiproffesional@gmail.com>
Subject: [PATCH v6] soc: aspeed: lpc-snoop: Fix usercopy overflow in snoop_file_read
Date: Fri, 12 Jun 2026 19:07:43 +0000
Message-ID: <20260612190744.172638-1-karthiproffesional@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <033f2657ae6a94ad13d22f717a2900afb75d892d.camel@codeconstruct.com.au>
References: <033f2657ae6a94ad13d22f717a2900afb75d892d.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

put_fifo_with_discard() acts as both producer and consumer on the kfifo:
it calls kfifo_skip() (advances out) and kfifo_put() (advances in) from
the IRQ handler without synchronizing with snoop_file_read(), which also
consumes via kfifo_to_user(). On SMP systems this concurrent access can
leave (in - out) larger than the ring buffer, so __kfifo_to_user()'s clamp
to (in - out) is ineffective and kfifo_copy_to_user() can attempt a
copy_to_user() past the kmalloc-2k backing store:

  usercopy: Kernel memory exposure attempt detected from SLUB object
  'kmalloc-2k' (offset 0, size 2049)!
  kernel BUG at mm/usercopy.c!
  Call trace:
   usercopy_abort
   __check_heap_object
   __check_object_size
   kfifo_copy_to_user
   __kfifo_to_user
   snoop_file_read
   vfs_read

Serialize kfifo access with a per-channel spinlock shared between the
IRQ handler (producer) and the file reader (consumer).  Annotate @fifo
with __guarded_by(&lock) and opt the driver into context analysis so the
compiler enforces that all fifo access holds the lock.

Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc chardev")
Signed-off-by: Karthikeyan KS <karthiproffesional@gmail.com>
---
 drivers/soc/aspeed/Makefile           |  1 +
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 38 ++++++++++++++++++---------
 2 files changed, 27 insertions(+), 12 deletions(-)

Andrew,

Thanks for the review.

Changes since v5:
- Annotate @fifo with __guarded_by(&lock) instead of a comment
- Move kfifo_initialized() check inside scoped_guard(spinlock, &chan->lock)
  in put_fifo_with_discard()
- Replace spin_lock_init() with scoped_guard(spinlock_init, &channel->lock)
  around kfifo_alloc() in aspeed_lpc_enable_snoop()
- Enable CONTEXT_ANALYSIS for this driver in drivers/soc/aspeed/Makefile

Dropped Cc: stable — the fix uses cleanup.h/context-analysis idioms absent
from LTS; I'll send adapted backports to stable@ once this is in mainline.

Tested on ast2600-evb (QEMU): clang-22 with CONFIG_WARN_CONTEXT_ANALYSIS=y
shows no context-analysis warnings; PROVE_LOCKING, DEBUG_ATOMIC_SLEEP and
HARDENED_USERCOPY show no splats. Overflow reproduced via a fault-injection
module forcing the post-race (in - out) state (QEMU doesn't model the ARM
ordering that triggers it in the field): unpatched panics, patched returns
cleanly.

Thanks,
Karthikeyan

diff --git a/drivers/soc/aspeed/Makefile b/drivers/soc/aspeed/Makefile
index b35d74592964..b5188dcde37a 100644
--- a/drivers/soc/aspeed/Makefile
+++ b/drivers/soc/aspeed/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_ASPEED_LPC_SNOOP)		+= aspeed-lpc-snoop.o
 obj-$(CONFIG_ASPEED_UART_ROUTING)	+= aspeed-uart-routing.o
 obj-$(CONFIG_ASPEED_P2A_CTRL)		+= aspeed-p2a-ctrl.o
 obj-$(CONFIG_ASPEED_SOCINFO)		+= aspeed-socinfo.o
+CONTEXT_ANALYSIS_aspeed-lpc-snoop.o	:= y
diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index b03310c0830d..7fa1a345acac 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/dev_printk.h>
 #include <linux/interrupt.h>
@@ -74,7 +75,8 @@ struct aspeed_lpc_snoop_channel_cfg {
 struct aspeed_lpc_snoop_channel {
 	const struct aspeed_lpc_snoop_channel_cfg *cfg;
 	bool enabled;
-	struct kfifo		fifo;
+	spinlock_t		lock;
+	struct kfifo		fifo __guarded_by(&lock);
 	wait_queue_head_t	wq;
 	struct miscdevice	miscdev;
 };
@@ -114,6 +116,7 @@ static ssize_t snoop_file_read(struct file *file, char __user *buffer,
 				size_t count, loff_t *ppos)
 {
 	struct aspeed_lpc_snoop_channel *chan = snoop_file_to_chan(file);
+	u8 *buf __free(kfree) = NULL;
 	unsigned int copied;
 	int ret = 0;
 
@@ -125,9 +128,16 @@ static ssize_t snoop_file_read(struct file *file, char __user *buffer,
 		if (ret == -ERESTARTSYS)
 			return -EINTR;
 	}
-	ret = kfifo_to_user(&chan->fifo, buffer, count, &copied);
-	if (ret)
-		return ret;
+
+	count = min_t(size_t, count, SNOOP_FIFO_SIZE);
+
+	buf = kmalloc(count, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	copied = kfifo_out_spinlocked(&chan->fifo, buf, count, &chan->lock);
+	if (copied && copy_to_user(buffer, buf, copied))
+		return -EFAULT;
 
 	return copied;
 }
@@ -151,11 +161,13 @@ static const struct file_operations snoop_fops = {
 /* Save a byte to a FIFO and discard the oldest byte if FIFO is full */
 static void put_fifo_with_discard(struct aspeed_lpc_snoop_channel *chan, u8 val)
 {
-	if (!kfifo_initialized(&chan->fifo))
-		return;
-	if (kfifo_is_full(&chan->fifo))
-		kfifo_skip(&chan->fifo);
-	kfifo_put(&chan->fifo, val);
+	scoped_guard(spinlock, &chan->lock) {
+		if (!kfifo_initialized(&chan->fifo))
+			return;
+		if (kfifo_is_full(&chan->fifo))
+			kfifo_skip(&chan->fifo);
+		kfifo_put(&chan->fifo, val);
+	}
 	wake_up_interruptible(&chan->wq);
 }
 
@@ -239,9 +251,11 @@ static int aspeed_lpc_enable_snoop(struct device *dev,
 	if (!channel->miscdev.name)
 		return -ENOMEM;
 
-	rc = kfifo_alloc(&channel->fifo, SNOOP_FIFO_SIZE, GFP_KERNEL);
-	if (rc)
-		return rc;
+	scoped_guard(spinlock_init, &channel->lock) {
+		rc = kfifo_alloc(&channel->fifo, SNOOP_FIFO_SIZE, GFP_KERNEL);
+		if (rc)
+			return rc;
+	}
 
 	rc = misc_register(&channel->miscdev);
 	if (rc)
--
2.43.0

