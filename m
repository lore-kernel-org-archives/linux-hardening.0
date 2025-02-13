Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56D9210F4D
	for <linux-hardening@vger.kernel.org>; Thu, 13 Feb 2025 22:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739485216; cv=none; b=N69I1owKNpVqufrvpolIVLcEd9xg2VJPe/UIB1IYapHX7EJjH/3CsBE9rZgxIcV0M8RwaJKP6zFW/GRxKYq0EfbTOuLHdUv6uyFQJV0A4m6j/2BIBq+16nT+RpBUdnMW//DEgyzhTbDCdKn2NGevTLYv83vpQNg8ksg8CWdQyXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739485216; c=relaxed/simple;
	bh=rkI2bgoqBjwvLXctY39v3PT6mQA1sS7b8DeXKPCOsfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WYX3l2TCOB4ckJqDc4WuSo+t/sDQVAF+d79vTFDZodCJ8J9rKG4xHBrPrj0ZR3RZOJlNP+/4AAF58paRa1lHx30JdFyMrRhUuxAb0RxHHR7t9G7h1F2YeDdwN2wwFdgdMhDnQ1aLdSEtJBNg7lxlJivU+TcYDFFvYXl3I8ynAbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OF3e67zR; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OF3e67zR"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3f3d8c0a2edso39504b6e.0
        for <linux-hardening@vger.kernel.org>; Thu, 13 Feb 2025 14:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739485213; x=1740090013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRaz9OxCEX01QL7HD6xXPMgP9kkUY8bY3eYmomXDOGg=;
        b=OF3e67zR/H0ZRabAn8rGGSroJXcpFSJ56aYKpIK6V488w+ANSUjA83QfpLPTKWLeBy
         qyvnAkofToppUrHUbc/cVghI1LcSjKTRclliSdOPcvj1uluqVWJgqaLWQSviCyLfsQcO
         idJ9DHzL0cPvZ0RcspRL4AzUAtbjidv042HaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739485213; x=1740090013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRaz9OxCEX01QL7HD6xXPMgP9kkUY8bY3eYmomXDOGg=;
        b=DZJsm4FZsfwP4M6bN+for+rOdpazQTvC0UpnvhQaEumdDI1UrHN/DpkN5s7fxfsVnT
         BgrDsEEVrs6urA+oJtIiJAXQBF2HENtPPTzbWWVCQEIrBJvaFXZ8SppENkAvyqTa35UZ
         RptIDFJK+MImAOUGY2vA0ymnct9EQohopS1bLi94yyeJCCLlTj3e5tni/78r/7JRgMJg
         192MvTSNpUXJ9Mwb+Jm8bvtn10niq4zpecvFUm8XODcthLhm0zIgPv8nS8hAWHSxzDvW
         zE1K5qPXhCQ48qBdiRT+WLnXn0kB5PLEzPNgPSS7sxe3K2q8tIWDynwJMgINyXJZp9TA
         K/7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+4ZdSj3IwfaVo+H2ShvNPcZOyJJLTFPUtYc89jl/ffEEDTLWCPXPiqzO6MjbRnM+aCAMh0jJsxwU3R3ZEjAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZp+yXVrjD9Wa+vj+GtITdpJvgIr71mwNVKpECLmTAHhc8X/56
	z+So4K8Oi8iZwef05JvBS80KSh4G3ajO35jKvl7xTuYFa2fwpu1LF9P9kN7resnTqyKZ+TyxbZ2
	nvjnKvKQJHIBIwzwpyHKLNQGc2khvA/68U036
X-Gm-Gg: ASbGncsdFX0U27AuhcDbWEhXPrJKK+PzQvO8N1mGQdiER4YqYEimPKiDZ2XngM6DInz
	SBfiVNHiwdE+8PlGblgl52i9JutnjHLWXeX+O1Q9GIwjlTng1pOS3wRgvl97xtDv4Fq3jHeDnq+
	wXt2HLx+KkNIZKSOCa9JAv3t/6ScQGxg==
X-Google-Smtp-Source: AGHT+IGEgr/tnpmZ7iFKLQkIbh+ChcL78omaiRk8B15Pn3sTe3eFnZc5dLwS9oc27svBh749EcdLfS07kL59waveuvE=
X-Received: by 2002:a05:6808:13c3:b0:3eb:45de:8ab5 with SMTP id
 5614622812f47-3f3e1a32cc6mr168816b6e.4.1739485212888; Thu, 13 Feb 2025
 14:20:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212032155.1276806-1-jeffxu@google.com> <20250212032155.1276806-3-jeffxu@google.com>
 <20250212135000-861e6353-6e0a-43c3-9b28-649ae4dfc607@linutronix.de>
 <CABi2SkUCviiTbd1roeBiqSk98S87R1WwSP9rUYh4t3JfSD+2ZA@mail.gmail.com> <35C0FD0B-0483-4663-AD60-701AB8D9247A@kernel.org>
In-Reply-To: <35C0FD0B-0483-4663-AD60-701AB8D9247A@kernel.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 13 Feb 2025 14:20:01 -0800
X-Gm-Features: AWEUYZli_FRMoDmTOv0oE_wQIaDl_68u_YOG1Uo7f717uYIA8g5CWTTkKASWsyQ
Message-ID: <CABi2SkU0kW8yAoucxLjkqXpFJMJzGDmKZZhgMJGobaALNVTGvA@mail.gmail.com>
Subject: Re: [RFC PATCH v5 2/7] selftests: x86: test_mremap_vdso: skip if vdso
 is msealed
To: Kees Cook <kees@kernel.org>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	avagin@gmail.com, benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, 
	willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, 
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, 
	mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 11:28=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
>
>
> On February 13, 2025 6:14:00 AM PST, Jeff Xu <jeffxu@chromium.org> wrote:
> >On Wed, Feb 12, 2025 at 5:04=E2=80=AFAM Thomas Wei=C3=9Fschuh
> ><thomas.weissschuh@linutronix.de> wrote:
> >>
> >> On Wed, Feb 12, 2025 at 03:21:50AM +0000, jeffxu@chromium.org wrote:
> >> > From: Jeff Xu <jeffxu@chromium.org>
> >> >
> >> > Add code to detect if the vdso is memory sealed, skip the test
> >> > if it is.
> >> >
> >> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> >> > ---
> >> >  .../testing/selftests/x86/test_mremap_vdso.c  | 38 ++++++++++++++++=
+++
> >> >  1 file changed, 38 insertions(+)
> >> >
> >> > diff --git a/tools/testing/selftests/x86/test_mremap_vdso.c b/tools/=
testing/selftests/x86/test_mremap_vdso.c
> >> > index d53959e03593..c68077c56b22 100644
> >> > --- a/tools/testing/selftests/x86/test_mremap_vdso.c
> >> > +++ b/tools/testing/selftests/x86/test_mremap_vdso.c
> >> > @@ -14,6 +14,7 @@
> >> >  #include <errno.h>
> >> >  #include <unistd.h>
> >> >  #include <string.h>
> >> > +#include <stdbool.h>
> >> >
> >> >  #include <sys/mman.h>
> >> >  #include <sys/auxv.h>
> >> > @@ -55,13 +56,50 @@ static int try_to_remap(void *vdso_addr, unsigne=
d long size)
> >> >
> >> >  }
> >> >
> >> > +#define VDSO_NAME "[vdso]"
> >> > +#define VMFLAGS "VmFlags:"
> >> > +#define MSEAL_FLAGS "sl"
> >> > +#define MAX_LINE_LEN 512
> >> > +
> >> > +bool vdso_sealed(FILE *maps)
> >> > +{
> >> > +     char line[MAX_LINE_LEN];
> >> > +     bool has_vdso =3D false;
> >> > +
> >> > +     while (fgets(line, sizeof(line), maps)) {
> >> > +             if (strstr(line, VDSO_NAME))
> >> > +                     has_vdso =3D true;
> >> > +
> >> > +             if (has_vdso && !strncmp(line, VMFLAGS, strlen(VMFLAGS=
))) {
> >> > +                     if (strstr(line, MSEAL_FLAGS))
> >> > +                             return true;
> >> > +
> >> > +                     return false;
> >>
> >> This only tests that any mapping after the vdso is sealed.
> >
> >The code above begins by searching for the "[vdso]" string, then looks
> >for the first line that starts with "VmFlags:", and looks for the "sl"
> >substring within that line. We're assuming the format of smaps won't
> >change from release to release.
>
> Oh, I missed this in my reviews: nothing _resets_ has_vdso to false, so i=
f any other mapping follows vdso that happens to be sealed, this will retur=
n true...
>
It won't return the next mapping's sealing flag.
After finding the "[vdso]", if the next line that contains VMFLAGS
doesn't have the "sl" flag, the function returns false immediately.

> >
> >> There is a real parser for /proc/self/smaps in
> >> tools/testing/selftests/mm/vm_util.[ch], see check_vmflag_io().
> >>
> >This test is in selftest/x86, which makes it hard to include the
> >vm_util from selftest/mm, if that's what you're asking.
>
> Hm, we have done these kinds of inter-tests dependencies before. (E.g. se=
ccomp includes stuff from the clone tests.) I think it should be possible i=
f it can just be a header include. Linking across tests would be more frust=
rating.
>
I can switch to vm_util, I will need to add a new parsing function in
vm_util, the existing __get_smap_entry() only searches for vm's
starting address, not name.

Thanks
-Jeff


> -Kees

>
> --
> Kees Cook
