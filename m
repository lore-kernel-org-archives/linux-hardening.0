Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE1C40961C
	for <linux-hardening@vger.kernel.org>; Fri, 21 Aug 2026 19:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341733; cv=pass; b=YEM7KO/pKlA0/H1AcPHVyT1rTsl2OBKjTf5RfIKK5tf7p90kBAbo1v/c5jmuJZPozpNXbR4JFewifj3ohZUmaXlnRXM3eBYMy3Azblqz/dUeKPpcaRA9UP6MRLsiRQgT857TPLTgZW6eQIVvDV7XKDjK536tLJplyMJcvgPznCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341733; c=relaxed/simple;
	bh=CIOe0gksc2TBFCzVC0UABUDWCb5y+xK8eszlV06eZyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fs3RGMjh9r1yVSvmr2DLG5cdLzbrwmTiuQv5mwcCAkHQjgaM2/RbZiqX9qlpAqx8gz0p4R8mnRZCsckiA8j08kYl4zxtiPKJEjxFzXPDSfioUeDDhuWmfDWAgPKNWvUp6jGyVrq/+VXyp7GsKvnkIchR79a9uoBVuhRd9JFfim8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcpGF+qM; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcpGF+qM"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cffd93cdedso1502085ad.3
        for <linux-hardening@vger.kernel.org>; Fri, 21 Aug 2026 12:48:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787341729; cv=none;
        d=google.com; s=arc-20260327;
        b=m80nuY0nnRKqEgF5TbKwxIm0pY/mPIMJIg12zjl0QUh673NO7x9KUuwnDCVE3EQS4P
         SKDcDE9evwqO1CIUDAKi1wIGZ1vd1EjljEgXN7RbeN5OF21TNDKpA1vPhjNGwKJUn0wM
         o1h8emoGvgvmlprqg6IVoUKEzMA4/GHSiMBz0gon4a6A9oxpScVAgIezs9RKzFffNUJh
         k/HvfW7xV9iMP/OGZYtJJz1R6TycFFJC/b09bSy5HdLmblb21bXdvNG0HNjNfDr6sea5
         04LU9HOj0rDv+iN9oMVolRev6Ns/QbkMaBpZhHXT70IVgAxTyvK4VSnmBgIwYQ5OPe3u
         1lnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CIOe0gksc2TBFCzVC0UABUDWCb5y+xK8eszlV06eZyA=;
        fh=0MqYPqMiXL/ZImfZ3zxew6FGoJ+P85r8EnjCCeN0paw=;
        b=m5/R0UxI1g3izVbolWtOXXx8ncocNi1t5w5QzY5oBe7FnGWzAMnwjfGEEccWznoxSe
         k6rmYScdxGuECzFkEESlFNeS/OSC/zJhZWyRQtISQBG4Y1n/zAls3kp5crp0FLG7AeGI
         FU/797FegHA5ddWqnQm3e26neyJU1DB8PLs4J425wnhoCF7y97cyHk89GiKX6Mt6gWAk
         ktlzGAF9afrSIBNmfp3NtM0Dr1wrlpQ5GqbSwryuJXm7dKLUam+B2/V3+znaip//xFp3
         recCJFX5XtiM2lfN2nBLP0IEIllqGhC36vTP4fcpvMs9JuD3GhlDAd6aGPII6mgFc2TO
         xYXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787341729; x=1787946529; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CIOe0gksc2TBFCzVC0UABUDWCb5y+xK8eszlV06eZyA=;
        b=CcpGF+qM8yYIih1cSAqy3lWYBxp96sh1Gj/OttiHxqrpYuMRGm6FlAx0tqoh4cggSM
         Pb+i2/SSzrnOozG/OY1Mw4F34yN2J9buwvFALEeUp2O8avFAgv3oDJozaIWVMuWgGTwX
         akBoWrOuYNOmL8B94SPxjS1FXfV3gJzm9aqj+Y0/f35EsfiDaPT/gQ9aexZHui9q3mFv
         pnZ48ywdxsD9JVj2BqSl5Blw7faLWP6QbXdXdvpyXdnag4GCND9d51YbRxFEpWtZ057I
         63rvLD96Dqcu+HJdNKZarWcS7c1CJqleOFSOkFZwJfQwpeum1UVbxyA9Jej3maFhMIhg
         uwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787341729; x=1787946529;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CIOe0gksc2TBFCzVC0UABUDWCb5y+xK8eszlV06eZyA=;
        b=PwTwsqSCsMyY49w7Kbo/SARVqS81oVnqQC+ytHwYMfTNJ9nh52DfZYnNWawzFYRolF
         dLGFscl1Ai63UzEbXlWfCRsg1ddgMvL83QFcV5JJ7V9M/BnCFHGADV0JJL4Z1+ceEgnA
         IeIhDXuLsqeu04GRvWeeXvHGXGn3eLuvwNxq0+0B2QRXyurXLicpJVvziTmPwAtN126O
         qBBUpMwqd5qVae4nBbTWe5UMOhq6WPPkjlkoVlsW+92Vf+TcBuIc950z+JxX0kND6VHL
         GpnrWuwzvUBTzMExG8EI9Wh54aYD1fPhfmbuo9TPA41qZLoZsc++JiUeUDQjZojOtleh
         3cpA==
X-Forwarded-Encrypted: i=1; AHgh+RoSNBbDqDarSc3/IWLES9j0XnGQ4QYrVYNWGzgPqaYYWMtKgcXyrCn8k1hMmn8CUrb3nZophNiqKR7hS/RSsl4=@vger.kernel.org
X-Gm-Message-State: AFuF++kavGTh4pAe5oz7UoLjlAjI6bXCZW+4jsKXit4eedN3hTcpV3Gw
	x5nINa82xBvWUGfoBgXRI4G6KdHVtS1qSOyHQH4R4N23bOvnreCCQI+46PvZndnfSNPwlzoSA3r
	z5FZbd1CqZeoIqfD7r0yypF4zxkJia+s=
X-Gm-Gg: AR+sD134g3k7aqANYC05dCkMJxCMOo/pE7PJT4JDUoFVtERQ61M86FRQsOUqsGaYGBV
	gyXWVyx4LAWR5ewt+EGHCrGaZDZwqFriEOE4eI9Dda/Y6vmy3grcvzk4/a0sZVMAQUUf+OPAGw/
	nFuA3+SxL8kFhW3J4aY8p1SoVW/PLb4U3YkP9XuJ0LV1mt4bbxdkfUgSADBDYHPRa+Fkp3RuaLY
	VdWNdVp/fTORETu68JfxBW91xe5+93NOAZr0B/Rap02bn0/tPE+bz3OS/w1Rk/mv7LtekHk046f
	I6IuWnX6Kdq4LTgUQwxaZsZSJbpdg5BzLBHD0LtYiMlq9zfOhqADTy2C3Ot321CD3X+aijuCT8i
	Go+y4jpSsSWpCjwuBwVUxfuIdXc5yDz46iK8swW5dvtfJjth7EuyyJ2EzIfqm
X-Received: by 2002:a17:903:1b65:b0:2d5:3f09:4126 with SMTP id
 d9443c01a7336-2d64b13195dmr82640675ad.4.1787341729446; Fri, 21 Aug 2026
 12:48:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805-rust-reverse-randstruct-dep-v3-1-7b8b2c761d6e@kernel.org>
 <178733378275.2181196.3186172911325132761.b4-ty@kernel.org>
In-Reply-To: <178733378275.2181196.3186172911325132761.b4-ty@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 21 Aug 2026 21:48:35 +0200
X-Gm-Features: AcwNN1VcEKRBJi5joKYnArWy65OxDBbAjzWAsN3BQpiDLg4VMvQL2Y1JGnUF-bA
Message-ID: <CANiq72kE4tf9b5BJnK4mcY39e2KELqErxHTZM8b3_GLiEvPt6g@mail.gmail.com>
Subject: Re: [PATCH RESEND v3] hardening: Default randstruct off with rust for
 better allmodconfig support
To: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Mark Brown <broonie@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 7:36=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> Applied to for-next/hardening, thanks!

In case you want it (I mentioned this in previous versions but I think
I didn't give the tag explicitly, sorry):

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Typo: "likely go give" -> to

I assume people does test (and enable) randstruct elsewhere, so this
likely will catch more issues at build time in linux-next, even if it
feels bad to lose the other coverage.

Thanks!

Cheers,
Miguel
