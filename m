Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1996E19F127;
	Mon, 21 Apr 2025 21:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745270597; cv=none; b=vAd/jV0elb6uUzZ7CsuLWMbv9EnAJPmzW/NQ5EJyvWYPLzRWghxZg4sQhfZbXwhCXnjF4JuUvOA51LC+kWFQzu6T3VR70JOf4ulkuwvGIaf4lFvW6bsa9dHE/htcSrguSj5SWOMP4vtBAdS4wvlMy0BOoghUP9mGVPCZtA9TaWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745270597; c=relaxed/simple;
	bh=xJ91RYyjNW6ERKd3NB9/gYclSsaCipGeyFTmb3C83Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCJ3JqgfMbzc5LoqMqn2uho63YyWOSr6yZ/MMeIiEa+IJXkw2zJQJ3RbOcX+/LU4n8BCi9MEvy9SVJNpV+Ph3kO5XMyjvJWs4nQ9v++yHplSJ11cV//cnC1+quVWkK5ZJx8FEskmU7tm/fFyD0kXGhFohMVfsNUpLGUywwYazOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OChlXyXS; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OChlXyXS"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 61E4340E0173;
	Mon, 21 Apr 2025 21:23:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kxbgOAo3Tz2X; Mon, 21 Apr 2025 21:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1745270580; bh=3QegChI5VmQxyAbe7RGBdtzGP8b1Xp50OSRQDsR75Vs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OChlXyXS+nYdWunaV00LIgwgVb8U8MPJhVDf9UkoZ+cF7ZWd4v/T5xxJocZ93KUCe
	 /FFryUHXiyGUxV/rcKkLhvN5TOhBwGu+yFfYTZfPKP7ScC+fUxLUg2SZ6aZIJkdJ1P
	 T+P/EJHX1Q+FWQvoTmoczENMcc+j+pE0LJRiajmE3skNn+5LssvNiFqyJGgQiO6kUA
	 VXWXtSEBz1fNlSQAdBnuiLqVJLmTNRYj4xNiYldkQYEK5EFGlHvSmenghl2fBwQKSr
	 J0pvFzya1at0orsXSFs0dqing3uuAEqVSrhwmYVXCzgG5iRWUn3DvyHN7y/Ww9M0g1
	 OloaHjNh8JbjdPHLJZQ/4mX/u0IfbLbTtJdQgGJK9AsujRM630n+CbNdRt3IoXWWmI
	 IyzjAlvJxdVpPBLOYhd5kfwBWH63RVaHeTFId+vAXLo4eN1RpG9QRNmP4szpO6cfjT
	 arejvAm/G8qF8J4A40Fws6kDzdK/zAhCy1nldoNjUZHCqZJhw5LU80mIO0RH54GWfW
	 CdMs3TB8i++LlWsKU8H1vU1lj1xXMLQ6j2gJMKKWwsyJz7qSYwrht/4LtA130Atufb
	 VkFkE28/N/DAfnbNViNTeRFmOrL382hmPGRIkVA+6clC9v7vvYSVMtJS/aQsnOl64X
	 2NIXmb1/rR5hYCISMWE/WxnU=
Received: from rn.tnic (unknown [78.130.214.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id A6C6140E016E;
	Mon, 21 Apr 2025 21:22:41 +0000 (UTC)
Date: Mon, 21 Apr 2025 23:23:41 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, thomas.lendacky@amd.com, hpa@zytor.com,
	kees@kernel.org, michael.roth@amd.com, nikunj@amd.com,
	seanjc@google.com, ardb@kernel.org, gustavoars@kernel.org,
	sgarzare@redhat.com, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH] x86/sev: Fix SNP guest kdump hang/softlockup/panic
Message-ID: <20250421212341.GBaAa3XbwU138aY-__@renoirsky.local>
References: <20250421204453.318557-1-Ashish.Kalra@amd.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250421204453.318557-1-Ashish.Kalra@amd.com>

On Mon, Apr 21, 2025 at 08:44:53PM +0000, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> [  117.111097] watchdog: BUG: soft lockup - CPU#0 stuck for 27s! [cp:318]
> [  117.111115] Modules linked in:
> [  117.111120] irq event stamp: 3066414
> [  117.111122] hardirqs last  enabled at (3066413): [<ffffffffa04878d9>] irqentry_exit+0x39/0x90
> [  117.111142] hardirqs last disabled at (3066414): [<ffffffffa0485c15>] sysvec_apic_timer_interrupt+0x15/0xb0
> [  117.111146] softirqs last  enabled at (3066364): [<ffffffff9f245852>] __irq_exit_rcu+0xb2/0xe0
> [  117.111157] softirqs last disabled at (3066355): [<ffffffff9f245852>] __irq_exit_rcu+0xb2/0xe0
> [  117.111165] CPU: 0 UID: 0 PID: 318 Comm: cp Not tainted 6.14.0-next-20250328-snp-host-f2a41ff576cc-dirty #414 VOLUNTARY
> [  117.111171] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
> [  117.111176] RIP: 0010:rep_movs_alternative+0x5b/0x70
> [  117.111182] Code: 8b 06 48 89 07 48 83 c6 08 48 83 c7 08 83 e9 08 74 db 83 f9 08 73 e8 eb c5 eb 05 e9 2f 21 02 00 48 89 c8 48 c1 e9 03 83 e0 07 <f3> 48 a5 89 c1 85 c9 75 ab e9 17 21 02 00 48 8d 0c c8 eb a0 90 90
> [  117.111184] RSP: 0018:ffffc061c16c7b50 EFLAGS: 00040246
> [  117.111187] RAX: 0000000000000000 RBX: 0000000000001000 RCX: 0000000000000200
> [  117.111188] RDX: 0000000000018000 RSI: ffffc061c3f53000 RDI: 00007f27a86a5000
> [  117.111189] RBP: ffffc061c16c7be8 R08: 00007f27a86a6000 R09: 00000000ffffffff
> [  117.111190] R10: 0000000000000001 R11: 0000000000000001 R12: ffffc061c16c7d30
> [  117.111191] R13: ffffc061c3f53000 R14: 0000000000000000 R15: ffffc061c3f53000
> [  117.111193] FS:  00007f27a86ae800(0000) GS:ffff9d420cf0d000(0000) knlGS:0000000000000000
> [  117.111195] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  117.111196] CR2: 00007fd1278a3000 CR3: 0008000053e58000 CR4: 00000000003506f0
> [  117.111200] Call Trace:
> [  117.111204]  <TASK>
> [  117.111206]  ? _copy_to_iter+0xc1/0x720
> [  117.111216]  ? srso_return_thunk+0x5/0x5f
> [  117.111220]  ? _raw_spin_unlock+0x27/0x40
> [  117.111234]  ? srso_return_thunk+0x5/0x5f
> [  117.111236]  ? find_vmap_area+0xd6/0xf0
> [  117.111251]  ? srso_return_thunk+0x5/0x5f
> [  117.111253]  ? __check_object_size+0x18d/0x2e0
> [  117.111268]  __copy_oldmem_page.part.0+0x64/0xa0
> [  117.111281]  copy_oldmem_page_encrypted+0x1d/0x30
> [  117.111285]  read_from_oldmem.part.0+0xf4/0x200
> [  117.111306]  read_vmcore+0x206/0x3c0
> [  117.111309]  ? srso_return_thunk+0x5/0x5f
> [  117.111325]  proc_reg_read_iter+0x59/0x90
> [  117.111334]  vfs_read+0x26e/0x350
> [  117.111362]  ksys_read+0x73/0xf0
> [  117.111373]  __x64_sys_read+0x1d/0x30
> [  117.111377]  x64_sys_call+0x1b90/0x2150
> [  117.111386]  do_syscall_64+0x8b/0x140
> [  117.111454] RIP: 0033:0x7f27a7510031
> [  117.111462] Code: fe ff ff 48 8d 3d cf 9b 0a 00 48 83 ec 08 e8 56 4b 02 00 66 0f 1f 44 00 00 48 8d 05 b1 09 2e 00 8b 00 85 c0 75 13 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 57 f3 c3 0f 1f 44 00 00 41 54 55 49 89 d4 53
> [  117.111464] RSP: 002b:00007fff8f2d31c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [  117.111466] RAX: ffffffffffffffda RBX: 0000000000001000 RCX: 00007f27a7510031
> [  117.111467] RDX: 0000000000020000 RSI: 00007f27a868d000 RDI: 0000000000000003
> [  117.111468] RBP: 0000000000000000 R08: 0000000000006000 R09: 0000000000000000
> [  117.111469] R10: 0000000000001000 R11: 0000000000000246 R12: 0000000000000000
> [  117.111470] R13: 0000000000000000 R14: 00007f27a86ad000 R15: 0000000000000000
> [  117.111499]  </TASK>
> [  117.111502] Kernel panic - not syncing: softlockup: hung tasks
> [  117.164421] CPU: 0 UID: 0 PID: 318 Comm: cp Tainted: G             L      6.14.0-next-20250328-snp-host-f2a41ff576cc-dirty #414 VOLUNTARY
> [  117.166326] Tainted: [L]=SOFTLOCKUP
> [  117.166878] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
> [  117.168116] Call Trace:
> [  117.168514]  <IRQ>
> [  117.168862]  dump_stack_lvl+0x2b/0xf0
> [  117.169530]  dump_stack+0x14/0x20
> [  117.170068]  panic+0x3a8/0x410
> [  117.170592]  watchdog_timer_fn+0x293/0x300
> [  117.171229]  ? __pfx_watchdog_timer_fn+0x10/0x10
> [  117.171961]  __hrtimer_run_queues+0x1c7/0x3d0
> [  117.172603]  hrtimer_interrupt+0x126/0x290
> [  117.173261]  __sysvec_apic_timer_interrupt+0x72/0x1c0
> [  117.174118]  sysvec_apic_timer_interrupt+0x80/0xb0

Why is that untrimmed splat even here?

What is that supposed to say?

> Kdump while doing vmcore generation will be walking through all the
> guest pages and copying them to userspace, while walking through
> these guest pages it dumps/reads the guest VMSA pages which are
> marked in-use/busy (if the vCPU associated with that VMSA is
> running then that VMSA page is marked in-use/busy in the RMP table)
> and touching these in-use pages causes unrecoverable #NPF/RMP faults
> which causes the guest to hang/softlockup/panic.

This paragraph is one single sentence! I think you're the only one who
understands it.

> If kdump kernel is running on BSP, then BSP's VMSA itself cannot
> cause any issues, but other APs may be halted in guest, hence
> they are still in VMRUN state and their VMSAs are busy/in-use
> and touching those VMSAs will cause the #NPF.
> 
> The issue is that either the AP running the kdump kernel has a
> conflict with it's VMSA page and additionally other APs halted
> in guest mode have a conflict with their VMSA pages.
> 
> Note that even if kdump kernel is running with one vCPU, other APs
> can still be halted in guest mode and they are in VMRUN state and
> their VMSAs are busy and will cause #NPF when they are being
> dumped during kdump.
> 
> Therefore, issue AP_DESTROY GHCB calls on all APs (to ensure they
> are kicked out of guest mode) and then the VMSA bit is cleared on
> their VMSA page. Additionally if the vCPU running kdump is an AP,
> then it's VMSA bit can't be cleared (and that AP can't be shutdown
> or destroyed as it is running kdump) so it's VMSA page is made offline
> to ensure that makedumpfile excludes that page while dumping guest
> memory. If the vCPU running kdump is a BSP then nothing else needs
> to be done as far as BSP's VMSA is concerned.
> 
> This fix is for kdump when using makedumpfile command/utility to
> generate vmcore.
> 
> For kexec, additional fix is required to mark the VMSA page of
> currently running vCPU as reserved during kexec boot and that fix
> will be depending on KHO/kstate patch-series which add the ability
> to preserve memory pages across kexec.

All that text is missing restraint, proper structure and makes me go:
what is that thing even trying to fix?

How about you read this here first:

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog

perhaps even use an AI to help you with the formulations and then send
a version which is actually parseable by other humans?

> Fixes: 3074152e56c9 ("x86/sev: Convert shared memory back to private on kexec")

I'd like to read in the next commit message why are you fixing your own
patch and why isn't this one CC:stable?

> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  arch/x86/coco/sev/core.c | 105 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)
> 
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index dcfaa698d6cf..2c27d4b3985c 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -110,9 +110,12 @@ struct svsm_ca boot_svsm_ca_page __aligned(PAGE_SIZE);
>  
>  DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
>  DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
> +DEFINE_PER_CPU(int, sev_vcpu_apic_id);

Why? What for?

>  DEFINE_PER_CPU(struct svsm_ca *, svsm_caa);
>  DEFINE_PER_CPU(u64, svsm_caa_pa);
>  
> +static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa, int apic_id);
> +
>  static __always_inline bool on_vc_stack(struct pt_regs *regs)
>  {
>  	unsigned long sp = regs->sp;
> @@ -973,6 +976,104 @@ void snp_kexec_begin(void)
>  		pr_warn("Failed to stop shared<->private conversions\n");
>  }
>  
> +/*
> + * kexec/kdump should be shutting down all APs except the one handling
> + * kexec/kdump and clearing the VMSA tag on those AP's VMSA pages as they
> + * are not being used as a VMSA page anymore, so that a random page in
> + * the kexec'ed guest which remains a VMSA page cannot cause unrecoverable
> + * RMP faults, kdump will anyway reboot afterwards while kexec will set new
> + * VMSA pages for all the APs to come up. Kdump while doing vmcore generation
> + * and page walking can cause unrecoverable #NPF/RMP faults when walking guest
> + * memory for dumping when it touches the VMSA page of the currently running
> + * vCPU while kexec can randomly use this pages when it is re-allocated after
> + * kexec via the page-allocator.

More gibberish text.

I give up - this is a mess.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
