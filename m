Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EF219DF9E;
	Wed,  9 Oct 2024 15:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728487130; cv=none; b=d7ITojDMI4yMA6kf6b8B4Q0eoM8KCZC7ESjz6RIzIK9HPzCanV5kbPc8YAY19bXQImF9xHLc1cJK2SZ0lHijtAJc4rojB0axrkSQxP/hGY2IcOO5TWxQwrFkCi4XK566DBCXcJXg+4NzcUG1vFO6oR7J5SF5eI7PpHsNJJUGozE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728487130; c=relaxed/simple;
	bh=TkTZF61Dm4geyGJUBrcOgExSip9VIIuFuCW1rSsvTXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DdchWUPk3jRxuO7xlkjHE5n31wFhwWKzufvPNNByKD6V58md988VV75wAZhj7UWxlh6VQj0jo9AeS+QXRrHb2+sIntuXUx9fhptBtB1yy5KtkODNmHtycI7dwgu0GyhgGS2/0TUaw87zaV642myu4RAAXhBFMVzZ+uOntu4dITs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Had75Z5w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Had75Z5w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F47C4CECE;
	Wed,  9 Oct 2024 15:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728487130;
	bh=TkTZF61Dm4geyGJUBrcOgExSip9VIIuFuCW1rSsvTXk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Had75Z5wgbmd/egQQY3HEvYNHmKqZ+puE8z0PwERZLBwgMjMS1aXEwFc+phw3X9V7
	 87mvKKfMiIc1dSuZvbxmh6yVS6DuMM4ksjyP2a44SDl5B2WXS1kUYLG0zeazcg9+3v
	 Iol1UPP4RzmWZTQypVSTyhlqlgPtwk9m0wFmMX2Dydt5f2yz5R/JRqzwvflBDjsQNx
	 MnBL2ghZxt3Y5+qNoVTIINJzyLDZRqP3PqW7NQ9UCsN1Puiv76rz3LzjVFcndNG47q
	 88PFdpZ7cSMMl/xWu88Gw89jV/M2ScPXfEORaBll8Zd058KgrduNAp0XRFCL1KwzRX
	 u5ebe2i39oFJA==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fac3f20f1dso76370511fa.3;
        Wed, 09 Oct 2024 08:18:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV89+ZgCj2tXmdDjXlcBX6ZCsaU8Y6ksM1HOqN2DY9sQPLUxagZUioiqOsYSs0t/xAd5lw0dt5Yblx3e+bXC48=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVdDmiyHYHOQvcxQsdODTzETbRlQs9yQVuo9zKvipGYZ0VicC1
	SvLxA2psNHQYGBw9TtnI9ZIN3uftvl2ZR6cyLuqB20BkCOT5whffVb3hxUsnBes1llnuKpVYy8E
	YrZ6neaEj4nhXmaB4U1VnfMJBrVQ=
X-Google-Smtp-Source: AGHT+IFyXVekuST3emLrAwDiziwfH3jcPUTJ8r+uaK2VNyULsaOucoAWsgJGCcBIELm+IDvVgmZ0VQ94P6Ec3LVD1+w=
X-Received: by 2002:a2e:8e6f:0:b0:2fa:bb5d:db67 with SMTP id
 38308e7fff4ca-2fb187aeb2emr15501101fa.32.1728487128346; Wed, 09 Oct 2024
 08:18:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007224747.3973322-2-ardb+git@google.com> <20241008174201.b23zrrvqv26ihq4t@treble>
In-Reply-To: <20241008174201.b23zrrvqv26ihq4t@treble>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 9 Oct 2024 17:18:36 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHBccOwtLWuT9P1ozpVm7bTcfPfjfXTVzJnCzsCYm1RfQ@mail.gmail.com>
Message-ID: <CAMj1kXHBccOwtLWuT9P1ozpVm7bTcfPfjfXTVzJnCzsCYm1RfQ@mail.gmail.com>
Subject: Re: [PATCH] objtool: Deal with relative jump tables correctly
To: Josh Poimboeuf <jpoimboe@kernel.org>, Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Oct 2024 at 19:42, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> On Tue, Oct 08, 2024 at 12:47:48AM +0200, Ard Biesheuvel wrote:
> > -     /*
> > -      * Use of RIP-relative switch jumps is quite rare, and
> > -      * indicates a rare GCC quirk/bug which can leave dead
> > -      * code behind.
> > -      */
> > -     if (reloc_type(text_reloc) == R_X86_64_PC32)
> > -             file->ignore_unreachables = true;
> > -
>
> I'm not sure if this bug still exists on current GCC versions.  If so,
> it will start reporting "unreachable instruction" warnings again and
> we'll have to figure out a way to resolve that.
>

Ah, I mistook this for a check against the first entry in the table,
but it is the reference *to* the table from the code.

So I'll just leave this alone.

> Otherwise the patch looks ok.
>

Thanks. I've added another tweak locally so validate_ibt_data_reloc()
uses the corrected offset as well, or I end up with !ENDBR warnings.
So with that in place, objtool can decipher the jump table if it
manages to recognize it as one.

However, there are pathological cases (see one below) where the LEA
that takes the address of the jump table is ridiculously far away from
the indirect jump, resulting in a warning like

vmlinux.o: warning: objtool: fdt_pmu_probe_pmu_dev.isra.0+0x229:
sibling call from callable instruction with modified stack frame


This is with GCC 14 (it is the only warning introduced by PIC codegen
in an allmodconfig build), and I suspect that this might happen with
non-PIC codegen too, right?

So how important is jump table support now that it is turned off in
most cases? And has there been any movement on compiler annotations?
If this is worth while, it is something I could look into: Kees and I
work very closely with both the GCC and the Clang folks, and have
contributed other features that are specific to the kernel.







ffffffff83203a40 <fdt_pmu_probe_pmu_dev.isra.0>:
3a40:  nopl   0x0(%rax,%rax,1)
3a45:  push   %r15
3a47:  push   %r14
3a49:  lea    0x597a98(%rip),%r14  <--- load of jump table address
3a50:  push   %r13
3a52:  mov    %rsi,%r13
3a55:  push   %r12
3a57:  lea    0x530(%r13),%r15
3a5e:  push   %rbp
3a5f:  push   %rbx
3a60:  mov    %rdi,%rbx
3a63:  sub    $0x10,%rsp
3a67:  mov    0x40(%rsp),%rdi
3a6c:  call   ffffffff81745c00 <__tsan_func_entry>
3a71:  call   ffffffff814ae4c0 <__sanitizer_cov_trace_pc>
3a76:  mov    %r15,%rdi
3a79:  call   ffffffff81747a00 <__tsan_read8>
3a7e:  mov    0x530(%r13),%rdi
3a85:  xor    %esi,%esi
3a87:  call   ffffffff82a25800 <of_get_next_child>
3a8c:  mov    %rax,%r12
3a8f:  call   ffffffff814ae4c0 <__sanitizer_cov_trace_pc>
3a94:  test   %r12,%r12
3a97:  je     ffffffff83203d55 <fdt_pmu_probe_pmu_dev.isra.0+0x315>
3a9d:  call   ffffffff814ae4c0 <__sanitizer_cov_trace_pc>
3aa2:  mov    %r12,%rdi
3aa5:  call   ffffffff82a26e00 <of_device_is_available>
3aaa:  xor    %edi,%edi
3aac:  mov    %eax,%ebp
3aae:  mov    %eax,%esi
3ab0:  call   ffffffff814ae740 <__sanitizer_cov_trace_const_cmp1>
3ab5:  test   %bpl,%bpl
3ab8:  je     ffffffff83203d31 <fdt_pmu_probe_pmu_dev.isra.0+0x2f1>
3abe:  call   ffffffff814ae4c0 <__sanitizer_cov_trace_pc>
3ac3:  lea    0x68e996(%rip),%rsi        # ffffffff83892460 <.LC29>
3aca:  mov    %r12,%rdi
3acd:  call   ffffffff82a26180 <of_device_is_compatible>
3ad2:  xor    %edi,%edi
3ad4:  mov    %eax,%ebp
3ad6:  mov    %eax,%esi
3ad8:  call   ffffffff814ae7c0 <__sanitizer_cov_trace_const_cmp4>
3add:  test   %ebp,%ebp
3adf:  je     ffffffff83203b03 <fdt_pmu_probe_pmu_dev.isra.0+0xc3>
3ae1:  call   ffffffff814ae4c0 <__sanitizer_cov_trace_pc>
3ae6:  mov    %rbx,%rdi
3ae9:  call   ffffffff81747a00 <__tsan_read8>
3aee:  mov    (%rbx),%rdi
3af1:  xor    %edx,%edx
3af3:  mov    %r12,%rsi
3af6:  call   ffffffff83203800 <fdt_get_pmu_hw_inf.isra.0>
3afb:  mov    %rax,%rbp
3afe:  jmp    ffffffff83203bd7 <fdt_pmu_probe_pmu_dev.isra.0+0x197>
3b03:  call   ffffffff814ae4c0 <__sanitizer_cov_trace_pc>
3b08:  lea    0x68e963(%rip),%rsi        # ffffffff83892472 <.LC30>
3b0f:  mov    %r12,%rdi
3b12:  call   ffffffff82a26180 <of_device_is_compatible>
3b17:  xor    %edi,%edi
3b19:  mov    %eax,%ebp
3b1b:  mov    %eax,%esi
3b1d:  call   ffffffff814ae7c0 <__sanitizer_cov_trace_const_cmp4>
3b22:  test   %ebp,%ebp
3b24:  je     ffffffff83203b4b <fdt_pmu_probe_pmu_dev.isra.0+0x10b>
3b26:  call   ffffffff814ae4c0 <__sanitizer_cov_trace_pc>
3b2b:  mov    %rbx,%rdi
3b2e:  call   ffffffff81747a00 <__tsan_read8>
3b33:  mov    (%rbx),%rdi
3b36:  mov    $0x1,%edx
3b3b:  mov    %r12,%rsi
3b3e:  call   ffffffff83203800 <fdt_get_pmu_hw_inf.isra.0>
3b43:  mov    %rax,%rbp
3b46:  jmp    ffffffff83203bd7 <fdt_pmu_probe_pmu_dev.isra.0+0x197>
3b4b:  call   ffffffff814ae4c0 <__sanitizer_cov_trace_pc>
3b50:  lea    0x68e92d(%rip),%rsi        # ffffffff83892484 <.LC31>
3b57:  mov    %r12,%rdi
3b5a:  call   ffffffff82a26180 <of_device_is_compatible>
3b5f:  xor    %edi,%edi
3b61:  mov    %eax,%ebp
3b63:  mov    %eax,%esi
3b65:  call   ffffffff814ae7c0 <__sanitizer_cov_trace_const_cmp4>
3b6a:  test   %ebp,%ebp
3b6c:  je     ffffffff83203b90 <fdt_pmu_probe_pmu_dev.isra.0+0x150>
3b6e:  call   ffffffff814ae4c0 <__sanitizer_cov_trace_pc>
3b73:  mov    %rbx,%rdi
3b76:  call   ffffffff81747a00 <__tsan_read8>
3b7b:  mov    (%rbx),%rdi
3b7e:  mov    $0x3,%edx
3b83:  mov    %r12,%rsi
3b86:  call   ffffffff83203800 <fdt_get_pmu_hw_inf.isra.0>
3b8b:  mov    %rax,%rbp
3b8e:  jmp    ffffffff83203bd7 <fdt_pmu_probe_pmu_dev.isra.0+0x197>
3b90:  call   ffffffff814ae4c0 <__sanitizer_cov_trace_pc>
3b95:  lea    0x68e8fa(%rip),%rsi        # ffffffff83892496 <.LC32>
3b9c:  mov    %r12,%rdi
3b9f:  call   ffffffff82a26180 <of_device_is_compatible>
3ba4:  xor    %edi,%edi
3ba6:  mov    %eax,%ebp
3ba8:  mov    %eax,%esi
3baa:  call   ffffffff814ae7c0 <__sanitizer_cov_trace_const_cmp4>
3baf:  test   %ebp,%ebp
3bb1:  je     ffffffff83203d31 <fdt_pmu_probe_pmu_dev.isra.0+0x2f1>
3bb7:  call   ffffffff814ae4c0 <__sanitizer_cov_trace_pc>
3bbc:  mov    %rbx,%rdi
3bbf:  call   ffffffff81747a00 <__tsan_read8>
3bc4:  mov    (%rbx),%rdi
3bc7:  mov    $0x4,%edx
3bcc:  mov    %r12,%rsi
3bcf:  call   ffffffff83203800 <fdt_get_pmu_hw_inf.isra.0>
3bd4:  mov    %rax,%rbp
3bd7:  call   ffffffff814ae4c0 <__sanitizer_cov_trace_pc>
3bdc:  test   %rbp,%rbp
3bdf:  je     ffffffff83203d31 <fdt_pmu_probe_pmu_dev.isra.0+0x2f1>
3be5:  call   ffffffff814ae4c0 <__sanitizer_cov_trace_pc>
3bea:  mov    %rbp,%rsi
3bed:  mov    %rbx,%rdi
3bf0:  call   ffffffff82a864c0 <xgene_pmu_dev_add>
3bf5:  xor    %edi,%edi
3bf7:  mov    %eax,%esi
3bf9:  mov    %eax,(%rsp)
3bfc:  call   ffffffff814ae7c0 <__sanitizer_cov_trace_const_cmp4>
3c01:  mov    (%rsp),%eax
3c04:  test   %eax,%eax
3c06:  je     ffffffff83203c25 <fdt_pmu_probe_pmu_dev.isra.0+0x1e5>
3c08:  call   ffffffff814ae4c0 <__sanitizer_cov_trace_pc>
3c0d:  mov    %rbx,%rdi
3c10:  call   ffffffff81747a00 <__tsan_read8>
3c15:  mov    (%rbx),%rdi
3c18:  mov    %rbp,%rsi
3c1b:  call   ffffffff8283d3c0 <devm_kfree>
3c20:  jmp    ffffffff83203d31 <fdt_pmu_probe_pmu_dev.isra.0+0x2f1>
3c25:  call   ffffffff814ae4c0 <__sanitizer_cov_trace_pc>
3c2a:  lea    0x20(%rbp),%rdi
3c2e:  call   ffffffff817474c0 <__tsan_read4>
3c33:  mov    0x20(%rbp),%eax
3c36:  lea    0x597923(%rip),%rsi
3c3d:  mov    %rax,%rdi
3c40:  mov    %eax,0xc(%rsp)
3c44:  mov    %rax,(%rsp)
3c48:  call   ffffffff814ae840 <__sanitizer_cov_trace_switch>
3c4d:  mov    0xc(%rsp),%edx
3c51:  cmp    $0x4,%edx
3c54:  ja     ffffffff83203d31 <fdt_pmu_probe_pmu_dev.isra.0+0x2f1>
3c5a:  mov    (%rsp),%rax
3c5e:  add    $0x8,%rbp
3c62:  movslq (%r14,%rax,4),%rax
3c66:  add    %r14,%rax
3c69:  jmp    *%rax
3c6b:  int3
