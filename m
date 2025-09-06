Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F011519E7F9;
	Sat,  6 Sep 2025 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757168644; cv=none; b=h5edncdCa3C3ByRqRiu3FWmdrtLcjI683T/QeGYYTj3+vFguq3slWY0oCzKanPzZNi2bV+727Lv45SBJxpGYQZVq3j6UeInXqougpFdCtDY0Cs1u23U4zVZZMFYHA7XhK4C8P5/OFfz1OzzxDdlKmABXsJ2Zizhwy92ETf2GYpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757168644; c=relaxed/simple;
	bh=7iPFonw0euykaQuo34TwcPk93plHO3+9T4C07Hb+yxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LR97M5xWLywuQ4rDwNYk7vRsKooFKaYg/L7ZEqkI5VUhe3PMUKmG8vUQ8ILL4bMZ92NIpAHepTggNHL/a/OnQJzJF/JiALPWbVO0U3RnnG5nRSWMk+oLxJRgXINQ3VscwdYo0akp+XQrNu4zO4PDdVU6a25iYcI0dyv3J6abN6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjDZlJj9; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjDZlJj9"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e970599004aso2725228276.0;
        Sat, 06 Sep 2025 07:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757168642; x=1757773442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UNEaIdm3ocr4DeKbIIic0RyA65Rlfh0XfIEfp2GIVR8=;
        b=IjDZlJj9jZhuRh7PyXD14TDrsuraZFoCPPN5kcb4Nz7fPKf4o1pQEy/AnD+t/fkbHs
         w2vRkxBB01b2F5o2TUivNIrJJR3VuXTrwg2FzMLIA3Ke2bqFMVv9Yb5Ml5Km3z4KvQFn
         8lhrKf+I1622vg2Z7pzu6oz5+hBKMa40VmqsOatb7kI+xhX9nb+YCpuCweihubebHZQy
         k36MRsiowNr0ekBJzjs/TvnygCWZPrlTRAZS1PLCO6oRUfqZ4l2PMIHDFPHRWQp8mvUP
         mJWvR7stDLDYs58iycSq8b6jXjlmuWlipOLUnHDjIdJsNoGRLuBP/XfFNJpKh4/+0MRg
         sWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757168642; x=1757773442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNEaIdm3ocr4DeKbIIic0RyA65Rlfh0XfIEfp2GIVR8=;
        b=aVTnusRMXLZ0dc8Pvx0wTXpODsdZvrrOzqaq0qLNu93DXFgavgklJrpT2r3HlnUxgH
         qkJMwPw65+M8rnMbcSLIMUa3jjs9bC5mTBwG3jgca17v7bSenvhSid7MbWAKsWJs5hsD
         TC5jSus47LCwKU1B14EeayjxTeHG/3wKm+2BWUjxnonRP3te/vE+JtKQcnZVVZAqs8gz
         N/YKNZ6Rh5ZBw2QQVLvNGYa1plc9DDqdiDqwPTlteUpJrnASGmaD74koH323Lq8+M+kU
         k9vvH4CcN/chR8QBGDtt2XKQfE+F+zf8+jsJT81+mfGHVV3+qomiYDJ3w/P4TJW8dCNB
         y3xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh/k0IgPiMqeN9XteHZoPbr0uU3uX87wifNiO9emf/EcF4XhlKgemtHjeJlH28Qm6uNv/g6C8vKBL0A52mvIw=@vger.kernel.org, AJvYcCVjC900CeLP8YjgQb6dj7FQGaeX5rMMJOV7xBx+MyhlwAh92tvlu13BZzOZkmMjq27AcWzWcLrC5Y+34M0d@vger.kernel.org, AJvYcCXhLLlcxcl6nXcrnkUgnASTIxnxfiWVyMXMnH8rZOkvV1f8qfFdoJ+viUu8YgK7gtDcAniPZe0f9jRRsweekps=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvlS5sRfVQaYzYPonH/exmqOCn3PKHuPHhVmzv2AypYFUSvea4
	n6bLNpy926opwiMACnSp5wsfst5kvzMf6TYgREqtKA/4WqkKyIugMpmf
X-Gm-Gg: ASbGnctcqQo5oZYSK2CdnxKNw2VyvHQdz/Lef++Gzm12eJMcQMpwa8fn88zO12rgmjT
	vvUpJPXNOx4LFlOzZduTFN2xtUoZg1O+fNWJD+NxyIi/mL2JmImSyOGNEiuF2vXPn/prUz+8Z1h
	t5g1VePTKwPlEH/UNWiINrNa4SPLabY+qRv5f3pEI0R+wM+Q0WAZWMDC8ibfeWed2FAl18ZK7tF
	94pR9F68DzWNHU/ZMp4bYk4UEN6LhyThm8WH4+rRrsizBLL0HUeimljlbvOeelapCc+iT4m5eNX
	NoTcGJGw2BSyWjvVEkOXoI/tbFIHilBxLOkdG4ObTVlGjcAnyy0iY0rKDByt6Yak25+/hdo66jZ
	mPVpraHzUU+4CB/25xFOmTBAJSqAyFpLiBU/E30u6E7gfUhRHkyRONeIMUg==
X-Google-Smtp-Source: AGHT+IH9gN2k+8kmiveMAZcSh668m2bJH4EFz/Z/HrczLpSxeO2TWFRwReFHlLCCEh94v/Ao6JhExQ==
X-Received: by 2002:a05:690c:30a:b0:71a:34f4:7530 with SMTP id 00721157ae682-727f28e3a55mr16140877b3.8.1757168641743;
        Sat, 06 Sep 2025 07:24:01 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a82d6adcsm36985657b3.11.2025.09.06.07.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 07:24:01 -0700 (PDT)
Date: Sat, 6 Sep 2025 10:24:00 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Philip Li <philip.li@intel.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Burak Emir <bqe@google.com>, Kees Cook <kees@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Carlos LLama <cmllamas@google.com>,
	Pekka Ristola <pekkarr@protonmail.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v15 0/5] rust: adds Bitmap API, ID pool and bindings
Message-ID: <aLxEAK33V-4VWHI8@yury>
References: <20250904165015.3791895-1-bqe@google.com>
 <aLnURXW_ZiX2iJd_@yury>
 <CANiq72==48=69hYiDo1321pCzgn_n1_jg=ez5UYXX91c+g5JVQ@mail.gmail.com>
 <aLrjNze2_L_vAnWX@yury>
 <aLtautgAVKdqNv2R@yury>
 <aLuEZQhnp7Z04EOg@rli9-mobl>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLuEZQhnp7Z04EOg@rli9-mobl>

> > > Thanks for the testing, Miguel! I've folded-in your fix and added
> > > your co-developed-by tag. Please let me know if it doesn't work for
> > > you.
> > > 
> > > Philip, is it possible to add CONFIG_RUST_BITMAP_HARDENED=y/n in your
> > > testing too?
> 
> Hi Yury, got it, I will add this coverage in the bot.

Thanks Philip!
