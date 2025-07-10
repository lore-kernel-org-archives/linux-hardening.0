Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0435C279DD1
	for <linux-hardening@vger.kernel.org>; Thu, 10 Jul 2025 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752162713; cv=none; b=I8HZ0/P+TiHKOcwLTmZCFqERB3x34pESEhm1YM8IJRSdKStBeoxQaJRs9Qm8Y3HHNL/Rka4XeqUIPhMxVSrGSCdIU2/JqeZcAz8HqNexrrts/YAQauzSyD9EO433ORfiKQF46+2wYPld99fOOgOEEGSoBq0pyJSHdNLOcwjihaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752162713; c=relaxed/simple;
	bh=M5c/DVPyptimOMWsQdRfTvxguAEvwygB3GtTJ5ww7VM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fUlwiN+Uzr4qXwVUx+gAyqhtcyo43a3zT7j7LLY0W1A7ewISVhoWgsJU1w/acQ/SjypiDbCV8sZobgJRtdLDAdVu4PHwdEs06P+V6UwLWsdzM5GcQ/5OtofYUnxa7muT5lqwOIVr96IpZfZAM50PJI5QyfNaCCyJgqYYIhHqw+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=W7OTp1N4; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EXSIPtDm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="W7OTp1N4";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EXSIPtDm"
Received: from pathway.suse.cz (unknown [10.100.208.146])
	by smtp-out2.suse.de (Postfix) with ESMTP id 5AF611F385;
	Thu, 10 Jul 2025 15:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752162709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bRpP64lfCHl+pWXPEbU1eZjjyjKvJfF6f19bhBwfZK4=;
	b=W7OTp1N4XwpA9TvwubURN/MJtBSEnEN1qrMH9uBD+ZPGR8tM3wcyAWSrcDu13HJhHrgDVe
	FDQ8j1bAASu5zHflTQthIXE9gp0YaVCuRMKDa7AlOrhDgez0P7cibKl5iss8oujUxo7lcq
	7e41DW9RlinOLsazJ7/3+FgnhOLsXG8=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752162708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bRpP64lfCHl+pWXPEbU1eZjjyjKvJfF6f19bhBwfZK4=;
	b=EXSIPtDmZGJw2zZXLUg28GRauLFob10KTkoZL5iXEYQXX8YdizTEKPr37HwAxJyM9uhzDW
	7LZ+TQFkxvdkR9fpwhxsNmZGm06vIuaba8VRBTE1n3QAI+d0hGsUXWwM4XMUHtOdiswyF7
	c8oWkeL7RemsT2qvgprwLr738Yervps=
From: Petr Mladek <pmladek@suse.com>
To: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	David Gow <davidgow@google.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v3] printk: kunit: support offstack cpumask
Date: Thu, 10 Jul 2025 17:51:39 +0200
Message-ID: <20250710155139.322955-1-pmladek@suse.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.967];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email,suse.com:email,suse.com:mid,linutronix.de:email,pathway.suse.cz:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.29

From: Arnd Bergmann <arnd@arndb.de>

For large values of CONFIG_NR_CPUS, the newly added kunit test fails
to build:

kernel/printk/printk_ringbuffer_kunit_test.c: In function 'test_readerwriter':
kernel/printk/printk_ringbuffer_kunit_test.c:279:1: error: the frame size of 1432 bytes is larger than 1280 bytes [-Werror=frame-larger-than=]

Change this to use cpumask_var_t and allocate it dynamically when
CONFIG_CPUMASK_OFFSTACK is set.

alloc_cpumask_var() and free_cpumask_var() are not called when
CONFIG_CPUMASK_OFFSTACK is not set. It would require an explicit cast
in the clean up action, leaking the stack address to the kthread doing
the clean up, or another workaround. And both function do nothing
do nothing in this case, anyway. It looks likes the least evil solution.

Fixes: 5ea2bcdfbf46 ("printk: ringbuffer: Add KUnit test")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[pmladek@suse.com: Correctly handle allocation failures and freeing using KUnit test API.]
Reviewed-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
This is actually 3rd version of the patch.

Changes against [v2]:

  + Fix compilation without CONFIG_CPUMASK_OFFSTACK

Changes against [v1]

  + Use KUnit API for handling allocation failure and freeing.

[v2] https://lore.kernel.org/r/20250702095157.110916-3-pmladek@suse.com
[v1] https://lore.kernel.org/r/20250620192554.2234184-1-arnd@kernel.org

The patch applies on the top of printk/linux.git,
branch rework/ringbuffer-kunit-test.

 kernel/printk/printk_ringbuffer_kunit_test.c | 35 ++++++++++++++++----
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/kernel/printk/printk_ringbuffer_kunit_test.c b/kernel/printk/printk_ringbuffer_kunit_test.c
index e67e1815f4c8..21000d7d7a32 100644
--- a/kernel/printk/printk_ringbuffer_kunit_test.c
+++ b/kernel/printk/printk_ringbuffer_kunit_test.c
@@ -223,6 +223,27 @@ static int prbtest_reader(struct prbtest_data *test_data, unsigned long timeout_
 	return 0;
 }
 
+/*
+ * A cast would be needed for the clean up action when the cpumask was on stack.
+ * Also it would leak the stack address to the cleanup thread.
+ * And alloc_cpu_mask() and free_cpumask_var() would do nothing anyway.
+ */
+#ifdef CONFIG_CPUMASK_OFFSTACK
+KUNIT_DEFINE_ACTION_WRAPPER(prbtest_cpumask_cleanup, free_cpumask_var, cpumask_var_t);
+
+static void prbtest_alloc_cpumask(struct kunit *test, cpumask_var_t *mask)
+{
+	int err;
+
+	KUNIT_ASSERT_TRUE(test, alloc_cpumask_var(mask, GFP_KERNEL));
+	err = kunit_add_action_or_reset(test, prbtest_cpumask_cleanup, *mask);
+	KUNIT_ASSERT_EQ(test, err, 0);
+}
+#else
+static inline
+void prbtest_alloc_cpumask(struct kunit *test, cpumask_var_t *mask) {}
+#endif
+
 KUNIT_DEFINE_ACTION_WRAPPER(prbtest_kthread_cleanup, kthread_stop, struct task_struct *);
 
 static void prbtest_add_kthread_cleanup(struct kunit *test, struct task_struct *kthread)
@@ -247,9 +268,11 @@ static void test_readerwriter(struct kunit *test)
 	struct prbtest_thread_data *thread_data;
 	struct prbtest_data *test_data;
 	struct task_struct *thread;
-	cpumask_t test_cpus;
+	cpumask_var_t test_cpus;
 	int cpu, reader_cpu;
 
+	prbtest_alloc_cpumask(test, &test_cpus);
+
 	cpus_read_lock();
 	/*
 	 * Failure of KUNIT_ASSERT() kills the current task
@@ -257,15 +280,15 @@ static void test_readerwriter(struct kunit *test)
 	 * Instead use a snapshot of the online CPUs.
 	 * If they change during test execution it is unfortunate but not a grave error.
 	 */
-	cpumask_copy(&test_cpus, cpu_online_mask);
+	cpumask_copy(test_cpus, cpu_online_mask);
 	cpus_read_unlock();
 
 	/* One CPU is for the reader, all others are writers */
-	reader_cpu = cpumask_first(&test_cpus);
-	if (cpumask_weight(&test_cpus) == 1)
+	reader_cpu = cpumask_first(test_cpus);
+	if (cpumask_weight(test_cpus) == 1)
 		kunit_warn(test, "more than one CPU is recommended");
 	else
-		cpumask_clear_cpu(reader_cpu, &test_cpus);
+		cpumask_clear_cpu(reader_cpu, test_cpus);
 
 	/* KUnit test can get restarted more times. */
 	prbtest_prb_reinit(&test_rb);
@@ -278,7 +301,7 @@ static void test_readerwriter(struct kunit *test)
 
 	kunit_info(test, "running for %lu ms\n", runtime_ms);
 
-	for_each_cpu(cpu, &test_cpus) {
+	for_each_cpu(cpu, test_cpus) {
 		thread_data = kunit_kmalloc(test, sizeof(*thread_data), GFP_KERNEL);
 		KUNIT_ASSERT_NOT_NULL(test, thread_data);
 		thread_data->test_data = test_data;
-- 
2.50.0

