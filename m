Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792429732;
	b=hJJrE3PgN0h9wKv94lStXk6i0rFcNK7aE4gqpOpnXJkS4XC6LX8q/PJsj62HPykrJiUF
	 ZvbZV191Kyj/u+CesKyNCovmEtKW8TToq+RNVJNZFofgF90HE/+5QfznVrsNTiI6qobqv
	 3CuslvEiu/CsyQkWE0jESC0QnfONy6FX5OndQKuJM51pe5Dox1z7T4fpV/mFvK/iHWQBA
	 3Nrc6KkcavbjrXvof6pRMZWPyMG0VElxszo9/IRTk3a7ZzqV2m/YZ0flga1nAMpjvahcu
	 u8tvjpSTBCc7HnpU06zKkN9y/DI7NlA7vRToo+7gUa/ddnZWkeZ0REuhiVdQRP2+0/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792429732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=H7k9Iqs7nqmgbTx9iPYp3EUuEUIbHa6CKRQHNpNJJgo=;
	b=sBrdnO7ZX2Bq++jrBulybuAz7zhZFVMKWmAmXxVQ4USZuOhdXBJeQ1kfcZe6+a2PoBBI
	 BH8Qf3FS0GyAoakIlU4Znhf6H3Dz0RwoHmOr3waa3ClDIJdYplMHA530IrV/gp6qpeyo9
	 1ZL6Gws/IXoLcyuAY3fLZHrkWp3ElRs2YbZ6MPgT6A+LfyWdhKmUZqc7iyRpdZlcvJJqK
	 m/jf934YzYocXum2v9QorzlUrW+tsEkcVo8hE5qxmTumEiGKtSNJ4Pmw997x5WKwg7WIT
	 LWMKLt1b9WGsrMzFUwv3t8inQdL0lJHkS74qGsa5Pa7VlSA89DlWlNWeYk/kjFuLDdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FCRCj27h;
	arc=none smtp.remote-ip=209.85.214.196
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2254F606A329
	for <linux-hardening@vger.kernel.org>; Mon, 19 Oct 2026 17:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2254F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FCRCj27h
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2e987b4a710so15697175ad.1
        for <linux-hardening@vger.kernel.org>; Mon, 19 Oct 2026 10:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792429730; x=1793034530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H7k9Iqs7nqmgbTx9iPYp3EUuEUIbHa6CKRQHNpNJJgo=;
        b=FCRCj27hrs1m6UPIW1/wCgZ0OcyBJwR4HZ9Xvyfho9JVoG0WdKlR/15jAWIDnxxayo
         QFYziwXks1uqraHg1uni51bOPAXcRcRa0HhEbn+GtP8hIWGOidjYCizQq7q9MttN5lWL
         iUKj94legljuVi2SkW02e8l2GZrEy/HL0dnZbWandK+PDaC9ooamYTme5ZHUxBfe3g20
         +0oc83OS2H7/1xvIE9LUnVQcB6khRU08MHMgBgE010hOJBN8uXKIHweHeYcq27gYEZc3
         3IoYYDWTplK6PpG1X+W8gJdyuIiU0B35WSIIuMGyr50e4Ho0HEYlgPTYTtKZEbx8lcPl
         /vSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792429730; x=1793034530;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=H7k9Iqs7nqmgbTx9iPYp3EUuEUIbHa6CKRQHNpNJJgo=;
        b=EMA+MAOxqRpFFKxJWz8OP7WUOueZEPtNXHN/HKFx3dV2j50Cm6c2Ia+XRlqDCxM4ou
         d+fHLum/legzFjOY7hd1bGk9GzH36pB02j4UI1u5MhoQLkAwNmEc6qiVuLHJbpfgudPD
         bZyNYmlXNunnkmeC8BdBWat38y+Jf6yv3fiWb7OaXN/uScqMYPvp9lTo12ZVPSNaashA
         WJ4fyeZq3UCNrf4SUolg73WdQH15kiZO9vkGtclgIKeyl46dpCqgy8JN9vY3IhxQTZPB
         qfbeiVDwEAMfMdcQ6gm2Vq+AZpYaKAm1LZelvo0Ckd00g+Dknn5PoAEPKKCpCipa4HDL
         nMNQ==
X-Forwarded-Encrypted: i=1; AKwUvBwiNXEa6g7Vl46qFj4Yzl3JcS0cesy39kLyKB1UGNu6yPFLpR+tZqd0assH2e2rGvaIyDHpQ4HeZLRQZfcOe0w=@vger.kernel.org
X-Gm-Message-State: AFq9FYKQIK5T3vuMJNLiRbxyMYRfzSwCc8m1kRWGVwKz30IwAZ4ueDUg
	I/0rDj5uM3NG+vgKjxNOW2uSazpSKY0cI/Yn+1rPOpY6E/yCG90p6ZaA
X-Gm-Gg: AYBFou0diwxhNGIp7zXITaZ5VCXtH4aEnl8KzuGxYjd+TBzudGVigaOxMQ5p04sabD6
	3hmoGwAmPZHWcEb4kEDIyGPsRTkatfdKPQxhBs2p3ss6YyVBbjUYoADF/I1J81E/5WGa7BHPdvB
	VvlDQgPTz+1EVPm8cU4ZpnYW+EgBerbjiy4awT8STp9ADrXSv7SR/ClOaHTPscF4lb4WzTK2gSY
	4/sCGZoR+qxJo/ttGMa8f6AfCKq30gYCX0jWCSKe9R89MrZ3iZuCRyPPxnToLqxBJCQ3sllOVAL
	v26zMtT/uHS9cs3DV8zdTcOgzEpYGW/aLT84P1J88vQQ/Y+RWbqJME+phEuiWgyOEwB3MCMN83V
	P+6f0pKJC/T5Hv1yDmTvZs7tCYDAAhrauzQPY8sVuTK0PbLwZBdG1r2q4eNQMvdlzYebOlGgTrC
	tI8GOIJ7I395y8TRVyCToG3ebodGuZO6ht+sky4EYhalPJoNMaGPePQRuXPxb7un27/4t31wJ4e
	oftljU1EZCJk2jlw/pCjAO5ys0=
X-Received: by 2002:a17:903:4405:b0:2e5:ff87:57f3 with SMTP id d9443c01a7336-2e97756f245mr73000545ad.32.1792429730192;
        Mon, 19 Oct 2026 10:08:50 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([183.36.237.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea1501e229sm3706735ad.47.2026.10.19.10.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 10:08:49 -0700 (PDT)
Date: Tue, 20 Oct 2026 01:08:44 +0800
From: Shihuang Liu <shlomojune6@gmail.com>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: linux-input@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ville Syrjala <syrjala@sci.fi>, Henk Vergonet <Henk.Vergonet@gmail.com>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] Input: misc - replace strlcat() with strscpy()
Message-ID: <avxqxhctzivudv7ixjqbl6l3g6x5xxg3nb5v3o5px7brdheitj@qrhj3ki7kdso>
Mail-Followup-To: Alejandro Colomar <alx+linux-hardening@kernel.org>, 
	linux-input@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ville Syrjala <syrjala@sci.fi>, Henk Vergonet <Henk.Vergonet@gmail.com>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-kernel@vger.kernel.org
References: <20261016170411.51025-1-shlomojune6@gmail.com>
 <20261016170411.51025-3-shlomojune6@gmail.com>
 <atXHuHxCqqkIuV2w@debian>
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
In-Reply-To: <atXHuHxCqqkIuV2w@debian>

On Mon, Oct 19, 2026 at 09:48:26AM +0200, Alejandro Colomar wrote:
> Hi Shihuang,
> 
> > Date: 2026-10-17 01:04:08+0800
> > From: Shihuang Liu <shlomojune6@gmail.com>
> >
> > The ati_remote2, cm109, ims-pcu, keyspan_remote, powermate and
> > yealink drivers build the physical path by appending a constant
> > "/input0" suffix with strlcat() after usb_make_path().
> > 
> > In preparation for removing the deprecated strlcat() API[1],
> > replace it with strnlen() followed by strscpy() into the remainder
> > of the buffer, as commit 34b228b739f5 ("HID: usbhid: replace
> > strlcat with better alternatives") did for the usbhid drivers.
> > 
> > Link: https://github.com/KSPP/linux/issues/370 [1]
> > Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
> > ---
> >
> >  drivers/input/misc/ati_remote2.c    | 4 +++-
> >  drivers/input/misc/cm109.c          | 4 +++-
> >  drivers/input/misc/ims-pcu.c        | 8 ++++++--
> >  drivers/input/misc/keyspan_remote.c | 4 +++-
> >  drivers/input/misc/powermate.c      | 4 +++-
> >  drivers/input/misc/yealink.c        | 4 +++-
> >  6 files changed, 21 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/input/misc/ati_remote2.c b/drivers/input/misc/ati_remote2.c
> > index 8db2dca84975c..929163f52177e 100644
> > --- a/drivers/input/misc/ati_remote2.c
> > +++ b/drivers/input/misc/ati_remote2.c
> > @@ -767,6 +767,7 @@ static int ati_remote2_probe(struct usb_interface *interface, const struct usb_d
> >  	struct usb_device *udev = interface_to_usbdev(interface);
> >  	struct usb_host_interface *alt = interface->cur_altsetting;
> >  	struct ati_remote2 *ar2;
> > +	size_t len;
> >  	int r;
> >  
> >  	if (alt->desc.bInterfaceNumber)
> > @@ -823,7 +824,8 @@ static int ati_remote2_probe(struct usb_interface *interface, const struct usb_d
> >  		goto fail3;
> >  
> >  	usb_make_path(udev, ar2->phys, sizeof(ar2->phys));
> > -	strlcat(ar2->phys, "/input0", sizeof(ar2->phys));
> > +	len = strnlen(ar2->phys, sizeof(ar2->phys));
> 
> Why strnlen(3)?  ar2->phys should be a string, right?  If it is not,
> then we'd already have a buffer overread in strlcat(3), and then the
> commit should be reporting a bug fix.  This should use strlen(3)
> instead.
> 
> > +	strscpy(ar2->phys + len, "/input0", sizeof(ar2->phys) - len);
> 
> NAKing this.  This is precisely what strlcat(3)'s documentation in
> OpenBSD says you shouldn't do:
> 
> 	Since it is known how many characters were copied the first
> 	time, things can be sped up a bit by using a copy instead of an
> 	append:
> 
> 		char *dir, *file, pname[PATH_MAX];
> 		size_t n;
> 
> 		...
> 
> 		n = strlcpy(pname, dir, sizeof(pname));
> 		if (n >= sizeof(pname))
> 			goto toolong;
> 		if (strlcpy(pname + n, file, sizeof(pname) - n) >= sizeof(pname) - n)
> 			goto toolong;
> 
> 	However, one may question the validity of such optimizations, as
> 	they defeat the whole purpose of strlcpy() and strlcat().  As a
> 	matter of fact, the first version of this manual page got it
> 	wrong.
> 
> <https://man.openbsd.org/strlcpy>
> 
> The right approach is to have a function that does the right thing.
> There are two viable alternatives:
> 
> -  Write strscat().  It would take the strlen() internally, and so it
>    would be unnecessarily inefficient.  Prefer the next one.
> 
> -  Write stpecpy().  It returns a pointer, which allows chaining easily.
> 
> Here's a viable implementation of stpecpy():
> 
> 	char *
> 	stpecpy(char *dst, const char end[0], const char *restrict src)
> 	{
> 		ssize_t  dlen;
> 
> 		if (dst == NULL)
> 			return NULL;
> 
> 		dlen = strscpy(dst, src, end - dst);
> 		if (dlen < 0)
> 			return NULL;
> 
> 		return dst + dlen;
> 	}
> 
> This would need to be accompanied by a seprintf() too, which would be
> used by usb_make_path() to produce a pointer suitable for chaining.
> I've been working on adding those.
> 

After sending this patch, I noticed the following comment from an
earlier patch:

> We don't want to do this as merely an open-coded strlen/sprintf; it doesn't gain us anything.

See:
<https://lore.kernel.org/all/202609151055.AFC6267@keescook/>

Replacing strlcat with an open-coded strlen + snprintf, or with alternatives 
such as strnlen, strlen, or strscat, would not provide any meaningful benefit.

According to Dmitry's reply to this series, my draft proposal is to replace 
the usb_make_path() + suffix pattern with a helper defined in the core header, as follows:

    static inline __printf(4, 5)
    int usb_make_subpath(struct usb_device *dev, char *buf, size_t size,
                 const char *fmt, ...)
    {
        struct va_format vaf;
        va_list args;
        int actual;

        va_start(args, fmt);
        vaf.fmt = fmt;
        vaf.va = &args;
        actual = snprintf(buf, size, "usb-%s-%s/%pV", dev->bus->bus_name,
                  dev->devpath, &vaf);
        va_end(args);

        return actual >= size ? -1 : actual;
    }


> If you want to keep it easy, I'd do strscat().  We can modify it later
> to be more efficient.  After all, we already have the inefficiency of
> calling strlcat(3) now.

Great. Improving its efficiency is exactly what I would like to do as well

Thanks for reviewing this and for your suggestions.

Shihuang
