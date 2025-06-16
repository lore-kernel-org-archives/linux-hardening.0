Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9D527FB10
	for <linux-hardening@vger.kernel.org>; Mon, 16 Jun 2025 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750070996; cv=none; b=fhUsdD2yCJCsxXL4zw+hTHYjCfH7/Uj/rrVHPtl0mvyCNPFPXYi3GyDE9/ia5zWbiQAh602HWqudn0NNXDlb2++yGugSmr3/UaHaeWaAeyfS0CKuaiztYovHxSVnVurtuTJPegf0D2o1ay0EBpiYjZCIJRbKz6JRykBP5l1Aa4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750070996; c=relaxed/simple;
	bh=fgAbH+bqMDdFSxa5Nsg900AieTB/XPyHcssZQxwzQvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kt8DR9IFCU9giHu3Sg9dA1wwLti0T973Z28owBKBUWUt8PqOI9QAqeFWGoo7EvMI5ilLuJQ9+8UhkF4I0Lhrops/IHSIlydlrhrd5R63chZ5a2j0eMqPdBZXjn+vin2ajnuxghQ+/auIi0yJzw92Vlbnh8BN0f6k5g6eTveSCZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OBcnlKMa; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OBcnlKMa"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45300c82c1cso13608635e9.3
        for <linux-hardening@vger.kernel.org>; Mon, 16 Jun 2025 03:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750070993; x=1750675793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=noASFFqKv9QR1JcSSNjGq2HTnkr+7eqAct6g0x+3TVU=;
        b=OBcnlKMaqNC2WOlTeGBmZbP1DYtdgWbUgbvF446lFQZV+9M1F/mYJPw4jjhK0i38hT
         2sLxaBiWaGUUL+azGAhFL7zgpJvqn5g74oULrWoFX3gtf6CISW11jNPRkOtgJ+YL5dAV
         wcgQ5dlzJw/fuWqug4MpRYDfVU5sujAiDB6TiwUhrIvrO1xrTmZyr4YPQ2NwiKQ5YRze
         KvuBYvuveubzHWWKXUJ7PnnhsfMTrwNTDAfrznQCyInKOh0+ZV4HaaBwgJ3B/QLcHB8W
         JuLA/mbHQAsZoeDgxrt8BoBZ/4AlYLfflvevd0kKUgd3Wvk9BMSTxul1yaTSB53Njf9V
         BfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750070993; x=1750675793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=noASFFqKv9QR1JcSSNjGq2HTnkr+7eqAct6g0x+3TVU=;
        b=qMWF7RyMBja0jlwUxwGlPNTUADPhcFRN2Suxshq84AoibbMvMMCHcOxlTMEFc/kB+P
         LwQEvU63MS7C2hUEzxVPu5fmGOzIT2s/b1QxiKYIAXMS/Am3fi6SZN/D/U9aLtUCHTzI
         Q+f/7Ack07KYmWXjXXqvR/Gm7HMr7oxtagSVqhf/vBCDp8OoavwsuhMt9l9P+A/9I5Rj
         q/5RJIAVDS/1t2jijNatBkxFHJPkCoC3yPwfUZHwgvq0iSdsQwsOYrm0zrSH0ITzu6Qs
         8ue/JlspB/e4LCRNEjCOCK8ZGku6jfta4rQ/RlxJCkkNpPnGd1rYo8H/jopqivCeGKpa
         0mew==
X-Forwarded-Encrypted: i=1; AJvYcCVdUMWUJ0wCySrlBI7GTDU4wIx9/UntxFAyV70aASw2cczBVgeQt3cCdUz41UrSUD/ILuhjeCQTKUo3OQwA6AU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy32tj++5WZ43vAiy78S3pMkY6Fxaz0ywWC2ZaGv9+WSoOUqOp+
	BMFfDRpbYqjUriatYEPskvfxGqekA7UP4T+DQGPjlZEWZqkkJCuapUeBBpoOlL0jSZhmiPLwp8q
	IBGhIV37A9q4ZKDyhLkF4xvr5F6MFkXgol8R4JjEl
X-Gm-Gg: ASbGncvgEa+sLACaWF5nS4M3rFhvcsYUf1WmF6v4WCPvgW62HEOxpwzbutRbjImdnpE
	TZU+0F0xKaZHqGcHEB5fGDWOeFti3T+x7NUSLRHEz++wpT6XdI9gBLSl4Diyjf95aE2YHnRKUPv
	P6P2SKfFjyIfCKO1eCwpxmMfIkYBZmIPLNgTvd6VcGaeFVJrJHf1e0cic=
X-Google-Smtp-Source: AGHT+IF5tKVn0HH4+Er7S+XZNod2FyfrS9dHKNqy5QhSTc4SSiK6Xgx8ZEz8Nlngk9yhomQM63HB2J6yh0gSTliC484=
X-Received: by 2002:a05:6000:188b:b0:3a4:ef0d:e614 with SMTP id
 ffacd0b85a97d-3a572e79d24mr7089351f8f.33.1750070992846; Mon, 16 Jun 2025
 03:49:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611194840.877308-1-bqe@google.com> <20250611194840.877308-4-bqe@google.com>
In-Reply-To: <20250611194840.877308-4-bqe@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 16 Jun 2025 12:49:40 +0200
X-Gm-Features: AX0GCFuTb5n8MBWBEa5YiiJmxDs0pB6vkofAmmHr2Oh2WDSvt3-JtKcoydHZXtM
Message-ID: <CAH5fLgiMCZuaCSYRDLCpZjaa=EZ=Zaw4y54zDED-7ox9K9++2g@mail.gmail.com>
Subject: Re: [PATCH v12 3/5] rust: add bitmap API.
To: Burak Emir <bqe@google.com>
Cc: Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	Carlos LLama <cmllamas@google.com>, Pekka Ristola <pekkarr@protonmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 9:48=E2=80=AFPM Burak Emir <bqe@google.com> wrote:
> +impl core::ops::DerefMut for Bitmap {
> +    fn deref_mut(&mut self) -> &mut CBitmap {
> +        let ptr =3D if self.nbits <=3D bindings::BITS_PER_LONG as _ {
> +            // SAFETY: Bitmap is represented inline.
> +            unsafe { core::ptr::addr_of_mut!(self.repr.bitmap) }
> +        } else {
> +            // SAFETY: Bitmap is represented as array of `unsigned long`=
.
> +            unsafe { self.repr.ptr.as_mut() }

Nit: You want NonNull::as_mut_ptr() here.

Alice
