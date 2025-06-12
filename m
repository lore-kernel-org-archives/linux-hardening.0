Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45942147E7;
	Thu, 12 Jun 2025 09:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749721981; cv=none; b=EXrq1uXKi1JzGhKlQJJPH47OodsWmSqWuLBlB+jkceuU/1T4XoCdobwb41GD8sidM8byGn6HRgqtW7eJpGpMXHqcjue0zz37FknznhLOQYBjc7sbFh4ronPw7uakQr2/PLlEBuHh4StSf3hHv4Ky32cDIzgA1AW/nfz7wfaKR8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749721981; c=relaxed/simple;
	bh=V5DPnJRry1OK1AUby4FmzrJdYc53co+Vvo5McgKVp+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BTmX+nYX3wiI4VJiUmz5CZv+xYhwZ4vh1ooU+7PT29rnMs2vGtID+3mHzTjWoRyIa5VEATwDON86xH2OtPudx+TTIvDUlcwXMMTRC+knsClU3m9OXcGAovETvj2q4Sfnwd6AmuC657+ToVmz13jmXv1yZZwbYmmHgT5b98yUN4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/LZc2zK; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/LZc2zK"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7429cbbeec6so128923b3a.2;
        Thu, 12 Jun 2025 02:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749721979; x=1750326779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5DPnJRry1OK1AUby4FmzrJdYc53co+Vvo5McgKVp+U=;
        b=J/LZc2zKrW2Dxg+GFOll9f2BfVteaygdlC7W+BLmOzp4JGzBcWkSoMT2V/5gS1ZtNN
         83TqdqyrVD0IAGPCgx97HhqE5px3GnpHNXrvjYDMysX5B3z181R6utpAnWil4gOTdhDh
         2TDsNDirmcpX7FNmtYisMQqHa0v0P6gXmfgtSKXpcqMcaivv4btS32byN8UWJ3BTnyr7
         0u10cttmAI0zQceYbGy5wlOBr/PKFM6wA/8Fw318/lrikC0EGuVojFMpdDx0BFw7XoFY
         RTSjCpWn7nqgIKxbIskmvP2JYDgtTdY7Plt0r9kTv7lainY43FVuvXF78sH7O1ED2QMY
         Y4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749721979; x=1750326779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5DPnJRry1OK1AUby4FmzrJdYc53co+Vvo5McgKVp+U=;
        b=m7opiB7AA7BDBku+u1F9gRKrKmFTY4xh+JK1Dz7h7ISxZWzbYNka/6I4H4kbIdjoUE
         aTVhk0e2bk2/QcVcnUih5wr8Yh/J5uwpP8pLP8PyVbqiys3OPYKWCpuw1SSTZbFnbl/M
         fa5QZ883cw9gtDjcriU8d2Gbek3mEfBYpl3NL76epWOdWuE2O01/27MVeDYrG4IWGrVd
         OK0KEGGc5E0BNtLDFqVTDBRCV+Qoqtq6sPMYCoSywfAgrk0CV0bRPHGSwNcMeDjEFFDK
         syH7J9cm+8AhstqXLl0Zuh12LoOCBMtxlL3TO0JQ9gGSZrLr+Nq7+ZYcH+1LeBOesZoj
         J/Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUXg3FkLjw80o2neM/EcaL0GIx54m0i8SpW6NDT+6X6etGbRxdimygdidzDhTAbjXgoJh2OEh1kcRgLtVMx5Nc=@vger.kernel.org, AJvYcCW8wVQHDz062hmKEip20SGiov8BmL+MtR7QS+k2zPlcLku11OmiTCUnX08JdXb/KtMiP8OfKCpohzjOZzx8OUk=@vger.kernel.org, AJvYcCWH+L+E4+ptVrWU5an6QaSrf/VErw0LrI4aseqs76gqUpOa2Ftsc0IsI4Ph9j6Da+41Sz86y1ZY6ro3rs66@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+fBLuZPmXY6uzGiOMombqorYVzid4E4eazMbJS3K72tdsYP7J
	roqcD0Uz4B7bwgQe0BK+tsgNvPYKbHqcGkGWOkBJcrGax+7taepREe8e9qZCo95NzSSZQoitXgg
	1b6t8u/KhGQeNDjk5Cn2UAYaBNfNoNbw=
X-Gm-Gg: ASbGncuFD2iGZ36YXA1jGsECMX5FKHAclXBj0HcDhllop92tjVgNny6FsONeSE7EA0Q
	f655+z3CJGyFoALmeoMFD0xzHV7RI5/LqBWntTOxKgv1qRqh95PHlWeWesv641FFAk1IB0iGcn0
	86aakXbd0dVPf3Dvr3MIVr2l347YzzpVGRfdCxNoRZszsCbMgB3B9g3g==
X-Google-Smtp-Source: AGHT+IHPE151L+2L8xLpf10WS2F8tUI6eax6tGycQNKhMolPYhuY5bC4kej16ZoAGc92LZQ5ZzwmMQaUExKxc8QL0Es=
X-Received: by 2002:a17:902:d4d2:b0:234:a139:11f7 with SMTP id
 d9443c01a7336-23641b16dc5mr37652985ad.10.1749721979155; Thu, 12 Jun 2025
 02:52:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611194840.877308-1-bqe@google.com> <20250611194840.877308-4-bqe@google.com>
 <CAH5fLgi1GBqDHvMh30fbxVUjnTETLXthpK6eGLJA0Vh_TZRnsQ@mail.gmail.com> <CACQBu=W4PziG3Fsnzqu_wu-vgBThktD7FcEJ-vOhOMhNDz8h3g@mail.gmail.com>
In-Reply-To: <CACQBu=W4PziG3Fsnzqu_wu-vgBThktD7FcEJ-vOhOMhNDz8h3g@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 12 Jun 2025 11:52:46 +0200
X-Gm-Features: AX0GCFsJPSfEGG6M_EXyv_QUF8gfnAl1V6r9HPZlTcf0LptF5juXMpYSnxrtFOg
Message-ID: <CANiq72kuRLANX=W7xUo1Jv7euH2eAhwHbx-CF4_4Nj=e9e1Weg@mail.gmail.com>
Subject: Re: [PATCH v12 3/5] rust: add bitmap API.
To: Burak Emir <bqe@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Yury Norov <yury.norov@gmail.com>, 
	Kees Cook <kees@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	Carlos LLama <cmllamas@google.com>, Pekka Ristola <pekkarr@protonmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 10:47=E2=80=AFAM Burak Emir <bqe@google.com> wrote:
>
> True, I observed the panic but the test is erroneously marked as failing.
> I have commented it out and added TODO to enable it once
> [should_panic] is supported.

No, please do not use `unwrap()`.

Instead, tests are supposed to be written as you would normally write
kernel code as much as possible, i.e. fallible.

We also have now support for tests that return `-> Result`, so you can
e.g. use the `?` operator.

Thanks!

Cheers,
Miguel
