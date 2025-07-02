Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682B42DE6EC
	for <linux-hardening@vger.kernel.org>; Wed,  2 Jul 2025 20:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751487727; cv=none; b=cJzCJY37Q8S3jYDTiPlR1ur8Gtfh8/8EH1sxmEaC59yGZ/iQOVZYKT8sKpi1cptnt85QlL1aKuUPWkYoad5Con2tR63zTkHc5fcHUzNlwujadPfetj6TKzcVzrmktaeKN6V5uzpejM9nUBc2bFeVztUgTrThenCEpLaTG9jb80Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751487727; c=relaxed/simple;
	bh=sdZUD4SUjgX+uY9yBVT2jw55tiIT2RzRywMurq/3UyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awfPGRJGKnFXToqR/BVa+VEk5hzMxQsiiTsx1hC8eEod+p3cjLoZlUQEkXlWKimYG1yG/tVIhRLv9d11LWpp4+Aqa0vVxfLU1aB/RJwxPyr5ueprWQlhwFtZo8YxNIx0YNx0LjF5mjwC0vZfpTdbs6odmZcNdCq96mTs4dbKxJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYuGjGCj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYuGjGCj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80905C4CEE7;
	Wed,  2 Jul 2025 20:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751487726;
	bh=sdZUD4SUjgX+uY9yBVT2jw55tiIT2RzRywMurq/3UyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gYuGjGCjIMW+SvLzrJgDrU4hDmhy9ZDWppgoQTAqUU+rhr4dKhGIZKIuC/ZaXtVlT
	 PzDHkUbPOlc5lt0KqBpJ27weLeFDAr5hGK+RZVIn3EbynuJUlCvvgxqwEHM3LRwEDw
	 swdJHTBkK72+KQ5uv04+nZUlf0uWAPbDJDAMzkzAr3E1iyExOmTgNBXAZ7meIoCH4h
	 VGemIzoESVFHKKlFVpmJeLKpUidqM9nczn3tdRNGHgEBKaarQkykU0vXW7Mi4rEG/P
	 M5GL+5ujawdYL7kOdXeszNil9ZbX2k1QKOutDztzDHw1zMMX3DcV2z3d80eWIWse6n
	 TobaHCIsqdZXw==
Date: Wed, 2 Jul 2025 13:22:03 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	John Ogness <john.ogness@linutronix.de>,
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>
Subject: Re: [bug report] printk: ringbuffer: Add KUnit test
Message-ID: <20250702202203.GA3347226@ax162>
References: <eaea66b9-266a-46e7-980d-33f40ad4b215@sabinyo.mountain>
 <20250626082605-c5fbbb88-f6cc-4659-bea0-a283cdb58e81@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250626082605-c5fbbb88-f6cc-4659-bea0-a283cdb58e81@linutronix.de>

On Thu, Jun 26, 2025 at 08:59:52AM +0200, Thomas Weißschuh wrote:
> On Wed, Jun 25, 2025 at 10:22:19AM -0500, Dan Carpenter wrote:
> > Hello Thomas Weißschuh,
> > 
> > The patch 5ea2bcdfbf46: "printk: ringbuffer: Add KUnit test" from Jun
> > 12, 2025, leads to the following static checker warning:
> > 
> > 	kernel/printk/printk_ringbuffer_kunit_test.c:91 prbtest_check_data()
> > 	(unpublished script worries this an off by one)
> > 
> > kernel/printk/printk_ringbuffer_kunit_test.c
> >     83 static bool prbtest_check_data(const struct prbtest_rbdata *dat)
> >     84 {
> >     85 	unsigned int len;
> >     86 
> >     87 	/* Sane length? */
> >     88 	if (dat->len < 1 || dat->len > MAX_RBDATA_TEXT_SIZE)
> >     89 		return false;
> >     90 
> > --> 91 	if (dat->text[dat->len] != '\0')
> >     92 		return false;
> >     93 
> > 
> > My question is that the prbtest_rbdata structure is declared like this:
> > 
> >     53  /* test data structure */
> >     54  struct prbtest_rbdata {
> >     55          unsigned int len;
> >     56          char text[] __counted_by(len);
> >     57  };
> > 
> > The size of text is not really counted by len, it's "MAX_RBDATA_TEXT_SIZE
> > + 1".  The condition "if (dat->text[dat->len] != '\0')" is reading one
> > element beyond the __counted_by() value so something should complain if
> > we enable all the debugging, right?
> 
> You are right, we are reading past the __counted_by().
> But I don't get any complains with CONFIG_FORTIFY_SOURCE=y and CONFIG_KASAN=y
> on either clang or gcc.

You will need CONFIG_UBSAN_BOUNDS to see warnings from __counted_by()
but they are present if I enable it with this test:

  [    0.507904] ------------[ cut here ]------------
  [    0.507904] UBSAN: array-index-out-of-bounds in kernel/printk/printk_ringbuffer_kunit_test.c:132:4
  [    0.507907] index 108 is out of range for type 'char[] __counted_by(len)' (aka 'char[]')
  [    0.507909] CPU: 3 UID: 0 PID: 392 Comm: prbtest writer  Tainted: G                 N  6.16.0-rc4-next-20250702 #1 PREEMPT(voluntary)
  [    0.507912] Tainted: [N]=TEST
  [    0.507913] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
  [    0.507914] Call Trace:
  [    0.507916]  <TASK>
  [    0.507918]  dump_stack_lvl+0x84/0xc0
  [    0.507922]  ubsan_epilogue+0x5/0x30
  [    0.507925]  __ubsan_handle_out_of_bounds+0xa2/0xc0
  [    0.507928]  prbtest_writer+0x16a/0x210
  [    0.507932]  ? __pfx_prbtest_writer+0x10/0x10
  [    0.507934]  kthread+0x21a/0x260
  [    0.507937]  ? __pfx_kthread+0x10/0x10
  [    0.507938]  ret_from_fork+0x77/0xd0
  [    0.507940]  ? __pfx_kthread+0x10/0x10
  [    0.507941]  ret_from_fork_asm+0x1a/0x30
  [    0.507945]  </TASK>
  [    0.507945] ---[ end trace ]---

  [    0.516113] ------------[ cut here ]------------
  [    0.516115] UBSAN: array-index-out-of-bounds in kernel/printk/printk_ringbuffer_kunit_test.c:91:6
  [    0.516117]     # test_readerwriter: lib/ubsan.c:228: array-index-out-of-bounds in kernel/printk/printk_ringbuffer_kunit_test.c
  [    0.516119] index 126 is out of range for type 'char const[] __counted_by(len)' (aka 'const char[]')
  [    0.516122] CPU: 0 UID: 0 PID: 389 Comm: kunit_try_catch Tainted: G                 N  6.16.0-rc4-next-20250702 #1 PREEMPT(voluntary)
  [    0.516125] Tainted: [N]=TEST
  [    0.516126] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
  [    0.516127] Call Trace:
  [    0.516129]  <TASK>
  [    0.516131]  dump_stack_lvl+0x84/0xc0
  [    0.516136]  ubsan_epilogue+0x5/0x30
  [    0.516138]  __ubsan_handle_out_of_bounds+0xa2/0xc0
  [    0.516142]  prbtest_reader+0x2ff/0x480
  [    0.516145]  ? srso_alias_return_thunk+0x5/0xfbef5
  [    0.516147]  ? set_next_entity+0x5e/0x140
  [    0.516150]  ? __pfx_prbtest_wakeup_callback+0x10/0x10
  [    0.516155]  ? set_cpus_allowed_ptr+0x83/0xb0
  [    0.516158]  test_readerwriter+0x297/0x3c0
  [    0.516161]  kunit_try_run_case+0x8c/0x190
  [    0.516164]  kunit_generic_run_threadfn_adapter+0x1a/0x40
  [    0.516166]  ? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
  [    0.516167]  kthread+0x21a/0x260
  [    0.516169]  ? __pfx_kthread+0x10/0x10
  [    0.516170]  ret_from_fork+0x77/0xd0
  [    0.516173]  ? __pfx_kthread+0x10/0x10
  [    0.516174]  ret_from_fork_asm+0x1a/0x30
  [    0.516177]  </TASK>
  [    0.516178] ---[ end trace ]---

I see Petr sent an updated patch for this, which does resolve the
warning in my testing.

https://lore.kernel.org/20250702095157.110916-4-pmladek@suse.com/

Cheers,
Nathan
