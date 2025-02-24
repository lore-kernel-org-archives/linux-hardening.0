Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BD41D6DB9
	for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 21:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740432261; cv=none; b=dMq42V85cHxJgd+hIY0j2tawWtu9Vmk2UWkOCgxxjzv77M1cR1tdm5PAHDf0/GWEeSuoXbS5LUMnCeRPf6b4y+LsnWVE6a+jPXATsOQKxl50m4eZBJSLqdAbaIE6INRC+LTWwEXiKGx77gemRMsaWMhiKEBIrlrwpSbOAuQJeS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740432261; c=relaxed/simple;
	bh=bEDCYKhvga/mKYUVmOKtSTNWxEWhshTpD85PfZW1ikg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Q+zhBxHF0lSDor5YwQosqO3AACB7nNX23ldEec7yBideAPKufV0tGkafcZ0EqwpXQHDJY6OR5ihuz0vSWKSIq3Og9+SN8P7i00crdyd9mUe0sbBLG90BYfUfa9KMsVUTggoMjCpsv58RFOFPvWsHHfuN7nzKoziNredOVHMqBHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Vfe8WNU1; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vfe8WNU1"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7231e216a06so811911a34.2
        for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 13:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740432258; x=1741037058; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6iVakU+60mPaapVIM2KyzfWT5FktcIRYWFJxMwHmNA=;
        b=Vfe8WNU11bANwf08zC1km1SFNjh/q26f+pkpUsyz8Zw3ka1FZqKV6iss9zE7wUuVOm
         C+GzB8hiV3+dviJbwSyWUrcCPeLmgUU8rlI/bZIcCoTH5AWZ4RLoQ7MP1JPrhSIW1Ncq
         LnPa43X022L3/+kRX/wxEGdeM6iOUGMC80wFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740432258; x=1741037058;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6iVakU+60mPaapVIM2KyzfWT5FktcIRYWFJxMwHmNA=;
        b=fuI/VkMTXIeDMeDdP8jGrmF2g6q8paaMUd6cmU0ZQm9G77S6Sc09kgnyuXU4+k1oM8
         f5tBPdpwlhmc0Z55gdFCCHQy0Yz7SsEl+AoT5Z1EHHHyd9zglBFW3NlqbayqPmRhmeLi
         EMqiqt/W9ODD7MTueTwZ3yFxjBFpWUBAf3nnnDUtPH5HclPy5nwZyeAe6JJ0pVHqMI8V
         36iPHbUXpz08CDAZdRF+yS/JTsmsVKNjd8pNX63ZYTKpfJyuqSK9ywuXp/XT6DTsV4oN
         2Puqw4X/sNgvr78Sm2tp1HbfHAL4x7AZQc/VD9gWBJ/xCg6cSDeHAd2yG+omAjUAaEdO
         RupA==
X-Forwarded-Encrypted: i=1; AJvYcCWIbQrm8InRcP5qp8rEuqGmq7lMuRtHUpGMwYgn8J2emaQyQwtECcULEgL5ADlISO0zAYJXIc7IRgXB5e5aRmU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp9h3QgUGYPYroNKfcBknWvo+XhJ5SRXhAMtsCyIzKc+5+jW3Q
	/xx3TpraA156gMUHtg2PYpWuHGGGk6vNBKrN2TppgIcrOzURbGUxbCYKlJKNlubCopR83U/Li33
	KeBg80hkgdwdj5m5W03ulCZ2WnOq9gS5KHOn4
X-Gm-Gg: ASbGnctTYk1dp4puE8BKs2yzLY3gMsQw7vOxARwhM0y2aMWSeqI7F7uF9B0cq0dRugS
	duuP9r6lXmXf0Ys2W/emf4uKnllkoc8sIiLvdZUFmfHwEBsfVh5rYeMp7FcKrhO3dp1JL50pN4L
	fwR01bHLq3ugNN7DSFbuL9GOL0aeaRVRgZdE4/
X-Google-Smtp-Source: AGHT+IGMjE2zpqlEIxhyMnwPoWpVAV8akw2/JtJyPdliPxKUHbc3QQ+N1vzjzgPsyyVVDxpLrkNwME4I1eTncXfPbtI=
X-Received: by 2002:a05:6808:1313:b0:3f3:fbed:9ff6 with SMTP id
 5614622812f47-3f4247be049mr4586259b6e.7.1740432258593; Mon, 24 Feb 2025
 13:24:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224174513.3600914-1-jeffxu@google.com> <20250224174513.3600914-3-jeffxu@google.com>
 <6oak6ibdf7yxan3cos3brcqojgjeud4rhlii5nlrlmu7lckalk@zypcm67ac2vk>
In-Reply-To: <6oak6ibdf7yxan3cos3brcqojgjeud4rhlii5nlrlmu7lckalk@zypcm67ac2vk>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 24 Feb 2025 13:24:07 -0800
X-Gm-Features: AWEUYZlrQK862CQsES86S0aPmYhOQ_SB2BdR_3R20vQplfaNi9olgHcBYg1SjhE
Message-ID: <CABi2SkVyOj_nxHnj6RueCoADVbQY1tpz-GbH1Y9pu6qdZ5OMZA@mail.gmail.com>
Subject: Re: [PATCH v6 2/7] selftests: x86: test_mremap_vdso: skip if vdso is msealed
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, jeffxu@chromium.org, akpm@linux-foundation.org, 
	keescook@chromium.org, jannh@google.com, torvalds@linux-foundation.org, 
	vbabka@suse.cz, lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org, 
	oleg@redhat.com, avagin@gmail.com, benjamin@sipsolutions.net, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, hch@lst.de, 
	ojeda@kernel.org, thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
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

On Mon, Feb 24, 2025 at 1:05=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * jeffxu@chromium.org <jeffxu@chromium.org> [250224 12:45]:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Add code to detect if the vdso is memory sealed, skip the test
> > if it is.
>
> It also skips the test if fopen fails on smaps, but maybe that's super
> rare?
>
If we can't access /proc/pid/smaps, that's an "environment" issue
unrelated to this test, therefore skip().

> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  .../testing/selftests/x86/test_mremap_vdso.c  | 38 +++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >
> > diff --git a/tools/testing/selftests/x86/test_mremap_vdso.c b/tools/tes=
ting/selftests/x86/test_mremap_vdso.c
> > index d53959e03593..c68077c56b22 100644
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
> > @@ -55,13 +56,50 @@ static int try_to_remap(void *vdso_addr, unsigned l=
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
> > +             ksft_test_result_skip("Could not open /proc/self/smaps\n"=
);
>
> fork() below prints errno, should this also print errno?
>
Sure.

> > +             return 0;
>
> I guess the logic here is that you might fail later because it's sealed
> but you don't know?  Is this rare enough not to matter?
>
yes. We should check the "sl" flag of vdso before continuing, or the
results will be unpredictable.

Android currently includes this selftest. In addition, you or someone
commented that  the selftest framework can randomly turn on kernel
config and run selftest, so it is necessary to add this check to skip.

> > +     }
> > +
> > +     if (vdso_sealed(maps)) {
> > +             ksft_test_result_skip("vdso is sealed\n");
> > +             return 0;
> > +     }
> > +
>
> This file also has an #ifdef __i386__ later,  Using it here would
> prevent unnecessary scanning of the maps file.  Probably not a big deal?
>
> Do you need to close the maps file?
>
OK, I will add close for good coding practice.

Thanks
-Jeff
