Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDED1AC425;
	Tue, 24 Sep 2024 17:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727199400; cv=none; b=q68T9K4nFtAPir8iBX9xDfKgNxgpKX/jEcOmX7ML53hNUSXWyVe2TsJHA1HoxQA8tKfTsjik2e9pfPcTTkyROIZ7Z6K1FLXqyjbrf5GCcKpphwMsWqEjjbv1EeOaeA20bVbgAO6ocn3GaoTGz03J1scDBOds9BiiiQ4SbNEqIWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727199400; c=relaxed/simple;
	bh=42THeqITHko78179pBW33IM4ih0htUdDUJDX7BHAVaA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=PDfx1nBicGKOUrI1e4TF1U1VYbYa8qIlsMJJ67wpjx8gFWiHdhb21BvyVGnKofQGvbvfv9o9aEpuah5zNrU3J4IkptrqLesRjF6E351GDfVUMuABtKrWyODpEEDcpl9aUuoHCJvqyhCMxvfBZQG02Yd4CNaysSkhHA8Q3HtSMBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHahNHr/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHahNHr/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5DACC4CEC4;
	Tue, 24 Sep 2024 17:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727199399;
	bh=42THeqITHko78179pBW33IM4ih0htUdDUJDX7BHAVaA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=IHahNHr/RIRPaTGXXB03jHBMK8V9sysvoMq85QjK/CNKTfee3hTyH8X+fE/UL736E
	 l67Z1C2WP+WSb4Iw0zzwbqqtK6obuPRXXLPgvUcxxIm3p4OejFCvHq8USu8K+Js7r7
	 tgyFN3aJ1Kgy8uVOmzLnEuGU+u16kgWbj2Qk41AkBDVrVlDl9EREk9AKQtpoxwk0N5
	 YESouQVj2SwpBp7OfZdnFTix+9WOPh1oknQTYR5RsAMp8BSasldw2pKuIpAuduVUF6
	 /WzpjzUe+YLv2POIqj9LJgXYBHLsHflh7teQFBYTsmNB1ZZEqGmCBPFGSAlU8Rwrgj
	 QEQK7fqgAD0jw==
Date: Tue, 24 Sep 2024 10:36:37 -0700
From: Kees Cook <kees@kernel.org>
To: Jason Montleon <jmontleo@redhat.com>
CC: linux-hardening@vger.kernel.org,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 linux-riscv@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BREGRESSION=5D=5BBISECTED=5D_Cannot_boot_?=
 =?US-ASCII?Q?Lichee_Pi_4A_with_FORTIFY=5FSOURCE_enabled?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAJD_bP+6qCgseo9of-cKW3+nH_UbGFwPo6WRbqqcneOZ+EEtOw@mail.gmail.com>
References: <CAJD_bPJes4QhmXY5f63GHV9B9HFkSCoaZjk-qCT2NGS7Q9HODg@mail.gmail.com> <B2A62C7F-45BA-43E1-975F-5AF0197CD2C3@kernel.org> <CAJD_bP+43=XXD7p3fRfDxCbj=_YedgVLv38XO4iOAw94a+4PHg@mail.gmail.com> <202409221511.9AF49BD@keescook> <CAJD_bP+6qCgseo9of-cKW3+nH_UbGFwPo6WRbqqcneOZ+EEtOw@mail.gmail.com>
Message-ID: <800CC050-E858-409C-A565-A6EF430E1B25@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On September 24, 2024 8:58:57 AM PDT, Jason Montleon <jmontleo@redhat=2Eco=
m> wrote:
>On Sun, Sep 22, 2024 at 6:38=E2=80=AFPM Kees Cook <kees@kernel=2Eorg> wro=
te:
>> Can you try this patch? It should avoid using the "WARN" infrastructure
>> (if that is the source of blocking boot), but should still provide some
>> detail about what tripped it up (via the "regular" pr_*() logging)=2E A=
nd
>> if it boots, can you look at the log to find what it reports for the
>> "Wanted to write =2E=2E=2E" line(s)?
>>
>> Thanks!
>>
>> -Kees
>>
>>
>> diff --git a/include/linux/fortify-string=2Eh b/include/linux/fortify-s=
tring=2Eh
>> index 0d99bf11d260=2E=2E469a3439959d 100644
>> --- a/include/linux/fortify-string=2Eh
>> +++ b/include/linux/fortify-string=2Eh
>> @@ -549,7 +549,8 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_s=
ize_t size,
>>                                          const size_t q_size,
>>                                          const size_t p_size_field,
>>                                          const size_t q_size_field,
>> -                                        const u8 func)
>> +                                        const u8 func,
>> +                                        const char *field)
>>  {
>>         if (__builtin_constant_p(size)) {
>>                 /*
>> @@ -610,8 +611,13 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_=
size_t size,
>>          * https://gcc=2Egnu=2Eorg/bugzilla/show_bug=2Ecgi?id=3D101832
>>          */
>>         if (p_size_field !=3D SIZE_MAX &&
>> -           p_size !=3D p_size_field && p_size_field < size)
>> -               return true;
>> +           p_size !=3D p_size_field && p_size_field < size) {
>> +               if (p_size_field =3D=3D 0)
>> +                       pr_warn("Wanted to write %zu to a 0-sized desti=
nation: %s\n",
>> +                               size, field);
>> +               else
>> +                       return true;
>> +       }
>>
>>         return false;
>>  }
>> @@ -625,7 +631,8 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_s=
ize_t size,
>>         const size_t __q_size_field =3D (q_size_field);                =
   \
>>         fortify_warn_once(fortify_memcpy_chk(__fortify_size, __p_size, =
 \
>>                                      __q_size, __p_size_field,         =
 \
>> -                                    __q_size_field, FORTIFY_FUNC_ ##op=
), \
>> +                                    __q_size_field, FORTIFY_FUNC_ ##op=
,\
>> +                                    #p " at " FILE_LINE), \
>>                   #op ": detected field-spanning write (size %zu) of si=
ngle %s (size %zu)\n", \
>>                   __fortify_size,                                      =
 \
>>                   "field \"" #p "\" at " FILE_LINE,                    =
 \
>>
>>
>> --
>> Kees Cook
>>
>
>Hi Kees,
>Sorry for the delay in responding=2E Your patch also caused the system
>to hang booting, but I took it as inspiration to try some things=2E
>TL;DR I see these two print several times:
>
>Wanted to write 8 to a 0-sized destination: oldptr at
>arch/riscv/errata/thead/errata=2Ec:185
>Wanted to write 28 to a 0-sized destination: oldptr at
>arch/riscv/errata/thead/errata=2Ec:185
>
>Since I suspected CONFIG_ERRATA_THEAD_MAE which relies on
>CONFIG_RISCV_ALTERNATIVE_EARLY I suspected it is just too early for
>pr_*, etc=2E I tried trace_printk but that didn't produce any traces,
>and then I found a comment which makes me think we're too early for
>that too=2E
>https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/torvalds/linux=2Egit/=
tree/arch/riscv/kernel/alternative=2Ec?h=3Dv6=2E11#n214
>
>I didn't want to give up so I wrote a simple module to figure out how
>to use sbi_ecall and then incorporated that idea into your patch,
>although even that was not straightforward:
>https://gist=2Egithub=2Ecom/jmontleon/f3536ad70dc92bed992139ad5b266d5c

Oh nice work! Probably something riscv-specific needs to be wired up to th=
e printk routines to do what you have there until printk is fully available=
  But that's a separate issue, I guess=2E

>Full output: https://gist=2Egithub=2Ecom/jmontleon/823facff38e28b717f153e=
38adcfd7fe

Does the system boot with your patch?

I would guess that this line at arch/riscv/errata/thead/errata=2Ec:168:

void *oldptr, *altptr;

Should be:

u8 *oldptr, *altptr;

But maybe __ALT_PTR needs adjustment too? Hmm=2E I would have expected voi=
d * to have a size of SIZE_MAX here, though, so something else might be con=
fusing the check=2E


--=20
Kees Cook
