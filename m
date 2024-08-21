Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1F417A5B2
	for <linux-hardening@vger.kernel.org>; Wed, 21 Aug 2024 21:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724277287; cv=none; b=SZ5kfGktLfInbwaQ0IZSLemTj8n0J3NaPnZ7RFnpNqJrnwd2DBpltAGzZ+IeowH15mxIBaOgjvr4+VAMyshk0s75T1Vmrnt/agYkmCvGcNu2H2yAbrz9n+BmxXy6LJMNS8uUGaRzYa60IxOL/W3f1V/m+HLh5Npq0+EOk1unygo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724277287; c=relaxed/simple;
	bh=lpYobYV+EPvplIsVlp9K0sXPmPwbCczja66tND3rD8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hsJV53HgUIG6RFKHAcdcRJNVrlf4PTWExyn1gFlurF/Wflm8L+3XZuE+IIqt9nFJFACDhjXWrIMTqjcUduYWEbhhyZB1PtJzmKuDSHn1gctRpBiUFnRhFs06yt6vT0Bil5Lbh+aLA/ejgTjFiXDMqhdmagSxowcAjNXU3NXKBQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FEP//O5G; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FEP//O5G"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-39d37218c5cso602005ab.1
        for <linux-hardening@vger.kernel.org>; Wed, 21 Aug 2024 14:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724277283; x=1724882083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAXSIdsJdlH1zAZMMu2gmF5Q96+XpHdPAtLFei8FT9Y=;
        b=FEP//O5GVn86Lr+SEnwK2MSr4z6b1GQJEwEFk7BJbvYcT/lUoeEUKOGZ6EyRb/ILe4
         rQJ7+T0RnVzVFG/RtSoZ2Z17Z63eFqEQDJAtMrkvBmMM3g8cd7+kOAneMyFm8UzeE0MO
         ta/vWWJw3TOY02z8Ned4CGYrNXB9kv+P5vsWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724277283; x=1724882083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZAXSIdsJdlH1zAZMMu2gmF5Q96+XpHdPAtLFei8FT9Y=;
        b=MWSriotvTUM1iBXBDqAwoD+F9UxL3iuzvFoiEwUhd/eIiEZ8vYxxZk+G0cLTh7xgBe
         euckIDKI7kXu0dECNS6h1A9Ete60p8YYvEkEP7pOWqfA93gN0DNm3z1+XVIbYnVNXi1E
         CBLticTHrY5J4+oOKq8tn9GzjtZ4l7lbl9lIx18jwsYaQvR4kBDJDSS17oljM1LtR6YB
         9r1Hdm7ieQr+0IczpFICI/qigTGCa5zlok29MGvQNg1HbAZMt0sEevuEEiGMbI1IEIV2
         1azsOwM4H9Vzr8s6pQO3fDAl8md0Dwo0ZvViadx6JpW3FAoP8iRiaIYaz3TsLQp2Q83t
         39Hw==
X-Forwarded-Encrypted: i=1; AJvYcCULsb7PR3wM1RX2dS/JnRL1vUtG2bEH45M0CP200+97vvS1JAOM9e0RsTVLXbS1zR/92NcoEVMRuqKKFLoFP8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGhcFJ76GNmjSw4RVPuo1zppdNqQS1T3D8wt8HJxHfRnkxuzZb
	plaEFLlLGXjBBblkASiRBvKCAf117gv31zb57DzERGoxQ6qO3Z1+emTXrtZU5A==
X-Google-Smtp-Source: AGHT+IHF/j+RTuHRPNqCRr8JPtO+qBGbzT3vZqCcAHdQyxkKKPjZZmAL3RN5hxTXaOMAHqrO4MiMeA==
X-Received: by 2002:a05:6e02:1e01:b0:375:e93b:7c8c with SMTP id e9e14a558f8ab-39d74b6f7a7mr637375ab.12.1724277283008;
        Wed, 21 Aug 2024 14:54:43 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:8b27:65e9:2bb6:ed40])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ad7d076sm92066a12.88.2024.08.21.14.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:54:42 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Yu Zhao <yuzhao@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Misono Tomohiro <misono.tomohiro@fujitsu.com>,
	Marc Zyngier <maz@kernel.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Stephen Boyd <swboyd@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	James Morse <james.morse@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Kees Cook <kees@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] arm64: smp: smp_send_stop() and crash_smp_send_stop() should try non-NMI first
Date: Wed, 21 Aug 2024 14:53:57 -0700
Message-ID: <20240821145353.v3.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When testing hard lockup handling on my sc7180-trogdor-lazor device
with pseudo-NMI enabled, with serial console enabled and with kgdb
disabled, I found that the stack crawls printed to the serial console
ended up as a jumbled mess. After rebooting, the pstore-based console
looked fine though. Also, enabling kgdb to trap the panic made the
console look fine and avoided the mess.

After a bit of tracking down, I came to the conclusion that this was
what was happening:
1. The panic path was stopping all other CPUs with
   panic_other_cpus_shutdown().
2. At least one of those other CPUs was in the middle of printing to
   the serial console and holding the console port's lock, which is
   grabbed with "irqsave". ...but since we were stopping with an NMI
   we didn't care about the "irqsave" and interrupted anyway.
3. Since we stopped the CPU while it was holding the lock it would
   never release it.
4. All future calls to output to the console would end up failing to
   get the lock in qcom_geni_serial_console_write(). This isn't
   _totally_ unexpected at panic time but it's a code path that's not
   well tested, hard to get right, and apparently doesn't work
   terribly well on the Qualcomm geni serial driver.

The Qualcomm geni serial driver was fixed to be a bit better in commit
9e957a155005 ("serial: qcom-geni: Don't cancel/abort if we can't get
the port lock") but it's nice not to get into this situation in the
first place.

Taking a page from what x86 appears to do in native_stop_other_cpus(),
do this:
1. First, try to stop other CPUs with a normal IPI and wait a second.
   This gives them a chance to leave critical sections.
2. If CPUs fail to stop then retry with an NMI, but give a much lower
   timeout since there's no good reason for a CPU not to react quickly
   to a NMI.

This works well and avoids the corrupted console and (presumably)
could help avoid other similar issues.

In order to do this, we need to do a little re-organization of our
IPIs since we don't have any more free IDs. Do what was suggested in
previous conversations and combine "stop" and "crash stop". That frees
up an IPI so now we can have a "stop" and "stop NMI".

In order to do this we also need a slight change in the way we keep
track of which CPUs still need to be stopped. We need to know
specifically which CPUs haven't stopped yet when we fall back to NMI
but in the "crash stop" case the "cpu_online_mask" isn't updated as
CPUs go down. This is why that code path had an atomic of the number
of CPUs left. Solve this by also updating the "cpu_online_mask" for
crash stops.

All of the above lets us combine the logic for "stop" and "crash stop"
code, which appeared to have a bunch of arbitrary implementation
differences.

Aside from the above change where we try a normal IPI and then an NMI,
the combined function has a few subtle differences:
* In the normal smp_send_stop(), if we fail to stop one or more CPUs
  then we won't include the current CPU (the one running
  smp_send_stop()) in the error message.
* In crash_smp_send_stop(), if we fail to stop some CPUs we'll print
  the CPUs that we failed to stop instead of printing all _but_ the
  current running CPU.
* In crash_smp_send_stop(), we will now only print "SMP: stopping
  secondary CPUs" if (system_state <= SYSTEM_RUNNING).

Fixes: d7402513c935 ("arm64: smp: IPI_CPU_STOP and IPI_CPU_CRASH_STOP should try for NMI")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I'm not setup to test the crash_smp_send_stop(). I made sure it
compiled and hacked the panic() method to call it, but I haven't
actually run kexec. Hopefully others can confirm that it's working for
them.

v1: https://lore.kernel.org/r/20231207170251.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid
v2: https://lore.kernel.org/r/20240625160718.v2.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid

Changes in v3:
- Add a comment summarizing the v2 discussion.
- Re-snapshot cpu_online_mask when CPUs still online.

Changes in v2:
- Update commit message to point to Qualcomm serial driver fix.
- Use a test-and-set to prevent stop code from running twice.
- Move mask clearing until after crash_save_cpu().
- Use local_daif_mask() in ipi_cpu_crash_stop().
- Don't use a new mask, just have crash case update online CPUs.

 arch/arm64/kernel/smp.c | 158 ++++++++++++++++++++++++----------------
 1 file changed, 95 insertions(+), 63 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index f01f0fd7b7fe..7bd28abb0acf 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -68,7 +68,7 @@ enum ipi_msg_type {
 	IPI_RESCHEDULE,
 	IPI_CALL_FUNC,
 	IPI_CPU_STOP,
-	IPI_CPU_CRASH_STOP,
+	IPI_CPU_STOP_NMI,
 	IPI_TIMER,
 	IPI_IRQ_WORK,
 	NR_IPI,
@@ -85,6 +85,8 @@ static int ipi_irq_base __ro_after_init;
 static int nr_ipi __ro_after_init = NR_IPI;
 static struct irq_desc *ipi_desc[MAX_IPI] __ro_after_init;
 
+static bool crash_stop;
+
 static void ipi_setup(int cpu);
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -823,7 +825,7 @@ static const char *ipi_types[MAX_IPI] __tracepoint_string = {
 	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
 	[IPI_CALL_FUNC]		= "Function call interrupts",
 	[IPI_CPU_STOP]		= "CPU stop interrupts",
-	[IPI_CPU_CRASH_STOP]	= "CPU stop (for crash dump) interrupts",
+	[IPI_CPU_STOP_NMI]	= "CPU stop NMIs",
 	[IPI_TIMER]		= "Timer broadcast interrupts",
 	[IPI_IRQ_WORK]		= "IRQ work interrupts",
 	[IPI_CPU_BACKTRACE]	= "CPU backtrace interrupts",
@@ -867,9 +869,9 @@ void arch_irq_work_raise(void)
 }
 #endif
 
-static void __noreturn local_cpu_stop(void)
+static void __noreturn local_cpu_stop(unsigned int cpu)
 {
-	set_cpu_online(smp_processor_id(), false);
+	set_cpu_online(cpu, false);
 
 	local_daif_mask();
 	sdei_mask_local_cpu();
@@ -883,21 +885,26 @@ static void __noreturn local_cpu_stop(void)
  */
 void __noreturn panic_smp_self_stop(void)
 {
-	local_cpu_stop();
+	local_cpu_stop(smp_processor_id());
 }
 
-#ifdef CONFIG_KEXEC_CORE
-static atomic_t waiting_for_crash_ipi = ATOMIC_INIT(0);
-#endif
-
 static void __noreturn ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
 {
 #ifdef CONFIG_KEXEC_CORE
+	/*
+	 * Use local_daif_mask() instead of local_irq_disable() to make sure
+	 * that pseudo-NMIs are disabled. The "crash stop" code starts with
+	 * an IRQ and falls back to NMI (which might be pseudo). If the IRQ
+	 * finally goes through right as we're timing out then the NMI could
+	 * interrupt us. It's better to prevent the NMI and let the IRQ
+	 * finish since the pt_regs will be better.
+	 */
+	local_daif_mask();
+
 	crash_save_cpu(regs, cpu);
 
-	atomic_dec(&waiting_for_crash_ipi);
+	set_cpu_online(cpu, false);
 
-	local_irq_disable();
 	sdei_mask_local_cpu();
 
 	if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
@@ -962,14 +969,12 @@ static void do_handle_IPI(int ipinr)
 		break;
 
 	case IPI_CPU_STOP:
-		local_cpu_stop();
-		break;
-
-	case IPI_CPU_CRASH_STOP:
-		if (IS_ENABLED(CONFIG_KEXEC_CORE)) {
+	case IPI_CPU_STOP_NMI:
+		if (IS_ENABLED(CONFIG_KEXEC_CORE) && crash_stop) {
 			ipi_cpu_crash_stop(cpu, get_irq_regs());
-
 			unreachable();
+		} else {
+			local_cpu_stop(cpu);
 		}
 		break;
 
@@ -1024,8 +1029,7 @@ static bool ipi_should_be_nmi(enum ipi_msg_type ipi)
 		return false;
 
 	switch (ipi) {
-	case IPI_CPU_STOP:
-	case IPI_CPU_CRASH_STOP:
+	case IPI_CPU_STOP_NMI:
 	case IPI_CPU_BACKTRACE:
 	case IPI_KGDB_ROUNDUP:
 		return true;
@@ -1138,79 +1142,107 @@ static inline unsigned int num_other_online_cpus(void)
 
 void smp_send_stop(void)
 {
+	static unsigned long stop_in_progress;
+	cpumask_t mask;
 	unsigned long timeout;
 
-	if (num_other_online_cpus()) {
-		cpumask_t mask;
+	/*
+	 * If this cpu is the only one alive at this point in time, online or
+	 * not, there are no stop messages to be sent around, so just back out.
+	 */
+	if (num_other_online_cpus() == 0)
+		goto skip_ipi;
 
-		cpumask_copy(&mask, cpu_online_mask);
-		cpumask_clear_cpu(smp_processor_id(), &mask);
+	/* Only proceed if this is the first CPU to reach this code */
+	if (test_and_set_bit(0, &stop_in_progress))
+		return;
 
-		if (system_state <= SYSTEM_RUNNING)
-			pr_crit("SMP: stopping secondary CPUs\n");
-		smp_cross_call(&mask, IPI_CPU_STOP);
-	}
+	/*
+	 * Send an IPI to all currently online CPUs except the CPU running
+	 * this code.
+	 *
+	 * NOTE: we don't do anything here to prevent other CPUs from coming
+	 * online after we snapshot `cpu_online_mask`. Ideally, the calling code
+	 * should do something to prevent other CPUs from coming up. This code
+	 * can be called in the panic path and thus it doesn't seem wise to
+	 * grab the CPU hotplug mutex ourselves. Worst case:
+	 * - If a CPU comes online as we're running, we'll likely notice it
+	 *   during the 1 second wait below and then we'll catch it when we try
+	 *   with an NMI (assuming NMIs are enabled) since we re-snapshot the
+	 *   mask before sending an NMI.
+	 * - If we leave the function and see that CPUs are still online we'll
+	 *   at least print a warning. Especially without NMIs this function
+	 *   isn't foolproof anyway so calling code will just have to accept
+	 *   the fact that there could be cases where a CPU can't be stopped.
+	 */
+	cpumask_copy(&mask, cpu_online_mask);
+	cpumask_clear_cpu(smp_processor_id(), &mask);
 
-	/* Wait up to one second for other CPUs to stop */
+	if (system_state <= SYSTEM_RUNNING)
+		pr_crit("SMP: stopping secondary CPUs\n");
+
+	/*
+	 * Start with a normal IPI and wait up to one second for other CPUs to
+	 * stop. We do this first because it gives other processors a chance
+	 * to exit critical sections / drop locks and makes the rest of the
+	 * stop process (especially console flush) more robust.
+	 */
+	smp_cross_call(&mask, IPI_CPU_STOP);
 	timeout = USEC_PER_SEC;
 	while (num_other_online_cpus() && timeout--)
 		udelay(1);
 
-	if (num_other_online_cpus())
+	/*
+	 * If CPUs are still online, try an NMI. There's no excuse for this to
+	 * be slow, so we only give them an extra 10 ms to respond.
+	 */
+	if (num_other_online_cpus() && ipi_should_be_nmi(IPI_CPU_STOP_NMI)) {
+		cpumask_copy(&mask, cpu_online_mask);
+		cpumask_clear_cpu(smp_processor_id(), &mask);
+
+		pr_info("SMP: retry stop with NMI for CPUs %*pbl\n",
+			cpumask_pr_args(&mask));
+
+		smp_cross_call(&mask, IPI_CPU_STOP_NMI);
+		timeout = USEC_PER_MSEC * 10;
+		while (num_other_online_cpus() && timeout--)
+			udelay(1);
+	}
+
+	if (num_other_online_cpus()) {
+		cpumask_copy(&mask, cpu_online_mask);
+		cpumask_clear_cpu(smp_processor_id(), &mask);
+
 		pr_warn("SMP: failed to stop secondary CPUs %*pbl\n",
-			cpumask_pr_args(cpu_online_mask));
+			cpumask_pr_args(&mask));
+	}
 
+skip_ipi:
 	sdei_mask_local_cpu();
 }
 
 #ifdef CONFIG_KEXEC_CORE
 void crash_smp_send_stop(void)
 {
-	static int cpus_stopped;
-	cpumask_t mask;
-	unsigned long timeout;
-
 	/*
 	 * This function can be called twice in panic path, but obviously
 	 * we execute this only once.
+	 *
+	 * We use this same boolean to tell whether the IPI we send was a
+	 * stop or a "crash stop".
 	 */
-	if (cpus_stopped)
+	if (crash_stop)
 		return;
+	crash_stop = 1;
 
-	cpus_stopped = 1;
+	smp_send_stop();
 
-	/*
-	 * If this cpu is the only one alive at this point in time, online or
-	 * not, there are no stop messages to be sent around, so just back out.
-	 */
-	if (num_other_online_cpus() == 0)
-		goto skip_ipi;
-
-	cpumask_copy(&mask, cpu_online_mask);
-	cpumask_clear_cpu(smp_processor_id(), &mask);
-
-	atomic_set(&waiting_for_crash_ipi, num_other_online_cpus());
-
-	pr_crit("SMP: stopping secondary CPUs\n");
-	smp_cross_call(&mask, IPI_CPU_CRASH_STOP);
-
-	/* Wait up to one second for other CPUs to stop */
-	timeout = USEC_PER_SEC;
-	while ((atomic_read(&waiting_for_crash_ipi) > 0) && timeout--)
-		udelay(1);
-
-	if (atomic_read(&waiting_for_crash_ipi) > 0)
-		pr_warn("SMP: failed to stop secondary CPUs %*pbl\n",
-			cpumask_pr_args(&mask));
-
-skip_ipi:
-	sdei_mask_local_cpu();
 	sdei_handler_abort();
 }
 
 bool smp_crash_stop_failed(void)
 {
-	return (atomic_read(&waiting_for_crash_ipi) > 0);
+	return num_other_online_cpus() != 0;
 }
 #endif
 
-- 
2.46.0.184.g6999bdac58-goog

