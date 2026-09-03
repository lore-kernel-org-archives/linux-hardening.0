Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AB0429CC7
	for <linux-hardening@vger.kernel.org>; Thu,  3 Sep 2026 10:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788431350; cv=none; b=sOe+PA1MiiR1F7znO4pa1RfrJUmr+CoWvayARtTaAPHYyRsLwRHQ7vr6+XzWG4lCh6UFsP2YISBBvw6uToGR9zQBkU+HX/IBHfU5ege4jC/RBzbKWIZovIJP9gCzxyg9EZpymT6yZ0nL25aw+kd62bOBNO8fb8EUQCdk9blp2RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788431350; c=relaxed/simple;
	bh=15Hrj+sB4kqVLc58S41Xe1fFUyqdekHHhp6EbXK4uDQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=b/RxE9/RVySpPJdvndBr0WX6iWwAlfMPs6StoWTPLzACGW1u1rAki8pJTjHpIg7WdGRelQgsrBuWUHAOodxkGKLivWVNfoCU8Bqhkw/upnedzFu1NxrL2A3e3LSKBVweD1StCnA9cEsSMcC++2PUVl++U7u5rbkLr88uKDxLC9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUb8mLky; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUb8mLky"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381351F000E9;
	Thu,  3 Sep 2026 10:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788431341;
	bh=AcNUpw6Lj1FIDQuWzDG+KLOdxeaiE2w93zLsFmaZvAE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=jUb8mLkyPBwXMFFFlLwW33UpGEo7FXT8StJWtl++ypNCasXynM+VDj/KHBygYTCSn
	 4m0YqpdBknZQBZPVB8W1qVIDGUqmP6YFCc7jKDfvOvNh1CDZQOe8ishQIo1jqOzjnU
	 p6L4tVwjec7VADcy1sTMBhudC2/tieJdhpKVT3g7LFz1ck729z9LMGm/NiD183CDmd
	 OSsTQC77sZdppWR1cVOEzEz9iGzIXQC/FG50lL7JaC7YsiFbOV0Yh1fLfeEx22QiqV
	 DiZmyC8K3WuwnPsc7nZsQC/E3luvM0omgWb39zneRfgKecowA5lullcmzpK6xNCVb0
	 WVwMm2uvJo54A==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id AE3F21980045;
	Thu,  3 Sep 2026 06:28:59 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Thu, 03 Sep 2026 06:28:59 -0400
X-ME-Sender: <xms:6kuZalUtuP1bXEY2b-7MOt3jhlQqrf3vi_-851mXMEu_EavhYPwvFg>
    <xme:6kuZagZ_ENyxVZZzfCGRtmYFRycmmQ7fwMtwBMVIZE9FZJivBB-lSejiCJYqRqbCC
    ekJ7fZUyNnBnXVFl8A6PhsYhlZFcYAfDFgeuvlzvHeD4Hz-1iTmkAuR>
X-ME-Proxy-Cause: dmFkZTGpGlOqFCkZ0WH/WgehOeKD573sL8pVMh09+XXdQ9YYfXtHQGBUMMeFoBgZOhu9+6
    VY2yLHizXQp5xMMh8f7sz0Yurgrtll2pymTiWOVGP7OpMVVKFh/K3yWKGFt7L85PD9lh/s
    wQt/aEw8TgfHc36mxm9xRPk3gia9uC1RWE3ZZnv2jIam9mrgvIud3+uurxKX3Yb90Q+rWz
    7VzqWernwLhD5uRv7Br9sJ2zTzgp4ZcjfAYFkDXqDKPXb3v2hm5+X5QQ0J64yBWyn5gx4T
    C4VS5jMF7zxm7Tb/+Nni8MstiG87rPqxlaIaaJCDOUzyVtHFc4QnbWwr4sF2oD+0rMfGQt
    9jnQ+3HDBpOgnE8R3/IxxGKku6wJ7y2CxQJYgDmbY6x3+D5VUfM8CoYYDvM5uNJWbOBq1S
    zbP/N4aU1y156JbN0krN+wU8wFyzAvHFI4MFJxsmDwOq8/2kIj3j6oV6rSUC7JdcQTiN5Z
    GyCOpS/ggHPiTTJmYepNhJUxlrqmkuufSTow57eVgs+jJjnLd5G+Mzw09pgHqaaqqHTBAc
    XBO27jlOchuDL5qjMqBZbYmSQnBi/IQgwXmhqtc++qRaSR8W84gOa/68NGQtIfKaesCTjH
    jgf+QrNw5kaI/L85dogYzf4I46SGT0dnrZbtzuWp3Tun5QW8Qm9vHEFWFIpw
X-ME-Proxy: <xmx:60uZajDmJwytUZfaUcivRBqASCd2dOpFUs60RVEtTuyXwlyawvKweA>
    <xmx:60uZai2S-b0TnxK39w8vnpYF3CWhd9xx0sopKloNSnTBFdyhqCrH2w>
    <xmx:60uZal16iUql1ZNyD-KdXiyikw1TeQzkCyY3Zi5P56G3v7OWfbCQ7g>
    <xmx:60uZanDGZENEGpis7oFzr7SKYXCKHS4O7YXYewDUVGycEto2mf4svQ>
    <xmx:60uZak6UeVksHy7LrhL3Rtl1X1JFO6TZgQN3lCNBgrBckX098Lr6K5NQ>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 05E6CF8007B; Thu,  3 Sep 2026 06:28:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 03 Sep 2026 12:28:37 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "York Jasper Niebuhr" <yjn@yjn-systems.com>,
 linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Kees Cook" <kees@kernel.org>,
 franzen@sec.in.tum.de
Message-Id: <4665e150-3ce3-4b63-949b-1f0210894e4b@app.fastmail.com>
In-Reply-To: <20260720191146.21473-1-yjn@yjn-systems.com>
References: <20260720191146.21473-1-yjn@yjn-systems.com>
Subject: Re: [RFC v3 0/5] Bootpatch-SLR: Randomizing Linux Kernel Structure Layouts at
 Boot
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello Jasper,

This work looks very interesting, thanks for sticking with it.
That said, I think the path to possible upstream inclusion is
rather uncertain, given the intrusive nature of this work.


On Mon, 20 Jul 2026, at 21:11, York Jasper Niebuhr wrote:
> Hello,
> this is the third RFC version of Bootpatch-SLR. The previous RFCs were
> sent to linux-hardening; this version is also sent to LKML for broader
> review. Compared to RFC v2, it uses a new GAS feature instead of a
> dedicated assembler inside the compiler plugin. Additionally, it
> introduces the Sanemaker validation framework. This version rebases
> BPSLR onto Linux 7.2-rc3 and resolves the boot failures that prevented
> earlier rebases.
>
> RFC v2:
>     https://lists.openwall.net/linux-hardening/2026/06/20/5
>
> Changes since RFC v2:
>   - Implemented GAS fieldlabel feature to label immediate instruction
>     operand bytes.
>   - Removed pinpoint instruction pin assembler. Metadata now links
>     directly against fieldlabels emitted by GAS.
>   - Implemented Sanemaker validation tool and integrated it into the
>     kernel.
>   - Rebased Bootpatch-SLR onto Linux 7.2-rc3.
>   - Excluded some RCU fields of task_struct from randomization to
>     prevent boot crashes on new version.
>
> Bootpatch-SLR enables per-instance structure layout randomization for
> distribution kernels. While GCC's RandStruct pass randomizes layouts at
> compile-time, every machine running the same kernel image receives the
> same layout. Bootpatch-SLR applies comparable randomization during boot.
>

I take it this means that DWARF debug data and BTF typeinfo are no longer
usable on such kernels? If so, how does that impact BPF?


> A full architectural overview and additional resources are available at:
>
>     https://spslr.yjn-systems.com
>
> At this stage, tooling is only available for x86_64. It is based on
> Linux 7.2-rc3. Bootpatch-SLR currently randomizes most of the
> task_struct. A few fields are exempt from randomization because of
> current implementation details (see v2 cover letter).
>
> Bootpatch-SLR requires a custom toolchain based on GCC 16.1.0 and GAS
> 2.46.1. GCC is extended to provide access to COMPONENT_REFs that are
> usually folded inside the parser.

How does this impact codegen and optimizations in particular? I suppose
keeping individual field offsets patchable results in missed optimization
opportunities? E.g., GCC may combine adjacent struct member accesses.

It would be good to get some numbers in terms of code size increase in
general, as well as I-cache efficiency on some representative benchmarks.

> The custom GAS provides the new
> fieldlabel feature used to annotate encoded instruction patch sites.
>
> An example for the fieldlabel feature is:
>
>     movq $fieldlabel(8, .Lspslr_ipin_42, .Lspslr_ipin_width_42), %0
>
> This causes the custom GAS to put the .Lspslr_ipin_42 label directly
> onto the bytes encoding the immediate value 8. It additionally defines
> the .Lspslr_ipin_width_42 label to be the size of the immediate field.
> The metadata emitted by the Pinpoint plugin directly references these
> symbols to specify exact patch-site locations.
>

Does the fieldlabel feature have any other uses? Or is this only for
SPSLR. Could these changes be extended to DWARF metadata generation too?

For example, it might be useful to be able to capture the SPSLR seed
(assuming there is one), and feed it into a host tool that can generate
a matching vmlinux.elf that you can load into the debugger.

