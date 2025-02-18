Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6891E21B9DF
	for <linux-hardening@vger.kernel.org>; Tue, 18 Feb 2025 19:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739906330; cv=none; b=Q13iqWb099ltzmuh+xGDclmPMAjZrMB4Hde9tgrJ4RQ0I7Mmy9xm+96MqFOHbU7zK1Czh3tflHPk/oRHnMB4H3asU1wsA2/B+54xJLif9Lp9nkTscsofaNLUAM0Y14aMuOQQ/vwX9d4vhkBi+v1D7PCsjaXSq0jLq79mZ+HHFUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739906330; c=relaxed/simple;
	bh=Wo1dSIMgOpzXJrHFjWadb3uFvvKajIMKXY4UPrEQHZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKwCMt55MY8Iwn9DbrpwKVr8MQJ/y/AXdTjzkub68Gd1SWJwwplUP1e/9F38Gg1Sas9yhqn6zhMN0wUCDj4iIFV2DWUz9+uqqSIwmhnClefHbIQTTGT6TedX6txndSg1yICTdHAif/aM6g3VYZ0Mvm/qtCKRRAEa8ZxlYZbY3ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=overdrivepizza.com; spf=fail smtp.mailfrom=overdrivepizza.com; dkim=pass (2048-bit key) header.d=overdrivepizza-com.20230601.gappssmtp.com header.i=@overdrivepizza-com.20230601.gappssmtp.com header.b=3COnDYR2; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=overdrivepizza.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=overdrivepizza.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=overdrivepizza-com.20230601.gappssmtp.com header.i=@overdrivepizza-com.20230601.gappssmtp.com header.b="3COnDYR2"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5461cb12e39so2633294e87.2
        for <linux-hardening@vger.kernel.org>; Tue, 18 Feb 2025 11:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=overdrivepizza-com.20230601.gappssmtp.com; s=20230601; t=1739906325; x=1740511125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZn7+VF4S7Dh4qG9hSrxTiOHJ0wC9t+U+ePn2pEV93g=;
        b=3COnDYR2o/q5tYKIch48HA+p6AlLI+u6N69asnuMdrCNkUx0/Q5ZSNfDlxEc9o1PbP
         Z5wvVpQ1m4Hi5Z45UciYwhxansa7Vzde8dnrXhlJ7xBOGFYbcNkY7mcAmING/VoyHdk7
         qJMDdvv/5m+ahOFXgqtMjJPAef90Cj6Xzx4WNPWqjMravTB2WeNn+iDBeaWYpxPLCXqw
         q8lS5n9RqCb2kCQId/wX6aZvPfgfI5YK+owVACV3TffhGAcJA9nR6EsQyOW53dtMtgd0
         CMrakdSO+8qSKEPEnnAgr3Rr+sPHCdvja/cjMJ34SRplLn2yPVvBTT8JrtNUmi97afZX
         LxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739906325; x=1740511125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZn7+VF4S7Dh4qG9hSrxTiOHJ0wC9t+U+ePn2pEV93g=;
        b=cbgec0DzZTvpFBRYbExJxKUOqt/pYedm7eoV8c/y7wjU55DVlwwCgd2lGl2cBKWOJh
         t8T6l8WQgPHofVeobRBk5cZkq9nAJxRQA99YQ+n5hY/qGGLUKsqwS/S3qv6hhwCtXsCn
         nxthVQwzw7VnYRi6v4wuEqycsNq6svIhfAkRg4o6cXqgh4bTMbabZ7fa7CgSIn8cJhom
         xNd5DrJxwtb5jJEGjz9bruKn6bGHRG90GaEIMx9Ied10/S0aoqHnTQuL4wP7SQwLXHT8
         5hi7GEpowuz34u5F4t1Thd9qREffpOD0TtNIarrVaKsoqkmQRT7aO3sbV94UK20xBd1j
         WPMA==
X-Gm-Message-State: AOJu0Yw3InumU4gmM69y2xv/9nYv3/jOK+7By7+1A2Pqac4CA/RY9VPM
	s5fEq2Oxb6wafupoVuTd7GKZLd5sS4fE/VL/v1gYlAU7OFkCASijVCNN6b38Io2X5gscTpW+Cqo
	FIQPfM15WlVsY78RdKgthlCW5Tym3urmOgJt1Cg==
X-Gm-Gg: ASbGncuELaCmVz9Md4B8xwWfCTA0/vNLA4TLBF+bnpCRRLuWTnPryVM3XAFE+Rw8roK
	sQnKayiLrtuW8AQ0E2Jv27Fr0uKDp8NbxmvLDl73R9l7Z4ZBmKzIkgqcq5FFNt/OucDt2xWSRKi
	HqyCSs0JcHHOrNTAwpboDJpxaOaKg=
X-Google-Smtp-Source: AGHT+IFBnQAaq+UtVijrCtBhvreBQUusJmJ8C6qywa/TQMPyDZNeI5BV9iEz1skvEJ4167zPjxaD06GdLZnYufrT5xw=
X-Received: by 2002:a05:6512:3b0b:b0:542:29b6:9c26 with SMTP id
 2adb3069b0e04-5452fe95c7emr4915672e87.47.1739906325124; Tue, 18 Feb 2025
 11:18:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z60NwR4w/28Z7XUa@ubun>
In-Reply-To: <Z60NwR4w/28Z7XUa@ubun>
From: Joao Moreira <joao@overdrivepizza.com>
Date: Tue, 18 Feb 2025 11:18:34 -0800
X-Gm-Features: AWEUYZmiCYvoBAdXmTwWdC9J_zjSsYebC861zEtGSgW-d_IuBtxsspbQYKx33Vc
Message-ID: <CAKUFkX0+zrvvajVgOiHb=hqaJA+7_WTFetweNZ2hzNHTKwhQbg@mail.gmail.com>
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
To: Jennifer Miller <jmill@asu.edu>
Cc: linux-hardening@vger.kernel.org, kees@kernel.org, samitolvanen@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Jennifer, really cool work :)

Since you mentioned approaches to handling the issue, a possible
simple fix could be aligning function endbrs to 0x1, and keeping the
entry points at 0x0. Then, before doing the indirect call, just OR 0x1
the function address. It seems PeterZ has something else on his
pipeline, which sounds very reasonable for upstream and closes other
concerns raised by Kees. Yet, given you may be interested in
approaches beyond what is suitable for upstream, I felt like you could
be interested in this trick.

Thank you for the paper, I'm looking forward to reading it.

Best,
Joao

On Wed, Feb 12, 2025 at 1:08=E2=80=AFPM Jennifer Miller <jmill@asu.edu> wro=
te:
>
> Hi All,
>
> As part of a recently accepted paper we demonstrated that syscall
> entrypoints can be misused on x86-64 systems to generically bypass
> FineIBT/KERNEL_IBT from forwards-edge control flow hijacking. We
> communicated this finding to s@k.o before submitting the paper and were
> encouraged to bring the issue to hardening after the paper was accepted t=
o
> have a discussion on how to address the issue.
>
> The bypass takes advantage of the architectural requirement of entrypoint=
s
> to begin with the endbr64 instruction and the ability to control GS_BASE
> from userspace via wrgsbase, from to the FSGSBASE extension, in order to
> perform a stack pivot to a ROP-chain.
>
> Here is a snippet of the 64-bit entrypoint code:
> ```
> entry_SYSCALL_64:
> <+0>:     endbr64
> <+4>:     swapgs
> <+7>:     mov    QWORD PTR gs:0x6014,rsp
> <+16>:    jmp    <entry_SYSCALL_64+36>
> <+18>:    mov    rsp,cr3
> <+21>:    nop
> <+26>:    and    rsp,0xffffffffffffe7ff
> <+33>:    mov    cr3,rsp
> <+36>:    mov    rsp,QWORD PTR gs:0x32c98
> ```
>
> This is a valid target from any indirect callsite under FineIBT due to th=
e
> endbr64 instruction and the lack of a software CFI check. After hijacking
> control flow to the entrypoint, executing swapgs will swap to the user
> controlled GS_BASE, which will be used to set the stack pointer, leading =
to
> a stack pivot. The rest of the entrypoint will execute with a hijacked
> GS_BASE on a user controlled stack. The stack page we use is one mapped i=
n
> the user address space and from another thread we race overwriting return=
s
> addresses on the stack to pivot a second time to a ROP-chain. For this to
> succeed we required a large area of user-controlled kernel memory that ca=
n
> serve as the forged GS_BASE address, we did this by spraying 2MB
> Transparent Huge Pages to fill the kernel physical memory map with
> controlled 2MB allocations and guessing relative to the base address of t=
he
> area to hit a page we control.
>
> We evaluated an approach to patching the issue in the paper but it touche=
d
> the userspace API a bit, added an error code returned by syscalls if they
> are invoked with a kernel address in GS_BASE, which is not a great
> solution.
>
> Linus provided some thoughts on how to potentially address this issue
> in our communication with s@k.o, suggesting the kernel could make the
> KERNEL_GS_BASE match the GS_BASE value so both registers always contain a
> valid kernel address and a confusion induced by executing swapgs an extra
> time cannot occur, and restore the value of KERNEL_GS_BASE ahead of
> executing swapgs in the exit path.
>
> I started working on a patch based on the approach suggested by Linus but=
 I
> haven't been able to get it passing the relevant x86 selftests yet. It
> turned out that it's more than the entrypoint code that needs to be
> modified for it to work, we need to correctly save and restore the user's
> GS_BASE across task switches and ensure it is updated correctly when set
> via arch_prctl and ptrace. Unfortunately, I lack familiarity with those
> parts of the kernel, and my understanding is that the paper will be made
> public in a couple weeks so I didn't want to delay too long on bringing t=
he
> issue to this list.
>
> Assuming this is an issue you all feel is worth addressing, I will contin=
ue
> working on providing a patch. I'm concerned though that the overhead from
> adding a wrmsr on both syscall entry and exit to overwrite and restore th=
e
> KERNEL_GS_BASE MSR may be quite high, so any feedback in regards to the
> approach or suggestions of alternate approaches to patching are welcome :=
)
>
> ~Jennifer
