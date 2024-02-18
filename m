Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4BB63A7
	for <linux-hardening@vger.kernel.org>; Sun, 18 Feb 2024 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708247092; cv=none; b=I+OBgMYPvG3cFgNEhdJohZLvCxJueGjMQpfdBSphYfVFbRue59nnicic3yMbM3TH123aQpeHRvMhvydbGs3/J04pG6pAWVXcm9oB4qlIBmfsGzE28npuojVEKiykB8iyMd8VKZfoLke/CqqpHMTGzz0OmX8ZeMUlYISGXMqdeMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708247092; c=relaxed/simple;
	bh=gsfp648GSeu4GSSGGmUz6uwvgJjtHhBRQ1HuetedarU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJWZfl6NedOHeasqBIG7d5k9lL8trYuX16fxzRaZFlQ3HdkuSYjW2EVD3aEUEj4HCP1kTlN4KFWhFB6D5H+BQPDlCZozOoKnuEbmUfBKo7ejFXEdZ2bqHtDP0tWxwyrZMrY+m4Qmqyj15N6O0zfky/NkNphIMVgWanFk117xRFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TAhcGFc2; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TAhcGFc2"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d7393de183so27404165ad.3
        for <linux-hardening@vger.kernel.org>; Sun, 18 Feb 2024 01:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708247089; x=1708851889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+PSGviE7P+pWKcxbR82hBe0e7HZtwlv0NsdYte+C5Ww=;
        b=TAhcGFc2D+xw4WANX79tqHrNVyJ1xT70hoVNMELKMJFfbftr0gGCaun5vsCqqpWcDv
         tLwpHYldPgkhpfKrqNsJ6QLPTHf16LEncrKuM6t3MNOYNPqCcom5AbGcE+FXjYM93MAl
         zK0DUY7Rrmm7X5YWkHj5ZDwPbJuzoWGKTh8cE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708247089; x=1708851889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PSGviE7P+pWKcxbR82hBe0e7HZtwlv0NsdYte+C5Ww=;
        b=C+zveNGyKZuJqVw1yTnBJhoKetqEMXF77JAhmRyHdiuGdSZ5Sv29RTWZVI8HdeIy6c
         jDKgrCdY193aN7v9WR2xIN3ESA6OId54/hsBbOhUsei8aoXkxgY5RU8TDKsGEScbljCe
         DvR3ac0ebdmO9qy3KBgGgzPUnQnmXPU1ScAZv+/McdWHTCOA0xlUvjcZnj4PKOGJ2H8S
         UJQJ4IItPaEP7PDuCVE9lF5rOkcZiksrdmLVebSeoNhr9tp8h5jxmzNZ477LmVPbJQ2h
         ykGQCsWrcHKFw0VWK49YHUUDwfFiHkS4FvmTayZ5Zcl40lkbFPApsJQrGS4D7Xr1Izw5
         pjRA==
X-Forwarded-Encrypted: i=1; AJvYcCVQdGxIGNlEkc0AYPr640Ayl1N4U9c8Im9yVq378WtzopJi8Oopa84bwys08V58hks/XOdTd6Dd+CAFqrxT1GKms4ois9jODLXvUBCbJKJB
X-Gm-Message-State: AOJu0Yx1JjT5BR0q6Z/73E6rG7i0TEqbz/1Kw6fY9PYaskqGPmu7smPd
	u3LKGzvdIsSJIMkyvdWzcIBc6SyYDB5uXkjBCmYe0I8X2veeP/aRzJ6AfHX3AQ==
X-Google-Smtp-Source: AGHT+IE8Ghl8NWV5BRDjTffg6tAQE1Fy/8QmYMG3CMSvf0PFWMiDr/5Kpsv3BwMiRgjuLIrzy52Cbw==
X-Received: by 2002:a17:902:778c:b0:1da:2bd6:a450 with SMTP id o12-20020a170902778c00b001da2bd6a450mr8279022pll.32.1708247089287;
        Sun, 18 Feb 2024 01:04:49 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v13-20020a170902f0cd00b001d8d1a2e5f2sm2435675pla.216.2024.02.18.01.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 01:04:48 -0800 (PST)
Date: Sun, 18 Feb 2024 01:04:48 -0800
From: Kees Cook <keescook@chromium.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Guixiong Wei <guixiongwei@gmail.com>, linux-hardening@vger.kernel.org,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Guixiong Wei <weiguixiong@bytedance.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND RFC] kernel/ksysfs.c: restrict /sys/kernel/notes to root
 access
Message-ID: <202402180028.6DB512C50@keescook>
References: <20240218073501.54555-1-guixiongwei@gmail.com>
 <2024021825-skiing-trustee-a56a@gregkh>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024021825-skiing-trustee-a56a@gregkh>

On Sun, Feb 18, 2024 at 08:47:03AM +0100, Greg KH wrote:
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
> >  - 0xffffffff810ad570) = 0xffffffffbaead570.
> 
> I've cc: the hardening list on this, I'm sure the developers there have
> opinions about this.

Oh eww, why is Xen spewing addresses into the notes section? (This must
be how it finds its entry point? But that would be before relocations
happen...)

But yes, I can confirm that relocations are done against the .notes
section at boot, so the addresses exposed in .notes is an immediate
KASLR offset exposure.

In /sys/kernel/notes (are there any tools to read this? I wrote my own...)

	type: 1
	name: Xen
	desc: 0xb4a711c0 0xffffffff

which matches a privileged read of /proc/kallsysms:

	ffffffffb4a711c0 T startup_xen

(and the hypercall_page too)

There are all coming from arch/x86/xen/xen-head.S:

        ELFNOTE(Xen, XEN_ELFNOTE_GUEST_OS,       .asciz "linux")
        ELFNOTE(Xen, XEN_ELFNOTE_GUEST_VERSION,  .asciz "2.6")
        ELFNOTE(Xen, XEN_ELFNOTE_XEN_VERSION,    .asciz "xen-3.0")
#ifdef CONFIG_XEN_PV
        ELFNOTE(Xen, XEN_ELFNOTE_VIRT_BASE,      _ASM_PTR __START_KERNEL_map)
        /* Map the p2m table to a 512GB-aligned user address. */
        ELFNOTE(Xen, XEN_ELFNOTE_INIT_P2M,       .quad (PUD_SIZE * PTRS_PER_PUD))
        ELFNOTE(Xen, XEN_ELFNOTE_ENTRY,          _ASM_PTR startup_xen)
...

Introduced in commit 5ead97c84fa7 ("xen: Core Xen implementation")

Exposed in commit da1a679cde9b ("Add /sys/kernel/notes")

Amazingly these both went in on the same release (v2.6.23, 2007). This
has been exposed for longer than KASLR has been upstream. :P

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
> > @@ -199,7 +199,7 @@ static ssize_t notes_read(struct file *filp, struct kobject *kobj,
> >  static struct bin_attribute notes_attr __ro_after_init  = {
> >  	.attr = {
> >  		.name = "notes",
> > -		.mode = S_IRUGO,
> > +		.mode = S_IRUSR,
> >  	},
> >  	.read = &notes_read,
> >  };

Yes please.

Reviewed-by: Kees Cook <keescook@chromium.org>

I wonder if we should also remove relocations that are aimed at the
.notes section for good measure? If that had already been true, this
would have just given the same info as System.map.

> 
> No objection from me, but what userspace tool requires access to this
> file today?  Will it break if permissions are changed on it?
> 
> And what about the module notes files?  If you change one, shouldn't you
> change all?

Luckily all of _those_ contain what I'd expect: the Linux and
GNU.build-id notes, which are harmless. But if we're going to suddenly
have things appearing in here, let's make those root-only too.

-Kees

-- 
Kees Cook
