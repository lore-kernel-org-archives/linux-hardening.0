Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C871BE844
	for <linux-hardening@vger.kernel.org>; Tue,  1 Oct 2024 10:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727780283; cv=none; b=XZBNtZM8XIMHffjldozL9VGlyCKOulrnr18DkPO5F0EoJRgtJX4X7zJSNPYUj+Z8E3h/Fa1tCkR2lxksVapkRyhISXdAAGNIYv97dPEnlr7SeWEPHGe5HRcAofeB0urQ247+qhHKQ06UsgDcwHV5lf3oQ/pUnSTy1oV5IbiW9q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727780283; c=relaxed/simple;
	bh=60EhXKAteHv2MPzzdgUAD7FikabFpPaPZwrLroTEnQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qe5ztS9JanJ9S00Q+FdoC3fqeau3sxJeWK2Ykw0En6Br2n+9HnOQCRBr8exIo1xVFcZNeXbwKsls0ah+3iQFwqvv22ZCaX/+2HAewJHvZ4uR5/0UBEf6E3EHL5pK+4pyOzX33ut9B6ZBqIlC4roSz3JOkj/YgzBZfNoR1CFFiTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=efNyB8Z+; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="efNyB8Z+"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37cdb6ebc1cso1985790f8f.1
        for <linux-hardening@vger.kernel.org>; Tue, 01 Oct 2024 03:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727780281; x=1728385081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1/SnEV7GpnCmA2f8SClpEwW0fcraNKH9MQf0vKkPjQ=;
        b=efNyB8Z+AvCwCkWkdL4h24U/TWX5Xmp4VJ2RIHSU9QUZq10Id9xKOA+YeAxKOonZW3
         N4rMc0/lYeVT6M95i6G5Yt1SfO3gBVE/ICwXCEkuhh0GmFyYLCNGTErEGPHWhr3Nkej4
         sK5r1Q9W/6vRsdu9BUXDIXvweyGRDHbczIK96DFbtJyvDuNTU1fdqd0nChksFaqqqA37
         0UgaQbZce0AD9LJX/4VZk1SYcJUgGAo5T9t7wFA8ijFvVvAfnJa5l/HknFFT5lzb5mZA
         1d87CEOFJwW2P7GDILhzwWM1tS9tIksUCAQnSNM++s1mGlXcpxE9gb87k1qzreuE1zfo
         kzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727780281; x=1728385081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1/SnEV7GpnCmA2f8SClpEwW0fcraNKH9MQf0vKkPjQ=;
        b=lcbaGiQJvwCa7c+zv87QCnx7ql3lCTobkz3Xad7Or5ksjVXz1w61pdCh2jWl1VzNBz
         ElGoAgXIKiqTN9XyBSwJVnw0XhsuG9hPo+59GlEaIlEgRVV91jcIZJOM/22lz9CBPMi1
         xsWjsQe996VTzL6vYKqWzVLgIv0yTfzS7UjhU+Yln28s8BepYm58kc7W5Xw7R3WA2UI6
         yetTStbeqOWDuXwaHch4S4QGfP8dvB2mY9vW4YCM2r4NLdRviiDvHOhnqeasnQbbwRfH
         O8dKWjWh8HMPnDowjspMBAuLkTyWeVSLeY1WAjspNbz3vyPdk8ap3zFrG/BB9rn54vrF
         TfeA==
X-Forwarded-Encrypted: i=1; AJvYcCXvtJO/5sh+uHPOeJas4LZ8tdotcVximSPXa0mU2p16ed7UlwOgZbY19kanWFUV81zVyXrFXFWi7S9MJjhf3yQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Fa1/IDAJeJ0rxwZwci08PmBp1Tpg+yicjh+EE+SykaWRLHoo
	xJ5J6nS/P8oSV04WqeCVtEme9yuDCSEYXz24sMg2Sx7DeB+HMcJO5A80NWug9Aa1h3RRlF/EmDi
	XxvdztfZlzIuQavujnA0QjBuBTGK9jJvjcALN
X-Google-Smtp-Source: AGHT+IG/OuMrpizTXMK9ykXj5tQizpl0H0yQsEL9StHtl8bSdqhVYJ82YEbwzDkAtDBmCQuH6QaI4BhD+/admbTQT6g=
X-Received: by 2002:a5d:4a92:0:b0:37c:d21a:3d61 with SMTP id
 ffacd0b85a97d-37cd5b319b6mr9097510f8f.39.1727780280536; Tue, 01 Oct 2024
 03:58:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913210031.20802-1-aliceryhl@google.com> <CALNs47sMJzeZ0yEF9sc-VO_QEu4=jc3QBa1_fhnhX9gdETYaNA@mail.gmail.com>
In-Reply-To: <CALNs47sMJzeZ0yEF9sc-VO_QEu4=jc3QBa1_fhnhX9gdETYaNA@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 1 Oct 2024 12:57:47 +0200
Message-ID: <CAH5fLgi4YNsLHFoKw7UsGbmpEaqeG4o5yMQAodZ1KwfExAPL3w@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: harden index manipulation using ownership
To: Trevor Gross <tmgross@umich.edu>
Cc: Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 1:16=E2=80=AFAM Trevor Gross <tmgross@umich.edu> wr=
ote:
>
> On Fri, Sep 13, 2024 at 5:01=E2=80=AFPM Alice Ryhl <aliceryhl@google.com>=
 wrote:
>
> > +//! Utilities for working with ranges of indices.
> > +
> > +/// A range of indices.
> > +///
> > +/// This utility is useful for ensuring that no index in the range is =
used more than once.
> > +#[derive(Debug)]
> > +pub struct Range {
> > +    offset: usize,
> > +    length: usize,
> > +}
>
> Would a name like "DataRange" or "CheckedRange" be better here, to
> avoid confusion with core::ops::Range?

Probably a good idea. I've had collisions on those types.

> > +    /// Use this range of indices.
> > +    ///
> > +    /// This destroys the `Range` object, so these indices cannot be u=
sed again after this call.
> > +    pub fn use_range(self) -> UsedRange {
>
> Maybe just `.use()`?

Makes sense to me.

> > +    /// Assert that this range is aligned properly.
> > +    pub fn assert_aligned(&self, alignment: usize) -> Result<(), Range=
Error> {
>
> It would probably be good to warn that this alignment is relative to
> the offset, i.e. if you split a range at an unaligned point then this
> may not be useful.
>
> This is a pretty cool API idea.

Thanks!

Alice
