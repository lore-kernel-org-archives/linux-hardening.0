Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F171990BC
	for <linux-hardening@vger.kernel.org>; Thu,  3 Oct 2024 13:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727960887; cv=none; b=UK59i3ICU+YhxG5Szehdp7j414hR9zZfyJ/GO4gVbRgQvxxpdRgHNxJwSdU2gO0LeuZYPkEdSFYjY9W66D7GdvG2JH10RadD7pw19F7zcc0Yushu8SPe3M+M1H9MuZyLD4ZQtKuHfoyj0DH4IgEO3YejuBwJ8r3Prg7CjsudmMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727960887; c=relaxed/simple;
	bh=YoGgqyZROlV9Lc6LUp+WIsr1dOtzf5CY++FV1FC/vBQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=e7V/E9JLsKGgqewBIN3h1IDzw1k6qDIUQzy4LsQPMaamq3T1lLG4yShF+i5d+Tey9KcmUoq1p5fA9g4vK7tGQYfpLct9ZyWZA42uNIVV1RgPDY8r8eMseg6z20UVYnq0t7PVM+fBbNwcdmPhc3wILgn7lP4uPt2TVynxP2hUdLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=3Fm/QOqp; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="3Fm/QOqp"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42ee66c2c49so1399605e9.0
        for <linux-hardening@vger.kernel.org>; Thu, 03 Oct 2024 06:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1727960884; x=1728565684; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YoGgqyZROlV9Lc6LUp+WIsr1dOtzf5CY++FV1FC/vBQ=;
        b=3Fm/QOqpM/PYF522FWkVo8T0uDCXNRZV1dO0lLuElsz8FDblhM9CCA032Ofs7BCRMj
         nz4vvYt9LNuKjjLar3uZoLQFsAuMhzN0PjMZ5fOsmBphKr9icdp9TAXq8+0pce3fANxO
         Kb5mB40DAkSfSTyvPwcq6jCU76wixCW++WrQgwnnNhZbQRXFH47zX2GTP2mavzaO+9W8
         GuHGYlkaV5H51tExK5Qiy5GvfbvJb9xm7bsTSj3IZq9OmgfD0ID/dV0mpHngDg0Mao1c
         KF7XrrSUnQ0j+fD5SEres/btxDNho9IB8gOf3stw6BsZ2mBo6PwYDky4DDVyXavm7h92
         PnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727960884; x=1728565684;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YoGgqyZROlV9Lc6LUp+WIsr1dOtzf5CY++FV1FC/vBQ=;
        b=NZfwKzU28eY30o2fonxF0eUSiEWP0MvqGMz8zFzEyYSIGQlj0ghmjQVspx+FW9TysH
         r/FWzgDr6nY42ZlmAgE9AbD+Hd2qs++g5KIKBDG1ZEPkdSmS5gL++bkaAk9tFPfuPlxU
         MkF9Rj+7883uOu/w8vRgzKbWHP9ip9JvJgZRDzZ1ZZT4hpx46btW6lRMKDviFT5hhI0I
         OtNuxjLo45R+iVX4+XSe+/g5XEz7FljJ8eKCZfV72B6YG/C3C81fCWSS3ZtxTrzM2wcj
         msCwIZ8GWb9/lwIogzboeJjzCr/sl8t6BpWzQueVgOzSSVoTd9rT5vFa49z4euRJUp9O
         ntCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhWsOJGu8jupNvkqizZKwbz1vE7Saf6+LM+3cOrVS7Ahq/ipBLEVR48slJ0ZQRrcMe8oVBRJBtyh1VQ/UpCro=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVdkZyQD0Q+zaDH6T/tR5SGSBOPrWhHTf0RRmKvSlSwA+RRCKF
	N4Nh4modTG+e8CrTwzo2jZmDQ+cfWtMCkzjWZVaGKfBp8OLXciX6XMIwOW62dZw=
X-Google-Smtp-Source: AGHT+IGbzGlbswZSZv2eaP5enEwx9F4DDc2D16GFzfToew/HsmbM50cqjKCZ2M/OIQtHk7bhpgN5xg==
X-Received: by 2002:a5d:5f82:0:b0:374:c92b:80a0 with SMTP id ffacd0b85a97d-37cfb8b6267mr2457441f8f.3.1727960884178;
        Thu, 03 Oct 2024 06:08:04 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:a4f:301:1558:85f1:4dd0:3ea9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082e6dfesm1235078f8f.117.2024.10.03.06.08.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2024 06:08:03 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [REGRESSION][BISECTED] erroneous buffer overflow detected in
 bch2_xattr_validate
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <Zv6BEO-1Y0oJ3krr@archlinux>
Date: Thu, 3 Oct 2024 15:07:52 +0200
Cc: Kees Cook <kees@kernel.org>,
 kent.overstreet@linux.dev,
 regressions@lists.linux.dev,
 linux-bcachefs@vger.kernel.org,
 linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 ardb@kernel.org,
 morbo@google.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <E8E64A72-3C1C-40D2-9F07-415F6B8F476E@toblux.com>
References: <ZvV6X5FPBBW7CO1f@archlinux>
 <3E304FB2-799D-478F-889A-CDFC1A52DCD8@toblux.com>
 <A499F119-5F0C-43FC-9058-7AB92057F9B3@toblux.com>
 <Zvg-mDsvvOueGpzs@archlinux> <202409281331.1F04259@keescook>
 <21D2A2BB-F442-480D-8B66-229E8C4A63D3@toblux.com>
 <Zv6BEO-1Y0oJ3krr@archlinux>
To: Jan Hendrik Farr <kernel@jfarr.cc>
X-Mailer: Apple Mail (2.3776.700.51)

On 3. Oct 2024, at 13:33, Jan Hendrik Farr <kernel@jfarr.cc> wrote:
>> [...]
>=20
> This issue is now fixed on the llvm main branch:
> =
https://github.com/llvm/llvm-project/commit/882457a2eedbe6d53161b2f78fcf76=
9fc9a93e8a

Thanks!

Do you know if it also fixes the different sizes here:
https://godbolt.org/z/vvK9PE1Yq

I ran out of disk space when compiling llvm :0

> So presumably this will go into 19.1.2, not sure what this means for
> distros that ship clang 18. Will they have to be notified to backport
> this?
>=20
> Best Regards
> Jan
