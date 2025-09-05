Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE302765C3;
	Fri,  5 Sep 2025 21:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757109074; cv=none; b=BmcTYN8LssK7grRXStGeBGWP3+tweKXz0ftQkJ0e+cBluDYqlMw2yTVIFy3SOYyFGzNZo7tccUlPz+wvuA5rnYo5F/367scHIT/pXg4Re4Z23DZwNgImbYSEwtltoh7xh7Ds5VaA+82bThkbhZUsPcgsTu48ZaDz8c+Te6ZfaCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757109074; c=relaxed/simple;
	bh=HFuUBNg17Dsv5PNKZrclLm9He3XFocEw32aESCPS1Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EETz/KhVF8/dYzCNyvGEG/3bDC29BqygLRGll1XQh/0BEkg+nPTcroEx7H3sKmwEGqzetCh8f93eHjkGaKWJ1qj4B4CAAyaUG6/vlOC7DGPI6+khZNL9Bxp4BSOD1AHEJkqt3xuKIThkxkMCpHCBurfFbDgeWnUJwA6Jce+iWk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWt8QAJj; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWt8QAJj"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d5fb5e34cso28195757b3.0;
        Fri, 05 Sep 2025 14:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757109071; x=1757713871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HFuUBNg17Dsv5PNKZrclLm9He3XFocEw32aESCPS1Jg=;
        b=eWt8QAJj5qAXYI30Xi0IW8fXr65gvODS6wODE9q+/4PkdOvIbrgNCWwA6s4RGwdnaU
         PbEAcZNOQxPXnSe3+W2C08dm0JcgyABiizTWEalRXTV2wSq9HaMVyJeXV8NcoNSFaeeS
         sEMvikhc3WUC0w9Y/8Q0LnbITZ/4G2M07q1mWBZNrGFJV7h+Wr44cuGwXSW2R65C4+5G
         L3BXIektR4pplHwOqcWm3iOTiv8WrHmLbMAmgX/Bi9oMAz7AixTa9CUUdPYe3+2bFhp7
         lFfGYtLo3yT/ma0YytEAEwmOdwhkO8HwAEGabJTt35mmp29sU2Bg/5vP+sAISQxTEBn8
         TuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757109072; x=1757713872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFuUBNg17Dsv5PNKZrclLm9He3XFocEw32aESCPS1Jg=;
        b=iqDfnbqUnWKeY6LNkd/SgoAiP9fi1DgfD8HMH4QrJsT9+bT9rRzd4XGldzqi8aJS7O
         JCoaz9WxMFvNKQ/xKPwINzdQ4yE6hlX57Z3e7Tj7RPkI2CAA14+pCT+m/6IM5JGTsLvP
         0boqrGAkEmA6q/27voHYPJwnrDnofHfega2nwqlrvFfDyN5rfrF1oMuf4h7X9yRyxe7E
         5XRArTxlIgOT1RphGIGTsbBy9Alio3mqfN6Q7M+zTWmaZrY7sy9O8Cgd3c2XIQGV0HGj
         pcSYkOlSkGN7ro2tQff/pn3/vTlSlh4JTNTQTBOdgIpyJHEM9TFbR9wuSxxAGT1jK6x2
         80fg==
X-Forwarded-Encrypted: i=1; AJvYcCUAxC4rCqb1yZbwxLtvAdbHZMI2xO207A+yN66JDSX+wHYVtXUwPxRNtHiobMnqAwlrzkzJBluuS31+i9HJ@vger.kernel.org, AJvYcCX3rSEWPwoQlKyncwuo6eeg7CIKAlH+7cxFUx6/uEAVWV13VZTs1dp6N+d6+kqcX76mI4iCJEnwvruHY6k1aNw=@vger.kernel.org, AJvYcCX9QAvGXiRHbaiHt0XkNlsbGcnlv/WWWzJ3af6eKFz6n714S3Ybe2aq+yALn/svSdyuTk7W0SWU6McI6v27OxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxEUzVj2rkY7qBnoSpolu/4XbPiUo7lu/33mTa4pDuGifJnGcl
	9bz5vPs5+K+MEKU07rco63DcTSdUd6HtSRkHBUdxrl1SO63hXjDPTCdNT2FMJA==
X-Gm-Gg: ASbGnctY8/RHZH+WH/lH2N/HbxRuNwAxJ+cK2NHRNi5UtsJw8aorMFMyFlP3Z8KuvwV
	dXDy0ujNX5PtqeTOuJ1kiyaAh40DIRbE9jjapE3Gv6c5f/KqlALaF02lb5dBd/QZmjI/kZqTJ1a
	7L9cKkDMPwS/zcxHh+36R4+xTHvCm3fNZpaNcwQwJnuvVwgnihrDdgXnY24ZrC6hkoCYuOymnYB
	DTaxomJv5VT3zoroRNJTRcl9tGwgrVW4KWtkywYfDQ8uwH/IhRRLNtHOePMEAeyMuLr4d0sSyRW
	VWAyCqvp1Wts9vYPTLligBFmipSi/WO1PAHa8M8d6b0OOkDL0p+chkq5Z7nnKHvzaxw8xHB6HBH
	7Sc2NoqGS9VgzG7XrQMveptdRIia5/w==
X-Google-Smtp-Source: AGHT+IF2B10aKZRPwqQhGEXNBgi8R07tHMhFR6m81m9sV3gvxshgNUtzJ+JZMQjUGmyXv/b/i2NaXg==
X-Received: by 2002:a05:690c:9506:b0:719:d8dc:343f with SMTP id 00721157ae682-72545e86b35mr42503947b3.15.1757109071546;
        Fri, 05 Sep 2025 14:51:11 -0700 (PDT)
Received: from localhost ([2601:347:100:5ea0:a745:ec:6416:ba44])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-5ff8ef2b4cdsm2425401d50.7.2025.09.05.14.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 14:51:11 -0700 (PDT)
Date: Fri, 5 Sep 2025 17:51:10 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Burak Emir <bqe@google.com>, Kees Cook <kees@kernel.org>,
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
Message-ID: <aLtbToZn26cEGH9J@yury>
References: <20250904165015.3791895-1-bqe@google.com>
 <aLnURXW_ZiX2iJd_@yury>
 <CANiq72==48=69hYiDo1321pCzgn_n1_jg=ez5UYXX91c+g5JVQ@mail.gmail.com>
 <aLrjNze2_L_vAnWX@yury>
 <CANiq72=KyX39_jyZNewithy-bVL90wN2mg=SQokX3ArKF83B6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72=KyX39_jyZNewithy-bVL90wN2mg=SQokX3ArKF83B6w@mail.gmail.com>

> As for the tag, you are too kind :) It is such a small thing that I
> feel it may look like it diminishes the work from Burak and others, so
> I think it may be best to drop it (and anyway I didn't take a close
> look at the code or the latest versions, and a SoB would need to be
> added either way).

OK, done
