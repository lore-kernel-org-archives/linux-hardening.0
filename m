Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C241E0DE6
	for <linux-hardening@vger.kernel.org>; Wed, 19 Mar 2025 16:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742403403; cv=none; b=tDaunWMbrZIFk1aALsubn3r8cLj+1T5mNiYhCJeF6KOYEbwOWw/I0EDYhLX3nvmbbrCLWIgWRUqVM2MnFjywLhOBBHql2EsOAC/93prti2KNQXlQ9w5oWRrncwUZ35xqQRVhwNJQAnjoxqxFTltTbQ6VNDvp1PagoDx7m00TKos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742403403; c=relaxed/simple;
	bh=zwYnXMMsa1QDVsiNd/S8z1RYMd3ZqeeN/TUb6PISgzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FHCsAs40H1BqCG7I1nlaG8i51QGAw+8lV4WGcdhI3VIb7D4HUPx/ElwGzifmdm5B+ou+mWsBHh1TE53zXAttoWgGGUh4IH58q29WlAC4q5VIvv6TXDulPwYcuXxW2P6cm5+oIghOMZ02wwBdbx9vVg5AF2x9Hnra0LkkT2Aajqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EBBhk5uN; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EBBhk5uN"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-72b9143f4c8so416992a34.0
        for <linux-hardening@vger.kernel.org>; Wed, 19 Mar 2025 09:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742403400; x=1743008200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RE5HVBmGckTruTp6gXALafzs0whRU9prTDWUYYmCwK0=;
        b=EBBhk5uNZh9ZBAyboCzc1aIyUl1KCcgE7b0IlGjfBsTfXjT5aOl9rr0f32KQIj9mp1
         Q8od83wTNmVoYo1FOmolYeqmgaGXgjY58Qth5cU4Uj4kYRlcDzJ6NiUt+TtIo4Rxa6TR
         N4pwpJnIotjlWOP7uLm7S5XHRu5Ct1FKhuGUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742403400; x=1743008200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RE5HVBmGckTruTp6gXALafzs0whRU9prTDWUYYmCwK0=;
        b=wqINfq6t1n3S6oHkF2ydwD2OEBO1mYMF0C0gaU2PyrII30QM4hdL+79kUpMoSM72CR
         oOE/9b0LY5cymAdV8LixZMyVMbPqFF7oNXeWJnHBREAGTfkJBGPz5ayZpev/n9oKscgP
         VRA2/jlduynf5cp38qb8kOO8TNAQP+Z3jHS4ZyY1+qViR79GdzGeftYpv3/J1udMqqhf
         Ql2WhnTXJwhqE4t8jH03Kbac1wf1vK6czj7HWOj+BjfXLdKTXSKfczGgf1ZNmDwToPK2
         ij2alXNG4+7wsejFu24fCZCWD8S++HUGrQCHcGlc+nhXpKNMng283fb4tbCGZyfdh1Cl
         DlEw==
X-Forwarded-Encrypted: i=1; AJvYcCWFE3vc4pr4ye8lucFTklnMDYHkde92OjUj1XXtt4PVftd9mO+MgLYgdWcJ+ar81XSlkjjMZn0x4SELSEC5GGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUNxetT+vtxwyqwzq60RpmZWsYOeXuBnIIP+5Wk5OsAy7TfAc9
	jpYS2IBZBjBcSaIztpb92OwK8SM4BN2sPhCNvwR+Mu3Uz2Bt65UbaJjmJdo7tHq5eT7H6E4i0fB
	lVaZAElniSnhZ4G39DxV8sCpR/IwibBboi87L
X-Gm-Gg: ASbGncvvJ+LTm0wW8iAcgoqdyR0lgF3OOIKWoRYJRqZ7EhHTNcjwJVFuyaxke8VVJXg
	E3wD4Eb+7WOeqKz6clC4jjK8hpqPLU4YIru7YGclgqzCWpn7NPt0A5Vwfcv+Bom02f0+qSnkHoT
	4YmQhKSLt17w1xSG9nFQcIxumFVUUXUeM22URvBdISqi8R/JMtIoBrjjipsF/5s4JJiA==
X-Google-Smtp-Source: AGHT+IFzgXMNQcpoWareSib6wev3ti0IRU9vlUdrQeO22LdB0Bu/vQYpcQWzOYqllkJTRFeitamGLkxU/bPpWHg0/cs=
X-Received: by 2002:a05:6808:228c:b0:3fe:ab9b:1a8a with SMTP id
 5614622812f47-3fead6023f0mr973087b6e.5.1742403400056; Wed, 19 Mar 2025
 09:56:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313000623.3192896-1-jeffxu@google.com> <1bbce89c-1efe-40cf-9085-ec4ec16f7996@lucifer.local>
 <CABi2SkVKxyX0uDabg+wHiq_vTBFbUST-nRdur7cCPB2myhCWhg@mail.gmail.com>
 <CAMuHMdWLjX-OavON-rj50kZyvV5+Pf0x34WJbcdKsCgAQA7TwQ@mail.gmail.com>
 <CABi2SkWU6orm-wBFKVt9rsSpYURHPb7fjHRzkOiPGd=Lh-DdkA@mail.gmail.com>
 <CABi2SkWmxwM-MbfmRCZvBYek8KpmOKPMsFmb=-eZTgKfp3AN6w@mail.gmail.com>
 <CAMuHMdWUHwRXR1VHEVJm36Dp0B_H6SNwtWHAW1dMQ-iM4ORUWQ@mail.gmail.com>
 <CABi2SkVndMyOUpRR8z7f0J-r7chkVNZ17-kaEcBje1kBjk-1iw@mail.gmail.com>
 <CABi2SkUAnWAu9L-Km35U4XMmbp9-w+hKCXkM6MYNejYi5ip5Tg@mail.gmail.com> <CAMuHMdUruXfLCZ7vC+VmPRnJUH1Z1LnN9iaeafGaa_EAisnk6A@mail.gmail.com>
In-Reply-To: <CAMuHMdUruXfLCZ7vC+VmPRnJUH1Z1LnN9iaeafGaa_EAisnk6A@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 19 Mar 2025 09:56:28 -0700
X-Gm-Features: AQ5f1Jo5j5hm3bh2_R1XoS4SHAz-D931z9dWRwfaWf7nMpMXBKMw_L75WG7Uvjk
Message-ID: <CABi2SkX2piCzCHMoxe5txGCZ0wAkMbZ0A1VeMottZo5xa3-A-A@mail.gmail.com>
Subject: Re: [PATCH] mseal sysmap: add arch-support txt
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: edumazet@google.com, m-malladi@ti.com, 
	Kevin Brodsky <kevin.brodsky@arm.com>, guoweikang.kernel@gmail.com, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	akpm@linux-foundation.org, Liam.Howlett@oracle.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	kees@kernel.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, svens@linux.ibm.com, 
	thomas.weissschuh@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert

On Wed, Mar 19, 2025 at 1:17=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Jeff,
>
> On Tue, 18 Mar 2025 at 19:39, Jeff Xu <jeffxu@chromium.org> wrote:
> > On Tue, Mar 18, 2025 at 10:21=E2=80=AFAM Jeff Xu <jeffxu@chromium.org> =
wrote:
> > > On Mon, Mar 17, 2025 at 12:14=E2=80=AFPM Geert Uytterhoeven
> > > <geert@linux-m68k.org> wrote:
> > > > On Mon, 17 Mar 2025 at 20:02, Jeff Xu <jeffxu@chromium.org> wrote:
> > > > > On Mon, Mar 17, 2025 at 11:14=E2=80=AFAM Jeff Xu <jeffxu@chromium=
.org> wrote:
> > > > > > On Fri, Mar 14, 2025 at 3:41=E2=80=AFAM Geert Uytterhoeven <gee=
rt@linux-m68k.org> wrote:
> > > > > > > On Thu, 13 Mar 2025 at 23:26, Jeff Xu <jeffxu@chromium.org> w=
rote:
> > > > > > > > On Wed, Mar 12, 2025 at 10:21=E2=80=AFPM Lorenzo Stoakes
> > > > > > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > > > > > > On Thu, Mar 13, 2025 at 12:06:23AM +0000, jeffxu@chromium=
.org wrote:
> > > > > > > > > > From: Jeff Xu <jeffxu@chromium.org>
> > > > > > > > > > Add Documentation/features/core/mseal_sys_mappings/arch=
-support.txt
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > > > > > >
> > > > > > > Thanks for your patch!
> > > > >
> > > > > I used "find * |xargs grep -i  CONFIG_64BIT" to look for CONFIG_6=
4BIT
> > > > > under arch/, and together with internet search/wiki page, and bel=
ow is
> > > > > the proposed update.
> > > >
> > > > That way you only find users of the symbol, not where it is defined=
.
> > > >
> > > > You can use
> > > >
> > > >     git grep -W "config\s*64BIT" -- arch/
> > > >
> > > > to find out which architectures are 32-bit, 64-bit, or support both=
.
> > > >
> > Microblaze, openrisc, sh, hexagon all don't have CONFIG 64BIT defined
> > in KCONFIG, and are not using CONFIG_64BIT in their arch code.  Is
> > there something else that makes you point out the hexagon as 32 bit
> > only (and not other 3) ?
>
> AFAIK Microblaze, openrisc, and hexagon are all 32-bit.
> Linux used to support sh64, but that was dropped, as sh64 never went
> beyond prototype hardware.
>
Great !  Thanks for the information.
I will update accordingly.

-Jeff


> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
