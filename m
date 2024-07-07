Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640FEEDC;
	Sun,  7 Jul 2024 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720365734; cv=none; b=ADK6L8qj+zgBD9V+AZ2sgZeF36GJ8tuxWOW6bYSPn+S1f+y7EPH6KiHKZ2IgNum1noVZfseQfksPNwjGW/gq1LqiHFZSkLYLoD1h2OJi85+bUdY5DOjp9NiWIb+V3o6UdyVUC6CGMF2ebHmz6S4otuzsQGOmfVW2fZYt2+ZNv3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720365734; c=relaxed/simple;
	bh=tmXvznDulf9bw8t1c6IsEHMz46Iiva662nh3Y9tT0aE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=i1TKySvsRYkHb6CH0vK3QhhMY3WFrW0gw1D0wdO2VaVFkNcCEGETvjVHFfaGlQr+ZAXomQ6zB/qcXMgX/YinD+2bUHzFrYmxs1aDekTD+Y1LblnIlT9BfKo17r0aUk3JtqNYZAA8MMRKSFaBGlRPgVcg46WjfVyN+xR67rkc+oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5SSOY74; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5SSOY74"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C57AC3277B;
	Sun,  7 Jul 2024 15:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720365734;
	bh=tmXvznDulf9bw8t1c6IsEHMz46Iiva662nh3Y9tT0aE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=B5SSOY74qYG5DLdwzkTGwVb0XVucLP4eHp+Y5Q/0/pNXCVSpbcpBEWVy1wnzivMIa
	 +5+gJxhq7H2IexxQ0cepAVSj74tIGUuvd/aV4rSTWO9LHK9ly1nVcOTK6NdXz8o/4/
	 AlJ37XDlVb5o/s1p9TmCaCizwulq1WnbpxIkgZS4xxqJERNWDiIzj8gpSAUEhbjh3D
	 AB3CtVOVIXQ6mNNT6hgwY3j912JwhQPz4zATZIIwH95OsBthqkx3vqHF8lH4h7tJ4e
	 JmG/YY/IWd2vTtLQM45SWVAEOWdF/j/RuhV7B1e/JTu5uSediYwvhEkdxU2eVXFWMA
	 FvL3yGwLOj35w==
Date: Sun, 07 Jul 2024 08:22:13 -0700
From: Kees Cook <kees@kernel.org>
To: Mirsad Todorovac <mtodorovac69@gmail.com>, linux-hardening@vger.kernel.org
CC: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
 linux-kernel@vger.kernel.org
Subject: =?UTF-8?Q?Re=3A_=5BPROBLEM_linux-next=5D_include/linux/for?=
 =?UTF-8?Q?tify-string=2Eh=3A580=3A25=3A?=
 =?UTF-8?Q?_error=3A_call_to_=E2=80=98=5F=5Frea?=
 =?UTF-8?Q?d=5Foverflow2=5Ffield=E2=80=99_declared_with_attribute_?=
 =?UTF-8?Q?warning=3A_detected_read_beyond_size_of_field?=
User-Agent: K-9 Mail for Android
In-Reply-To: <9b69fb14-df89-4677-9c82-056ea9e706f5@gmail.com>
References: <9b69fb14-df89-4677-9c82-056ea9e706f5@gmail.com>
Message-ID: <3639BC84-F533-45A6-AB7D-CABA1A1673EF@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On July 6, 2024 5:26:25 PM PDT, Mirsad Todorovac <mtodorovac69@gmail=2Ecom=
> wrote:
>Hi, all!
>
>This is the result of testing randconfig with KCONFIG_SEED=3D0xEE7AB52F i=
n next-20240703 vanilla tree on
>Ubuntu 22=2E04 LTS=2E GCC used is gcc (Ubuntu 12=2E3=2E0-1ubuntu1~22=2E04=
) 12=2E3=2E0=2E
>
>The particular error is as follows:
>
>In file included from =2E/include/linux/string=2Eh:374,
>                 from =2E/arch/x86/include/asm/page_32=2Eh:18,
>                 from =2E/arch/x86/include/asm/page=2Eh:14,
>                 from =2E/arch/x86/include/asm/processor=2Eh:20,
>                 from =2E/include/linux/sched=2Eh:13,
>                 from =2E/include/linux/audit=2Eh:12,
>                 from kernel/seccomp=2Ec:19:
>In function =E2=80=98fortify_memcpy_chk=E2=80=99,
>    inlined from =E2=80=98syscall_get_arguments=E2=80=99 at =2E/arch/x86/=
include/asm/syscall=2Eh:85:2,

memcpy(args, &regs->bx, 6 * sizeof(args[0]));

Yup, this reads from regs starting at bx, rather than only bx=2E I will se=
nd to patch to expand it (like is done for compat mode a few lines later)=
=2E

-Kees

--=20
Kees Cook
