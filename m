Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12F321D3C9
	for <linux-hardening@vger.kernel.org>; Tue, 25 Feb 2025 22:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740523080; cv=none; b=uDY/WkmG4B9Re4t/DDfVsj5vkctps1VeUw+HeFLX3XBaTGoPtjcma0vlVeQMUDJ9JRMKajz9S1OaVOfNHttPw8gsHiInUxp+QSe+6XiN9lULwWCbt76OKBcv5KG+pF8ys/ucUvjQlJK1Wa4Wq4fvu0wPOJX70Te+T/hqUgziZyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740523080; c=relaxed/simple;
	bh=aXrabKXlM0IsIZuDH6QT6eCKq7zU4WZZRKh8RcjzM6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dsx+TLkkUGSvRIqxcCponbMqlRy1L2n2hUks0qtvFpKA9VEYBr9+6plDUgyFlcCRxl/Lyftvp6fi9o1YHpk+Fvk0ZHCbmzi6I8i4IZ4A66gSYQmiyeOyoC0QnIdhraLMKSip9RFQTYh6Etf9gCJEcvDfp6pmUoanUKBN40mjWxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cSf1Negk; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cSf1Negk"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-724daedf8c3so1567736a34.3
        for <linux-hardening@vger.kernel.org>; Tue, 25 Feb 2025 14:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740523078; x=1741127878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TM09Vy3kN6bqyw39MdyhtNezW+WJUnfi9H/ALFTk9Q8=;
        b=cSf1Negkg/Ryr7WSJ7S2yPded28YGB1f25ttqVD5kxbAWuN/9ZDbl0nEquaFuQdHOJ
         PxDToikmLTU6tcQdLvsazmQj9ZuU86fblBps8Ezk0CFo0hOILvJe9sV8WbSFW3WwZ0DH
         NlbLEI8ukfOmVqJ3qEBQxzUAqSJefCFg46yxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740523078; x=1741127878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TM09Vy3kN6bqyw39MdyhtNezW+WJUnfi9H/ALFTk9Q8=;
        b=TFNs34o3Lm/CZCJmTaZaJuf2dlXTqbJ9NKmGZmc+xXOtgap/kUuqT8TAEFU7l0QX+o
         103KmJzkkoBJi6SkRwDk5mOnvkL9GMpVIo8mTDIAuVPDtkMnGpDT+OJsf7/uIpcsTrPx
         3gEkNAsQebNYZIz82zou/dGQ26bWlfEOzkjYRrINv2vFnpEzipnbvaO1xixwxuULoxaj
         fhct7i9ujMtFMqUPMarE75Sy9QPBqeidQWfWSRw56oqUjPG6bbi/JQBAQB3Vs059ULD+
         y4DYX4V/wy/Yj+FtPlUgOIOE/PaNqsvPhxryP8hAWuO6L7AEyIC5Si/QcpDLOOs/6Ujr
         OhdA==
X-Forwarded-Encrypted: i=1; AJvYcCV2Bt5AjYumOZsuNvBbdtKB4XnLAAykqDnb0Db1ud7ASkglfJqe9wj1AHryNekrZgARNIhFgVUcS1tRzNKeT88=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKe/SbqAVoZH0HaLA8gEqlwAVlJs/6KxmupJra7yA5knNMFiFp
	7dLvV5+sV1HCzxavhr/nGp5fxywGRtB8H/eEGhsrC5H+UXDFuvDxAT8rO1inFXBtuOkfGonjPX2
	9bAr+X7/g3GAsEUI1HjDZKSN+HMxLsIyFM1II
X-Gm-Gg: ASbGnct5Xe428xpyyNljJgS9VPLKHMJF3LYsFGBeAfU5tFsUySxgTUKd5GNPEzk38pG
	aBX6qZPgPStn0ZEvrb/FkoXBeoSZNiAT2rp6bXCivgt2YRHGnYjY9mHPcs9VKw9fN5tJW9I4P7e
	Srf8iFMBgi0fJDwTIhBBJ3g3fsH8aRAN/U2SI=
X-Google-Smtp-Source: AGHT+IEpcvXgYiPClCySX5ynQ10F8Hy35U+lAZUo00/td8VvueGsr0yfG4XsKHGe1Drl9rCIX+ro1GOLwaDthyw6wO4=
X-Received: by 2002:a05:6830:3106:b0:727:2b73:cbb7 with SMTP id
 46e09a7af769-7274c257d4emr4278353a34.4.1740523077707; Tue, 25 Feb 2025
 14:37:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224225246.3712295-1-jeffxu@google.com> <20250224225246.3712295-3-jeffxu@google.com>
 <f300404f-91a9-40ae-8fcc-2e855b43ac76@lucifer.local>
In-Reply-To: <f300404f-91a9-40ae-8fcc-2e855b43ac76@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 25 Feb 2025 14:37:46 -0800
X-Gm-Features: AQ5f1JoKtUHhlK-Y7z-DtFO5DD67q41dfSZq435LKdak_34AMb1q5CdQGGx9fmY
Message-ID: <CABi2SkWXvc0p5u+AwFEHXVM00nX=n3ROKwEp8RaYWEZ-3-n5sw@mail.gmail.com>
Subject: Re: [PATCH v7 2/7] selftests: x86: test_mremap_vdso: skip if vdso is msealed
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, 
	willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, 
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, 
	mike.rapoport@gmail.com, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 10:15=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Mon, Feb 24, 2025 at 10:52:41PM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Add code to detect if the vdso is memory sealed, skip the test
> > if it is.
>
> I feel this is a little succinct of a commit message, but I guess it gets=
 to the
> heart of what you're doing here.
>
> Fundamentally I mean it makes sense, but I'm concerned that x86 has a tes=
t
> -expliictly checking- whether mremap() of VDSO is possible - are there ca=
ses
> where x86 might want to do this internal to the kernel?
>
> I guess not since this is essentially a userland self test and probably
> asserting you can do this in the way rr, etc. do.
>
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > Reviewed-by: Kees Cook <kees@kernel.org>
>
> Anyway, this aside, this looks fine, aside from nit below, so:
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> > ---
> >  .../testing/selftests/x86/test_mremap_vdso.c  | 43 +++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >
> > diff --git a/tools/testing/selftests/x86/test_mremap_vdso.c b/tools/tes=
ting/selftests/x86/test_mremap_vdso.c
> > index d53959e03593..94bee6e0c813 100644
> > --- a/tools/testing/selftests/x86/test_mremap_vdso.c
> > +++ b/tools/testing/selftests/x86/test_mremap_vdso.c
> > @@ -14,6 +14,7 @@
> >  #include <errno.h>
> >  #include <unistd.h>
> >  #include <string.h>
> > +#include <stdbool.h>
> >
> >  #include <sys/mman.h>
> >  #include <sys/auxv.h>
> > @@ -55,13 +56,55 @@ static int try_to_remap(void *vdso_addr, unsigned l=
ong size)
> >
> >  }
> >
> > +#define VDSO_NAME "[vdso]"
> > +#define VMFLAGS "VmFlags:"
> > +#define MSEAL_FLAGS "sl"
> > +#define MAX_LINE_LEN 512
> > +
> > +bool vdso_sealed(FILE *maps)
>
> Should be static?
>
sure.

> > +{
> > +     char line[MAX_LINE_LEN];
> > +     bool has_vdso =3D false;
> > +
> > +     while (fgets(line, sizeof(line), maps)) {
> > +             if (strstr(line, VDSO_NAME))
> > +                     has_vdso =3D true;
> > +
> > +             if (has_vdso && !strncmp(line, VMFLAGS, strlen(VMFLAGS)))=
 {
> > +                     if (strstr(line, MSEAL_FLAGS))
> > +                             return true;
> > +
> > +                     return false;
> > +             }
> > +     }
> > +
> > +     return false;
> > +}
> > +
> >  int main(int argc, char **argv, char **envp)
> >  {
> >       pid_t child;
> > +     FILE *maps;
> >
> >       ksft_print_header();
> >       ksft_set_plan(1);
> >
> > +     maps =3D fopen("/proc/self/smaps", "r");
> > +     if (!maps) {
> > +             ksft_test_result_skip(
> > +                     "Could not open /proc/self/smaps, errno=3D%d\n",
> > +                      errno);
> > +
> > +             return 0;
> > +     }
> > +
> > +     if (vdso_sealed(maps)) {
> > +             ksft_test_result_skip("vdso is sealed\n");
> > +             return 0;
> > +     }
> > +
> > +     fclose(maps);
> > +
> >       child =3D fork();
> >       if (child =3D=3D -1)
> >               ksft_exit_fail_msg("failed to fork (%d): %m\n", errno);
> > --
> > 2.48.1.658.g4767266eb4-goog
> >
