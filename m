Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC328226CFD;
	Thu, 12 Jun 2025 09:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749721345; cv=none; b=eS+gy51yGVHXSHfooM84aD39zcFstSKxDmmfcf/GiXIQqGAgYXJPZQgC6mcoyvYsZTVIIecPEIZEk7V3BUx3ijjdVD1IH1uzGiBDRO72f5rcEnLi/Gn9LmgMJSS+2zY51TrtTJcnmlhYfYcrtVHQiZaMS0cJzAXokRc6HPLMItM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749721345; c=relaxed/simple;
	bh=sq9hO7gy7h/F5/lVVGWDONViWmyI9zKZH6AWzPKe+7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=maGNKThxcOWV8pRHzWMlyrEwA2vb6AO3gjk07+CL2BvKCrvs3m190ZFxzPs/41yFkBqqMt8T66HdGxxbQICVA0QO3bs6ekjxHbO0HEZaNOrOxCHsEBtG772pqXUYngy8RK8iOUQSP0580O8Wgx+k5a/9MZFG59iByvkSrDeSCZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSevqgnu; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSevqgnu"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3131aa07b50so120336a91.1;
        Thu, 12 Jun 2025 02:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749721343; x=1750326143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sq9hO7gy7h/F5/lVVGWDONViWmyI9zKZH6AWzPKe+7c=;
        b=iSevqgnuIpAd6HJgU7+FwDuiIINDpLe1Lw+Y+eQr+O0DPTL9lqk2sA/WWxwGd+skRZ
         cXbc0P6ePQ5m6r7mz/qON0VNlewJaaR8wnWg2zNfJgehQY8DwfGhDsT0hzvj+Gp1Rgs4
         OM1X5KVJH2uRZOpNaMWkuQj3IJ4QMJGYlXyOLd38Fan6W4hAtTBVYMalmUMuVS/Fb/Wx
         3MQklPCDyMxL7AsI98mRhfiqJH+mSa8EIYTCqK+bN1OTb54/JNB1zOvmye1bgBeZcXsF
         GuXbabOOSPynQLC83bkQJ/SzgbnegxQpe1644LHRdD5ZmvGwwOA4wpuQquAiXe4n6HJL
         surQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749721343; x=1750326143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sq9hO7gy7h/F5/lVVGWDONViWmyI9zKZH6AWzPKe+7c=;
        b=Oq+Czv8PVgILDhXCU6r2hYk/VCIuh5gwMQ3Ay5qXd1kRvrizDm0ezQydEoPULtoTLo
         d8AMoG28ra7CR/cX06yQOp5kbtglChBhibjRvKf+s52vP/Mll1lCc+NcSmTgywV+y/s/
         a8bZ8CTLxuAFcJrmNXEdQ2g5qx3yjisBYNmAU9PT73sQePDCzVlWjcpeqkzGFxWFF9Ms
         Jui1ebusA30KcDAv25KF9gAkpHMH64xdqfY2K97a3Yg7JpgSMObwGoyDvY3W72TixqwJ
         5O2pB4gkPu5Bd8eGqtQpp3VoRDJy3cr3pvTfegGgKVTWGZKqjZl7XK0ywPlmLWCA9nPk
         9u5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgQPz8msRob+qpLpboucmf7gCipQMa2bKF1RgeviPWjONH1F4b9MgSmDc3KFzuFwHJKIz9Iq5/pkaDo97P@vger.kernel.org, AJvYcCUk+buU1Z+TpZaO9Ve3hRKplbiExCRm7XxG6L0xcSYxn70KOmBH2S0xDFXani2Djatj0xyLYD/tR4/AFO02GsU=@vger.kernel.org, AJvYcCUofiH0LN7ca9GzJuwGOroAgB543k6joYe7UN6t9mprqMmbz7lXcmH/0CNMG0lthk53rAYWZw8eg6eLJ5A4w+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9NI+NgKWl6Y5y2ErfqdbsCyK6x2LbCktWZYvwKx6g2F864K+w
	au/YMZIYvmTvT98wJ6lo3HcKLGeAd+weV0jbz0LBN0iklxWBouGa7bySmKUitCfLka2x81D8E9T
	999JA1U6sLwDLdC2klBOLeOG8zCma030=
X-Gm-Gg: ASbGncsXx+Dxer/uD3O5HoRFfgHq5u9i42Vf4JLL4JnysErsF2SpmL0lnPtKeHg1qY6
	2jhW5xzPN7epoOm08JTC7hf0Apf+wCwjS11MdEpe0f/gMkH70xvMjMda86pbUD4oaLzHKAcoSmo
	ahvZb2eyqj6ndzT5wWR0gM2AX+VO2iH4IH6uzfeSUe2kvXFBFpZzSDuw==
X-Google-Smtp-Source: AGHT+IFt7ueltOG9NYYwvQ5popvkkzoji4R7Ok74DKsOYkcHurMU0XlWQtWuklfj6yE4gCKvF+3MNHffqlTqdirwLfY=
X-Received: by 2002:a17:90b:4d07:b0:311:c1da:3858 with SMTP id
 98e67ed59e1d1-313af03e807mr3813436a91.0.1749721343062; Thu, 12 Jun 2025
 02:42:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602135231.1615281-1-bqe@google.com> <20250602135231.1615281-4-bqe@google.com>
 <LGWNtyhjCByj6PPHMsGCwo-WBkCCUuCOn_cUuwlwHPhfRZ4TdDR97a3u63ACSIvJQZF2SyAInyX90iMkERX2MK3Up-R6jazWHWhFzTIWah4=@protonmail.com>
 <CACQBu=VX_x97dJcjUUs_=fxYmtitcrNd8NB+5K8Cqu2+9yoXqg@mail.gmail.com>
In-Reply-To: <CACQBu=VX_x97dJcjUUs_=fxYmtitcrNd8NB+5K8Cqu2+9yoXqg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 12 Jun 2025 11:42:10 +0200
X-Gm-Features: AX0GCFugGIsueMKRDGUh-NUf3dT2DnKhhhZ5_I5J1V9Egp2SzNYgDzfvlhdFUZA
Message-ID: <CANiq72kHd=Z3OvAxCsaEqdvytMjx2v8zRmsfYSwUjRWyNYwEhg@mail.gmail.com>
Subject: Re: [PATCH v11 3/5] rust: add bitmap API.
To: Burak Emir <bqe@google.com>
Cc: Pekka Ristola <pekkarr@protonmail.com>, Yury Norov <yury.norov@gmail.com>, 
	Kees Cook <kees@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, Carlos LLama <cmllamas@google.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 7:24=E2=80=AFPM Burak Emir <bqe@google.com> wrote:
>
> I could not get kunit to enable RUST_BITMAP_HARDENED - now I understand w=
hy!
> Also added the missing test now, exercised the code and observed the
> fault (though [should_panic] does not seem to work).

Yeah, `should_panic` is not supported. Note that `assert!`s maps back
to KUnit in doctests and `#[test]`s, so you should not need it for
assertions anyway, i.e. you should see a KUnit assertion failure like
in C if the assert is not correct.

I hope that helps.

Cheers,
Miguel
