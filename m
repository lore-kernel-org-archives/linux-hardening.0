Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C1615199D;
	Fri, 14 Feb 2025 02:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739501574; cv=none; b=bDYnBGsWsTG1fXG+wl/hy57hr3Dt5zSMbteyQdUmNvREDc7mxxgwhRdA7uwkwvWtAn2lmdRd1Sl/cLNHaQdjMinHZa2vLyJDhhGi4Pf7yoYfmCjFIg9LbXiVV1eYcwPHOlxyEXKpxNJqvb2JVeUb7NeeaIWbzlDCgmCictiKgAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739501574; c=relaxed/simple;
	bh=iQrR0w+uywPbCMMcShpDdSWaDs875MPZG+kpvEZmr+I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Ll4R1HlnZjAx1aOaEuOEi1QVI5bU10V5yevWHjuxIIJ6HPyDPBcAa1Gv0ryAIoW5aokq1GacRo7g+YQMYTIZKlzTcU5D0GWj3W+A2hnAkmanV2Ovft/zbBR7g/BWXwt5vdp+a2GpaFcaRM9cCdQFY2JQId8c1xE6KiXbQpfsKiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKt+sg8s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKt+sg8s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6FAC4CEE5;
	Fri, 14 Feb 2025 02:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739501572;
	bh=iQrR0w+uywPbCMMcShpDdSWaDs875MPZG+kpvEZmr+I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=cKt+sg8sqg+2JOJ//ExePR0T/GrWSCdhTOKgePpfQ5Sg13FdXi59nWGQULD93DlOl
	 D6NdC+tizRciB8cFIdCRsSD3U3HsA3PJj2HX6RLb7Mh3ND1oFuXZsDJMfMBye//uxW
	 TkuLaXjk8vT4TSKYuzGEuFOBkR+24uIC1mMFON0X1SkLuEnpmt2TDWnq8xshxYjQr1
	 JDcNHo9iAFKQQyTN/N+vVnLeoX01bDSsx4+xTyfwPE3X2yjXlighxqJ/5l/lr65yYL
	 DMXLGUdaPW9sXvkypTxHJR1hRyDUKsN+DmD1ocDky+/5qARWlMbai5Z4zkcv/0QC/m
	 JcPJzJTYRabEw==
Date: Thu, 13 Feb 2025 18:52:51 -0800
From: Kees Cook <kees@kernel.org>
To: Jeff Xu <jeffxu@chromium.org>
CC: =?ISO-8859-1?Q?Thomas_Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
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
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH_v5_2/7=5D_selftests=3A_x86=3A_t?=
 =?US-ASCII?Q?est=5Fmremap=5Fvdso=3A_skip_if_vdso_is_msealed?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CABi2SkU0kW8yAoucxLjkqXpFJMJzGDmKZZhgMJGobaALNVTGvA@mail.gmail.com>
References: <20250212032155.1276806-1-jeffxu@google.com> <20250212032155.1276806-3-jeffxu@google.com> <20250212135000-861e6353-6e0a-43c3-9b28-649ae4dfc607@linutronix.de> <CABi2SkUCviiTbd1roeBiqSk98S87R1WwSP9rUYh4t3JfSD+2ZA@mail.gmail.com> <35C0FD0B-0483-4663-AD60-701AB8D9247A@kernel.org> <CABi2SkU0kW8yAoucxLjkqXpFJMJzGDmKZZhgMJGobaALNVTGvA@mail.gmail.com>
Message-ID: <462A068C-489E-400D-9E82-F54F46E77DF3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On February 13, 2025 2:20:01 PM PST, Jeff Xu <jeffxu@chromium=2Eorg> wrote=
:
>On Thu, Feb 13, 2025 at 11:28=E2=80=AFAM Kees Cook <kees@kernel=2Eorg> wr=
ote:
>>
>>
>>
>> On February 13, 2025 6:14:00 AM PST, Jeff Xu <jeffxu@chromium=2Eorg> wr=
ote:
>> >On Wed, Feb 12, 2025 at 5:04=E2=80=AFAM Thomas Wei=C3=9Fschuh
>> ><thomas=2Eweissschuh@linutronix=2Ede> wrote:
>> >>
>> >> On Wed, Feb 12, 2025 at 03:21:50AM +0000, jeffxu@chromium=2Eorg wrot=
e:
>> >> > From: Jeff Xu <jeffxu@chromium=2Eorg>
>> >> >
>> >> > Add code to detect if the vdso is memory sealed, skip the test
>> >> > if it is=2E
>> >> >
>> >> > Signed-off-by: Jeff Xu <jeffxu@chromium=2Eorg>
>> >> > ---
>> >> >  =2E=2E=2E/testing/selftests/x86/test_mremap_vdso=2Ec  | 38 ++++++=
+++++++++++++
>> >> >  1 file changed, 38 insertions(+)
>> >> >
>> >> > diff --git a/tools/testing/selftests/x86/test_mremap_vdso=2Ec b/to=
ols/testing/selftests/x86/test_mremap_vdso=2Ec
>> >> > index d53959e03593=2E=2Ec68077c56b22 100644
>> >> > --- a/tools/testing/selftests/x86/test_mremap_vdso=2Ec
>> >> > +++ b/tools/testing/selftests/x86/test_mremap_vdso=2Ec
>> >> > @@ -14,6 +14,7 @@
>> >> >  #include <errno=2Eh>
>> >> >  #include <unistd=2Eh>
>> >> >  #include <string=2Eh>
>> >> > +#include <stdbool=2Eh>
>> >> >
>> >> >  #include <sys/mman=2Eh>
>> >> >  #include <sys/auxv=2Eh>
>> >> > @@ -55,13 +56,50 @@ static int try_to_remap(void *vdso_addr, unsig=
ned long size)
>> >> >
>> >> >  }
>> >> >
>> >> > +#define VDSO_NAME "[vdso]"
>> >> > +#define VMFLAGS "VmFlags:"
>> >> > +#define MSEAL_FLAGS "sl"
>> >> > +#define MAX_LINE_LEN 512
>> >> > +
>> >> > +bool vdso_sealed(FILE *maps)
>> >> > +{
>> >> > +     char line[MAX_LINE_LEN];
>> >> > +     bool has_vdso =3D false;
>> >> > +
>> >> > +     while (fgets(line, sizeof(line), maps)) {
>> >> > +             if (strstr(line, VDSO_NAME))
>> >> > +                     has_vdso =3D true;
>> >> > +
>> >> > +             if (has_vdso && !strncmp(line, VMFLAGS, strlen(VMFLA=
GS))) {
>> >> > +                     if (strstr(line, MSEAL_FLAGS))
>> >> > +                             return true;
>> >> > +
>> >> > +                     return false;
>> >>
>> >> This only tests that any mapping after the vdso is sealed=2E
>> >
>> >The code above begins by searching for the "[vdso]" string, then looks
>> >for the first line that starts with "VmFlags:", and looks for the "sl"
>> >substring within that line=2E We're assuming the format of smaps won't
>> >change from release to release=2E
>>
>> Oh, I missed this in my reviews: nothing _resets_ has_vdso to false, so=
 if any other mapping follows vdso that happens to be sealed, this will ret=
urn true=2E=2E=2E
>>
>It won't return the next mapping's sealing flag=2E
>After finding the "[vdso]", if the next line that contains VMFLAGS
>doesn't have the "sl" flag, the function returns false immediately=2E

Oh! Agh, yes=2E You are right, this is all fine=2E

>I can switch to vm_util, I will need to add a new parsing function in
>vm_util, the existing __get_smap_entry() only searches for vm's
>starting address, not name=2E

Unless someone feels strongly about this, my instinct is to avoid the high=
er complexity of a cross-test thing=2E

-Kees


--=20
Kees Cook
