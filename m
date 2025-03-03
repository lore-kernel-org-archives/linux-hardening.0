Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF4A22F16E
	for <linux-hardening@vger.kernel.org>; Mon,  3 Mar 2025 19:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741031230; cv=none; b=ALv5AR/5om5HAkYwFCB9sUzsQGrwvdr/E+uX/RKWYYRvPgiGZRjljfHRLkXfacesfFcGDAPaQzKI66iOjZp2kJC9hrnzYJ9k7/INK5CFcBGUDTQvjfIdaeSfnnSxqHRdhnmnAgbBIEegJFPFRxjwegLBsLjcsZkQZXyyomGuB0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741031230; c=relaxed/simple;
	bh=lNOWY3AEd2PaX0q988PiSl/WnNrCjfBJO5tvCJGKaAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gkc+SXrphPqtaFrJYlirJ/QQLUWicJh4u3yOsVFaByY989Dj2yRXV5R8ptnL0HP9Hx4beh7Mxlq5Rq9q1/h0whC8fIroA8dXSiTRTRzyh+LQY4Tvwg0zg9NV23Ru9fxb38qCizXx9IxFQO+cCpzQmji4syg81dRxjnD8qjF1qHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eFeMf9vB; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eFeMf9vB"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3f3ff8d7362so69660b6e.2
        for <linux-hardening@vger.kernel.org>; Mon, 03 Mar 2025 11:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741031227; x=1741636027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdySKNh+U/MozZaPGFIgSr4OVSnw7VsTVIZmgZPuEMc=;
        b=eFeMf9vB/IrRkhV0WyHNtUm0FUx2nT3K1+rCI5xfixrRaYyMv5/PMp1Gs2fI4V2LFN
         1VddJ5ZCP4PyZOcIPB4hhDbAdYDPJToDkiKjxtr9XnaaUxV7doqHLLa0dA7p2xxKfQJ8
         O+4tTXJTWMh+sVkGSS9Xmzl+Ttc5FfnY8RNkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741031227; x=1741636027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tdySKNh+U/MozZaPGFIgSr4OVSnw7VsTVIZmgZPuEMc=;
        b=PosYr7cDCKW1IsUI5xIGx6cqnKvzrbQnep+1ePjRzpTV/m7jL1m3e7njNDtUyKsXrh
         pewGmIfpkpBRTrs+SPaNIDz8zh400Ikqdcwv8QCWroA38mcGEqABCgE41oDfnND58som
         ThikFfqUGwACbENAPmMku2IwED2RAG9r2TogQUEbsSyz/3/lMnLU570Aqik8vay9z2PD
         qjDg7T2TBM5NT6ttZEYjH6N2xKBQV6LhYWhapQvawRKx+HaR4VMxAilNVOqEaYxs5Yth
         s/1bRMFuxMGuTr2+7rBbjapm9WRqG3vrbKC7kJu3xnVgFijvu4Z/oyc5Eflxlrhc76Qv
         dnSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU25P8d4BueLRgo2BxjrdRcsh88XNxzb5Z4tROnkzF7P14a/gFcnyr57xzRNGH4k4j/kFMdt+nK1W0mLu4uwJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx04n9n1KtcJPXEet1GU4ZiJwYSeGPqEkQci0o/jSU2lWMOqVLd
	y0lztQ56iisgHaMk/L5Vuc/0Yj8JxfEk14SUFD5VlizKuMe83D3zIyWZkbluts9Ms3mWP2FlDeD
	ynbglPNMBDkTdnO0VYtZ2Xtk4sJJvZp2/RBmW
X-Gm-Gg: ASbGncuyXM7tul2HQWN4w43eazV4WkOILlcSESjryoM25ooUKmedQ8naT79x/53pa5B
	YKjyfc3Y31MifQTgZJvYNUEpcPSMbrg6zjl8Gnn26g56nC/kaP7mDfRhKZvqMYDXP1OpHCS4b4Y
	t4z2Xx26dpyruIjwA+wX7ojMdAIM/7Q4EETuUA5UEZjLjJ4JBo/w13/+k=
X-Google-Smtp-Source: AGHT+IGbwrwickIpYhittEgOfAoR0qTYv+wYBr9OOEL5Lt2J9vnVmHKzecBtYFj15CPQzeL90HdcX6sf7zDBzcuZ5is=
X-Received: by 2002:a05:6808:2020:b0:3f3:ff78:e5ef with SMTP id
 5614622812f47-3f55861872emr3349824b6e.8.1741031227387; Mon, 03 Mar 2025
 11:47:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303050921.3033083-1-jeffxu@google.com> <20250303050921.3033083-8-jeffxu@google.com>
 <d945816e-b01f-4a7c-b698-23ec356280f3@lucifer.local> <8285bc26-6afe-4141-ad1a-6d8c5d6d76f9@lucifer.local>
In-Reply-To: <8285bc26-6afe-4141-ad1a-6d8c5d6d76f9@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 3 Mar 2025 11:46:55 -0800
X-Gm-Features: AQ5f1JoVzBCcGr-qxUwehoY9N8ED-gXAC-R3kUqB5QFve2eN18_acCDV037aaXM
Message-ID: <CABi2SkVOzn4RauuL79ewf+Ngp-MjRFi9ofc4jnoWT=R47Go6Gw@mail.gmail.com>
Subject: Re: [PATCH v8 7/7] selftest: test system mappings are sealed.
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, jorgelo@chromium.org, sroettger@google.com, 
	hch@lst.de, ojeda@kernel.org, thomas.weissschuh@linutronix.de, 
	adobriyan@gmail.com, johannes@sipsolutions.net, pedro.falcato@gmail.com, 
	hca@linux.ibm.com, willy@infradead.org, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, 
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, 
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, 
	mike.rapoport@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 8:43=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Mon, Mar 03, 2025 at 12:08:49PM +0000, Lorenzo Stoakes wrote:
> >
> > On Mon, Mar 03, 2025 at 05:09:21AM +0000, jeffxu@chromium.org wrote:
> > > From: Jeff Xu <jeffxu@chromium.org>
> > >
> > > Add sysmap_is_sealed.c to test system mappings are sealed.
> > >
> > > Note: CONFIG_MSEAL_SYSTEM_MAPPINGS must be set, as indicated in
> > > config file.
> > >
> > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> >
> > We do need to add this to the general selftests Makefile, but this code=
 is
> > fine, so have a:
> >
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >
> > Congratulations! :) and thanks for addressing the issues that were rais=
ed,
> > appreciate your efforts on this.
> >
> > Maybe you could send a fix patch? As it's such a small fix.
> >
> > Cheers, Lorenzo
> >
> >
> > > ---
> > >  .../mseal_system_mappings/.gitignore          |   2 +
> > >  .../selftests/mseal_system_mappings/Makefile  |   6 +
> > >  .../selftests/mseal_system_mappings/config    |   1 +
> > >  .../mseal_system_mappings/sysmap_is_sealed.c  | 113 ++++++++++++++++=
++
> >
> > Can you add this to tools/testing/selftests/Makefile? I _think_ adding:
> >
> > TARGETS +=3D mm
> >
> > Should do it. Thanks!
>
> Obviously I meant to say:
>
>         TARGETS +=3D mseal_system_mappings
>
> Doh! :)
>
Yes. I will add that in v9.

This new selftest requires linux-kselftest@vger.kernel.org's approval.

As previously discussed [1], the KCONFIG: MSEAL_SYSTEM_MAPPINGS is
disabled by default. Hopefully, the selftest automation will be able
to detect and parse the "config" in the new
selftests/mseal_system_mappings/config at runtime.

Thanks
-Jeff
[1] https://lore.kernel.org/all/60f5b979-2969-4cb0-ad3d-262908869c5f@lucife=
r.local/

> >
> > >  4 files changed, 122 insertions(+)
> > >  create mode 100644 tools/testing/selftests/mseal_system_mappings/.gi=
tignore
> > >  create mode 100644 tools/testing/selftests/mseal_system_mappings/Mak=
efile
> > >  create mode 100644 tools/testing/selftests/mseal_system_mappings/con=
fig
> > >  create mode 100644 tools/testing/selftests/mseal_system_mappings/sys=
map_is_sealed.c
> > >
> > > diff --git a/tools/testing/selftests/mseal_system_mappings/.gitignore=
 b/tools/testing/selftests/mseal_system_mappings/.gitignore
> > > new file mode 100644
> > > index 000000000000..319c497a595e
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/mseal_system_mappings/.gitignore
> > > @@ -0,0 +1,2 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only
> > > +sysmap_is_sealed
> > > diff --git a/tools/testing/selftests/mseal_system_mappings/Makefile b=
/tools/testing/selftests/mseal_system_mappings/Makefile
> > > new file mode 100644
> > > index 000000000000..2b4504e2f52f
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/mseal_system_mappings/Makefile
> > > @@ -0,0 +1,6 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only
> > > +CFLAGS +=3D -std=3Dc99 -pthread -Wall $(KHDR_INCLUDES)
> > > +
> > > +TEST_GEN_PROGS :=3D sysmap_is_sealed
> > > +
> > > +include ../lib.mk
> > > diff --git a/tools/testing/selftests/mseal_system_mappings/config b/t=
ools/testing/selftests/mseal_system_mappings/config
> > > new file mode 100644
> > > index 000000000000..675cb9f37b86
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/mseal_system_mappings/config
> > > @@ -0,0 +1 @@
> > > +CONFIG_MSEAL_SYSTEM_MAPPINGS=3Dy
> > > diff --git a/tools/testing/selftests/mseal_system_mappings/sysmap_is_=
sealed.c b/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
> > > new file mode 100644
> > > index 000000000000..c1e93794a58b
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.=
c
> > > @@ -0,0 +1,113 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * test system mappings are sealed when
> > > + * KCONFIG_MSEAL_SYSTEM_MAPPINGS=3Dy
> > > + */
> > > +
> > > +#define _GNU_SOURCE
> > > +#include <stdio.h>
> > > +#include <errno.h>
> > > +#include <unistd.h>
> > > +#include <string.h>
> > > +#include <stdbool.h>
> > > +
> > > +#include "../kselftest.h"
> > > +#include "../kselftest_harness.h"
> > > +
> > > +#define VDSO_NAME "[vdso]"
> > > +#define VVAR_NAME "[vvar]"
> > > +#define VVAR_VCLOCK_NAME "[vvar_vclock]"
> > > +#define UPROBES_NAME "[uprobes]"
> > > +#define SIGPAGE_NAME "[sigpage]"
> > > +#define VECTORS_NAME "[vectors]"
> > > +
> > > +#define VMFLAGS "VmFlags:"
> > > +#define MSEAL_FLAGS "sl"
> > > +#define MAX_LINE_LEN 512
> > > +
> > > +bool has_mapping(char *name, FILE *maps)
> > > +{
> > > +   char line[MAX_LINE_LEN];
> > > +
> > > +   while (fgets(line, sizeof(line), maps)) {
> > > +           if (strstr(line, name))
> > > +                   return true;
> > > +   }
> > > +
> > > +   return false;
> > > +}
> > > +
> > > +bool mapping_is_sealed(char *name, FILE *maps)
> > > +{
> > > +   char line[MAX_LINE_LEN];
> > > +
> > > +   while (fgets(line, sizeof(line), maps)) {
> > > +           if (!strncmp(line, VMFLAGS, strlen(VMFLAGS))) {
> > > +                   if (strstr(line, MSEAL_FLAGS))
> > > +                           return true;
> > > +
> > > +                   return false;
> > > +           }
> > > +   }
> > > +
> > > +   return false;
> > > +}
> > > +
> > > +FIXTURE(basic) {
> > > +   FILE *maps;
> > > +};
> > > +
> > > +FIXTURE_SETUP(basic)
> > > +{
> > > +   self->maps =3D fopen("/proc/self/smaps", "r");
> > > +   if (!self->maps)
> > > +           SKIP(return, "Could not open /proc/self/smap, errno=3D%d"=
,
> > > +                   errno);
> > > +};
> > > +
> > > +FIXTURE_TEARDOWN(basic)
> > > +{
> > > +   if (self->maps)
> > > +           fclose(self->maps);
> > > +};
> > > +
> > > +FIXTURE_VARIANT(basic)
> > > +{
> > > +   char *name;
> > > +};
> > > +
> > > +FIXTURE_VARIANT_ADD(basic, vdso) {
> > > +   .name =3D VDSO_NAME,
> > > +};
> > > +
> > > +FIXTURE_VARIANT_ADD(basic, vvar) {
> > > +   .name =3D VVAR_NAME,
> > > +};
> > > +
> > > +FIXTURE_VARIANT_ADD(basic, vvar_vclock) {
> > > +   .name =3D VVAR_VCLOCK_NAME,
> > > +};
> > > +
> > > +FIXTURE_VARIANT_ADD(basic, sigpage) {
> > > +   .name =3D SIGPAGE_NAME,
> > > +};
> > > +
> > > +FIXTURE_VARIANT_ADD(basic, vectors) {
> > > +   .name =3D VECTORS_NAME,
> > > +};
> > > +
> > > +FIXTURE_VARIANT_ADD(basic, uprobes) {
> > > +   .name =3D UPROBES_NAME,
> > > +};
> > > +
> > > +TEST_F(basic, is_sealed)
> > > +{
> > > +   if (!has_mapping(variant->name, self->maps)) {
> > > +           SKIP(return, "could not found the mapping, %s",
> > > +                   variant->name);
> > > +   }
> > > +
> > > +   EXPECT_TRUE(mapping_is_sealed(variant->name, self->maps));
> > > +};
> > > +
> > > +TEST_HARNESS_MAIN
> > > --
> > > 2.48.1.711.g2feabab25a-goog
> > >
