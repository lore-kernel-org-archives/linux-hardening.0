Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3BB220F26;
	Fri, 20 Jun 2025 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750415175; cv=none; b=FWGQc/ATxpwST1ANKfvV4aiDtbVgGsY1tojzQrYykDz2WlPbL/CLO6tc3/pmWcjHTX4u1lN6OZXXub0V5bdbj4UXQFEi6CQDwOQjJE4+sE3rsIiFnzkVvD58BwU5f/06LzcE8PW5UyJLLshF9bYX8J7fgJPKM5oY2+UeGkT8Uqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750415175; c=relaxed/simple;
	bh=KsZULzgoOOT+sxKvko8XniZUMGczHqGKfi8mVmnXnn8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TInDqDy68dyiMHJhX+WHflS9lp0kljZTp8KEwqpieQM8YcDbhSd2+ru5fw0CsrpYnR0xPcQu8+Ngcmbkx8LU/w3h6ueZMku7nn8C+vy31ICWaaFonfv5IwiKf5JsNMV5Bh+cfScjiOLU6ovpaKWOdPXp2BWKAIt0B7JdrW8cUCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vveZINik; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vNAhsltt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vveZINik";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vNAhsltt"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750415171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=37+pc5hnSQcIUC1PphTCj1MTjNL2mT1cwiHFC56eyhU=;
	b=vveZINikc4AKFFT+ryK0r7aJwbbr26KR+MVE1tYCfqbYhmy2OIURS0BNr8bTE3M0Ou66fR
	NGEWyMeMJNFPcQoZOnKydKY04VdWlRZaiO41dVhSQ2WOMoIILnonopmbyA7VpRtBYUBpVi
	rEOL82bDTpRyZgKuNtib0HTb2I/kowudTMK0kyw8px3syVde+iJ8EEnLLevcer0qmMaQh2
	+33aM2HtNICsX6JG3BOYYgob3LpsZLdO+3InDzJgaM6fOdmVTrvUwB9os0k4HuvAju6jJL
	P4BnDoVYIKU3GSNCxJvPVcj6P+OrRq8U9ddmGiDo5N0XBmgfiNnNbhN/WD+f2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750415171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=37+pc5hnSQcIUC1PphTCj1MTjNL2mT1cwiHFC56eyhU=;
	b=vNAhsltt6nMTMUBPw60Sc9J/e6fn5n6cRj7hE0EyQ6es3hI3Qldyj1B2aP7h+PxIskFhQ9
	g5v9cGt74MbiY5Bg==
Date: Fri, 20 Jun 2025 12:26:09 +0200
Subject: [PATCH v4] printk: ringbuffer: Add KUnit test
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250620-printk-ringbuffer-test-v4-1-8df873f1f3e0@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAEA3VWgC/33OwWrDMAwG4FcJPtdDsi3H3WnvMXawHbk1G0lx0
 tBR8u5zusNKaXYR/AJ9+q9i5JJ5FK/NVRSe85iHvgaza0Q8+v7AMnc1CwXKICDKU8n99CnrPIR
 zSlzkxOMkk2mTa6P1zgVRj0+FU77c4PePmo95nIbyffsz47pdSQKDtEXOKFG27Cm2QXsG/faV+
 /NUhj5fXjoWKzurO0rpTUpVyioMe4idjxQfqF3zSxDYfwkkpQDI7jngszbmvo3bpEylDDH4ECF
 pomeU/qMsqk1KV4oIIjjHrK17pJZl+QHVETyT5AEAAA==
X-Change-ID: 20241011-printk-ringbuffer-test-f47f87c6a88b
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: John Ogness <jogness@linutronix.de>, David Gow <davidgow@google.com>, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750415170; l=15393;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=KsZULzgoOOT+sxKvko8XniZUMGczHqGKfi8mVmnXnn8=;
 b=cDGLTuoUl+nlM1Q8Rvdf/Ux4DUEybUug4bblcZlx6OPepcqP2UDDY8ugtnhl2x6j9BEaR3B1r
 zEpUFMz3I5yCxyd6hfgX4ADrE3PkC4iV3qVKQip7DPeZAkvBpWNJmiz
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The KUnit test validates the correct operation of the ringbuffer.
A separate dedicated ringbuffer is used so that the global printk
ringbuffer is not touched.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>
---
Changes in v4:
- Add comment about possible prb_reserve() failures
- Pick up tags from Petr
- Link to v3: https://lore.kernel.org/r/20250612-printk-ringbuffer-test-v3-1-550c088ee368@linutronix.de

Changes in v3:
- Rebase onto v6.16-rc1
- Fix build for PRINTK_RINGBUFFER_KUNIT_TEST=m
- Add comment about reinitialization
- Avoid strnlen() in prbtest_check_data() to
  - Avoid out-of-bound reads with CONFIG_FORTIFY_SOURCE
  - Work correctly with so many CPUs that "text_id" will be '\0'
- Link to v2: https://lore.kernel.org/r/20250506-printk-ringbuffer-test-v2-1-152200569eb1@linutronix.de

Changes in v2:
- Adapt to new MODULE_IMPORT_NS() syntax
- Handle platforms without u64 division
- Allocate resources through kunit wrappers
- Drop setup thread
- Allow multiple executions
- Make naming more consistent
- Use get_random_u32_below()
- Allow !CONFIG_SMP
- Follow KUNIT kconfig naming scheme
- Fix limited string formatting in prbtest_fail_record()
- Fix MODULE_DESCRIPTION
- Use get_random_u32_inclusive()
- Drop timing measurements, preemption and lost tracking
- Use plain jiffies variable
- Print warning if only one CPU is present
- Style cleanup
- Fix formatting of bad message payload
- Link to v1: https://lore.kernel.org/r/20250415-printk-ringbuffer-test-v1-1-7ea5c7b3ae03@linutronix.de
---
 init/Kconfig                                 |  13 ++
 kernel/printk/.kunitconfig                   |   3 +
 kernel/printk/Makefile                       |   2 +
 kernel/printk/printk_ringbuffer.c            |   5 +
 kernel/printk/printk_ringbuffer_kunit_test.c | 308 +++++++++++++++++++++++++++
 5 files changed, 331 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index af4c2f0854554bbcdf193852cf5c1d2c2accc64f..e3973d1576a3ea3aa62bf8fe7c449b6b49518ea7 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1667,6 +1667,19 @@ config PRINTK
 	  very difficult to diagnose system problems, saying N here is
 	  strongly discouraged.
 
+config PRINTK_RINGBUFFER_KUNIT_TEST
+	tristate "KUnit Test for the printk ringbuffer" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	depends on PRINTK
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the printk ringbuffer KUnit test suite.
+
+	  For more information on KUnit and unit tests in general, please refer
+	  to the KUnit documentation.
+
+	  If unsure, say N.
+
 config BUG
 	bool "BUG() support" if EXPERT
 	default y
diff --git a/kernel/printk/.kunitconfig b/kernel/printk/.kunitconfig
new file mode 100644
index 0000000000000000000000000000000000000000..f31458fd1a92fe24a61f6a6ebd1078b7ea2cd137
--- /dev/null
+++ b/kernel/printk/.kunitconfig
@@ -0,0 +1,3 @@
+CONFIG_KUNIT=y
+CONFIG_PRINTK=y
+CONFIG_PRINTK_RINGBUFFER_KUNIT_TEST=y
diff --git a/kernel/printk/Makefile b/kernel/printk/Makefile
index 39a2b61c7232e7b65d64eafd3ceadcf72cd32760..f8004ac3983da27a6218705fc5273bf3bf572045 100644
--- a/kernel/printk/Makefile
+++ b/kernel/printk/Makefile
@@ -7,3 +7,5 @@ obj-$(CONFIG_PRINTK_INDEX)	+= index.o
 obj-$(CONFIG_PRINTK)                 += printk_support.o
 printk_support-y	             := printk_ringbuffer.o
 printk_support-$(CONFIG_SYSCTL)	     += sysctl.o
+
+obj-$(CONFIG_PRINTK_RINGBUFFER_KUNIT_TEST) += printk_ringbuffer_kunit_test.o
diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index d9fb053cff67dbdb8741ee3cac60f51ab986e499..bc811de18316bb8bcb59b96a272addd3c0d46e40 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <kunit/visibility.h>
 #include <linux/kernel.h>
 #include <linux/irqflags.h>
 #include <linux/string.h>
@@ -1685,6 +1686,7 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 	memset(r, 0, sizeof(*r));
 	return false;
 }
+EXPORT_SYMBOL_IF_KUNIT(prb_reserve);
 
 /* Commit the data (possibly finalizing it) and restore interrupts. */
 static void _prb_commit(struct prb_reserved_entry *e, unsigned long state_val)
@@ -1759,6 +1761,7 @@ void prb_commit(struct prb_reserved_entry *e)
 	if (head_id != e->id)
 		desc_make_final(e->rb, e->id);
 }
+EXPORT_SYMBOL_IF_KUNIT(prb_commit);
 
 /**
  * prb_final_commit() - Commit and finalize (previously reserved) data to
@@ -2184,6 +2187,7 @@ bool prb_read_valid(struct printk_ringbuffer *rb, u64 seq,
 {
 	return _prb_read_valid(rb, &seq, r, NULL);
 }
+EXPORT_SYMBOL_IF_KUNIT(prb_read_valid);
 
 /**
  * prb_read_valid_info() - Non-blocking read of meta data for a requested
@@ -2333,6 +2337,7 @@ void prb_init(struct printk_ringbuffer *rb,
 	infos[0].seq = -(u64)_DESCS_COUNT(descbits);
 	infos[_DESCS_COUNT(descbits) - 1].seq = 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(prb_init);
 
 /**
  * prb_record_text_space() - Query the full actual used ringbuffer space for
diff --git a/kernel/printk/printk_ringbuffer_kunit_test.c b/kernel/printk/printk_ringbuffer_kunit_test.c
new file mode 100644
index 0000000000000000000000000000000000000000..217dcc14670cd5d17ee412a11ccf784afd7343b9
--- /dev/null
+++ b/kernel/printk/printk_ringbuffer_kunit_test.c
@@ -0,0 +1,308 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/cpuhplock.h>
+#include <linux/cpumask.h>
+#include <linux/init.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/random.h>
+#include <linux/slab.h>
+#include <linux/timer.h>
+#include <linux/wait.h>
+
+#include <kunit/resource.h>
+#include <kunit/test.h>
+
+#include "printk_ringbuffer.h"
+
+/*
+ * This KUnit tests the data integrity of the lockless printk_ringbuffer.
+ * From multiple CPUs it writes messages of varying length and content while
+ * a reader validates the correctness of the messages.
+ *
+ * IMPORTANT: The more CPUs you can use for this KUnit, the better!
+ *
+ * The test works by starting "num_online_cpus() - 1" writer threads, each
+ * pinned to their own CPU. Each writer thread loops, writing data of varying
+ * length into a printk_ringbuffer as fast as possible. The data content is
+ * an embedded data struct followed by string content repeating the byte:
+ *
+ *      'A' + CPUID
+ *
+ * The reader is running on the remaining online CPU, or if there is only one
+ * CPU on the same as the writer.
+ * It ensures that the embedded struct content is consistent with the string
+ * and that the string * is terminated and is composed of the same repeating
+ * byte as its first byte.
+ *
+ * Because the threads are running in such tight loops, they will call
+ * cond_resched() from time to time so the system stays functional.
+ *
+ * If the reader encounters an error, the test is aborted and some
+ * information about the error is reported.
+ * The runtime of the test can be configured with the runtime_ms module parameter.
+ *
+ * Note that the test is performed on a separate printk_ringbuffer instance
+ * and not the instance used by printk().
+ */
+
+static unsigned long runtime_ms = 10 * MSEC_PER_SEC;
+module_param(runtime_ms, ulong, 0400);
+
+/* test data structure */
+struct prbtest_rbdata {
+	unsigned int len;
+	char text[] __counted_by(len);
+};
+
+#define MAX_RBDATA_TEXT_SIZE 0x7f
+/* +1 for terminator. */
+#define MAX_PRB_RECORD_SIZE (sizeof(struct prbtest_rbdata) + MAX_RBDATA_TEXT_SIZE + 1)
+
+struct prbtest_data {
+	struct kunit *test;
+	struct printk_ringbuffer *ringbuffer;
+	/* used by writers to signal reader of new records */
+	wait_queue_head_t new_record_wait;
+};
+
+struct prbtest_thread_data {
+	unsigned long num;
+	struct prbtest_data *test_data;
+};
+
+static void prbtest_fail_record(struct kunit *test, const struct prbtest_rbdata *dat, u64 seq)
+{
+	KUNIT_FAIL(test, "BAD RECORD: seq=%llu len=%u text=%.*s\n",
+		   seq, dat->len,
+		   dat->len <= MAX_RBDATA_TEXT_SIZE ? dat->len : -1,
+		   dat->len <= MAX_RBDATA_TEXT_SIZE ? dat->text : "<invalid>");
+}
+
+static bool prbtest_check_data(const struct prbtest_rbdata *dat)
+{
+	unsigned int len;
+
+	/* Sane length? */
+	if (dat->len < 1 || dat->len > MAX_RBDATA_TEXT_SIZE)
+		return false;
+
+	if (dat->text[dat->len] != '\0')
+		return false;
+
+	/* String repeats with the same character? */
+	len = dat->len;
+	while (len--) {
+		if (dat->text[len] != dat->text[0])
+			return false;
+	}
+
+	return true;
+}
+
+static int prbtest_writer(void *data)
+{
+	struct prbtest_thread_data *tr = data;
+	char text_id = 'A' + tr->num;
+	struct prb_reserved_entry e;
+	struct prbtest_rbdata *dat;
+	u32 record_size, text_size;
+	unsigned long count = 0;
+	struct printk_record r;
+
+	kunit_info(tr->test_data->test, "start thread %03lu (writer)\n", tr->num);
+
+	for (;;) {
+		/* ensure at least 1 character */
+		text_size = get_random_u32_inclusive(1, MAX_RBDATA_TEXT_SIZE);
+		/* +1 for terminator. */
+		record_size = sizeof(struct prbtest_rbdata) + text_size + 1;
+		WARN_ON_ONCE(record_size > MAX_PRB_RECORD_SIZE);
+
+		/* specify the text sizes for reservation */
+		prb_rec_init_wr(&r, record_size);
+
+		/*
+		 * Reservation can fail if:
+		 *
+		 *      - No free descriptor is available.
+		 *      - The buffer is full, and the oldest record is reserved
+		 *        but not yet committed.
+		 *
+		 * It actually happens in this test because all CPUs are trying
+		 * to write an unbounded number of messages in a tight loop.
+		 * These failures are intentionally ignored because this test
+		 * focuses on races, ringbuffer consistency, and pushing system
+		 * usability limits.
+		 */
+		if (prb_reserve(&e, tr->test_data->ringbuffer, &r)) {
+			r.info->text_len = record_size;
+
+			dat = (struct prbtest_rbdata *)r.text_buf;
+			dat->len = text_size;
+			memset(dat->text, text_id, text_size);
+			dat->text[text_size] = 0;
+
+			prb_commit(&e);
+
+			wake_up_interruptible(&tr->test_data->new_record_wait);
+		}
+
+		if ((count++ & 0x3fff) == 0)
+			cond_resched();
+
+		if (kthread_should_stop())
+			break;
+	}
+
+	kunit_info(tr->test_data->test, "end thread %03lu: wrote=%lu\n", tr->num, count);
+
+	return 0;
+}
+
+struct prbtest_wakeup_timer {
+	struct timer_list timer;
+	struct task_struct *task;
+};
+
+static void prbtest_wakeup_callback(struct timer_list *timer)
+{
+	struct prbtest_wakeup_timer *wakeup = timer_container_of(wakeup, timer, timer);
+
+	set_tsk_thread_flag(wakeup->task, TIF_NOTIFY_SIGNAL);
+	wake_up_process(wakeup->task);
+}
+
+static int prbtest_reader(struct prbtest_data *test_data, unsigned long timeout_ms)
+{
+	struct prbtest_wakeup_timer wakeup;
+	char text_buf[MAX_PRB_RECORD_SIZE];
+	unsigned long count = 0;
+	struct printk_info info;
+	struct printk_record r;
+	u64 seq = 0;
+
+	wakeup.task = current;
+	timer_setup_on_stack(&wakeup.timer, prbtest_wakeup_callback, 0);
+	mod_timer(&wakeup.timer, jiffies + msecs_to_jiffies(timeout_ms));
+
+	prb_rec_init_rd(&r, &info, text_buf, sizeof(text_buf));
+
+	kunit_info(test_data->test, "start reader\n");
+
+	while (!wait_event_interruptible(test_data->new_record_wait,
+					 prb_read_valid(test_data->ringbuffer, seq, &r))) {
+		/* check/track the sequence */
+		if (info.seq < seq)
+			KUNIT_FAIL(test_data->test, "BAD SEQ READ: request=%llu read=%llu\n",
+				   seq, info.seq);
+
+		if (!prbtest_check_data((struct prbtest_rbdata *)r.text_buf))
+			prbtest_fail_record(test_data->test,
+					    (struct prbtest_rbdata *)r.text_buf, info.seq);
+
+		if ((count++ & 0x3fff) == 0)
+			cond_resched();
+
+		seq = info.seq + 1;
+	}
+
+	timer_delete_sync(&wakeup.timer);
+	timer_destroy_on_stack(&wakeup.timer);
+
+	kunit_info(test_data->test, "end reader: read=%lu seq=%llu\n", count, info.seq);
+
+	return 0;
+}
+
+KUNIT_DEFINE_ACTION_WRAPPER(prbtest_kthread_cleanup, kthread_stop, struct task_struct *);
+
+static void prbtest_add_kthread_cleanup(struct kunit *test, struct task_struct *kthread)
+{
+	int err;
+
+	err = kunit_add_action_or_reset(test, prbtest_kthread_cleanup, kthread);
+	KUNIT_ASSERT_EQ(test, err, 0);
+}
+
+static inline void prbtest_prb_reinit(struct printk_ringbuffer *rb)
+{
+	prb_init(rb, rb->text_data_ring.data, rb->text_data_ring.size_bits, rb->desc_ring.descs,
+		 rb->desc_ring.count_bits, rb->desc_ring.infos);
+}
+
+static void test_readerwriter(struct kunit *test)
+{
+	/* Equivalent to CONFIG_LOG_BUF_SHIFT=13 */
+	DEFINE_PRINTKRB(test_rb, 8, 5);
+
+	struct prbtest_thread_data *thread_data;
+	struct prbtest_data *test_data;
+	struct task_struct *thread;
+	cpumask_t test_cpus;
+	int cpu, reader_cpu;
+
+	cpus_read_lock();
+	/*
+	 * Failure of KUNIT_ASSERT() kills the current task
+	 * so it can not be called while the CPU hotplug lock is held.
+	 * Instead use a snapshot of the online CPUs.
+	 * If they change during test execution it is unfortunate but not a grave error.
+	 */
+	cpumask_copy(&test_cpus, cpu_online_mask);
+	cpus_read_unlock();
+
+	/* One CPU is for the reader, all others are writers */
+	reader_cpu = cpumask_first(&test_cpus);
+	if (cpumask_weight(&test_cpus) == 1)
+		kunit_warn(test, "more than one CPU is recommended");
+	else
+		cpumask_clear_cpu(reader_cpu, &test_cpus);
+
+	/* KUnit test can get restarted more times. */
+	prbtest_prb_reinit(&test_rb);
+
+	test_data = kunit_kmalloc(test, sizeof(*test_data), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, test_data);
+	test_data->test = test;
+	test_data->ringbuffer = &test_rb;
+	init_waitqueue_head(&test_data->new_record_wait);
+
+	kunit_info(test, "running for %lu ms\n", runtime_ms);
+
+	for_each_cpu(cpu, &test_cpus) {
+		thread_data = kunit_kmalloc(test, sizeof(*thread_data), GFP_KERNEL);
+		KUNIT_ASSERT_NOT_NULL(test, thread_data);
+		thread_data->test_data = test_data;
+		thread_data->num = cpu;
+
+		thread = kthread_run_on_cpu(prbtest_writer, thread_data, cpu,
+					    "prbtest writer %u");
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, thread);
+		prbtest_add_kthread_cleanup(test, thread);
+	}
+
+	kunit_info(test, "starting test\n");
+
+	set_cpus_allowed_ptr(current, cpumask_of(reader_cpu));
+	prbtest_reader(test_data, runtime_ms);
+
+	kunit_info(test, "completed test\n");
+}
+
+static struct kunit_case prb_test_cases[] = {
+	KUNIT_CASE_SLOW(test_readerwriter),
+	{}
+};
+
+static struct kunit_suite prb_test_suite = {
+	.name       = "printk-ringbuffer",
+	.test_cases = prb_test_cases,
+};
+kunit_test_suite(prb_test_suite);
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+MODULE_AUTHOR("John Ogness <john.ogness@linutronix.de>");
+MODULE_DESCRIPTION("printk_ringbuffer KUnit test");
+MODULE_LICENSE("GPL");

---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20241011-printk-ringbuffer-test-f47f87c6a88b

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

