Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6D827FD59
	for <linux-hardening@vger.kernel.org>; Wed, 27 Aug 2025 16:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313204; cv=none; b=XnwJEpFCNlhM/VmqxdKwQWW364WCJy811xctlAaVz0QF33A0Nz+dYKnN/ptDerySeU2qC9HX3SWCcRqRZ8sYojCOOxInpLB/Qh7aKtSDT97Jdzhp/ZQhSK1gjIGcwGMRNhTviUm5IEkndt+B7IQkCxk8oCKzjcptCrgAX41WOQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313204; c=relaxed/simple;
	bh=/Oe8mL8TjjkGnR2jG5Rxs9VLauseuU6oqwYerqQXRro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nKEBLR6ndlxa4o0P4CWIPNyNSgF9c/L1S3AR9muwDUYhYj9KSq8PTw+fFYXwe5dPv/JPdC4DXUSRA9RbvR32Tb4bLqK8mEsJ6EyODAT9wH9T0JexZHzeCi5E47F2m/JB+h+pZHHDwHjhMYklH1MkiBW6I1SaP47kdvxwQcm4lLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Y2tS2rwK; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Y2tS2rwK"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55f4345cfd3so58341e87.1
        for <linux-hardening@vger.kernel.org>; Wed, 27 Aug 2025 09:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756313200; x=1756918000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Oe8mL8TjjkGnR2jG5Rxs9VLauseuU6oqwYerqQXRro=;
        b=Y2tS2rwKaOZMyZh9ka58faXvzXrL50njDDYSugjXepp16GhbLbrRDic1EMKDEsQu7A
         Jo8yPVvxwUMzfjzBwV2r9dxBxeTg8sgMMKdtJapvfsRogNaVdSQnnGdOH4To/VCgFtyC
         CUbfx+Y3/frlByut4tTXIzvdnS1NQ/u3KJM1Vskoxza1szm03/bmnwdDzpkH5RArG2My
         2gh4gwuP36bc8X5O0lejMIEvU5eBN5SnnfgCUXUpwA1NBXYKXNpIyGPt8sbzR72Jml1z
         UlSgYZSxDKJluIOqB94vh/N4j9nleZMEJMlr/u6VmGxhfKuC3Q0WKTQtytRdteJ+0JV5
         cE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756313200; x=1756918000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Oe8mL8TjjkGnR2jG5Rxs9VLauseuU6oqwYerqQXRro=;
        b=ZiyP2x09jEEMqD6AAmtpi3SqDx5je4VW+Yx30kcwb1Qsm4tOxfA3nR8xiaPHm81oBg
         rwcYMOVwmyhx+cgnVbgNca+ud0hXiSftzPY5GtWbcwZ2q3oxSYmwTmNLyWiGMTQXe7c3
         QBYynX9PlssADGHQwSbpzwa8wD7HRQOwKC/HRvjRA7YXXZDLwChWnGA1bw/+k/6ZpT18
         FHJuSAq1eKB2sswa1IpnzN5vj825cQlWB53s1rS4jsjhhe8Sz24oCKpq+GP7Zk4NLnsg
         pwnNZ0hJaUyjodL2MbxUAftpWVqxdUFilIG9anIGDEKT7ZzjUwLHvLzSqGIdDF4uwWl1
         jN5g==
X-Forwarded-Encrypted: i=1; AJvYcCXK3lSLfvX3BAebRhLbcPDO2zrM7D/rPTYBXSqZFZNFLiWhFnfutEJVtjWQjmFRBRsGjzPFNZrcEI8OhtJIjAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZJnbVdi8PDteAxv+gazc/7FMCIJBulglpmLomogNPurrWP549
	QrEn/aCqIsToZHJEbgYl58xs6JPnvT5mh8cQaf835Az3UkgC87lU8DQVt+RHL2AgSh4E0qp5Ghp
	FiZiguH4R2vx02s3X7TV7wNFWtvLliLw8+PzQ4eYo9Q==
X-Gm-Gg: ASbGncv13APHV5OP5+0UvFqBZjLZwMW6CsrZbzKpSxyqWxWsdNdj14o4JrYct+nSPf9
	4v28ajJH3FXU+e1NZLAZKIcOf+vriH0T1r8swuC8b0VL5BJDo3wyJYNlLfLZ5bktuXgx5B5kdtX
	kQdIqfQaRl6328et1+b9N7A/5Z08s8YCO2ozb/sZwgUnQf/l+IxtHBzpTQGYkUJEZCX+4Zi04YH
	Xqmc6PZYcKj6W/cnt9GWfkAsKl1lRiCjHbva/qLSiqjI5HyWg==
X-Google-Smtp-Source: AGHT+IH2vScJrK3ld667OkWoypLYcKly6TqnbjFjPvpTB4KCLVEthUMwQrvNGz6iiIbdkdd5rCAEnq3AM7MI6KeEyo4=
X-Received: by 2002:a05:6512:138c:b0:553:2969:1d6d with SMTP id
 2adb3069b0e04-55f4f4c6a98mr2026962e87.13.1756313200214; Wed, 27 Aug 2025
 09:46:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815-pinctrl-gpio-pinfuncs-v5-0-955de9fd91db@linaro.org>
 <CACRpkdaDGmdhaik+1saRv7Ts4myQ+tg1aQqGU3xQyT7ma8dJFw@mail.gmail.com>
 <CAHp75VephepLq61HrVy=PX2oKUQd5NK2qS-vOC5h_NR65td3Uw@mail.gmail.com>
 <CACRpkda4soRCLF5=W=6R4wnwT3pjk743j022XfJxjTTQzuarAA@mail.gmail.com>
 <534ad082-08fa-42c0-9c24-f0c11af7d5b2@sirena.org.uk> <CAMRc=Mdn0_yPXyYq4sbvH4P9-h71vEc4arLPBfSk1PiEFaB7jQ@mail.gmail.com>
 <1804d9dc-8814-47d4-af88-c819c3f17bc0@sirena.org.uk>
In-Reply-To: <1804d9dc-8814-47d4-af88-c819c3f17bc0@sirena.org.uk>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 27 Aug 2025 18:46:28 +0200
X-Gm-Features: Ac12FXzUBjVjZcm1OFCa8B8Pt22rGMmSNEEFj8GwunzU7aycJyqw28vaNlWwNSA
Message-ID: <CAMRc=MdKgqa+vjhHvD2+Tjw5NwBtFv-0aUivi5UuEQd+n4KxmA@mail.gmail.com>
Subject: Re: [PATCH v5 00/15] pinctrl: introduce the concept of a GPIO pin
 function category
To: Mark Brown <broonie@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Alexey Klimov <alexey.klimov@linaro.org>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Paul Cercueil <paul@crapouillou.net>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
	Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, NXP S32 Linux Team <s32@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Tony Lindgren <tony@atomide.com>, 
	Haojian Zhuang <haojian.zhuang@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, imx@lists.linux.dev, 
	linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Chen-Yu Tsai <wenst@chromium.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 12:22=E2=80=AFPM Mark Brown <broonie@kernel.org> wr=
ote:
>
> On Tue, Aug 26, 2025 at 08:19:37PM +0200, Bartosz Golaszewski wrote:
> > On Wed, Aug 20, 2025 at 8:41=E2=80=AFPM Mark Brown <broonie@kernel.org>=
 wrote:
> > > On Wed, Aug 20, 2025 at 09:12:49AM +0200, Linus Walleij wrote:
>
> > > > The qualcomm 32bit platforms fail in next anyway so I dropped the p=
atches
> > > > for now.
>
> > > FWIW the i.MX8MP also seems to have been broken by this:
>
> > I can't test it unfortunately - would you mind sharing some info on
> > what's failing exactly?
>
> I've just got the log I linked above.

So, I've been looking at this bisect email and clicking the links to
LAVA jobs and I can't find anything. Does it fail to build? Fail at
run-time? I'm not sure how to read this.

Bart
