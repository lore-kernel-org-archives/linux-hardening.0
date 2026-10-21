Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602032;
	b=iQL16WOMXJN8HlCxt31DhUkbJPbbLN+n98vyMf7y1+BQrkeBsbZpbnMWdHRiTrs+L/nF
	 T2gRwUAQjOt/pLU95bRK1lRX9OPjyIqbmaR6wAbqVTPO+2omCMhJ3boa+rf/Yw1w4sObQ
	 ipVn/zq8Uxr4n8S/bQ5VoyPuHwoqOWZHF4D8b7yMFKh9zfOD1HNwZ74gTl1wJ1/7A52hX
	 l+TrNxxiP/UKyUtgAPqrpB5QO+QIAAM7WOCm+CoG4pxWFWRSxpA4dMtF1Qr5QRPnv7nnw
	 +HAbjJ3ngMAbVg9REpUq69Gidiw7TPx+blgLYfviuO0Xtp7VDFpRF72AZAAq1VBkQTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602032;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=4p+sU87b0SPhlui/+SUmlIQxPYDUposWA1I/eyb2zBo=;
	b=frmowvf07tS7aleWFxQAB36NUJDMe+kMj1aXr1/Nc/aAEDsH7csKt1hq5paTXeyBwkdP
	 LpQc/p4TcD1P5Wc+JDPvYg+AKZoWsFj/U6upg14hEVxIKOICnJYy3HcG/tvn6ZJIULbIi
	 GR9vPiQ+t9gR8pNMFjzyQMjXUp+p6+odfwq57eJSGzZlVPRG9SPUfUIc0BtjetYM8GmeA
	 mY7ORe69utAAXtjcLrl+Q+cfkf1QsNzqO7Tt0nzuyLPAg/Q/8y0I3zx9d1RJfO4wijoK1
	 kcRd6hX3MMNLMlktkyE+7rERmB6dIE4/9L9D55XgTiqHRIXYZx5oUcbD+OBsI3V/iTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=M8RxpCIE;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C795606A328
	for <linux-hardening@vger.kernel.org>; Wed, 21 Oct 2026 17:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C795606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=M8RxpCIE
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35f1f76ea84so1373703eec.1
        for <linux-hardening@vger.kernel.org>; Wed, 21 Oct 2026 10:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792602032; x=1793206832; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4p+sU87b0SPhlui/+SUmlIQxPYDUposWA1I/eyb2zBo=;
        b=M8RxpCIEofL9gJ5DckeXvGsUslZ6Q4DvS7VvN/32rUbvls5x0t3PpQxbF3xNNiONix
         G4er9FNPghbqvpcjCB9a90fgehYMDRuFW5AJ1TgGbTTe/viBndxkV7+55C9RctzoDVPu
         vp1waHkH0RoBy79SmwS4pJifyBGVBE5p39l3jQovCmQ2GXnNTpo6vg8Vvy2e5VV4D+0m
         n+Oaet1ZG+hG08urdjczDElenH1S2a8m3qmc7ncmcd8+9HUhwyfjWoM7PWCYpq8tOoEP
         HzG/QgH9KpWICGNaqDhKRS6NlT+7+Rn+PPKi1iKQgP7MbolyXq0hBNvTovNnFCsXojJ/
         Nc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792602032; x=1793206832;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4p+sU87b0SPhlui/+SUmlIQxPYDUposWA1I/eyb2zBo=;
        b=tuo7PVACkpxlemVxj8GxKCAPWZ6V088ywpDne0lfzyNuPFs5JlCdqXeubl/0wLpJtt
         yysQ8pEDB7Ssfz76a4dbDY/D6S6gqGqikXQa0R41+unLAf7ba16ZwRRjtajFiDkrqSqZ
         pUCuwPO/5z8d0Snb73QCpWHdoO6hYCr9WmKzrVihzoHni59OVx+Nd2ljQUOYdHyDYgYS
         nPRyMj8pF+PTlsfC7tJTjrmlBILqfedlg38RFZ/NwRzRtEjQKA6h91igJ1Huv7NcJYFk
         q6mdNsNAxcaYr6UJ3Lh9lY895kVNn2PypAS4F7RAUc0xvsLYARhVy6+2SQ3d15VIIxqp
         Wlrw==
X-Forwarded-Encrypted: i=1; AKwUvBw4Kf5pxV8UdJlbgCAUvptg8Z8KHzoeiXu9CVZcNxspbryBN9N2t0H0A6VvH1zhLpDyUoULv6auszcpw8ETH08=@vger.kernel.org
X-Gm-Message-State: AFq9FYITsPJgjL6ZI+r4oWFI4BwNLHtAgGYwm/J5acQFKxXATTSRx/Gm
	xXYdvu8nNIBOWtv/nRVd/EGWYBDRnf0DW9/YuAmMuzpynckGqGaC0QI5
X-Gm-Gg: AYBFou0RWACgVTocQXUuM0Btm8uGQnq1+S7cSZAjUUduXXHGFRoANusUKDoMiUtnT/q
	Hu1opnLu5AdORjV0y4k3uRAXxKgSsOMufJeOU2csBfDNL1oo6SAjlfQ7LbkaMA8NPDxa3t697Gu
	dxt+5olEixAEliv9R+VWd3aMJ03gOw+T1rfSCybkPaf7Xu+R2CWHz6lJHQBBzfA6XDYY2jOYLKd
	YOEcZGlHLrERJsNxHXecWDCzu7zx+oMikJZhQQsafKwSFS+e65SCzAkD/gfyekQo08fBld4zmhR
	gAT4qt/J2Y4q9s1vLoQbZbJ3fstuYVd1oxK3g1fzefkXKn65jaP6AqHrhoEdnZx2tEx1efWRgcU
	b8K9FYDw1BUpBcEzTWylm6Vr221qQbqritFAnbaTcDuIDnop6ZMYG6yEkGidkTY+U/1LQ21uN+U
	aGlvKk7RmJF1mXiDHZrf94zF9Xi1epkT3MsK/kP2c9JRKNRXQckkjlwanwd3mr7VmhSqp2/24cG
	a1JDQa23CvZJqN/VMIYOGearJFGBK7pP4pilo1pjPAY1z4es3+79Hu6S8iac3uuK2wPRXeVat5y
	4Zgo8/6BRs1F3vpZdCrW6A==
X-Received: by 2002:a05:693c:414b:20b0:367:5e31:ce29 with SMTP id 5a478bee46e88-3675e31ce6bmr3904222eec.20.1792602031067;
        Wed, 21 Oct 2026 10:00:31 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:92d1:8038:c4e7:1f0c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367405ee5e3sm8459829eec.4.2026.10.21.10.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 10:00:29 -0700 (PDT)
Date: Wed, 21 Oct 2026 10:00:26 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Shihuang Liu <shlomojune6@gmail.com>, linux-input@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>, 
	Ville Syrjala <syrjala@sci.fi>, Henk Vergonet <Henk.Vergonet@gmail.com>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] Input: joystick - use usb_make_subpath()
Message-ID: <atjvKMOXQY_psYcF@google.com>
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

Well, there is absolutely no performance concerns in this code, so
another option is to simply leave it as is. I see no benefit here from
using yet another variant of str*cat().

Thanks.

-- 
Dmitry
