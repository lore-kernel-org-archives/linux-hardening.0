Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9B33BA222
	for <linux-hardening@vger.kernel.org>; Sun,  6 Sep 2026 20:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788727492; cv=pass; b=WgxXrWkRabs83ai/algZYsVRTuyO9E2LDnCZTQZqWrdf/OZwdOC2bD1mCgEn2lPEE34+xMftIbM3yK9mOdZcBwblJmFN97faRHLV5G7zpE2s4SKu7RUhqoiutrJyDcXelBEwMzHTuXXctE1fS6D7puqvV9htzNfAE/VUz2eHMfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788727492; c=relaxed/simple;
	bh=qfahVnAkOq9Dy0GM7LrueFYNNe+ttAyxCGh+kKGHkNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IJu/MWGUfyd+JQG9l++AnbLng+dgRhFLgPCw9d6KU+USNr8Qc2MR7YCeniYSl0CxBRaZ5v4K80cB/ttZIjpiqjRLbbjvY0jS52CixCb6tRoi1sgW1JN5waQSFMJTCtZvmNPL+QTxYztAw9m1270cDjOyM2MZDlvbuGkGltmh2PM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvuJLxq7; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvuJLxq7"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c259e5c22ffso80283566b.1
        for <linux-hardening@vger.kernel.org>; Sun, 06 Sep 2026 13:44:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788727489; cv=none;
        d=google.com; s=arc-20260327;
        b=Xu/eAXc3TVEB2MnifQqAQxaYJNDFMeE3rWrUfuo0hNA017hcEtBTUS3S50wdEs0RqI
         O6c1cPo5m7oBuFN6Ahg876bQ5X8PraSauNIML4Y0BGSwBW3+JwF23NFy7VbErB+lihPi
         5ksY4vmj1gF40NJMIaDahSw4MprovncnvmWX3Si3PkrbrM5amET59J2CsCps2RFROZLV
         yeiDXhg8KuJFRF23fCoKVfLUBhnCclhv5L+kK5ustOn2i2AmfpiAvfgzK4NW+5G5veU+
         kVpzEqwmZKkoW0fb+EArtIut7E7thUnpdSIuyqQUkBT2I22gAAAFT26FOR7Zkhboqkvl
         X+Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qfahVnAkOq9Dy0GM7LrueFYNNe+ttAyxCGh+kKGHkNM=;
        fh=ZO5akpko50QkPKur6QY/RP7yNLXb1afmlimmZE0F/f4=;
        b=AfeMQpN/+hx8LrefaYYkLwYkZJVmtreYeKu2fGK9z1JqILlUPRYAS1+3cPhvmyVSfz
         vaeL+wcNd3CV8VJyyF2HdEeol4XrlAxFnAztHGDJpbto/Rz/8UEBqTe4iLvPb3AiFi7a
         bwdyvcYn79x4NLUZd8wAvggADLCLlR6FeYCYh5+NDpcyJwLX8Oyox3nky/SaUO72T+IY
         T/cN1JYlfTldqdgPBre86f3J3ZrVBS8WaEvNHqqCNASybP34bTGyDo2oL0jJcdv0qGBM
         14CcmdPvoMLl7GBAa/ITwnM0E3POViG1vs2Y8zJJ6mV6xYTp9w16FdmTuByS8MZKqRU2
         XBBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788727489; x=1789332289; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qfahVnAkOq9Dy0GM7LrueFYNNe+ttAyxCGh+kKGHkNM=;
        b=ZvuJLxq7UnGxQy3/tdKxGRBTo/vvPeoBfQ0i0xekofZOIeMf2wV2W+VDhf44hQ8Z69
         jcux6HyQMsL88AyR0/n+TjFMuX2rbmqgrEPLF8Xf51KCFvHuVT4yEBhCuYvXAylFx1Ot
         wzZC3RBgQ+Y9PG6O/qb1fSUtnfAOkx48gyOjQyO2EV5NXSyL2FDmEXFmyKvnnqmh7EXE
         V67vh06NnSQTYiJ8XeMIBt27Ow4JKaXoiFPZ6UC0URp1kP67uZTJFd4wbR9PpTyKlwff
         c/ddNP+A50ar1QYW6iFhpbLPZZmh2tHuLQcy1exGq4XP/SwBPsdbXOBtHnAAVejojsrZ
         GWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788727489; x=1789332289;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qfahVnAkOq9Dy0GM7LrueFYNNe+ttAyxCGh+kKGHkNM=;
        b=Fk4G93G/0VuqDolaXodlhpq90hRubwgQg0D6GglpGtkS/UwCfSur2MWpot5SKYlV9X
         6lf/XyE2RjT40NJhJGGZwwT4mBaAPEQXCu3QPBWVmeXg/Jc0jtw16HOOnQafj+JkwVlr
         wjdlJx6+ApnS9PlD9tZjepYYPbhAfr3YMiYrZWaMsei4HlZlszkPoKmjaGcJQsyYCPZb
         BPg5owpoT1/eQNAusBjjeDX5HHZm42erd7mqYh3SZf3yrEoyR787wl4MPrkcxTnd+YbG
         T13Cvt+T7ziJL6iLxn+arYQyHnCd3ZyS8nbr/HnIBTKMhIJgzbiZjh4SsQ099sXaZi4Z
         EudQ==
X-Forwarded-Encrypted: i=1; AKwUvByjY0+MvdnRD1E/32fSdauzpK4VS9inBfp0PqLl5DslLQbQT3snJLsYwyf+UsyT8tMLG19XOsoYPBg6XQbT+Vg=@vger.kernel.org
X-Gm-Message-State: AFuF++mpH1MJAE+B6qph9ZzomeTfZ10ndouFEVk4Z4A96OHMYhTkyJzD
	qxfiZzjRhPHrgsIfqYwL0Tqt7ytrjr38ckuSCVQNcQL3iOh5VUh365+ynAJFiVITPsd3zM6WdHy
	Yir/rVjAdoo3wB1ltPkjCl3Fp41L+hxo=
X-Gm-Gg: AYBFou0DuKC07AfTyY6GanI00O3HfzhSDPaE94W1hVXnOv2Q7tDQOY3qtD7S7tM3HFp
	UZPAIkiOTa6wVEEORvx96Ii6LOwV6KF2LjRpph9Yuw5btLK8EuFROyEbve2ESzYtGf67qo8f8jd
	/TyxB40OXerv3J+GNE203BtujQk53uy7zl44R0UoRL3lbPlpUgYZA5cllclRfdeW7LGVex64KSJ
	mzCegUABcQRwEI6asUzlkNzKZPa8BeOjalx5P5GSxzPhYGK641Y9uYKDas9s3Ymg1yZTdPJh7Qt
	rpIpPLMs5w6JRYyujlnrd1R/fMrzlzLct2z5N6c8xIafDtG3KyCWfm+8S/t8fwAatxnGAlBWw1M
	Au/G8PJLFVSa8ntkMzpgmYIGD/6YeFg==
X-Received: by 2002:a17:907:72d5:b0:c26:1691:b361 with SMTP id
 a640c23a62f3a-c261691b94dmr574303066b.26.1788727488511; Sun, 06 Sep 2026
 13:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905-arch-kconfig-options-v2-v2-0-83e8245761a2@gmail.com> <20260905-arch-kconfig-options-v2-v2-21-83e8245761a2@gmail.com>
In-Reply-To: <20260905-arch-kconfig-options-v2-v2-21-83e8245761a2@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 6 Sep 2026 22:44:36 +0200
X-Gm-Features: AcwNN1We0AsiI87C6m3-nOVPbE0KRdcX5bT97xhlIc8oCAONBoZx_sgPyrzwY90
Message-ID: <CA+=Fv5SC4qL76Fe_wk50p=8a069mKJ8ZAyUHMrP82DgvoHAsFg@mail.gmail.com>
Subject: Re: [PATCH v2 21/22] alpha: add HAVE_PERF_REGS and
 HAVE_PERF_USER_STACK_DUMP support
To: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Kees Cook <kees@kernel.org>, 
	Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Sat, Sep 5, 2026 at 9:30=E2=80=AFPM Matt Turner <mattst88@gmail.com> wro=
te:
>
> Implement the perf register sampling interface for Alpha. This enables
> perf to capture register state and user stack dumps with samples,
> supporting --call-graph dwarf.
>
> The perf_regs enum exposes the registers available in pt_regs: r0-r8,
> r16-r28, gp, pc, and ps. Registers r9-r15 are callee-saved and live
> in switch_stack, not pt_regs, so they are not included.
>
> A switch statement maps perf register indices to pt_regs fields since
> Alpha's pt_regs layout is non-contiguous (unlike architectures where
> direct array indexing works).
>
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Matt Turner <mattst88@gmail.com>

I think this patch still needs kernel-side work in addition to the
matching tools/perf support.

HAVE_PERF_USER_STACK_DUMP makes the generic perf code obtain the user
stack pointer through user_stack_pointer(regs), which on Alpha returns
regs->usp. However, the interrupt SAVE_ALL path does not initialize
that field, and do_entInt() does not snapshot USP. A profiling
interrupt taken from user mode may therefore attempt to copy the stack
from a stale or uninitialized address.

The proposed perf register ABI also does not include SP. A DWARF
unwinder needs both the sampled stack contents and the corresponding
stack pointer, so this cannot be completed solely by a later
tools/perf patch.

Would it make sense to drop this patch from the current series and
submit the perf support separately, including USP capture on interrupt
entry, SP in the kernel perf register ABI, and the matching tools/perf
support? That would allow the rest of this series to proceed without
waiting for the perf interface to be completed.

Regards,
Magnus
