Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDBE51FCCB
	for <linux-hardening@vger.kernel.org>; Mon,  7 Sep 2026 16:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788799484; cv=pass; b=ID14MrZodSaSJPZDyH0ut0UMwkQwDL6JatJnBNZ/s5aj0NLgIXHwQmyxPNJjU3WYvhmXSN2ok95UMBbMnmGBuZluT4JZqTlrmJCqo5B3oStkYAKkc7DK1/3rhIn4e7RXvpD9Wu41hDB5S/RrdVhJMoskeI6ReOKdoSRMAvTopgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788799484; c=relaxed/simple;
	bh=hu54HuHxaG9TzaXr27h8viqIU9/+3WJ0xcFwySTlB+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fLSWQxHSrdFC4dbbc8h8Hpvk5VHlrYhFL3fte0Y0YMU5zVuJMkLs2nQxeENrwz7+5zKmCGBBMZvoOsQ5U1Auh9qaDtreVT2fIB7pVkjhR91gWjILxF22gbI148bRTOYfhEKES3nkN+t5n9OsTP5GqSY+5X34F1bgR9tKAmdsfrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com; spf=none smtp.mailfrom=yjn-systems.com; dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b=vA0uAOFV; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b="vA0uAOFV"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4843e9c5960so3727890f8f.0
        for <linux-hardening@vger.kernel.org>; Mon, 07 Sep 2026 09:44:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788799480; cv=none;
        d=google.com; s=arc-20260327;
        b=FRzZxJT9wGsB8SBaRjNg8RjiNmIQAwUKLW+5RMWVaeDBp9mHZAHCm+xsTho2ETIRly
         25rWwIErez2qUiPmpVkRORwRVAQgcBjdC23AslnwEv4d18Qp6hmUdILCHj+MyAjy/9JX
         YhXw3AjQnCfvi3jz/fI/TuggGTXIEzihR1IEGRBeT4KVxU6guvYG96wpivtl6wn8kzZy
         fAD3iExHbrZvh2GG1cwHbscpPT6QPlJrbCgMv5k5pI3QUIOo8hbDyyah3ipYt+BTORSM
         N37pxqO/WhQEqmC2i98tw73aVoS5on736XjaHebEDkpknPik+ILeAeDCOiR2MXzXkvJ2
         Ne1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=no2JTz+593dP2LvPf64iCF24x/Ni6xuZ4pzBDxKo+RM=;
        fh=xOzpoQAPeuQWO9slhjb5r5h33wBvJWs1Gk0e9jwpkro=;
        b=YtddRCdKAVQZd5nL1s90Shie24HS1Js/0YmHPh3kDEVjXcY9OzPGGVrPWHMJ2Fh7Pa
         G64iqWF53YcOKO9fxZ13PHyzQ7vif/RA1djTVr77U3xNxI9F3vLPn2Tf20hwFtDjz+Sb
         IZL94kRY4qgbnnXYK1XVI1bHs6Exaot1RQQgHzLwDajLfbboJCzwYaE1FZRF0c4WQHUn
         Ve+5s1RhoYSMsljF7RzoQvCJiSQORWLnPqtcenGXqNH/BT46B9fPdq/lIINr/Yu/W5Jd
         5SzlPII3SJku/cVpwqUKDxFcRjoPMPx8BX2hMy5nazEg1wIW7CCaTYkbdRmpituMGwFU
         /Zyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yjn-systems.com; s=google; t=1788799480; x=1789404280; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=no2JTz+593dP2LvPf64iCF24x/Ni6xuZ4pzBDxKo+RM=;
        b=vA0uAOFVN6M7Ffwq/pEtX7gwc2H4wMNjj/k331ZHi0mYvXKdw2j2fOEVmkk0e2+Mfl
         B9fq7fF9bph/IJRsEq/MruTkEe57jsvAzIYOfRAafL+8OH5KM4fmbmV2HOAn/4cfJ0uV
         Fa3wg/aJqpiCYYbpI2ZScKB5XN4EqtQKOsSsD7XCJzcPlgmk15IPhzNYWxSCf+AhKUg7
         GCEqzierDBRJsExmO++NYZ0kdTclGcpUlfzjT3wBpL87krqJS7uZk2gzg/Wl+pDDG9vR
         gA2jjuYEFsX2ravYgc2ztaPsB1X/kUHy4FVVrmMOro05zsbrb0HvdiU/A9er0mDrUTx5
         Ct9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788799480; x=1789404280;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=no2JTz+593dP2LvPf64iCF24x/Ni6xuZ4pzBDxKo+RM=;
        b=kNDTQS/mHAp+aj/bAkz8bIgyh7/B427130LcJ90aLeEzR5m+jQMZ2eydt4HXe2m8TY
         UY0WasDqiWRktpFgm1DFgXqtQvVVMykBk+JwlrMxjxffnkQ5v9NA3irFGlEvrbzrhBgc
         CW1SsYSWw/1JgYKhmeF/T/X4y4eg//pUSSSgZ1TZxQD6HuZsJMOo8tZ6eNtf71SLewaI
         iIinvrerWCXP/Mel654oxQScb5tEN4t3lkWpjB1eHB8Km1SOnmGQ94y0CWBgiA6mbkSh
         N7o8eKXoBe2fQpFlvL2y/zJQFfwi/xUAZYc7/tXCLFXf+c+PMizPGyNcOFJuTNiUmYZH
         pP7A==
X-Forwarded-Encrypted: i=1; AKwUvByZGShvqT/AgArChnwC8p6cJmhnBYxOrHDfwf61wD2B5If9KFPihwWxg6Kay3Xgw80dL8d6YI8cKpzLddh/1Zg=@vger.kernel.org
X-Gm-Message-State: AFuF++lVUwa6gV5WRXnvEKR7zNVJL6NilUij82w0F5VLY0XHcOQi+bi+
	CCPMC6k0pIUmr3UaMbohid4k9zA/A6oNgA88dLsu8ZrVBtb40XHUwVj7YIWexPUg8G09JPenlL/
	HC0JZCVbA+Rp3taQmEtd4IAmBPzR+WequHonx3d9rFRc=
X-Gm-Gg: AYBFou3u+eo6Tx7y/7GS7ZiHEmVSj9yj4Z9m2AcieJv2+y0Kuqq596gqBgCzVGbHcsT
	kZZWHhyEk6o9f9Z24qz+ZDpXaclsu7F8HgmjuIQXfb0MsSAAA88JEaNGkBaayRDaA3nJx/CHITR
	nRLCf+RZO0sI6YSAWfR9gIQtOCptBNFHknAyCl/dPLC5jrpeh86xQeHtbqmMnvXj7EgIdWHV29P
	jfo7av8mp2e5jQQOrqrWE8fbPd3LCOjNRgedTfSZxTKnaBFkLvlJUYFRM2Vn9cNoE4csQeDNXvN
	NSz9ug3jaDoDCOrSMLw2lv1QWnxoo7pAkKhfcWK6hclZKkl54Fl7Tb9+xJN10OLg8QBw0CDLDpQ
	=
X-Received: by 2002:a05:6000:4304:b0:484:3313:fd86 with SMTP id
 ffacd0b85a97d-485872d6572mr28878501f8f.27.1788799479962; Mon, 07 Sep 2026
 09:44:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902233338.i.375-kees@kernel.org>
In-Reply-To: <20260902233338.i.375-kees@kernel.org>
From: Jasper Niebuhr <yjn@yjn-systems.com>
Date: Mon, 7 Sep 2026 18:44:28 +0200
X-Gm-Features: AcwNN1WpoAzs5bQuXOBErpPne_vm3xlt1x9dSUSeK4h4vWSeoZ6T3aoNB79zlM0
Message-ID: <CAMjCObuPsTDLt5P7H_=K26bw5HcwFgithDn6yyCRz9ax63rGLw@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/3] SPSLR-v3 cleanups
To: Kees Cook <kees@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, franzen@sec.in.tum.de, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Resending to all - I accidentally replied to Kees earlier.

On Thu, Sep 3, 2026 at 1:33=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> Hi Jasper,
>
> I finally carved out some time to build, run, and test this. It works! :)

Hi Kees,
Thank you for your review and fixes, I am glad you got it to work!

> - "Boot Patch SLR" vs "Self Patch SLR" confused me briefly. I think the
>   whole thing should be just called Self Patch SLR?

This naming happened because I usually differentiate between
"Selfpatch-SLR" for the user-space implementation, and "Bootpatch-SLR"
for the kernel version. But 100% of Pinpoint and about 95% of the runtime
component are identical between both projects, so I just copied them over.
I intend to eventually propose the compiler portion to GCC/Clang people
under the "Selfpatch-SLR" label, and not frame it as kernel-specific at all
(works for web servers, daemons, etc. too, and might make it considerably
more attractive to upstream in compilers). Beyond that, I wouldn't mind
either name for the kernel integration and runtime. At least for the next
versions, I'll make sure to uniformly use "SPSLR" to avoid unnecessary
confusion.

> - I was expecting this to build on randstruct, but I see it's making its
>   own choices about things. I was expecting SPSLR to attempt to randomize
>   the same things randstruct targets, but it seems not? E.g. It looks lik=
e
>   you're trying to randomize the _entire_ task_struct instead of just the
>   substruct within that is marked with __randomize_layout. And since you'=
re
>   doing your own struct randomization, there some thing missing here, e.g=
.
>   trailing flexible arrays, auto-randomizing all-function structs, etc.
>   And as part of not being built on randstruct, probably the Kconfigs
>   should be mutually exclusive. :P

I figured there is no benefit in running randstruct under this, and there i=
s
not much overlap in functionality with randstruct either, since SPSLR does
not actually make any changes to structs at compile-time. I would have
reused the Fisher-Yates shuffle, but I needed an algorithm that can handle =
the
constraints imposed by the actual compile-time constants (like struct size =
and
fixed fields). Turns out such algorithms do not really exist off the shelf,=
 so I
wrote my own, beyond messy, and slow randomizer with an O(n^3) runtime
complexity (task_struct has about n=3D200 fields).

I have plans to circumvent the constraints by no longer allowing individual
fixed fields (which I needed for development convenience, but not really fo=
r a
final version) and padding the randomized structs to their worst-case
layout size.
In the case of a defconfig task_struct, this padding would add 320 bytes to=
 the
usual 3264. It adds a lot less to more homogeneous structs, and 0 to e.g.
pointer-only structs which are always the same size, no matter what order o=
f
fields you choose. In return, it would allow the runtime to use a normal Fi=
sher-
Yates shuffle. This would reduce the current randomization overhead of half=
 a
second or so to almost 0, and shave almost 500 lines off the randomizer.

Regarding the substructs: v1 and v2 actually randomized the substruct, but
the sanemaker_target_tag trap introduced with v3 needs to refer to the type
that is being randomized, and I wasn't sure how to make that work with
anonymous nested structs. For v4, I am probably going to add an optional
handle string to the spslr attribute and have the sanemaker stuff refer to
those handles instead of the types themselves. That way, v4 can go back to
randomizing the nested struct.

> Anyway, impressive work! I'm looking forward to seeing this continue
> to expand and getting the self-reference pointer stuff fixed and the
> offsetof() stuff working for BPF folks too. :)
>
> -Kees

All the issues I didn't just explicitly address will be fixed or mentioned =
again
in v4, thanks once more for pointing them out!

Best,
Jasper
