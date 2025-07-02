Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A1424A04A
	for <linux-hardening@vger.kernel.org>; Wed,  2 Jul 2025 09:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449965; cv=none; b=rNzGPQzjGFF0QFzwWBavyR2e1JhhcmCdsF2o/oSGPmGCozyL60+QBsrnGmqXKBfjVO+1vhQp+bEw/ml9Maew1w7AlF97Os3MRUGbcn5T0MD+vrvnB/BbO1PGKwfCwdKvEavXIn2pFAbaLbn05UIkHuTLohSWbFgzs3o99rgMz90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449965; c=relaxed/simple;
	bh=8+IocTVPHtIzyazJ31Vaiz/Kmsd8w4OreEIHZSP7zHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MhVT3GkTHDBSjZYztlBCs01BdvTpXTPueVF6Z/+0l+ToNf40ouOss/3RLLck2xA96qk8A1ORQeM8Ywv1CwAt2TW6U6uzSbwtYrFXILqSt3hAQXou+ElZmPCO0k7I2Asz3fVc/EzMzfHb9Lk+YNVoCiP1+LUCngQx2PIgbKKMsxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KOL3va1/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KOL3va1/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KOL3va1/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KOL3va1/"
Received: from pathway.suse.cz (unknown [10.100.208.146])
	by smtp-out2.suse.de (Postfix) with ESMTP id EAD231F452;
	Wed,  2 Jul 2025 09:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751449962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R141c4az1l0aIn6z2S1Ipsg0PRnB2HV2w1/AenNGjdo=;
	b=KOL3va1/WdWNzqJmXkS41CxVEtvMJasaahFoml2jZ/uInt4QuK7mHhtmA5/9rwsVCVaJs5
	Pq1RsXAPuwpNDoV/KkrEXcr6X64s+VTV0OecfW6pAA+OTZeTc3LHJLeGPhGSwmSqS575W0
	b4dCJbFbQKqUNPhg2wiXxANjLEfB7nQ=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751449962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R141c4az1l0aIn6z2S1Ipsg0PRnB2HV2w1/AenNGjdo=;
	b=KOL3va1/WdWNzqJmXkS41CxVEtvMJasaahFoml2jZ/uInt4QuK7mHhtmA5/9rwsVCVaJs5
	Pq1RsXAPuwpNDoV/KkrEXcr6X64s+VTV0OecfW6pAA+OTZeTc3LHJLeGPhGSwmSqS575W0
	b4dCJbFbQKqUNPhg2wiXxANjLEfB7nQ=
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
Subject: [PATCH 2/3] printk: kunit: support offstack cpumask
Date: Wed,  2 Jul 2025 11:51:56 +0200
Message-ID: <20250702095157.110916-3-pmladek@suse.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250702095157.110916-1-pmladek@suse.com>
References: <20250702095157.110916-1-pmladek@suse.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLpam4jm9phgcop7d53x6uygpb)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pathway.suse.cz:helo,suse.com:mid,suse.com:email]
X-Spam-Level: 

From: Arnd Bergmann <arnd@arndb.de>

For large values of CONFIG_NR_CPUS, the newly added kunit test fails
to build:

kernel/printk/printk_ringbuffer_kunit_test.c: In function 'test_readerwriter':
kernel/printk/printk_ringbuffer_kunit_test.c:279:1: error: the frame size of 1432 bytes is larger than 1280 bytes [-Werror=frame-larger-than=]

Change this to use cpumask_var_t and allocate it dynamically when
CONFIG_CPUMASK_OFFSTACK is set.

Fixes: 5ea2bcdfbf46 ("printk: ringbuffer: Add KUnit test")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[pmladek@suse.com: Correctly handle allocation failures and freeing using KUnit test API.]
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk_ringbuffer_kunit_test.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/kernel/printk/printk_ringbuffer_kunit_test.c b/kernel/printk/printk_ringbuffer_kunit_test.c
index 217dcc14670c..0c3030fde8c2 100644
--- a/kernel/printk/printk_ringbuffer_kunit_test.c
+++ b/kernel/printk/printk_ringbuffer_kunit_test.c
@@ -216,6 +216,7 @@ static int prbtest_reader(struct prbtest_data *test_data, unsigned long timeout_
 	return 0;
 }
 
+KUNIT_DEFINE_ACTION_WRAPPER(prbtest_cpumask_cleanup, free_cpumask_var, cpumask_var_t);
 KUNIT_DEFINE_ACTION_WRAPPER(prbtest_kthread_cleanup, kthread_stop, struct task_struct *);
 
 static void prbtest_add_kthread_cleanup(struct kunit *test, struct task_struct *kthread)
@@ -240,8 +241,13 @@ static void test_readerwriter(struct kunit *test)
 	struct prbtest_thread_data *thread_data;
 	struct prbtest_data *test_data;
 	struct task_struct *thread;
-	cpumask_t test_cpus;
+	cpumask_var_t test_cpus;
 	int cpu, reader_cpu;
+	int err;
+
+	KUNIT_ASSERT_TRUE(test, alloc_cpumask_var(&test_cpus, GFP_KERNEL));
+	err = kunit_add_action_or_reset(test, prbtest_cpumask_cleanup, test_cpus);
+	KUNIT_ASSERT_EQ(test, err, 0);
 
 	cpus_read_lock();
 	/*
@@ -250,15 +256,15 @@ static void test_readerwriter(struct kunit *test)
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
@@ -271,7 +277,7 @@ static void test_readerwriter(struct kunit *test)
 
 	kunit_info(test, "running for %lu ms\n", runtime_ms);
 
-	for_each_cpu(cpu, &test_cpus) {
+	for_each_cpu(cpu, test_cpus) {
 		thread_data = kunit_kmalloc(test, sizeof(*thread_data), GFP_KERNEL);
 		KUNIT_ASSERT_NOT_NULL(test, thread_data);
 		thread_data->test_data = test_data;
-- 
2.50.0

