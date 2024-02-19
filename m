Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761DD364CC
	for <linux-hardening@vger.kernel.org>; Mon, 19 Feb 2024 13:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708348937; cv=none; b=hqttRByFCnY1l6F/We5NucPCczxCzg42lCvVmr6OZ4E2USvNLeMOlW1xrjbW17QdZjrfwSwj7l4MgvhYZHB+ScBD1dSFGgmnrI0xzqzRSUk5bN6bDaiy2Y8NLCjwTHMvywht0BuwpI2BZGN6a6d5byz4DZtwsctACeSfHkPl9/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708348937; c=relaxed/simple;
	bh=7gbzT0bFlv7Vx+qBIh0t/oLWx0mTJwXdNjLV3zbFmRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vA1oy3LDYSRZLgAUrCbDevM/X42YlRpcI/uEZqdvstxmS+Y8Jj9N2ICf1kxRDY5Ph7BLvqvVq1uU9xI8lCma6oCcmpA8EQg6NqJXoBQkVIp46Qj3dI1UFgIAnI08eFKk6omYWoOvAwFDgIvyG2ZS7TF/a1Zb+5EozwDjtAVnv6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dxKxvUE/; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dxKxvUE/"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5645f0b887fso7788a12.1
        for <linux-hardening@vger.kernel.org>; Mon, 19 Feb 2024 05:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708348934; x=1708953734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XR/z2c5RZraUzauY2z56Ou90i3GAu2aYjsgtVMp28As=;
        b=dxKxvUE/0uVP0R13Uri2E2vM7/cRDswa7hV7Wiekqx6dUuev7d3+nG9k/Cej0NhUnO
         AyGz4duGKTbwCsEzytJw1Y1TFf7PtrdUmHJBxOdUfAY9XWwjOe2eySWLCWhDHBMrXpl/
         if6HP1itS5gN6ErgWppcURwDjhjvjtVDF1SVb8fOtYIqcbsbJchs3C8TNfDCXLibzhqs
         Lylm9vkW93wM5yLV8kz/K2D0vvceD/hp/ycYCOJH3VHS56cn9lpS214CDOTbuaVneHah
         OipvVonwqCasJ+RiBnrg63+bpQ5E46+k8PJio7By6K7UVl0TLop6ZGHUa39J65vquGmP
         VRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708348934; x=1708953734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XR/z2c5RZraUzauY2z56Ou90i3GAu2aYjsgtVMp28As=;
        b=riiRidWiLZk5VbqfamddzK936TVS2YIRYkpOgKXiEvid7b5qf/1q/OvIMejXy4lLFj
         vcLb5Mu9qGSWw4SxyoHwGpWjzf8H+C/InG62PL5MAkizzKy08E/a+S/1uv/KYTdTHnEz
         sQOfm0wX0BGSEFXZDrZ2w0KGrQWycrEMjtUc8tb28yRkUOzeloxI4HpeibTvIBVmFFms
         HU21jYC51uUdajivu3wGCAMIcQlL6kbzmmdR8G+OfuLJNO+jr1z7/RXaNmihBSTpvWff
         vRsP4rtR6ILt/sQ4uRMD+TmsnfsJWBg/wDWIPXInWh7hEUexbUBZ7Jlpr58tJLXiG60n
         Bk8g==
X-Forwarded-Encrypted: i=1; AJvYcCUIIjE+QQr9NXdQ31D/TRC5xwV51o2ODCxRBRX4kR1pDET6n1FJpOCOyDqgq46dy2QAHLFDIamDkoUZEW9hHTLs37eWLg+qUF4nxlrWsJ4/
X-Gm-Message-State: AOJu0Ywn4REnKuHuWlbs4I0g15i3cQENtN9SI+ewf/VHZX8Xz9XupLcy
	LyJ3BdRf+MyxClNvEuFCkOeFgV1qSxRUWWfOBS7lAIZGTq522zqLmPdaKX7eDbhdMplzdMkX28O
	8EhlDcpWLRzohObqmQRB+UaeyEZ4Ebkj8vXh6
X-Google-Smtp-Source: AGHT+IFPRzTY5t73jcifT3Rn47qUnlB2DlUaCnDpkGWwzhR6nZzTzUdbK/OxBtetxy0o+T2EaUFM+sbLktcNGyhaz00=
X-Received: by 2002:a05:6402:1649:b0:564:55e5:6ee1 with SMTP id
 s9-20020a056402164900b0056455e56ee1mr140228edx.2.1708348933587; Mon, 19 Feb
 2024 05:22:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240218073501.54555-1-guixiongwei@gmail.com> <2024021825-skiing-trustee-a56a@gregkh>
In-Reply-To: <2024021825-skiing-trustee-a56a@gregkh>
From: Jann Horn <jannh@google.com>
Date: Mon, 19 Feb 2024 14:21:37 +0100
Message-ID: <CAG48ez32+y7jK5e7WHJxD9aP20WHLmHiXX8U8F=jBtFO3qakAQ@mail.gmail.com>
Subject: Re: [RESEND RFC] kernel/ksysfs.c: restrict /sys/kernel/notes to root access
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Guixiong Wei <guixiongwei@gmail.com>, linux-hardening@vger.kernel.org, jgross@suse.com, 
	boris.ostrovsky@oracle.com, linux-kernel@vger.kernel.org, 
	Guixiong Wei <weiguixiong@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 8:47=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Sun, Feb 18, 2024 at 03:35:01PM +0800, Guixiong Wei wrote:
> > From: Guixiong Wei <weiguixiong@bytedance.com>
> >
> > Restrict non-privileged user access to /sys/kernel/notes to
> > avoid security attack.
> >
> > The non-privileged users have read access to notes. The notes
> > expose the load address of startup_xen. This address could be
> > used to bypass KASLR.
>
> How can it be used to bypass it?
>
> KASLR is, for local users, pretty much not an issue, as that's not what
> it protects from, only remote ones.
>
> > For example, the startup_xen is built at 0xffffffff82465180 and
> > commit_creds is built at 0xffffffff810ad570 which could read from
> > the /boot/System.map. And the loaded address of startup_xen is
> > 0xffffffffbc265180 which read from /sys/kernel/notes. So the loaded
> > address of commit_creds is 0xffffffffbc265180 - (0xffffffff82465180
> >  - 0xffffffff810ad570) =3D 0xffffffffbaead570.
>
> I've cc: the hardening list on this, I'm sure the developers there have
> opinions about this.
>
> > Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
> > ---
> >  kernel/ksysfs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
> > index b1292a57c2a5..09bc0730239b 100644
> > --- a/kernel/ksysfs.c
> > +++ b/kernel/ksysfs.c
> > @@ -199,7 +199,7 @@ static ssize_t notes_read(struct file *filp, struct=
 kobject *kobj,
> >  static struct bin_attribute notes_attr __ro_after_init  =3D {
> >       .attr =3D {
> >               .name =3D "notes",
> > -             .mode =3D S_IRUGO,
> > +             .mode =3D S_IRUSR,
> >       },
> >       .read =3D &notes_read,
> >  };
>
> No objection from me, but what userspace tool requires access to this
> file today?  Will it break if permissions are changed on it?

FWIW, https://codesearch.debian.net/search?q=3D%2Fsys%2Fkernel%2Fnotes&lite=
ral=3D1
shows that (from what I can tell) this is mostly used by stuff like
perf, libdwfl and systemtap for figuring out the kernel's build-id,
probably mostly for kernel profiling?
