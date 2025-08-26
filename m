Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F4B3054E8;
	Tue, 26 Aug 2025 23:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756252713; cv=none; b=YDsCklZE0pxsKKCjEdz2aWj0x8oQj7BfxayTKhXCvfzeEaG+4b2dH/T/LM5TTOk0LddLw9l7dAbzf+sulYPDUjTAKe1gRXeTAXVDVqsuMeOv0tUwQF9qiY2pluntRlxDbnHCwcLGU2X0HVj1lCWNgoDfbW7E0Ovqik3uRH4DXgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756252713; c=relaxed/simple;
	bh=nuHOdNUW4UYG0UK0IaQeNCpSxBqJKIEqqjz9V+bPwHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnIVFpqkTiu55FJ5CcyVe2LYndtJFKyfCOFzBSiL199tB82OflH2lgspYM8/Qc7TWFv+i8KBevqjJ9BBlXRWhbiZGxOElKECU03e3eABEGUzMyg4YOSr2hN0PC3zwcR2lmoCsS4wXqeOKx2UkyAQ1VWoYUkQFmvgBXL8a4SCZnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ff7kqvAV; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ff7kqvAV"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24457f581aeso47795685ad.0;
        Tue, 26 Aug 2025 16:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756252711; x=1756857511; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LamzE/gkyZ6yTExt2P4iRk+e9f4csO95nvxKEfx2wMA=;
        b=ff7kqvAVWxiFDr3zWdWfridvpENq0XFcHnRzF6WHqw2LltwZCmxwKoPGwbbm2/fKps
         EGiz+mzVm+T+DW/mwWkiQNUfibmLZ5LVfLwlStputvnAIYriGTvNcBKeTnX2z7VWLbW7
         EkF5AiOYUFRT+/XCtihw53x75F7wWg6rfZOAw+FhJ1EO0Er+EJ78d/imrLr3vWHgjr7o
         VflgI5u/ZjFinnjGA+bAbmPuETgadCgmu0EZWbJWIxkjkrcnYm+6b4RT0BDZbRv4Uy28
         v187ZEIkXA3/8ePu5epoIVJZVmUfs04gdj1g9xgbntAAh0XDeIfwGNEliQ1C8eG/387T
         +gBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756252711; x=1756857511;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LamzE/gkyZ6yTExt2P4iRk+e9f4csO95nvxKEfx2wMA=;
        b=wC4nghUbE3iHiD4YhbPfwGDUFPVGIRFIiruGsR+iN6kIabQxLoNgPo4eHDeQ0stqrI
         L33DzyrBZpRgBRI5GYjlEgtejlsg6GE1YrgPSac/FFoSPsgfPLf+ieAN4BIcvP8HCdjA
         H0RaGTMoVfq3sfmPr+YrlNJIb3P1JMTfffN/XmI+HDixlm30jYLrGBwdn9siThv0Xda1
         KyJb6pEpYEHwOemBkq/qgEKQDbhHfgwo9fI/88jo80wivcXxB0EhyopAaOxx1JXEPkOv
         KhAqfcOQskr1RY1dSVHGyVzgm/T5WKpxA4OhpI2Q8kFQWqritSG+hPcSFIsefdaw1Vxl
         7p/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjmNjZrE5/mvmzdf/glzdrMFzFjAuxhTwDxruoGlJWIIYe1pkyW6K77syRSBtSfCeFSj9Ns1YGz+sDRqEh@vger.kernel.org, AJvYcCVlXS8Cn+RgCQI8hFkSx0cmGsO6Ei55Fe1ucGulAeNJk9mJk18+8F3aW05N2Qj8dVXdL3ZECWmYHPnqJLGQvPs=@vger.kernel.org, AJvYcCXrN2laKSbVYGCvVa6/EOY5qyKzESZehY/cP+ONAcJ6l07P/AZnzOFNF5r0YDcLCzSj2w0F7xXyyLh7ihJ7Vpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK3UdwV86jHwUD3Nd07zqLYZCo7qY3eAmYznv6zXSbESJq7keq
	H+4BHS10Wo4Ds6wyBHweM405D/QaMwpMB12GS0sOMS1wHz1Wk45yBrWizycyuQ==
X-Gm-Gg: ASbGncuJcGvCr1Q469CDm2fQ2lFG874jFzP/jjMrqOa8v9p/8yx8K1q6CgJk7IkPIAE
	8XdkV7PPdqSPzk4n7NwVdnoheuYgb2QyIbrNSmDjmpIdLtjlHplwlIWwsQbqqQaUVO6DPDi0KZo
	MnSWxiv/KACn0r+sbA0mdnykmo3Dyie3VLH1i+znffRv0yb8XXpzHP8CrfUDuVghGuA65twyvuG
	SQEjNRDerhvsH5tADdo53unPHBm0gp9iUcuFbOpq5kMf7nWiXrx6Su4S4yl72miKrCnLKq3qEuP
	STpdfrkUYGvLLTkBxMfjWH5l13iTqihiy3XmRXmprzf0bmFmV5X7g+Ccs4OQXy0Ecta0NsJWCLR
	XTy+veHAX0MIBHhcydXciAMyxMkJ8gO2I
X-Google-Smtp-Source: AGHT+IGJnTblXdsI0mMrMQt5u+A6j8f+FyXLu8UqL5X6slJcm5QeUphMrjj2NZNYIfh16tAIwDAsPQ==
X-Received: by 2002:a17:902:cec2:b0:248:7513:14aa with SMTP id d9443c01a7336-24875131ea0mr42030715ad.21.1756252711161;
        Tue, 26 Aug 2025 16:58:31 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24877ca9d26sm23620055ad.47.2025.08.26.16.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 16:58:30 -0700 (PDT)
Date: Tue, 26 Aug 2025 19:58:28 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Burak Emir <bqe@google.com>, Kees Cook <kees@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Carlos LLama <cmllamas@google.com>,
	Pekka Ristola <pekkarr@protonmail.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v14 0/5] rust: adds Bitmap API, ID pool and bindings
Message-ID: <aK5KJDSDKiOsQ4gN@yury>
References: <20250813153548.1650533-1-bqe@google.com>
 <aJ2Y21Yjs3a0CnAo@google.com>
 <aJ4Y_DAZe__0EWEm@yury>
 <CAH5fLgid9fF2fb06No9zmeQfru_nQicaM_9bb+DWe3zsOwm_cA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgid9fF2fb06No9zmeQfru_nQicaM_9bb+DWe3zsOwm_cA@mail.gmail.com>

On Tue, Aug 26, 2025 at 03:58:01PM +0200, Alice Ryhl wrote:
> On Thu, Aug 14, 2025 at 7:12 PM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > > Thanks a lot for doing this, Burak! I gave it a spin locally on
> > > v6.17-rc1, and it seems to work.
> >
> > Does this mean Tested-by?
> 
> Just to confirm, is the plan that you will pick this up through your tree?

Yes I will.

This series is very related to bitmaps, so I think my branch is the right
place to move it. Let's wait for a few more weeks. If no any objections,
I'll apply it.

Everyone, please send your tags if you had chance to test and/or review
this series, especially the rust part.

Thanks,
Yury
