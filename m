Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CAD26B951;
	Fri,  5 Sep 2025 21:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757108927; cv=none; b=gMZxGUekY1emVK+6coBReja4V0kEbypO2uVAaz0j4KwSmbk0MWVEbsPcsxrvDPDbNY65ib05Lua0Cqapji+JTKIidrEarwpUF/sIzLTywny1AWewzaHimP9Zr6gwoXynKoeTSPj90iY4hUZfug4tjkYvzvkG82bI+1YAN2ekqhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757108927; c=relaxed/simple;
	bh=xUNNlqwOESV0eE+tUpWmOnuKApsTiklZcSE/4hYwGlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJohnxtGkS09Y/Ti5bhPTh4KjCEvc61AMC9xgsGw5IG2pbd+uzdvCz6I/bYL06auTJ6ukIjxKRmoz9GwLlash94eZioJcjpF6NZEJAEwr7M/GsFiXBesPqomok6SZ7FAuSn7RoCIWLMvxs5KbG/256DcYz0/YSXNwkooN67Pk8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqJNDZ5X; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqJNDZ5X"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d60501806so25246097b3.2;
        Fri, 05 Sep 2025 14:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757108924; x=1757713724; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TlvGjgOOrYou8qPPCBam0uB1ddfexbPjHc8LzQs0nbU=;
        b=CqJNDZ5XCZ9uxdV5wjjq+ECZKi8jl9dkNUa2+1e9pojOqTeJKWyG2ML1vNUjRCew9E
         sfaWxTbhwfKkp44FS9hl7zsMjkx+V6O8DDw97pc9Whuklsjg6OHaqR1PCw31gV8lxNbZ
         rB+Nt2qq8V07x6GPZM8lZaHRryxDppVaJYWR/yXyqxFuQ3I6sEyITjaJ/hDIk3GNeDEf
         OowWFd9gxky5OQAFXloreVEZiRhGAhkOB689CT9FGecHUZkuRyBDHwz9uTaYAfwmVio8
         ArZvH+mW5srbZJqJeoXRNn4pq5M4JLIAS9SlARQ5vxQ9TGJG41UfCMpnAPNPE4d3J3MH
         MAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757108924; x=1757713724;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TlvGjgOOrYou8qPPCBam0uB1ddfexbPjHc8LzQs0nbU=;
        b=tB1HJHaG1bbGsnV01Tcfm5iW/O08rtEpwLEwm6kYHYnl4eWLxwEd0zH/ASAoDNGUGp
         g0C63hqEQXsqRjHsBmFEDK2Lld/nqU1Hzi4Qq2qN1PX55mLeCa1Tw7JgBHFEp1uT38nZ
         X7EpcZ0k3NoAhoPt5bTn2u/wB3HFsbj/64RlDmxZIjEM/ob2M0C5ZTer1pufQ+2PQha6
         gyt92cMLj6qyZM5ZSygkgLUh4vzoH2WcAUuHR1G8VGM9PP3xjFGTgoNRSOvKWFJ+fTmk
         g6JABh2DzsUcKWEbBP2qizXO5SXacQUjUMhF3VBU/UKjnY3E2x0wKYKUanrUUrRyPXwy
         BkfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF9yi23PWzMT10Gw/Z7Ro84bi3S7xvBuGMyyzaTx7hTd8hWPzrUPejJyLDIz8r92BZmKNErQff69WkpzW14+A=@vger.kernel.org, AJvYcCWU1tTcr3N/BUymG4Mto4ThlWpVM6MBpvbg/G/aaVg3egGX34RRTo6Ozd63M+XnjsGpPhTt+B5dahj3pbT/@vger.kernel.org, AJvYcCXidz08b4DWXQ2PAIQnzSlNri2sTMA1JoRKf3LMBSrXH8bY4ojvcm40yssKwFLMJB1NDWuv5NePspaSHVndIbU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpcfjkq73SimQjpmkAzcuchw9LMKE7NNjGOVjzORIruEMQF5tG
	8WxB+8dJaRRO0Vpr1yDUeu7YF683fvFh6yezeDhqPe02nxsCklu8hmZM
X-Gm-Gg: ASbGncvx6MOArl8/2ckZCkpehtWaij4yJoHvpQfdkjNeMnI+0Xoc5C0jvS5vxXghsmB
	5amshdL6ledBGacSI0mikhbsXu69+CAChiIcH6r/hrT4GSiGOZ7wPjhZmEJV/G7z70gnvXeoHTI
	ohbaGcMYyjsT8yKyky/KzVgxfpvMO6WmFZzxKsA68kmXeB5uAMrxvdIhQ+rRCWZPaM7oTBXVBwm
	qW7sEDu4uOlCNXOGnkFeD84+xQIOsfgXV+IwJaGlZOwDeTooXn1+LSJ09NITzoADRHWIlWVqR0U
	UfHi/FZ0adhhYuIWspIJ3gsWqHC0HyIEjUqwmbliermRqTQxOFHzagfMxDqsW2FEnyCGwx5EA0v
	dYCeeHNseLvulRJ8HSns=
X-Google-Smtp-Source: AGHT+IGaw+gqiKbD8tSP3wYYMKk+NhXYGOt0QQgdzAKGLPBQortYFRwLmY/VZvXpIwDyWbzuX71RBQ==
X-Received: by 2002:a05:690c:6e93:b0:723:88f6:c332 with SMTP id 00721157ae682-727f31a8b33mr4017117b3.18.1757108924205;
        Fri, 05 Sep 2025 14:48:44 -0700 (PDT)
Received: from localhost ([2601:347:100:5ea0:a745:ec:6416:ba44])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a8329a4dsm32770907b3.22.2025.09.05.14.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 14:48:43 -0700 (PDT)
Date: Fri, 5 Sep 2025 17:48:42 -0400
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
	linux-hardening@vger.kernel.org, Philip Li <philip.li@intel.com>
Subject: Re: [PATCH v15 0/5] rust: adds Bitmap API, ID pool and bindings
Message-ID: <aLtautgAVKdqNv2R@yury>
References: <20250904165015.3791895-1-bqe@google.com>
 <aLnURXW_ZiX2iJd_@yury>
 <CANiq72==48=69hYiDo1321pCzgn_n1_jg=ez5UYXX91c+g5JVQ@mail.gmail.com>
 <aLrjNze2_L_vAnWX@yury>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aLrjNze2_L_vAnWX@yury>

(Actually adding Philip in the list.)

On Fri, Sep 05, 2025 at 09:18:50AM -0400, Yury ooNorov wrote:
> + Philip Li <philip.li@intel.com>
> 
> On Fri, Sep 05, 2025 at 11:29:22AM +0200, Miguel Ojeda wrote:
> > On Thu, Sep 4, 2025 at 8:02 PM Yury Norov <yury.norov@gmail.com> wrote:
> > >
> > > Added in bitmap-for-next for testing. Thanks!
> > 
> > linux-next breaks with CONFIG_RUST_BITMAP_HARDENED=y:
> > 
> >      error[E0425]: cannot find function `owned_bitmap_out_of_bounds`
> > in this scope
> >        --> rust/kernel/bitmap.rs:484:1
> >         |
> >     484 | #[kunit_tests(rust_kernel_bitmap)]
> >         | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ not found in this scope
> > 
> > because the proc macro doesn't support `cfg`s (moving it below
> > `#[test]` wouldn't work either). I have filled:
> > 
> >     https://github.com/Rust-for-Linux/linux/issues/1185
> > 
> > so that we don't forget about it.
> > 
> > Meanwhile, I would recommend e.g. moving the `cfg` inside the
> > function, something like:
> > 
> >     diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> >     index 6e0824579781..2f00e91e9c35 100644
> >     --- a/rust/kernel/bitmap.rs
> >     +++ b/rust/kernel/bitmap.rs
> >     @@ -551,18 +551,21 @@ fn bitmap_set_clear_find() -> Result<(), AllocError> {
> >              Ok(())
> >          }
> > 
> >     -    #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
> >          #[test]
> >          fn owned_bitmap_out_of_bounds() -> Result<(), AllocError> {
> >     -        let mut b = BitmapVec::new(128, GFP_KERNEL)?;
> >     +        #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
> >     +        {
> >     +            let mut b = BitmapVec::new(128, GFP_KERNEL)?;
> >     +
> >     +            b.set_bit(2048);
> >     +            b.set_bit_atomic(2048);
> >     +            b.clear_bit(2048);
> >     +            b.clear_bit_atomic(2048);
> >     +            assert_eq!(None, b.next_bit(2048));
> >     +            assert_eq!(None, b.next_zero_bit(2048));
> >     +            assert_eq!(None, b.last_bit());
> >     +        }
> > 
> >     -        b.set_bit(2048);
> >     -        b.set_bit_atomic(2048);
> >     -        b.clear_bit(2048);
> >     -        b.clear_bit_atomic(2048);
> >     -        assert_eq!(None, b.next_bit(2048));
> >     -        assert_eq!(None, b.next_zero_bit(2048));
> >     -        assert_eq!(None, b.last_bit());
> >              Ok(())
> >          }
> 
> Thanks for the testing, Miguel! I've folded-in your fix and added
> your co-developed-by tag. Please let me know if it doesn't work for
> you.
> 
> Philip, is it possible to add CONFIG_RUST_BITMAP_HARDENED=y/n in your
> testing too?
> 
> Thanks,
> Yury
