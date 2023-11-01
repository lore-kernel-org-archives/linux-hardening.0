Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184726ABB
	for <linux-hardening@vger.kernel.org>; Wed,  1 Nov 2023 16:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ad4H0JRo"
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9C6FD
	for <linux-hardening@vger.kernel.org>; Wed,  1 Nov 2023 09:23:51 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so16645a12.0
        for <linux-hardening@vger.kernel.org>; Wed, 01 Nov 2023 09:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698855830; x=1699460630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoRbzGRAnQty7H13YdGej79QgL+EU0noB4+Qr1wy+V0=;
        b=ad4H0JRo1FOjGfbOlC3vzbXzRAOkUMgRXPVcgE/f/kNGY3Ny2uyyabn3dFCOYwM93/
         zlMJExKeTsSxejzMGmNrLJ25kHHVBL4QGNWdwpwQVGJiiSeVSRNXiRfmY+uvVB55iGer
         lu36ZREU35qIkXzJ9lHtZuRa4ERucs11a+9dyAaRUTnjJNq1SBFJlbEi2GviFm6kd2oJ
         MLFzpzdpMA6z+9/u6zZu4eyUr14K3s4bKbETHP2jAwlgvX52yYk5Nd+tp+NCvmCgFTm8
         GbkrA0fxwpZ7/7hHiFLW0rHcoQJ/VYWTWiENPMN0S2uBY7w+JcVhHLwyd5Ejl7WPmxmU
         7cuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698855830; x=1699460630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uoRbzGRAnQty7H13YdGej79QgL+EU0noB4+Qr1wy+V0=;
        b=bnno/8+7E/Wcd0HgNopquWZj+c/1YsHEbJOt5Ga4SiHaMGMPxL5TqwtCgiZeNbswMi
         0b5O63hUlzgPH7FI2ETitVMm85aOH4cJy68i11QR79SXgEq0RoyITI/T7SM8wtEuNd3F
         CXwTfb0jsSjDXFkkI21mgO+ZnHWyO04V5aiM7+xA8k+Y4S5pGLBndBDMuKiahLjaayB0
         9wWpfCB2ClyC/KegrheU4IGf1WIq+0Jkx3R6qra+Nr5Ufc1RkCqVtx6zFgWjLNPh16Kv
         elbIAyJZXT5EJODGs6Gu1acf1qpUAHA9ujblekLvPsaRPWVlBnbKesqV4ImtWlGoM4af
         r2lA==
X-Gm-Message-State: AOJu0Yzh0UzqZKzbs+thRUHnH3/v4hpwn73SAuwY8KDX3PjQSoIQeyzT
	TDsIhoRLaIqNCvdqqlO8kmHNDM2p1orKLjqZtrB3ew==
X-Google-Smtp-Source: AGHT+IGDG43OvjOvSZ1G9d15u19P4ARTOgNs/LGmiDYoHslrS9Gutvb89Z1DejMyuF4UMP8kxPHI3i/yBGTUv8+4se0=
X-Received: by 2002:a50:d0de:0:b0:543:5119:2853 with SMTP id
 g30-20020a50d0de000000b0054351192853mr255080edf.6.1698855829665; Wed, 01 Nov
 2023 09:23:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Y59qBh9rRDgsIHaj@mailbox.org> <20231024134608.GC320399@mail.hallyn.com>
 <CAHC9VhRCJfBRu8172=5jF_gFhv2znQXTnGs_c_ae1G3rk_Dc-g@mail.gmail.com>
 <20231024141807.GB321218@mail.hallyn.com> <CAHC9VhQaotVPGzWFFzRCgw9mDDc2tu6kmGHioMBghj-ybbYx1Q@mail.gmail.com>
 <20231024160714.GA323539@mail.hallyn.com> <ZUFmW8DrxrhOhuVs@mailbox.org> <20231101.eeshae5Ahpei@digikod.net>
In-Reply-To: <20231101.eeshae5Ahpei@digikod.net>
From: Jann Horn <jannh@google.com>
Date: Wed, 1 Nov 2023 17:23:12 +0100
Message-ID: <CAG48ez0wQ3LFxZ2jWj1sTZngTg4fEmx1=dXYuRbMMFk5CiYVbg@mail.gmail.com>
Subject: Re: Isolating abstract sockets
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Stefan Bavendiek <stefan.bavendiek@mailbox.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	kernel-hardening@lists.openwall.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 1, 2023 at 11:57=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Tue, Oct 31, 2023 at 09:40:59PM +0100, Stefan Bavendiek wrote:
> > On Tue, Oct 24, 2023 at 11:07:14AM -0500, Serge E. Hallyn wrote:
> > > In 2005, before namespaces were upstreamed, I posted the 'bsdjail' LS=
M,
> > > which briefly made it into the -mm kernel, but was eventually rejecte=
d as
> > > being an abuse of the LSM interface for OS level virtualization :)
> > >
> > > It's not 100% clear to me whether Stefan only wants isolation, or
> > > wants something closer to virtualization.
> > >
> > > Stefan, would an LSM allowing you to isolate certain processes from
> > > some abstract unix socket paths (or by label, whatever0 suffice for y=
ou?
> > >
> >
> > My intention was to find a clean way to isolate abstract sockets in net=
work
> > applications without adding dependencies like LSMs. However the entire =
approach
> > of using namespaces for this is something I have mostly abandoned. LSMs=
 like
> > Apparmor and SELinux would work fine for process isolation when you can=
 control
> > the target system, but for general deployment of sandboxed processes, I=
 found it
> > to be significantly easier (and more effective) to build this into the
> > application itself by using a multi process approach with seccomp (Basi=
cally how
> > OpenSSH did it)
>
> I agree that for sandbox use cases embedding such security policy into
> the application itself makes sense. Landlock works the same way as
> seccomp but it sandboxes applications according to the kernel semantic
> (e.g. process, socket). The LSM framework is just a kernel
> implementation detail. ;)

(Related, it might be nice if Landlock had a way to completely deny
access to abstract unix sockets, and a way to restrict filesystem unix
sockets with filesystem rules... LANDLOCK_ACCESS_FS_MAKE_SOCK exists
for restricting bind(), but I don't think there's an analogous
permission for connect().

Currently, when you try to sandbox an application with Landlock, you
have to use seccomp to completely block access to unix domain sockets,
or alternatively use something like the seccomp_unotify feature to
interactively filter connect() calls.

On the other hand, maybe such a feature would be a bit superfluous
when we have seccomp_unotify already... idk.)
