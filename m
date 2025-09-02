Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AA42DAFCA
	for <linux-hardening@vger.kernel.org>; Tue,  2 Sep 2025 14:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756821822; cv=none; b=iTZUQN+DME5hUg5y32ZjYPL0J8qAzL3Q0LRLf+HrsXO1bp/hrD9k3G2NXQTf59WDkCL1lk/5Y3KEmVxjd5MtLe1EFn06FHox/cs0EAlopxkRcdVjUX84kFXe2PNNlz/9EkFqwOQ1VWQW7gp3MUWeoo/3rEHiyJ7j7J6umogSIhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756821822; c=relaxed/simple;
	bh=S0kmrdVS0K2Abz4W9Kj/zMcV05L3rj3/6CRG4UjjXlU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LqjiS0ehbDUHzmZmMUyzm5w68s13S/v2CXBqhLN2fBXDQn1+BFY0d3xy/i7nViOggV3aNIqUaza4LT1Ogn5wK7CAtAQriIeUv9QxJQpG1cXnotypTnvh/Eq5jwHez8cLUh1dYPlLq5axHIj1OlG+x/AP8uhDtIWR+sOxsnT44w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OLu78ZH6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=d1sETiW2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OLu78ZH6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="d1sETiW2"
Received: from pathway.suse.cz (unknown [IPv6:2a07:de40:b2bf:1b::12bd])
	by smtp-out2.suse.de (Postfix) with ESMTP id C850B1F38E;
	Tue,  2 Sep 2025 14:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756821819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FGE3n9gHMNWRbYGx9xfea52LLP6GPSA5dEO2fMhySTk=;
	b=OLu78ZH6h6v7JXx9iLoa+InAb/Funj1lAMK54qKynZrBUYdz4OdLpNiM12plHbzuaIVHTa
	ZEUsCD4HRz4s3ZVsdIewMM9FdhPOXvofrT9G+C1JbEuDbt0+Ob98TANvqXYDYDSoyK5ckV
	fCNSPO4i6eYFIZm5q7EXjuGZvoI47gc=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=d1sETiW2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756821817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FGE3n9gHMNWRbYGx9xfea52LLP6GPSA5dEO2fMhySTk=;
	b=d1sETiW2tCyE7LPpr085ovvyMIWOABCgJ9ciI/Gi1Zbh0nAJ2HvKGTuqT5L5QeQZCVIZO/
	N05AEsJwbeO0yYEdEDt5v+EHOnGRY5tb7VpWYKh5CP8jg0qITL032oLyICHEV+YUPKKRt9
	4Ebh+87mwHgOL5Z8G6+Ondlgf1x8DoE=
From: Petr Mladek <pmladek@suse.com>
To: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	David Gow <davidgow@google.com>,
	Arnd Bergmann <arnd@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v3] printk: kunit: support offstack cpumask
Date: Tue,  2 Sep 2025 16:03:26 +0200
Message-ID: <20250902140326.344214-1-pmladek@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: add header
X-Spam-Flag: YES
X-Spam-Level: ****************
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [16.68 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_SPAM_SHORT(2.99)[0.997];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	MID_CONTAINS_FROM(1.00)[];
	HFILTER_HELO_IP_A(1.00)[pathway.suse.cz];
	R_MISSING_CHARSET(0.50)[];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[pathway.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DIRECT_TO_MX(0.00)[git-send-email 2.50.1];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b2bf:1b::12bd:from];
	GREYLIST(0.00)[pass,body];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,pathway.suse.cz:helo,arndb.de:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[]
X-Spamd-Bar: ++++++++++++++++
X-Rspamd-Queue-Id: C850B1F38E
X-Spam-Score: 16.68
X-Spam: Yes

From: Arnd Bergmann <arnd@arndb.de>

For large values of CONFIG_NR_CPUS, the newly added kunit test fails
to build:

kernel/printk/printk_ringbuffer_kunit_test.c: In function 'test_readerwriter':
kernel/printk/printk_ringbuffer_kunit_test.c:279:1: error: the frame size of 1432 bytes is larger than 1280 bytes [-Werror=frame-larger-than=]

Change this to use cpumask_var_t and allocate it dynamically when
CONFIG_CPUMASK_OFFSTACK is set.

The variable has to be released via a KUnit action wrapper so that it is
freed when the test fails and gets aborted. The parameter type is hardcoded
to "struct cpumask *" because the macro KUNIT_DEFINE_ACTION_WRAPPER()
does not accept an array. But the function does nothing when
CONFIG_CPUMASK_OFFSTACK is not set anyway.

Fixes: 5ea2bcdfbf46 ("printk: ringbuffer: Add KUnit test")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[pmladek@suse.com: Correctly handle allocation failures and freeing using KUnit test API.]
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
This patch applies on top of "rework/ringbuffer-kunit-test" branch
in printk/linux.git.

Changes against v2 [2]:

  - Hardcode the pointer type to "struct cpumask *" when defining
    prbtest_cpumask_cleanup() action to avoid warning
    when CONFIG_CPUMASK_OFFSTACK is not set.

Changes against v1 [1]:

   - Abort the test when the cpumask allocation fails.
   - Free the cpumask when the tests exits.

[1] https://lore.kernel.org/all/20250620192554.2234184-1-arnd@kernel.org
[2] https://lore.kernel.org/all/20250702095157.110916-3-pmladek@suse.com

 kernel/printk/printk_ringbuffer_kunit_test.c | 24 +++++++++++++++-----
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/kernel/printk/printk_ringbuffer_kunit_test.c b/kernel/printk/printk_ringbuffer_kunit_test.c
index e67e1815f4c8..2282348e869a 100644
--- a/kernel/printk/printk_ringbuffer_kunit_test.c
+++ b/kernel/printk/printk_ringbuffer_kunit_test.c
@@ -223,8 +223,17 @@ static int prbtest_reader(struct prbtest_data *test_data, unsigned long timeout_
 	return 0;
 }
 
+KUNIT_DEFINE_ACTION_WRAPPER(prbtest_cpumask_cleanup, free_cpumask_var, struct cpumask *);
 KUNIT_DEFINE_ACTION_WRAPPER(prbtest_kthread_cleanup, kthread_stop, struct task_struct *);
 
+static void prbtest_add_cpumask_cleanup(struct kunit *test, cpumask_var_t mask)
+{
+	int err;
+
+	err = kunit_add_action_or_reset(test, prbtest_cpumask_cleanup, mask);
+	KUNIT_ASSERT_EQ(test, err, 0);
+}
+
 static void prbtest_add_kthread_cleanup(struct kunit *test, struct task_struct *kthread)
 {
 	int err;
@@ -247,9 +256,12 @@ static void test_readerwriter(struct kunit *test)
 	struct prbtest_thread_data *thread_data;
 	struct prbtest_data *test_data;
 	struct task_struct *thread;
-	cpumask_t test_cpus;
+	cpumask_var_t test_cpus;
 	int cpu, reader_cpu;
 
+	KUNIT_ASSERT_TRUE(test, alloc_cpumask_var(&test_cpus, GFP_KERNEL));
+	prbtest_add_cpumask_cleanup(test, test_cpus);
+
 	cpus_read_lock();
 	/*
 	 * Failure of KUNIT_ASSERT() kills the current task
@@ -257,15 +269,15 @@ static void test_readerwriter(struct kunit *test)
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
@@ -278,7 +290,7 @@ static void test_readerwriter(struct kunit *test)
 
 	kunit_info(test, "running for %lu ms\n", runtime_ms);
 
-	for_each_cpu(cpu, &test_cpus) {
+	for_each_cpu(cpu, test_cpus) {
 		thread_data = kunit_kmalloc(test, sizeof(*thread_data), GFP_KERNEL);
 		KUNIT_ASSERT_NOT_NULL(test, thread_data);
 		thread_data->test_data = test_data;
-- 
2.50.1

