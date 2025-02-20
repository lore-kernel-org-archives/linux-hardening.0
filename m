Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6951FCFF0;
	Thu, 20 Feb 2025 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067047; cv=none; b=sWP0nwxCQB7h1bSKZ5TWcHuFKIWT/Qfx697gAIAw6QEbOr1qTTGqt5BNCDRniXUNyDsOPXWcFqvj2D3uz11l/Bc5WSQxM9PMsXoS9iH2GTkWLpky/rQVwRymTorYtI1zRZUqcATB6e/2ouifPlvrCeLk1i2bMFYzySL7QzLTTpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067047; c=relaxed/simple;
	bh=CpYsGqHtn0E0TROwwhqeRxs7muVqX2BBmFbCFHP7OWU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bqAeblje7UryITfKv2lXZSyizE3w3L3akIxfUy2xxO+oiTmn1cJ/54JoohE/wt41kUWAKKd9uVqWby1Nu2VF64fl207K11qATc//zUBfEnX0uNPRf5A1x02P6YjntiNMUFqIiu1/NZO3M5v1M4BjZi3LfTJr2h6mwbX3092qVTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W/1NciUT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nz3TbVgT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W/1NciUT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nz3TbVgT"
Date: Thu, 20 Feb 2025 16:57:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740067043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=wH1m/nQDxdTsgKnO7n/1Ar9PnOVnrrN+8IoQkhMntlU=;
	b=W/1NciUTYXaN4rJT/RcXXdqXaE2/NbrS6DN+U65v2eGth4omfm69LHroohFFPoU6zZIzSK
	7kG04jX9kS4A783W3FAl42T7dXRZ3rf7eUAjPqmIjcfWSUd3cd6DCCq2VIOz0343E1cw6u
	BRaJBhXpzOX2nWrNsCSZTxQypgGnrv8+eWlC5ZxlCI7y/UzHhrzqkkrfnL+RXfz4F0PrbH
	4crMDoiDvWUmouT7ub/+1pkYpu9CHnP/C2pUHuOH5cR1Egvgf4itR01i9xNEzPCkbkR1Up
	wQPaGYNVqKqsqRTiA7DwPaXk8eTrMBJ2Dr7cetCPVtVq0sU25hMHUJMIqmBIlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740067043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=wH1m/nQDxdTsgKnO7n/1Ar9PnOVnrrN+8IoQkhMntlU=;
	b=Nz3TbVgTI5KJVYGEKreH2vy2/nKSBQIOl4iGxHHgvsAwUtvPXz1nee7SWr7PbT4YKxBdjc
	1/tS0Zwz//bUZuBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, Petr Pavlu <petr.pavlu@suse.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [linux-next:master] [x86]  66fbf67705:
 kernel-selftests.kvm.hardware_disable_test.fail
Message-ID: <20250220155722.2Z2a-3z0@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Z7bUC9QY815Cv6nb@xsang-OptiPlex-9020>

On 2025-02-20 15:04:43 [+0800], Oliver Sang wrote:
> hi, Sebastian,
Hi Oliver,

+ UBSAN & KASAN + STACK unwind people. The commit question is
    e9d25b42bde5a ("x86: Use RCU in all users of __module_address().")
  in -next.

> just FYI. we rebuild the kernel, and run the tests more times upon this c=
ommit
> and its parent, still see the issue persistent:
>=20
=E2=80=A6
>=20
> f985e39203090cc6 66fbf677051818b9b5339fa8bfe
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :20         105%          20:20    kernel-selftests.kvm.hardwa=
re_disable_test.fail
>          %stddev     %change         %stddev
>              \          |                \
>     580.92           +17.4%     682.06        kernel-selftests.time.elaps=
ed_time
>     580.92           +17.4%     682.06        kernel-selftests.time.elaps=
ed_time.max
>     550.23           +13.1%     622.20        kernel-selftests.time.syste=
m_time

this is +~100 secs?

> as above, the time spent is also longer, though it's not only for
> kvm.hardware_disable_test (the time is for whole kernel-selftests.kvm)
=E2=80=A6
> it seems to us that the commit really causes some slow down and it happen=
s to
> make kvm.hardware_disable_test timeout on the older machine for our origi=
nal

I made it slower, why is that so, let me look. On my HW
#1 patched (as of 66fbf677051818b9b5339fa8bfe)
| ~# time ./hardware_disable_test
| Random seed: 0x6b8b4567
|=20
| real    0m43.242s
| user    0m0.635s
| sys     0m18.292s

#2 use preempt_disable instead of rcu_read_lock() in unwind_orc.c (=3Drever=
t)
| ~# time ./hardware_disable_test
| Random seed: 0x6b8b4567
|=20
| real    0m30.212s
| user    0m0.448s
| sys     0m12.939s

#3 replace preempt_disable with __rcu_read_lock() [slim without debug]
| ~# time ./hardware_disable_test
| Random seed: 0x6b8b4567
|
| real    0m29.953s
| user    0m0.436s
| sys     0m12.789s

#4 replace preempt_disable with __rcu_read_lock() + lockdep [RCU watching
  test is missing]
| ~# time ./hardware_disable_test
| Random seed: 0x6b8b4567
|=20
| real    0m41.497s
| user    0m0.639s
| sys     0m17.112s

#5 Using rcu_read_lock() only if orc_module_find() is invoked.
Lost the output but it was more or less at #2 level meaning it does not
lookup modules to the point that it matters.

#6 CONFIG_UBSAN -CONFIG_KASAN +revert
| ~# time ./hardware_disable_test
| Random seed: 0x6b8b4567
|
| real    0m9.318s
| user    0m0.207s
| sys     0m3.395s

#7 -CONFIG_UBSAN -CONFIG_KASAN with RCU
| ~# time ./hardware_disable_test
| Random seed: 0x6b8b4567
|=20
| real    0m9.249s
| user    0m0.196s
| sys     0m3.332s

#8 -CONFIG_UBSAN -CONFIG_KASAN -LOCKDEP
| ~# time ./hardware_disable_test
| Random seed: 0x6b8b4567
| ^[[A
|=20
| real    0m4.416s
| user    0m0.120s
| sys     0m1.426s

#9 -CONFIG_UBSAN -CONFIG_KASAN -LOCKDEP +revert
| ~# time ./hardware_disable_test
| Random seed: 0x6b8b4567
|=20
| real    0m4.391s
| user    0m0.137s
| sys     0m1.415s


Now. Based on this:
The RCU read section increased the runtime (on my hardware) for the test
=66rom 30 to 43 seconds which is roughly 43%.
This is due to the lockdep annotation within rcu_read_lock() and
unlock() which is not existing in preempt_disable(). After disabling
UBSAN + KASAN  the lockdep annotation has no effect. My guess that
UBSAN/ KASAN is in charge of countless backtraces while enabled. Those
backtraces seem to be limited to the core kernel.

How much do we care here? Is this something that makes UBSAN + KASAN
folks uncomfortable? Or is lockdep slowing things down anyway?

If so, we could either move the RCU section down (as in #5) so it is not
used that often or go the other direction and move it up. I got this:
| ~# time ./hardware_disable_test
| Random seed: 0x6b8b4567
|=20
| real    0m32.618s
| user    0m0.537s
| sys     0m13.942s

which is almost the pre-level with the hunk below after figuring out
that most callers are from arch_stack_walk().=20

diff --git a/arch/x86/include/asm/unwind.h b/arch/x86/include/asm/unwind.h
index 7cede4dc21f0..f20e3613942f 100644
--- a/arch/x86/include/asm/unwind.h
+++ b/arch/x86/include/asm/unwind.h
@@ -42,6 +42,7 @@ struct unwind_state {
 void __unwind_start(struct unwind_state *state, struct task_struct *task,
 		    struct pt_regs *regs, unsigned long *first_frame);
 bool unwind_next_frame(struct unwind_state *state);
+bool unwind_next_frame_unlocked(struct unwind_state *state);
 unsigned long unwind_get_return_address(struct unwind_state *state);
 unsigned long *unwind_get_return_address_ptr(struct unwind_state *state);
=20
diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
index ee117fcf46ed..4df346b11f1e 100644
--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -21,8 +21,9 @@ void arch_stack_walk(stack_trace_consume_fn consume_entry=
, void *cookie,
 	if (regs && !consume_entry(cookie, regs->ip))
 		return;
=20
+	guard(rcu)();
 	for (unwind_start(&state, task, regs, NULL); !unwind_done(&state);
-	     unwind_next_frame(&state)) {
+	     unwind_next_frame_unlocked(&state)) {
 		addr =3D unwind_get_return_address(&state);
 		if (!addr || !consume_entry(cookie, addr))
 			break;
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 977ee75e047c..402779b3e90a 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -465,7 +465,7 @@ static bool get_reg(struct unwind_state *state, unsigne=
d int reg_off,
 	return false;
 }
=20
-bool unwind_next_frame(struct unwind_state *state)
+bool unwind_next_frame_unlocked(struct unwind_state *state)
 {
 	unsigned long ip_p, sp, tmp, orig_ip =3D state->ip, prev_sp =3D state->sp;
 	enum stack_type prev_type =3D state->stack_info.type;
@@ -475,9 +475,6 @@ bool unwind_next_frame(struct unwind_state *state)
 	if (unwind_done(state))
 		return false;
=20
-	/* Don't let modules unload while we're reading their ORC data. */
-	guard(rcu)();
-
 	/* End-of-stack check for user tasks: */
 	if (state->regs && user_mode(state->regs))
 		goto the_end;
@@ -678,6 +675,13 @@ bool unwind_next_frame(struct unwind_state *state)
 	state->stack_info.type =3D STACK_TYPE_UNKNOWN;
 	return false;
 }
+
+bool unwind_next_frame(struct unwind_state *state)
+{
+	/* Don't let modules unload while we're reading their ORC data. */
+	guard(rcu)();
+	return unwind_next_frame_unlocked(state);
+}
 EXPORT_SYMBOL_GPL(unwind_next_frame);
=20
 void __unwind_start(struct unwind_state *state, struct task_struct *task,

Sebastian
