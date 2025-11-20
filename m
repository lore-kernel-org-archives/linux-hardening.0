Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E38372AD7
	for <linux-hardening@vger.kernel.org>; Thu, 20 Nov 2025 08:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763626652; cv=none; b=C/VeMPZfD+L2Yohiln9YfK/pyiWoha+oH2qwscNGN+Qe0q264Ys9YK2rGduY9urN4bKeQqRtoDSybsJfbXZWifkZ8HsfAxtr7yoJeEZDKVvFEvg6CNsbSFAxgK9mny7VqyenXgnnHuihyLXdUEF3z93o5cY7lD2s3JaDpgRtjWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763626652; c=relaxed/simple;
	bh=jSg+SjgNe59R18eQPCEufQeRLB5mrC0B/Yvf8NJlr6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F3orAbsFOojnO+xCZw9uehsvr7fQ5CJi5zTVATr9Y9aZDWIQN2CEUMPVmMFMCWLvDqF1/qYEvB7z2tuY+IWun5hod4FYp8fctep3zaSxTTCT6JVXwxrMmIkpOhd4uk7ez+N+kvYDAVAqNEMBI2hkJSkiztfsLUHjHeTTMPmqcsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dT8hMGLi; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dT8hMGLi"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b983fbc731bso92338a12.2
        for <linux-hardening@vger.kernel.org>; Thu, 20 Nov 2025 00:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763626649; x=1764231449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSg+SjgNe59R18eQPCEufQeRLB5mrC0B/Yvf8NJlr6c=;
        b=dT8hMGLi16xbgK6SbqtPAuDtyqpKG4JWEwD+7vCw6/Pv0B4E2h2thgceUar38J0MCP
         Z0Up9Uek03GchNFRTE7ik5Lsatl/4ei5+sQQc5KtBEB1kDgtIrg8Q4edfNTXrEv2PV1F
         abmiLVFihYTVDIfCK7P6cZb6V8ysSv8bovZCSDK7l8YcWIapaJDPEmcnnHOf4w1m56yx
         pVzbcRqaYxLa1OBcYXRWmjiJvGetWdy52iyuy08T8xnT+tBRZYjRpwNdvEUHYyt85MZB
         ibd7T8xEJfYFL5qKBFdLs86gmJqn9lXVTogzFBbZMsMOkqfEQ0DuEIkFDR7Y1uA1iK9l
         MPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763626649; x=1764231449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jSg+SjgNe59R18eQPCEufQeRLB5mrC0B/Yvf8NJlr6c=;
        b=WpWXHzldiywnr+qM0zlu66xX2j6z8znYFTVRDYDYqluTZOcuO/ELaTAitx7fkQ/EHL
         tPGNsmppHuYVM8QouRbNh0bgFfYdfwJtzbgaUhEHN56pbvfgJ3ptZniwHg6i6QfnY2+Y
         BfFHAX+UfrAqK6R/cOG4zBfgwDZ5ebSccLIw12ohzAWKQ1Ocd8ofwUCc8Xqi0krBiWX6
         pY1owIoR8+wgmDfhEbDLy2R7IbfC40vv1710IeYnlENIoUYXIkKOd0VfjHbQkiAS1ZBI
         1X7KGHZNvp6h4H9GjRIJvaPkOAXxd4BVaFVQpvg2ZhzSFpuv0wz5bFJuIvqcRpKJyXJJ
         NUMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/4vsc1xgnNoP3DJ5Iziq0ZwdFVGQT6dXbjKtBMr/t3rM3Kv13AguvsFBPI5C5QiRv5en55Z9erdgnPkT3Ag0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6qCGTNT31y9pf59XNF/1OUvgwEPSdh199pZFJfgIlf8DfVJjZ
	t9batQJFnvW1UDL2TlYFUtrqgkSYqz3pPh9sYYFRFzXmjqikyPXsjiwy26G9vSNbf5LRyJZzlwL
	8L9Bwey8Ucd2RmjNZraVkNgZi6h1WzHw=
X-Gm-Gg: ASbGncve7Vz2bzqp88d+FVuS3RxxM4LH7XM3NKs6mfaKqcFcIgy0RvHOgAcvJVVq0pB
	T69oF/WsvgKQdOGisq1sqnuOYvnc13oHzZbdSLX4BWRYA0HulFOumbJ5Nl3jKhzVJbrnfiMFHgA
	GvbbwtwvMkTfF0mR9b11gUk77p0+fl42JEn7x/blwepMb16/43iVkAtxgtW+f60AlNF7OnMEwSP
	fjsh9fulHZYDfBI62pAtHNyl77AFmyWAjFD5Ncc9EeSsMwuCMVRM6P7vf30dv6tUOZUb/EvsAtJ
	dHL4XmHtzml91Cx0C2iXH93GOcxtRJzSTpVhO2SRCrY05PV2cGWX/uEOZDdhxE45uZYHpXwP2Tg
	qiaVp8VuJC4VC8g==
X-Google-Smtp-Source: AGHT+IFSV3sHtvtqDssKB2tHpRHUhWWlo+eT4mIcaa6dljUhAh5xLV/SY3Emuw0RdaDjo7y7x6bkTKs/Knf+/gs8ERs=
X-Received: by 2002:a05:7022:670c:b0:11a:344f:7a74 with SMTP id
 a92af1059eb24-11c957b8c00mr390496c88.3.1763626649168; Thu, 20 Nov 2025
 00:17:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119224426.work.380-kees@kernel.org>
In-Reply-To: <20251119224426.work.380-kees@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 20 Nov 2025 09:17:16 +0100
X-Gm-Features: AWmQ_bnDAuYyVCt0sQ-SmVRcceof0nVsQqV57_bNcnOtwbEC3sZ09od5B_8jyf0
Message-ID: <CANiq72=tzUPrDd2=GBnqxm_PmjF9nT3iVJ5ZT6AiZQqkjvdH_g@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Enable GCC diagnostic context for value-tracking warnings
To: Kees Cook <kees@kernel.org>
Cc: "Gustavo A . R . Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Masahiro Yamada <masahiroy@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, linux-kbuild@vger.kernel.org, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Tamir Duberstein <tamird@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 11:44=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> Enable GCC 16's coming "-fdiagnostics-show-context=3D2" option[1] to
> provide enhanced diagnostic information for value-tracking warnings, whic=
h
> displays the control flow chain leading to the diagnostic. This covers ou=
r

> existing use of -Wrestrict and -Wstringop-overread, and gets us closer to
> enabling -Warray-bounds, -Wstringop-overflow, and -Wstringop-truncation.

I am probably missing some context, but in what sense gets us closer?
Do you mean it will make it easier to understand those when we enable
them? i.e. we still can't enable them until the minimum is upgraded,
right?

Apart from that, it looks like a nice improvement on the output from
the PR examples -- I didn't test it, but the patch itself looks fine
of course:

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel
