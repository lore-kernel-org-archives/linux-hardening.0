Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCDD2594BD
	for <linux-hardening@vger.kernel.org>; Wed, 12 Aug 2026 15:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786547243; cv=pass; b=L1KFAuN6r8SqaYNehR9WIqZ8/u/gj5Uv+o6opRe3+yhjkOPLcqAmqCDgyLKoD5ltCn8NsmVGvkFYeqKiZAw9jbPBqQ8b4UpufGMh3tmmfhUohJssY0pd08PCIaPkODOkL7X+0vq8ohtxFW2zri9T2Gd4QuhYvqop0imROZrxRss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786547243; c=relaxed/simple;
	bh=SlZLfgo1HzckHxM/PmeaQG3Wasnf7U+/Me0RJrjBNFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WKLh1nB0JncYHwt5+5h23fjEhy7qm3VnSbF50dtRj+j+RbTBDkiWKXRWRlcY6d2it+OuWb/53MiQHmt/ZMGW7YXYppsEYpdZiZ+tRq93LXF7t33qMpFcWktMPXPlnIDMLmrD0eGb/e/EuX6fwpPcXrBHhZXf6b8fsO7fCz+q4jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gwlK4ENd; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gwlK4ENd"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cacef7d299so118125ad.1
        for <linux-hardening@vger.kernel.org>; Wed, 12 Aug 2026 08:07:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786547235; cv=none;
        d=google.com; s=arc-20260327;
        b=cvejE0pljH6GfSp3BccRIAsEEaq9K6hkQ538ygVbjXAtC0x3WCsplVjZvxKncL+XUW
         fAvc0+PUJiKISigMW3TjV//9bYMrl3NIKctW5BNwHfKslKkV9z0nyMZpGqHQEhJVwiRh
         3I77DtJVsrRcVJMykBj+Pi30ml4wFBK/uCCUrgGdM2ViKFKxYYwh8Gn3s0bi6zbOlSsX
         d333OzoEBZvURBTmEsHmR54AWy2P4BWsl0t6GFAYgw7VXG0hEBK0CdT5VEV0zmUm3oKw
         M7tn5gJ6R2ruSjQWPgnbHmDFoBvoa7kCS6bZAyMUDpkyPlq1g81iS6thQq6FHBQcfk5g
         ic8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NzGKVDxszs1TFSJeo9cTD6Uf/WnU6D5XOWsHATUWRrU=;
        fh=hM3USdSAdJ2NBS9T0yZmPwx8j6HUxlIUtdlhKMh6YyI=;
        b=YuFUFTGidi9b8By0C9DmA5n8FPiJcYRvrJ0XNyFXs3e99MWQHTMgIzs7iI9eTyr9bx
         8GewuYMK745J0SG1gk6UDIC1M2gqVs2tyPO8jnDLL1DptmkIeldnjQnkh4KOsAzv4m/e
         PVJCkGCDii0JcWm4OdAp7qJGa512TRg9zYVazWtrVFIy5wZqofIZmPRbhXwMJoPS3Kc7
         s/iPj6Y6t0rmRmx0rW+nhhmF1ljrttAAw36+BF1MM+iUdeDVtHjtj9F+1xbZVp/FV3yA
         j2HHsh+/JjavfLnHVQY+OZQ532tITBnVg7VLMNLV6DkH0mWj7xgwvaxiYNcTA/9ZyYzd
         osnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786547235; x=1787152035; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NzGKVDxszs1TFSJeo9cTD6Uf/WnU6D5XOWsHATUWRrU=;
        b=gwlK4ENd0x2vm/rFCZRyFGOAH7ERE0vZ02mvr8BH4fttzgrtTCscbkWr8xOtdGeviT
         /YM+GAOvZOnNkOAMJNQTojtjoWEOI0cRkmJtGeNhfH0ol7KlrQIGknZGzCeBqvh9FSyP
         7+o0zr5flbUk2Ep56wTOugKmABrf1KND6zoj+FYHD5h5SeFM5mX8umpbRpGvb8nhESCZ
         AjW6MKXY+dnfeva6YIUX68xoiX6w0CCXxQixvOnHjp55Xl2na16H/NaK3pvdZ8lXikjq
         fOLQ3iyyaB/KQRz5spmV5gpiQ+Fc51kGJD8DJ+dryzYhBODT7u7QxjUJE24KiP2T/++t
         1M2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786547235; x=1787152035;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NzGKVDxszs1TFSJeo9cTD6Uf/WnU6D5XOWsHATUWRrU=;
        b=jsfSwcrBDV9LaGp/17kY9uLqFec39qbHtJ2gtSLZI9jQ7V5TTlEd7FlhfuAPbhyqdH
         dAZIzRZT79gW4unac/YLTc8ZkL6SlOGrhP5tviZoltNO8ZNdeFeum3qrZNdimxGroHGf
         yjQTpPumgTrFwrkSlZmeA9gXfG025ueDDJ+mWj5TQsb9uq7n6Qr/v0mQMnK6vZP6xbp4
         OFgXmg2zGcPTWiWkZ28YVq0WuWdE0aNKiRSVo98wzVEkHzDKNWZ2VZgaD83MqRhBvJzr
         gg6mn2KBgbc3xEA102zks9s1r4gko1SMN9HlMHEVUtxQ1uZiVCyDm/Q/2XqK5umDJQCn
         1whA==
X-Forwarded-Encrypted: i=1; AHgh+Rq6UNgoWDpPn4x36CmFyZEhYR/WTQk0Fh/JMtyLOek/nFoFWjnBy7/BFFYUnBhUh+IQcwb9ISfsDfLQ+q8B+5c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+GtHOlF9rKbtaXe7JC2E1U6YoDzzf/JLiQIiCXtsboXoVbG2J
	eDCemvhWkotZvsFHXrJblWsdyPt/55E08/kdprAPU23tsiYqFt7wATq7t3uvapXIs4fHHsctrLi
	gNJKorN/Uhjd4VFQzW4l1VisHER/cov8aZSQQ+fOM
X-Gm-Gg: AR+sD10NMDwcFvlqytMXEKEpQJgp5Ogg2x3dqw1Y5MP6hgORMSTEMUW9cvG5XzBN4UX
	RUDU2VQa8U3U6cfcFODynPRtOHP2l9sx6ojiEWtesP8wLSlyjWWum8QbJKvryz6O5AUfSACjcMC
	M2zZGq5X76KVoyfEzu++BjRXaDxIUf/GepkkHgAPVmdZq053vvrgxwAtrAUZiZmat61451hFHBB
	DZbrls/AiA/EFrv7fWP5RFgCbAvZm75JZanYG8N9RhjW83vxtj1iqmI+kvL0wP93+K9CYPM5E5B
	kgFm658WJMkLmK3NfWBk/9puvNMuHgN9grBYqzZYSplLfwUxapGqILdwPdtLARs4wJ7LZdsa4aM
	vLhJ7LVqgRdu1kLOVLdVu92d5qk6vUrY=
X-Received: by 2002:a17:903:390c:b0:2c7:b1e7:501e with SMTP id
 d9443c01a7336-2d34aa35d46mr6961565ad.3.1786547234173; Wed, 12 Aug 2026
 08:07:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810204118.1981755-1-morbo@google.com> <20260810204118.1981755-3-morbo@google.com>
 <202608101713.34DEA00E9D@keescook> <CAG48ez1VBBkukXH17RRSnAU7rMu0St5x59rkTDVkcMebxuS4-g@mail.gmail.com>
 <202608111721.06C99CDB58@keescook>
In-Reply-To: <202608111721.06C99CDB58@keescook>
From: Jann Horn <jannh@google.com>
Date: Wed, 12 Aug 2026 17:06:37 +0200
X-Gm-Features: AUfX_mwt37BvXoWFUv-1vDnfuxc4lh2srUqJYKBk3og95OdTzVrG071DbNykp8Q
Message-ID: <CAG48ez3R+WKhcoJMTbQpkO+62eSDn_1bSLw3ZUhgo5dX4SJG=Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] vfs: Add KUnit tests for fdtable
To: Kees Cook <kees@kernel.org>
Cc: Bill Wendling <morbo@google.com>, codemender-patching+linux@google.com, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 2:22=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
> On Tue, Aug 11, 2026 at 05:42:05PM +0200, Jann Horn wrote:
> > On Tue, Aug 11, 2026 at 2:16=E2=80=AFAM Kees Cook <kees@kernel.org> wro=
te:
> > > On Mon, Aug 10, 2026 at 08:41:13PM +0000, Bill Wendling wrote:
> > > > +static void fdtable_test_alloc(struct kunit *test)
> > > > +{
> > > > +     struct fdtable *fdt;
> > > > +     unsigned int slots =3D 64;
> > > > +
> > > > +     fdt =3D alloc_fdtable(slots);
> > > > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fdt);
> > > > +
> > > > +     /* Check that max_fds is set correctly and is >=3D slots */
> > > > +     KUNIT_EXPECT_GE(test, fdt->max_fds, slots);
> > > > +
> > > > +     /* Check that fd is allocated */
> > > > +     KUNIT_EXPECT_NOT_ERR_OR_NULL(test, fdt->fd);
> > >
> > > Nice to add these tests! Can you add one for each of the conditionals
> > > in alloc_fdtable (e.g. ENOMEM, EMFILE, and the power-of-two rounding-=
up
> > > logic, etc)?
> >
> > Wouldn't tests for stuff like the rounding-up logic get into
> > implementation details too much, and break if implementation choices
> > change?
>
> It seemed to me like we'd want to notice if that behavior changed?

Why?
File descriptor tables are often power-of-two sized, but they aren't
always. That is an implementation choice that doesn't impact
correctness, it just affects performance somewhat. So I don't see what
the point of a test for this would be - it seems like it would just be
in the way of making changes, a "Change-Detector Test"?
