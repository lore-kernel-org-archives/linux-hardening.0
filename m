Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792654605;
	b=bkcIWgMTaiGOg05Y88YpAlOk1d8BQHcmJxxrugcV5gRfdWWoJp43zjbBYkYhck1lyI3y
	 OEu0aCH0tgMNGV5+FKc9sm5/R/iLuvq6vHHkqUtcQwLb5sC8nRaTrzWBpMxL1nUJwdbEM
	 YtA4gYU7JwFwKuWIPmM4M3RGnj84Je5KUC14c58LCf2s8SX+V5QDBa/ET9vO+3+9FGChy
	 g1bQc7770bRMHMKzvc/dds79nbPzqXy+EIxzEp1Iqki24qS9PzeY2hVACyuPCCh+uOnpp
	 6QnmzDx/4HtssQOtPuBBh4XNOKZKvwtPNElgInCOC6OwsoAA9rXTX4jH38VYrXIxZKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792654605;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vhZJaErBTvR4/vMLVwCau5Oaj0vnh/Fm4H8k4FT36Fk=;
	b=WRBFtODMAmbaveEAm3A2wBCqi/2X/y+2CAQtqENeWVmQA4NFRYvv/4+EtpZ3ZvZbCsBc
	 dANHyRqJxp95H0gVCNU1Q9g1+6Ouq/B0In1SFbe13jN5785sMIyDAkoKrlJQ0YBkMupaq
	 xdwfganp2asD/EZ0+Al+sjTGmBnWVJC/dZEzMfbwW3BNOdZv1ae1pzQ59oEdDiWIwfTEi
	 zK6eNIdI2MNos+h8dAqrfKSvQIuzBvZmYFKz/xeIh17OzXTiyOvOYboMq7Z5iGN1mIwbS
	 DXi8JXacT4fQk6h9UX1mGWZo82lFrbhhadcxqZ6XfOX8f1uSMNMWx6jsUU4igRiWuEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dN08mXkf;
	arc=none smtp.remote-ip=74.125.227.135
Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0E7606A31B
	for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 07:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD0E7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dN08mXkf
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-3ac5f801d7cso419812a91.0
        for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 00:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792654604; x=1793259404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vhZJaErBTvR4/vMLVwCau5Oaj0vnh/Fm4H8k4FT36Fk=;
        b=dN08mXkf79FFDAxGBHR+VMNEFIyIUS6++BEmKBtNUdHXM63ew7nmjMsMUQn/Wa+QyB
         jwEHtTzMruw8Snt0J9YMI8P+3n2jNtTxLWbROTcI/TFckIX8xdVZ+XekmcVVnn8VoODl
         ikt1YVFz9mh+TT8fv/FA0/qBzXde1lJfmVfwvkjZ0Hax5xYGgrRPoy7vVaEpiFfrWvEq
         S6U7av0tL+2k/pCCeaON5a608/VhzdCJgqIvizv+juQmWcAhhE0nDfaW12Y6L9FvjDCg
         P5riTgwu3V09dwBwrLRd5GBeWmoryrEWaFdCz6OeXX7dCxZZxSxjc4GRo1PygV9GcRbL
         wUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792654604; x=1793259404;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vhZJaErBTvR4/vMLVwCau5Oaj0vnh/Fm4H8k4FT36Fk=;
        b=RXyXUVjyI0eHUxKbXc7tW8ldQIwWeNa7LH6rqOKc4L0krwriqI2Hn5kfc+NQ0ml4mn
         cHR8zz0pgDz0DU8yY7oM9eEusZA5U7RPRwjHLUsGNUt0YMB/fkFoSVaSARHLMIx4tfKx
         6Exz+7WtpSU1uKtlAaZfemb9BSRD6Kl5yO9DiJvVjoguISmYrtPGKdVqdcYNroqaMsNH
         GC9S+x6Tsu5843+kIwK+D5jzuBwyKEadUo+gbh/ZlS3ScSOswtTai/wUQithXqYMJr8p
         LtdK01sjtZ+BTs9g077vTFadFyEdJaTyuJ/dvkJlaJE2X8qBsnU92BFoPKAes7XKKZbn
         aWpA==
X-Forwarded-Encrypted: i=1; AKwUvBxP3mUcBkndCsxb8siGt0MiHf4u1Jb1tvVG7ItEoucCiub9zfwpiTDNfZCKOJYWWSZaGEZFWMKGMCVpvyaw2jQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYL1jDeT6C7ok/Gr7kVATws7/H2ci4HbYr8qWFJiDjTCG3C7RnVE
	EN74lJ08AeYg/2ViDsQaTyvsxJHFznyn5pt9RQS+LZbM/U34v393+04u
X-Gm-Gg: AYBFou3PqbgWGbkjvF5XOgUu2K4LVTAbVU51C/Gm8lme4b2Ms5fOJDrbDYF9d2x3o5s
	y2zepnYG4wKxZtZWkYha6Cr5Fyqm+uAEPo3xxLmYYHnKVofRC1qTlkeXKZYHO+foIb/UBXvpynw
	Qa4iEvzmF+A4RHJH9Asn2HAX56JhRm8szNAjW8JxgAB4tE0uHabmQn6IrXdzBNf5/qVR6QRQClO
	jABd8UgvUEDMNP8H0kpC+4phdbng8o0iKX9s564pOnl+kd+IcrdEGNGGFN2ke5VPWNf1TvdAY+Z
	tv3RjcbClYlonOgYEimmjeam2DNP7Wj+QOA+IfiDND+9W4meRLuIeicYODhvwtGXdUv5gdsJ42+
	W7a24z4YRbpiMRQSdl4pDKRer6ZtxPN9FGU21n6Pl8LJFZdAmKH4UTX/XyA+bbrNpWL1mlLgG1z
	ZM+OORfsrj7thnjuXGKmIoNV544RQAtK3fbEqgRV8BFgWuVMSGOgRFtNGRzNNtNu/GyaMyXt1pg
	rYqH2aJJna+ZHMELUfgm50vNQyjAEAoaXF59ZJuU4brUHvd3pxxm6O1ShYTgZGjABRO88twGysN
	eAhlMpA=
X-Received: by 2002:a17:90b:39ac:b0:3ad:85fd:711c with SMTP id 98e67ed59e1d1-3ad86ce82a7mr3886173a91.28.1792654603953;
        Thu, 22 Oct 2026 00:36:43 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada48876ebsm2951117a91.1.2026.10.22.00.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 00:36:43 -0700 (PDT)
Date: Thu, 22 Oct 2026 15:36:39 +0800
From: Shihuang Liu <shlomojune6@gmail.com>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: linux-input@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ville Syrjala <syrjala@sci.fi>, Henk Vergonet <Henk.Vergonet@gmail.com>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] Input: joystick - use usb_make_subpath()
Message-ID: <5wdnvsf6bepzpxzfizt4fs3325denwzeeksg3b3hpmzu3257tk@ms7kh4fcgz2k>
Mail-Followup-To: Alejandro Colomar <alx+linux-hardening@kernel.org>, 
	linux-input@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ville Syrjala <syrjala@sci.fi>, Henk Vergonet <Henk.Vergonet@gmail.com>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-kernel@vger.kernel.org
References: <20261021123146.17202-1-shlomojune6@gmail.com>
 <20261021123146.17202-3-shlomojune6@gmail.com>
 <ati7yINv0_Z3yPMg@debian>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ati7yINv0_Z3yPMg@debian>

On Wed, Oct 21, 2026 at 03:21:28PM +0200, Alejandro Colomar wrote:
> Hi Shihuang,
> 
> > Date: 2026-10-21 20:31:42+0800
> > From: Shihuang Liu <shlomojune6@gmail.com>
> >
> > The pxrc and xpad drivers build their input device physical paths
> > by appending "/input0" with strlcat() after usb_make_path().
> > 
> > In preparation for removing the deprecated strlcat() API [1],
> > replace each pair of calls with usb_make_subpath(). The helper
> > formats the USB path and the "input0" subpath in one call,
> > avoiding a separate buffer scan and append operation.
> > 
> > Link: https://github.com/KSPP/linux/issues/370 [1]
> > Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
> > ---
> >  drivers/input/joystick/pxrc.c | 3 +--
> >  drivers/input/joystick/xpad.c | 3 +--
> >  2 files changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/input/joystick/pxrc.c b/drivers/input/joystick/pxrc.c
> > index 52d9eab667b7a..1a11e73d7cd04 100644
> > --- a/drivers/input/joystick/pxrc.c
> > +++ b/drivers/input/joystick/pxrc.c
> > @@ -169,8 +169,7 @@ static int pxrc_probe(struct usb_interface *intf,
> >  
> >  	pxrc->input->name = "PXRC Flight Controller Adapter";
> >  
> > -	usb_make_path(udev, pxrc->phys, sizeof(pxrc->phys));
> > -	strlcat(pxrc->phys, "/input0", sizeof(pxrc->phys));
> > +	usb_make_subpath(udev, pxrc->phys, sizeof(pxrc->phys), "input0");
> 
> To be honest, I think the composed approach is more readable.  You don't
> need to learn a new _subpath function with all the details it has.
> 
> Everyone knows what a str*cat() (or str*cpy, FWIW) function does.
> 
> I'd rather improve this by adding strscat().  The reason for removing
> strlcat(3) is that it is vulnerable to DoS, and that it is inefficient,
> but it is good at producing readable code, and a replacement should not
> degrade that.
> 
> 
> Have a lovely day!
> Alex
> 
Besides that, strscat() has other issues:

- The `sizeof(buf) - len` arithmetic is a classic source of
off-by-one bugs.
- any future change means re-deriving the offsets all over again.

I'd prefer to avoid strscat() here.

Thanks
Shihuang
> >  	pxrc->input->phys = pxrc->phys;
> >  
> >  	usb_to_input_id(udev, &pxrc->input->id);
> > diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> > index feb8f368f834e..0f7ca5adaeee7 100644
> > --- a/drivers/input/joystick/xpad.c
> > +++ b/drivers/input/joystick/xpad.c
> > @@ -2059,8 +2059,7 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
> >  	if (!xpad)
> >  		return -ENOMEM;
> >  
> > -	usb_make_path(udev, xpad->phys, sizeof(xpad->phys));
> > -	strlcat(xpad->phys, "/input0", sizeof(xpad->phys));
> > +	usb_make_subpath(udev, xpad->phys, sizeof(xpad->phys), "input0");
> >  
> >  	xpad->idata = usb_alloc_coherent(udev, XPAD_PKT_LEN,
> >  					 GFP_KERNEL, &xpad->idata_dma);
> > -- 
> > 2.43.0
> > 
> > 
> 
> -- 
> <https://www.alejandro-colomar.es>
