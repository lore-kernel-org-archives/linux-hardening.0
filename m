Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAE135082E
	for <linux-hardening@vger.kernel.org>; Tue, 26 Aug 2025 13:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216698; cv=none; b=It+5YOlnQkrfWCqBiK2NvqlQ1Mvsm0l5K+nwFMn4VVpA37+HLAzegt0NDDYRXQoxe2DNlq5WM8dHt1iM2SAJMZ/Fj1ASqDrsCQ1Bz6Cl8MsTxG3ip6hVqkxzYZpGPXyjSM6WjlKz+0fpv18ZE6xN/tn+ajwCJtE75hgh7rYlug8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216698; c=relaxed/simple;
	bh=F/fAPnfHxUemRrZHN9zWvSIFmtxgD0s1aIaOJ66WCvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kh/zhtxsZEBH5l/8ynqVtc7fweFFMtcBbMA11EME/tp6qm7jGMdi7rKQW8MPSzh6JxrXMbMMaM2oKGXp7Ger5PNtKyb/jTuGvrBTHlemuAYB4RJ2pcuBzV07EV+cqTrBzpuBiHCUZoMXyRQ1I/885uJd+IBr9DZNKTfLpwYRz1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RGCQsClm; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RGCQsClm"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3c68ac7e238so1939351f8f.1
        for <linux-hardening@vger.kernel.org>; Tue, 26 Aug 2025 06:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756216693; x=1756821493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/fAPnfHxUemRrZHN9zWvSIFmtxgD0s1aIaOJ66WCvQ=;
        b=RGCQsClmP4mM9OBBB9U3mt19EDLwls+80WqGnM/+Qv7ZiKe1Lq1+k4yIXNvMs8QTIx
         lO2h4hpiUhkIbhihjizj1YJshZTei2xQoysWMtAsJPyXZP0vF5kCXQULc+BLbeFjikeM
         a1YGGJy3kKrMJC5DzzerJEcqMAIY+QXItMkYdla35XfVpt587pbewhj6iasRAFPJt5KP
         353bac/ZRNiwEXaCX3aIUHV0nZgFGHSCZwYM1pXqH7dYNzCGKihNEhAgZHlgSe69Xvm+
         fj9cg+rD6AQFyqX8TWgORZIj40EB0Vq++FoE9FvrQKadbicvs0V9CI8p0QGV1CaIuQIp
         1DCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756216693; x=1756821493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/fAPnfHxUemRrZHN9zWvSIFmtxgD0s1aIaOJ66WCvQ=;
        b=crAXyJtE8pLAgDI527poBrxaEGniYQg+k4ZFXsam0tPYw/8WmbrinyMucbZgzpIMOT
         FnrFB5vF4ScnleAK2xqtXdISrDKUcZtLSX+ehEFVmptvW8FuIFbuCSelOil9iFFqX00G
         viwAm22qodOL7zJedFgPtIpZgY5dPkf9CnIZyXulNLezzSPya/eD1W+KRdy+5E5KSR8I
         dbimXlL6iD0btQfsh8oM7elBtu9dM0bK6Hpo+d3ygtWKDqDMB+unpLrrzddEWaMFjb8D
         bIF9Pcnk969qP71nnddlcdikYfM8XV0sVQKZW15357zmcB9YDGDoTEHgFSKVSUX+bovB
         8cPw==
X-Forwarded-Encrypted: i=1; AJvYcCUWE5FoZWy8tcdU4/aUcQ4l2nRDj1tvajAvmtLHVzLlU+dOgiOKzgDSlcHbE7BacRWqwaleghP1uJqrw2LTc+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZmx4sJLC9oaE5lTUeNCrqlx8UcFKKW5tyvC0gEluo3TKXKFwM
	LAhHwhy0diDzekBP2MC6EVzSHx+7eehsTjmmC1V8HMKIvYE/sa45BLn/YyRaLB14UwJ1wh0SRce
	hbWmpV2dDGbsSXdJiOCoyMz9hemdVMTA710CooP2t
X-Gm-Gg: ASbGncvoN40qhHcWIilDiR3JSDgkQtz7zqiSiqz/ihSA+MQaxZbb2xXIbOfBAM3TGko
	YvqfC1BWftZDJEDd+9+nixTk+7jrvX+sSkCcBAlH+mhObidIB2bCaa0c2PDjZO3JFQud47vxJR6
	4JYoP6wevHbjUgSyJk/vp2u2FHtNTtnuSffm93NKbbH/o6gteTKaNrC87KDLQ58bohXCl76Phrp
	sh8epto0fbf+ULzxipw6csmR1vIvvhv4P03MYyKnn1wMYrTfhoLYBuOuuZT9ZWAR6r3FTqCvfI=
X-Google-Smtp-Source: AGHT+IHRgvzTO5clOrALiSfYSq6INd4bC5T/yqjf+veSVOxDpuDbA4FBiVt0kYdgDa/qqkni21+SFeOOi9dYSd3GzS8=
X-Received: by 2002:a5d:64ec:0:b0:3a6:d95e:f38c with SMTP id
 ffacd0b85a97d-3c5dd8aa9e5mr11922498f8f.33.1756216693355; Tue, 26 Aug 2025
 06:58:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813153548.1650533-1-bqe@google.com> <aJ2Y21Yjs3a0CnAo@google.com>
 <aJ4Y_DAZe__0EWEm@yury>
In-Reply-To: <aJ4Y_DAZe__0EWEm@yury>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 26 Aug 2025 15:58:01 +0200
X-Gm-Features: Ac12FXxekRc_zLGFS3Qk-92ThB02sZE2hj5xq7cHAtlXq8wdo0Ut_NCfgzEs07k
Message-ID: <CAH5fLgid9fF2fb06No9zmeQfru_nQicaM_9bb+DWe3zsOwm_cA@mail.gmail.com>
Subject: Re: [PATCH v14 0/5] rust: adds Bitmap API, ID pool and bindings
To: Yury Norov <yury.norov@gmail.com>
Cc: Burak Emir <bqe@google.com>, Kees Cook <kees@kernel.org>, 
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

On Thu, Aug 14, 2025 at 7:12=E2=80=AFPM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> > Thanks a lot for doing this, Burak! I gave it a spin locally on
> > v6.17-rc1, and it seems to work.
>
> Does this mean Tested-by?

Just to confirm, is the plan that you will pick this up through your tree?

Alice
