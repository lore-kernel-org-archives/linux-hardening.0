Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139813B6BE4
	for <linux-hardening@vger.kernel.org>; Wed, 16 Sep 2026 09:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789551010; cv=none; b=LwXZ1BqeGfX7kdmnu6Rvp29P5IuOiqHkm+NpyUD9B00T1AVg3IlkL8C5vcNJhPUJbCUXm7SEKaR4GYSh09DuOrAnJNvreCHEwPE0JGIj5aN/8YcHocRI3SDiiq3LT1L0sicyUdQtqmUL2MGiN2O+pUYRMlyeCgwE1j8cUBRQSjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789551010; c=relaxed/simple;
	bh=g/iC+DIqI1xrZJ0xCTu4BStW2wCcnb3D4yhvlUsffN0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1yl1/9O3VVpi8C4MR1bGZa3hsJnK+4lIzecNQTEKMt+WrXaQ/7bdLJZcrRPxAh1Qny9bcPJbK/2NMkzFkPaQ4QqhTrijyIKrgMrzPVd5KBB+lK/VC8lapMcGHgkk1N65GQeJUkEbZcaV4liSvxhWXVqFv11KYbG0g+WD8JIkbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqKxl7Lr; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqKxl7Lr"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e6598dd44so3815355e9.1
        for <linux-hardening@vger.kernel.org>; Wed, 16 Sep 2026 02:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789550994; x=1790155794; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=drCB0bFzLSt3iJv3AQNAxjZ5jc1SFYIJv68Mmbr8obI=;
        b=TqKxl7LrugOFrQrgr8bdk88+4lv6xwiasJTOfStkN5VPSjnmIzv6T/HIKUKB391l8m
         aP0WS6ji1Q/XPsOSzWynGbp6G3Sqk/TrqGdPwxlP+NPP7z04EpDLifyTLmNpyKjPitul
         EB9Rkfwh8ymrL4n1jIueyXuEuicoczUb6JmVVr6Ywn6sjH6iyLNAuPuGHRMBurrKQw1r
         4ZrPpvellJRfv8uBz/Hvs87/BfLCOS4sganTG4pAUCnUPLSPyjBBFaxLvBqNXUXAURG3
         7JEvragE67izv0WU4XGTUcfR1iYvN1W8CdmHmjmDSfZR8IAkAZA9Dx4kydTrt7X1fSg9
         yxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789550994; x=1790155794;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=drCB0bFzLSt3iJv3AQNAxjZ5jc1SFYIJv68Mmbr8obI=;
        b=iNst8uM2hxE0Nal4RHix3scPLehvABVbo/yoh0Qfh5pS1eDqeKKzwSr6Pr/N9bEGdY
         m5ingmfQIkTvArFL4JTMB4dF1eIpidxlkCf4zaxLX6YO7XGzO777YJhN3crYiFAmKIuv
         tWrx0emxRvZgXzeP1Xk39yHYL81nyFVf5JzXSUBdiEOvCua/ftuYJFS3vQHOXEaDFXJN
         Zl3PksJ1OIM+4E2GkycAbNw2Yliou/tG3EQEvt0WDjx4k9R5mHvvW66xpvW82wUj3PlR
         Z3als6DNGYSxmGUxaKHe9RAEDiDhc0XG3aX0gDxM8saYD+oEFfhx93Qkor0i/HgADtvs
         o4pA==
X-Forwarded-Encrypted: i=1; AKwUvBxlVnGGyIIiT3YVk1p9h/4EH3bPFu1dOzu/uYykMx4t1BQs1MBKAQg6UhBhbic/pSZtTW39BABvpeSBLDYyO0M=@vger.kernel.org
X-Gm-Message-State: AFuF++lNRya0w1fQMjEwLnUXFiVxMQLmfBYZfRIxcyOdW+aUJ+nxls9S
	lY/JjS7/cszBlOv1OSbVTMR1sQn/HYUclipTNmBuBvX4/2/5a6sKIz3C
X-Gm-Gg: AYBFou2I8MX9C/sMO5LsQcl6PvGwmX5hjRsP4Zaq+aAjm3QvbrmMgD52Fxf0uSVyUgw
	B/nwb27zmzf5Y7lUKKVi/rHOyTCyW3Pg7Vz70IhpXgpJjnP541M2qHng5aIgIs6ZdI3zYKk/dyW
	3FEVTEOPtutx43ler9cnNd71lMfDxrN9lAhctY/yPY2KgS8eNDp7fk7QjLRA40JB9bzszfqtcAq
	iZM1NqPXU+VE+eK/aMVljah5mxMgIZcUbmQyX4YhGfdX1sSRWWXubbkh5FdRrqyOnWDYRLbEo78
	rnVQ2DdiKxNnhnJSQCLyX7ocBgFKbp8JIgGVJCaDQQJPfODwf4wGE7AuEMgeCv/lp8Fs+IhGe2d
	l+vdghzASewDvmLrDL+xtnwtahAeOUbd825B1sYXlgmZ79oUOlBz/u1WTUSDpuYU/AIf6XijH2s
	Pk8ysVIKAE/errsqGVHwmuGaC1rlRmZ2YZctQEEzA6pmEVuSInqcrF2ykzmqqArqOTaVEiwhDge
	nfdrmn6IgOZ+IxL3QYW9OsHUP1wdHX88LpY
X-Received: by 2002:a05:600c:4709:b0:493:f5bf:4dc6 with SMTP id 5b1f17b1804b1-49eac46374bmr21150555e9.7.1789550993497;
        Wed, 16 Sep 2026 02:29:53 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e83db9102sm64812065e9.12.2026.09.16.02.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 02:29:53 -0700 (PDT)
Date: Wed, 16 Sep 2026 10:29:51 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Bill Wendling <morbo@google.com>, linux-kernel@vger.kernel.org,
 codemender-patching+linux@google.com, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Peter Griffin <peter.griffin@linaro.org>, Linus
 Walleij <linusw@kernel.org>, "Martin K. Petersen" <mkp@kernel.org>, Trond
 Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Jiri
 Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, Chuck Lever
 <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, NeilBrown
 <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo
 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Andrew Morton
 <akpm@linux-foundation.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Kanglong Wang <wangkanglong@loongson.cn>, Tiezhu Yang
 <yangtiezhu@loongson.cn>, Qiang Ma <maqianga@uniontech.com>, Randy Dunlap
 <rdunlap@infradead.org>, Pengpeng Hou <pengpeng@iscas.ac.cn>, Ard
 Biesheuvel <ardb@kernel.org>, Breno Leitao <leitao@debian.org>, Thorsten
 Blum <blum@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Johan Hovold
 <johan@kernel.org>, Cen Zhang <zzzccc427@gmail.com>, =?UTF-8?B?Q8Ohc3Np?=
 =?UTF-8?B?bw==?= Gabriel <cassiogabrielcontato@gmail.com>, Rong Zhang
 <i@rong.moe>, linux-input@vger.kernel.org, linux-media@vger.kernel.org,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 devel@lists.orangefs.org, linux-hardening@vger.kernel.org,
 linux-sound@vger.kernel.org
Subject: Re: [PATCH 01/28] ALSA: ac97: Refactor snd_ac97_get_name() to use
 snprintf()
Message-ID: <20260916102532.4b881a25@pumpkin>
In-Reply-To: <202609151134.361FEA04@keescook>
References: <20260915081910.4142719-1-morbo@google.com>
	<20260915081910.4142719-2-morbo@google.com>
	<202609151134.361FEA04@keescook>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Sep 2026 11:39:34 -0700
Kees Cook <kees@kernel.org> wrote:

(I've just juked a lot of the 'reply to' list - too long to gmail.)

> On Tue, Sep 15, 2026 at 08:18:18AM +0000, Bill Wendling wrote:
> > --- a/sound/pci/ac97/ac97_codec.c
> > +++ b/sound/pci/ac97/ac97_codec.c
> > @@ -1850,10 +1850,12 @@ void snd_ac97_get_name(struct snd_ac97 *ac97, unsigned int id, char *name,
> >  
> >  	pid = look_for_codec_id(snd_ac97_codec_ids, id);
> >  	if (pid) {
> > -		strlcat(name, " ", maxlen);
> > -		strlcat(name, pid->name, maxlen);
> > +		int l = strlen(name);
> > +
> >  		if (pid->mask != 0xffffffff)
> > -			sprintf(name + strlen(name), " rev %u", id & ~pid->mask);
> > +			snprintf(name + l, maxlen - l, " %s rev %u", pid->name, id & ~pid->mask);
> > +		else
> > +			snprintf(name + l, maxlen - l, " %s", pid->name);
> >  		if (ac97 && pid->patch) {
> >  			if ((modem && (pid->flags & AC97_MODEM_PATCH)) ||
> >  			    (! modem && ! (pid->flags & AC97_MODEM_PATCH)))
> > @@ -1861,6 +1863,7 @@ void snd_ac97_get_name(struct snd_ac97 *ac97, unsigned int id, char *name,
> >  		}
> >  	} else {
> >  		int l = strlen(name);
> > +
> >  		snprintf(name + l, maxlen - l, " id %x", id & 0xff);
> >  	}
> >  }  
> 
> I'd rather not open-code the length math here. Can't we use seq_buf()
> instead?
> 

Or just use the length returned by the strscpy() call that wrote the initial
part of name[].
The return the name length so the callers don't have to use strcat()
themselves.
Replacing strlcat() with strlen() and a copy is just pointless.

David
