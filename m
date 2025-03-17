Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727D9143748;
	Mon, 17 Mar 2025 19:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742238863; cv=none; b=DD0u4etoHMXPhdFJdSs7po8dgPTFDElAcT/ilFSXP25Ao/XfvXLO3AgMkKbfbPsORxvuAwZGejlzMLo5cCd6ROQPxZRKkE0P4oc4SnCdSaQhbsxdNH61PtphSk3VX/HjpQy3E/99FTdq0TzxQS6EsuRKIPHtEdI30iGuId5lgWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742238863; c=relaxed/simple;
	bh=dHymmMbIaqF0+sfTgKtXQkKvZ+Qnb5l3AeaRlWkLbDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PvrtdNtCLQWzuXFLkqXo8LOjZN1JZ8sFEwsp+3SJmxf9gJC3OuF0VthWVwHpKlIrVk+913JgkPcep7usVyROBoFnYYEu/macRDRpFXcMHegAI1zSVX273Ba6iuJbOaedr22hD9+xwXvzU2i1jsPlKuS7ZnBtZJ4boNywNga51/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-521b84da5e9so1995642e0c.0;
        Mon, 17 Mar 2025 12:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742238858; x=1742843658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KcIwkcsoaQ0FAEZj7T4N6g60IAwpi7JRXMtyAvp1tmQ=;
        b=HUmLH5PALl11TPGJHoxm/KZZMUdfIDsy4TMi1n88mWpYQZ95pFMfOGGqwkpWfG+D8V
         UCWSLLelUtSc1+wfa6l5lErWS78Ikxb0SLnIrxCJIo8VKOA2P5bjl2bklYWgjThaTUL6
         eYqHzahe0cmDc/lmlg8bvktgVZ7lEMpstCW2kr+MnVF9hOxbTVkTizskCSdkf+6S9GFW
         CmTj8Awwk3muzsV60zrJcXbQa4W9fLQmQx34JlNxQhkIbZ1k8E6zFi2YsxCJP7dsWFOv
         iQgt8n3TRpZProIYoqOyRFDySyMyi+PKNB+f2DpliDWMr+4foFkZxcxk35QCssJW7V2Y
         DsnA==
X-Forwarded-Encrypted: i=1; AJvYcCVXy99eF49qdXu4F2c+31eeyXHbEtlBItxnJy+IxrSE3j9VlmVGiwPMl8wCgcmw5eEmFyfBr2TVCQ7lquxX@vger.kernel.org, AJvYcCVrFrYUXR7xTc1MbibMyzs4fanGuxT6z1N6huOe4fZpv9Gh5DVtE9mABJyTVhOfwG/zyvZOBaL7MqZH5W+tJs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxNmWE9SIuS9tizYhbemRMCx1+6wytzWBVr7ThCMxXw7DaHLHO
	JaVoxuPSqDKGmESxEK4+T3mePUvy6PTFwqZmm9tGikLUXhd854RKuWAXNZ7s
X-Gm-Gg: ASbGncuyEeMKTaPS4ajq/z5sX0XAMuhDKgtnYJI2tgGzATIAsp+eudclQjFlMiPWmYe
	Vlw++jXtBmcbNskVjB1bV+jcxeFDImkCxxFlfANYYxan1KR2movveIz18/iVVCVU0uSQG/3qw2G
	euo9+5eKKIwrvYb5uvqKriii28gyKMWPe8lOFFEXxnEQ6IDRksmxxm9aATFO5CZ9FeNpRp207Zu
	k+5eSbyXx4HbblsdpSncaMoQNsVyBwSFyQnMKYfr3EPkXlAZEIxQ3AZ8gbZQj1lxoMwNpPBPvKG
	zqHWBGkYG8rTfK9L2Sc9JjLC/cUxARQHmh5Q3mLTHsAPNmGrv+O89g6Vp0xGN2QGoW2CxVDX6al
	ZxkMHub8=
X-Google-Smtp-Source: AGHT+IF9bmtjIEj5Gneke14cAMJUnf8/Gw10MthLcr7ZqY2rB+sQFHMk1cSYjKfslupOPfqFjTLlXA==
X-Received: by 2002:a05:6122:2519:b0:520:61ee:c7fc with SMTP id 71dfb90a1353d-524498e55b5mr9745950e0c.4.1742238858632;
        Mon, 17 Mar 2025 12:14:18 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5243a718254sm1689881e0c.44.2025.03.17.12.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 12:14:18 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86b9d9b02cbso2151347241.1;
        Mon, 17 Mar 2025 12:14:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3eaXQGTyFe5XyZKA3l1I9wlq4k3pOXowgaRVMIhaXvB7YW6SUaHWBIGdGhmpXeomnwO+wGI/nWqQsCpqi@vger.kernel.org, AJvYcCWOMU3V+8GCfN9LjCIOfQb0gunaba55gok8r0JKVcrjfjP2A8RfD4Z9cAae2j7Ximj3P9WedhYbKRVua4DR95U=@vger.kernel.org
X-Received: by 2002:a05:6102:c08:b0:4c3:577:a8e7 with SMTP id
 ada2fe7eead31-4c383201fd7mr9211696137.16.1742238857962; Mon, 17 Mar 2025
 12:14:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313000623.3192896-1-jeffxu@google.com> <1bbce89c-1efe-40cf-9085-ec4ec16f7996@lucifer.local>
 <CABi2SkVKxyX0uDabg+wHiq_vTBFbUST-nRdur7cCPB2myhCWhg@mail.gmail.com>
 <CAMuHMdWLjX-OavON-rj50kZyvV5+Pf0x34WJbcdKsCgAQA7TwQ@mail.gmail.com>
 <CABi2SkWU6orm-wBFKVt9rsSpYURHPb7fjHRzkOiPGd=Lh-DdkA@mail.gmail.com> <CABi2SkWmxwM-MbfmRCZvBYek8KpmOKPMsFmb=-eZTgKfp3AN6w@mail.gmail.com>
In-Reply-To: <CABi2SkWmxwM-MbfmRCZvBYek8KpmOKPMsFmb=-eZTgKfp3AN6w@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Mar 2025 20:14:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWUHwRXR1VHEVJm36Dp0B_H6SNwtWHAW1dMQ-iM4ORUWQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jo33OQ6XPEGZtZG1I61eGY_-WkVSie1D3g0U40eFO6bCxWBH5jm_7xZ3DA
Message-ID: <CAMuHMdWUHwRXR1VHEVJm36Dp0B_H6SNwtWHAW1dMQ-iM4ORUWQ@mail.gmail.com>
Subject: Re: [PATCH] mseal sysmap: add arch-support txt
To: Jeff Xu <jeffxu@chromium.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org, 
	Liam.Howlett@oracle.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com, 
	gor@linux.ibm.com, hca@linux.ibm.com, kees@kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, svens@linux.ibm.com, thomas.weissschuh@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

On Mon, 17 Mar 2025 at 20:02, Jeff Xu <jeffxu@chromium.org> wrote:
> On Mon, Mar 17, 2025 at 11:14=E2=80=AFAM Jeff Xu <jeffxu@chromium.org> wr=
ote:
> > On Fri, Mar 14, 2025 at 3:41=E2=80=AFAM Geert Uytterhoeven <geert@linux=
-m68k.org> wrote:
> > > On Thu, 13 Mar 2025 at 23:26, Jeff Xu <jeffxu@chromium.org> wrote:
> > > > On Wed, Mar 12, 2025 at 10:21=E2=80=AFPM Lorenzo Stoakes
> > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > > On Thu, Mar 13, 2025 at 12:06:23AM +0000, jeffxu@chromium.org wro=
te:
> > > > > > From: Jeff Xu <jeffxu@chromium.org>
> > > > > > Add Documentation/features/core/mseal_sys_mappings/arch-support=
.txt
> > > > > >
> > > > > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > >
> > > Thanks for your patch!
>
> I used "find * |xargs grep -i  CONFIG_64BIT" to look for CONFIG_64BIT
> under arch/, and together with internet search/wiki page, and below is
> the proposed update.

That way you only find users of the symbol, not where it is defined.

You can use

    git grep -W "config\s*64BIT" -- arch/

to find out which architectures are 32-bit, 64-bit, or support both.

> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/features/core/mseal_sys_mappings/arch-suppo=
rt.txt
> > > > > > @@ -0,0 +1,30 @@
> > > > > > +#
> > > > > > +# Feature name:          mseal-system-mappings
> > > > > > +#         Kconfig:       ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
> > > > > > +#         description:   arch supports mseal system mappings
> > > > > > +#
> > > > > > +    -----------------------
> > > > > > +    |         arch |status|
> > > > > > +    -----------------------
> > > > > > +    |       alpha: | TODO |
> No CONFIG_64BIT found under arch/alpha, but search results show alpha
> supports 64 bits. Keep as TODO.

Alpha is 64-bit only. So the code under arch/alpha/ does not need to check =
for
CONFIG_64BIT, hence you didn't find it;-)

> > > > > > +    |         arc: | TODO |
> > > > > > +    |         arm: |  N/A |
> > > > > > +    |       arm64: |  ok  |
> > > > > > +    |        csky: | TODO |
> (N/A)
>
> > > > > > +    |     hexagon: | TODO |
> No CONFIG_64BIT found under arch/hexagon, but search results show
> hexagon supports 64 bits. Keep as TODO.

32-bit only on Linux.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
