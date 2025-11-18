Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B348B2D94A0
	for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 18:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763491190; cv=none; b=Hs0+XEuNZw9qGeSFueJZm/gvfPPgErp04uBq8sSW1jTtmy9g2XpwaX//JYrI5E006STKs56t1Q2c4a2/8LSiR6WMJP4O+8gkyGkHykYOeTmBFw/8QE3Ezyr5XHwO/b9E7q1tZZxQTrl5cMue1qt5Mdc4reJrS0hOVt4medpAUMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763491190; c=relaxed/simple;
	bh=SftSHA4pwuW3hwjMIvWLAVH9Fj+Y9tog22TOJlfgyWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MROJ5ZhbicGpk7i5tnnHfS8/juwToG3MV5qFmVo/oiFcLcbvOMkrzuFd2Twg5q6x4nPGIeCUCXoAqHieCzZfMS4FJGqZdcbonHMpljyXwnszwI9N3IYRavTnu+rAaRR8Vmf/qnRnCF1hxANmQ+uivX+P1sfnLgUEgcSNLS7YPNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vb4G6AgG; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vb4G6AgG"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-bc274b8ab7dso4142802a12.3
        for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 10:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763491188; x=1764095988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SftSHA4pwuW3hwjMIvWLAVH9Fj+Y9tog22TOJlfgyWY=;
        b=Vb4G6AgGXZtkbnSe34z/2V6G+b+2lzzAK5jfOeRr+/UlI1xdL10mupV3MSQmc7x1Ph
         RbC+nT4/flAb2qtD4RUdwkdwZmfFor2kO/C2aLNCYJAh2+mSnZh8fLmDTF9h0C8lM8BZ
         sWW5EoWb53Ob+3oB63nKykCAzb3mui8x2naN9MngmdMitGNDAJ7oeFIWPK9/LZElADGi
         H54FYHczbb+5nNXNiZxiwvXmOck3A0YnPX2xC1qe7CgRatp37JiF4Nhd+EffUd8Ow+i5
         878u3xq9mfAq6NA9SITcWjjPUyNu8BfVle+DUVJkUrHoki97LeJTUS3dNpgGkV6m21ym
         eZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763491188; x=1764095988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SftSHA4pwuW3hwjMIvWLAVH9Fj+Y9tog22TOJlfgyWY=;
        b=NrB+dxEBJ792ecF4YmEBF0/mrCVnRFmfl80+n2Oa+Wzw7Umo7Ikcepu9hBweL9uFi5
         bR88t0Za9t1jh86326Qx2bQt5jbyINbh08l0WXA8YsYNG+jARtxi+jSWzvQqFtuRZz24
         MKY2BWewmJNJ2eWrC8P8/S1NsxA0/c5lgL+nFHy+gujqE+asnByq2yZ286vtpHfZ+9N1
         RMC/ourT11dhZS/j/OmfV1yPJovem0smmQapWWk4816Y6xpc8ZBVQV3003RcuplW4P9Z
         /hE2+Eg/0yX1pLuIHl8swGNf+S0AzVD8OH/LgH6CskdG5+/f34tUgpW0iIP0lxBVFmn7
         q8QQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo9qNeP7E9v79bWr5ZyXWbbEGo5cERh71eIa3fwDKJGcrjGN5qxQggm+XCtPJgVlrm3ncKypXoNmOkuH5yDD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyosti0WSqFFJobY9eTO5+lSkbyEFrWimUvKjhkH7KYV099wvQ4
	1XPWlsSDaD8PHo80cPoLzMeTrjhjw0IRMH1FBEyV7oh6wcc3QdjPXJ4lGpSrDUH12yS3LCpuepv
	1XJOhXb6jIXUvC/5razbqzFJeNixsZOkk5va2ySQ=
X-Gm-Gg: ASbGncsDQXWvFQtdv3lVFIM6jcAmu+7W0lcRUq0IKhAZn0KZbQi7ewQxGlXZkSsQR+6
	ts1ZXr4eSfmMwp7L6YBOgGV2bnxOeoAERh2DK+tiFkx18iqMPv7crdrcUvb82aHwmFbPU3Nnoso
	c0up4CUuAEA/Xx8B3ExYpreEZVoZdUl9n/HkC/wqqhe98bSHPDeYbezSGFR1rkrUrR2lkA0+yQO
	ieAfauBVFQrNvu8DR5s2i6wv5o+k6Qr+9tbPUsQlIT83iLQRM1XW9Kyczl4hGbsRmJpL26L
X-Google-Smtp-Source: AGHT+IEA6VH8m9IPg8JrQ5kwUHoR4zbwxf+KMAPlOxovvhBQ4E6IQ8Uwmtc9DTHyzZIUH7fc0+EX4lmVCKTEA692EAU=
X-Received: by 2002:a05:7301:fa0d:b0:2a4:3594:72e7 with SMTP id
 5a478bee46e88-2a4abb23ecdmr10176137eec.22.1763491187893; Tue, 18 Nov 2025
 10:39:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118180008.2620929-1-kriish.sharma2006@gmail.com> <aRy6jISBogIIT-0o@ashevche-desk.local>
In-Reply-To: <aRy6jISBogIIT-0o@ashevche-desk.local>
From: Kriish Sharma <kriish.sharma2006@gmail.com>
Date: Wed, 19 Nov 2025 00:09:36 +0530
X-Gm-Features: AWmQ_bmfSltVjmNjoNJxAqNJRI1v-_M1M3nlhHDAxmODem0Q8z9qoXCZrU7dMCM
Message-ID: <CAL4kbROtPSbOmbqYnCF6zXRStxUyQf4s6GcjOgvHDvvWkPt4Uw@mail.gmail.com>
Subject: Re: [PATCH] string: Fix missing kernel-doc descriptions in string.h
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: kees@kernel.org, andy@kernel.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 11:57=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> strends() fixes are in Bart's tree, will be soon in Linux Next I suppose.
> The rest seems good.

Hi Andy,

Thanks for the review and for the heads-up.
I=E2=80=99ll drop the strends() changes since they=E2=80=99re already in Ba=
rt=E2=80=99s tree
and send a v2 with only the kbasename() and strstarts() kernel-doc
fixes.

Thanks again for the quick feedback.

--
With Best Regards,
Kriish Sharma
