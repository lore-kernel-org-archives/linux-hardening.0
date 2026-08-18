Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1893EDE40
	for <linux-hardening@vger.kernel.org>; Tue, 18 Aug 2026 18:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787078691; cv=pass; b=UcEXS68Ok2ZItH7v9xNJE1eBV08NvU9RyGZ4bhZBctzZVYQjMO+acIRx32OvE8thELZ0/DIUCGjyGeUJdmJmWrvhdgvs1KQObZbOQk66kLd2KbPQ5BqceS08qc8r9YuRzbpz45Q/0Q5IkfaO+beiMAdKACCGo9ZWUhfateP+RoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787078691; c=relaxed/simple;
	bh=3oW2WhdOYSxmg4pvKp10tBDIqvdQLZRlXXHrFgQdYA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGDGbU5j9DCKP9OsAErgtMrni1fW2Dy6Y1QIfGgoyp+1Ec0f1GfUi0L8qwllfRjtBvwqs7JQYYW8StMSr72rjFTD+9H49S3ZztGbskA/V/0AEmz89mkP2eKvhFw67BCaH8ldLSLassasQB1U7B0OlV3b6Jtbf5FvbE1A/bMm8o8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QhgClk3A; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QhgClk3A"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-80c5cb9a888so2840967b3.3
        for <linux-hardening@vger.kernel.org>; Tue, 18 Aug 2026 11:44:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787078689; cv=none;
        d=google.com; s=arc-20260327;
        b=pKxT9tStAfrTUh6IQOc8DygJ/WfFnjO413viyPopYh5gSC2gt3Ow1nwu+av8SIt8Uo
         Sf15HKwlRaXyFfvRBxcY6NACmNF8AKGbwEvuWJAtvJwnyMdyKsdDaCE9Fbno3LVGwKYR
         8Ig8WmSRD7WQ42WOlE1Rs7n0Buk3M8ivtUl7EVLAIAINFAzdQCNfBCY3fhUgTVLxBZNV
         rz5MLo9i/cIqHOZ2i3Hn73pjXnM1tcTW+uOU5DoR/FfD6KDT4C1EnEYEtH8MPZvpTmuP
         zNq/kKxObUgfylqFE3j1hUIwfVFzQLfpemL3RlF9swsVf10StRTOQyaSRRZnc6J8QMch
         6wJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eUWxoyugIoSCCau305C8MjG63CJLkHpqw2M9gsy7wTY=;
        fh=oZxqpop9rs1SziJYgdoAGW8FVvLCnHqlHjGtGjdkrcM=;
        b=ZQ3inKMGBJfCn0YeXG7m3Weo4Eue3+wUjmB1BoblGx4bPDlqyNAUjVv6JOwtv/ANkF
         yDhvDOzGcv2qI1pQPyW+OeV4lQu2HxZJzFj+uZeKuQqy3yiLuXk/8J4F5Tk+px59L6v3
         pYKedCfOZx2XGNmlxtOKyMMk2qFxCo+vbPF9WjhjABZuHLrf4aHrz0jqC4Hu5fELs3SM
         PJD0MsOMMqhDUktWMWs2H13TeyjidVP0oUcHUdbBMPTaLConPVT4Oni9RiM3l7mivqno
         MSn8+9qYiRCKvm8Lrze/LJdW8pwjjLlTMmgpIr1TvQOn+zu/nyZ/4g2tn4ECfT1uwjoK
         YJdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787078689; x=1787683489; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eUWxoyugIoSCCau305C8MjG63CJLkHpqw2M9gsy7wTY=;
        b=QhgClk3ATWr0bK9Ye8Jt/pNvuYBWD1JxyGW1xT90xViOmYw4sFnsC80XBgA5oI4GJ8
         KNBgXtKPBNiDIE8girY6Sg7EhXMUt0abTRqWjgoeeWc248bN3hrhQQ+izZgrqZBKhRzM
         fdcWPh+im0++ZgXfCE0Wt9y1SVtXnVEJBNuGuWpHA35Vc5V9woyqtHJsx8rBEg4Eh5iB
         21T6N99GRL1SjEJO//d1qQJdzjMSAIFFnPcmbyink9lK6oN1/pi/cgoP6cZSbyIS1y8d
         7BXlV/6jkjCTwwGlb05Lpsik8IXM1Mwym8XvsXLci1djepe4d7a+K5VjcriP561jeqUK
         QiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787078689; x=1787683489;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eUWxoyugIoSCCau305C8MjG63CJLkHpqw2M9gsy7wTY=;
        b=cQWEJBU96EJ2MiH9ELgavkEPBYO1yPMWcXGVspGk1KrOFXENmhWcpy6A3amk3NFaKh
         e1GMV4DQAt7XI6m+3PSDrr3sUzTS+EYJ/9MDGZK4J/fd1FozBg2ftxKQZwgBFDZUGHi2
         f+4JKQlpCP12TzCVqS5YTDlCSEQAXWvRk0J/IyKyKBBL/cUAvWCS1wVSZTLIaTi9Kd12
         0FXlDJJ1pbxsxYh1sqfPHPf4Tt92xT5hEbvePtSIg/tOrt1NfMYfPnymCylitLXTQGso
         davvdInEYpjLz+QI38+KSdlBseZo2PSRMR1oGgFR9Zk+F1ykUayqFJB26hIHNfSs2gC1
         Rqbg==
X-Forwarded-Encrypted: i=1; AHgh+RoEPvcPLA16aHl+e2rNEehrEwwt7Xb7UUMSCSkaiZfYGTlXh19gA5ohOghVLzf3IRj1x3m3LPo22HWWqKHK8eA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgtQfSj+wXH0/UBHBv78xlhdFPU5FxwA2tskTNQ6KZ+n93WyJM
	u5sS1X+B5zDFdNkBJHk6+nYBCtWH72h/CPKyAJF6i46hBxgweSOmM1r0Tqns4iz3xwcT5OkEbu1
	/uo2B2vnN4GdBGvwF8MmjNvYmQFKzN6yDYa15cTQg
X-Gm-Gg: AR+sD11nGp3aDwJzqIPz/xuQgYV+17rL5EP2uGN4JdQ+hribOAQZk5YTqZ6vWg4aIgz
	WXJW06KSg8stQUu2pUrzYFxCVAc9Z9IyM5qVZFLhKuI7B7xAinP/bFTn/n2ViGkQmxemo3t/Clw
	/WrAMkFLVIf0ovcdFiazUCWhUyoxlG7LT82lFKipaVG6wGA4vIc14/Jqs5pnbN1SKn97VDzPj29
	DjfPkrGe4EZhHrjZcRHkIoy2XYjbW7cnRUPL7Cj7un8HITLRCeYHwHPKkSYjgvdVus2R7sOXvcA
	QmExF0ZbEht1P2XZhN6oUXRLUqRqDx9LU7nA66txolqc2eD2WQ3WELY6vLo2BBC0yHU6Z1H4XNR
	r1uqRf2gR
X-Received: by 2002:a05:690c:e1c2:10b0:80c:76fd:f732 with SMTP id
 00721157ae682-841316567a4mr32446497b3.26.1787078688444; Tue, 18 Aug 2026
 11:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <27956255dde39f58d73a7b51cb53cbe3d7804f54.1786411026.git.mariianikitash@google.com>
 <20260818095548.27e0edb2@pumpkin> <202608181041.0619C92@keescook>
In-Reply-To: <202608181041.0619C92@keescook>
From: Mariia Nikitash <mariianikitash@google.com>
Date: Tue, 18 Aug 2026 11:44:36 -0700
X-Gm-Features: AcwNN1VpdCirsWcApQO42k7ZgW4GVpZYRhbKLXvlSnwbeWlmgtq1HM7L9WUmBXE
Message-ID: <CAK=BGyKGPf+dvph30b4m=oPhA=cfAYEj2Sq0FY=Qsbpmb2XEQw@mail.gmail.com>
Subject: Re: [PATCH] NFS: nfsroot: replace strlcat() with snprintf()
To: Kees Cook <kees@kernel.org>
Cc: David Laight <david.laight.linux@gmail.com>, trondmy@kernel.org, anna@kernel.org, 
	justinstitt@google.com, linux-hardening@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nikitash.mariiaw@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,



On Tue, Aug 18, 2026 at 10:42=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Tue, Aug 18, 2026 at 09:55:48AM +0100, David Laight wrote:
> > On Fri, 14 Aug 2026 00:28:45 -0700
> > Mariia Nikitash <mariianikitash@google.com> wrote:
> >
> > > In preparation for removing the deprecated strlcat() API[1], replace =
its
> > > uses in root_nfs_cat() with snprintf().
> > >
> > > Build the separator and source string in a single call using the
> > > remaining space in the destination buffer. snprintf() returns the len=
gth
> > > it would have written excluding the terminating NUL, so comparing the
> > > return value against the remaining buffer space preserves the existin=
g
> > > truncation check.
> > >
> > > Link: https://github.com/KSPP/linux/issues/370 [1]
> > > Signed-off-by: Mariia Nikitash <mariianikitash@google.com>
> > > ---
> > >  fs/nfs/nfsroot.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/fs/nfs/nfsroot.c b/fs/nfs/nfsroot.c
> > > index 432612d22437..e951fe731679 100644
> > > --- a/fs/nfs/nfsroot.c
> > > +++ b/fs/nfs/nfsroot.c
> > > @@ -173,12 +173,12 @@ static int __init root_nfs_cat(char *dest, cons=
t char *src,
> > >                            const size_t destlen)
> > >  {
> > >     size_t len =3D strlen(dest);
> > > +   size_t remaining =3D destlen - len;
> > > +   const char *sep =3D "";
> > >
> > >     if (len && dest[len - 1] !=3D ',')
> > > -           if (strlcat(dest, ",", destlen) >=3D destlen)
> > > -                   return -1;
> > > -
> > > -   if (strlcat(dest, src, destlen) >=3D destlen)
> > > +           sep =3D ",";
> > > +   if (snprintf(dest + len, remaining, "%s%s", sep, src) >=3D remain=
ing)
> > >             return -1;
> >
> > I think I'd have gone for:
> >       size_t len =3D strlen(dest);
> >       if (len && dest[len - 1] !=3D ',' && ++len < destlen)
> >               dest[len - 1] =3D ',';
> >       if (strscpy(dest + len, src, destlen - len) < 0)
> >               return -1;
>
> This is valid, but I just feel like %s%s is more readable for what it
> does. You've open-coded the first %s, and the ++len's interaction
> between the logic and the argument to strscpy is subtle. Since this
> isn't fast-path, let's use what Mariia has proposed.

I had also considered similar approach to what David suggested, I am
open to any path forward based on what maintainers want.

>
> >
> > Although it would be better as an 'add_option()' function.
>
> If this were done in more places, I'd agree, but as-is it's pretty
> limited.
>
> Reviewed-by: Kees Cook <kees@kernel.org>

Thanks for the review!

>
>
> --
> Kees Cook


Mariia
