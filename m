Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA97279910;
	Tue, 27 May 2025 16:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748363943; cv=none; b=uItQpHJaeQ+8fLaB3PbH0hCLkST7kZObQt23nCMa7Pr9m25I8DDTdvrrBMLbK4fAnWgw8BWNRiyzKu62u0eDSrwy2ofIE0VEbYbuRcHMXtnsTPjimMCHUZ02wq81IAHmwZSNs3fbPrcZ9w7DbiWWnQ+9qZMG1h9aoqRkddI5KZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748363943; c=relaxed/simple;
	bh=rZQjfSJILa0p9mfWNefpFQfo1fRe/4rlRyiLEuMTGbQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCp2YrzBaAKmt72aEPxkTZjY0UC9GUt2vAH/TSdVftaMEE1qXCvYMkG3TmLqWfLrtaecoiPCUWs6t7JtjMvk9bQ0hfL8YEkz4TLgk621o4kz+KFSrL/oBxvQ5/PyiD84vlXJb7Gzq29371Wl+jopg9aWCbTlvR3L7vdBPgXq96c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyBy5ip0; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyBy5ip0"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-477296dce8dso32357911cf.3;
        Tue, 27 May 2025 09:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748363940; x=1748968740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfddXWQjibZTKBKNGGDcZrogNXqSxDWqL62QdR5c3kQ=;
        b=TyBy5ip0DVcvJGlg7IDA236ny3R3a/a3Rhp+Uh6DSjvbz/gQZiSE+S6BNNuSd4qosc
         JLQuB/w9w/j/lDtM/a73eLFX6Srh3KHBW5Tsls+rzF4jMte0GjjHFVV5dXqj/1RpftrD
         3UHtsDem7UwUBuDAzaETSkOINbiC3WL9KVuZaVcK1tKX4pGWYfkApGOhNX6FZnAtnBFT
         ISTw2u0Fr8hdKlhUzvh6I2g5mBOVj4QgEmI/cszA9SvUL+p/3kWkt36XsvHnLl7Ba+kl
         w5bNehsH7I9Ox+6qQJGRAhzU3U8oli89RlP/iFFHF1AZhobYr1txw+1sD81kCecWkhnW
         FVRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748363940; x=1748968740;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vfddXWQjibZTKBKNGGDcZrogNXqSxDWqL62QdR5c3kQ=;
        b=WxNXQnMbtoBS9U8QXBTxJTXf9a554CJoj8bo3FWLJXutDqIjqmmQoZvV2RYBv6Nssd
         aCdNzj3OgWFmECfPu2xyEdJChwLs2wTKqOcyQhBXFPioZQbpBuEc3cGIVhIqy/VtFU+d
         Gw33FsqxPNVveOBwmI4ns8c/PWE1Z+mMpVaNYFHpKNBr2BOQV00KPAPUwSeRtIRhXIsF
         niAnC7S/mHsUUWcYKmHf6Kxuf/rR32tc/uBYNFiYe9wrX+7LQWq+iE4lSZfxpEnYbged
         0HONnJStVDPXIirP6sH3DeedBupdQKzyisZkPMReofG9omz8hK3siXtmwEqTaS4GA2tx
         KJoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAVFb+5dvVBuCwAsSPUTrjIKW58AE+RQHQxUt5SP1uXs2WNKn9wlfNRFUXAAel8wK2X1Onpx2CGIfy75Shngs=@vger.kernel.org, AJvYcCWPmpnkPVnsrAPLXO5X5bT+GTbRW9W4dYkfIbX/AfgWfCPkJZg7vHfbouRklEUNAQ2PFQurpatWEPkxojVL@vger.kernel.org, AJvYcCWdYm9a9sHumHVaSX2SxzdMTK4UQVZufz8pSBfgK66fxMBbcQY8qEnZ+9UxsQHCc7EGW0TivMpUCXQYGC9XIR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB3IEBWA4s6Ndzkmk19CHBgHShfotyGVte+QpwafOAeU9r9knx
	VYuRkmeTfQq55KLPvCCCyfR93DleauhygxQImLDVJIBoFcXvP0mrlP2H
X-Gm-Gg: ASbGnctWS1BAGnK0/ENrTWzwIWtT6TVIwO4FsAhFDcejBQqwezqLXBRETZ/FiEdBa56
	ssas4zirIWBO3fsCjzuK+vO8RicRb/fvIGPp1WvSYzKE3vwaf2Twjohy3zOUTfNH96vj9Nj5Rpv
	fdEkAtnWHSajJr/dyH2lEC0YuO20/+Q+nwhSS+bSi4d/RQm6yJO5eImSbBjXPM7BfGbFFDQfQ7g
	qc/gwfZ52sDir639KEUQuPHxFxBM45bSxBHC7/j/ynUGukKT4jf2bJynpANavptfVV8MYkt5H93
	0T6vXh6lKtUn9YdCXYuy8ch+JkAV/9wf4v1N5BGnALx6lTzEQ835ENRpQ5K7aOszClapyQHUB/E
	RNYnhDRMTNpSD7c1zv9WNNoQqZSbVGdlcJSl9XVjfqQ==
X-Google-Smtp-Source: AGHT+IFuyJn0HW6EUxmfq5bmO3813CO0NIxsIdhk+LTmdfzK05Upiz7d1opR40QJWZTn1ek7TxuJtw==
X-Received: by 2002:a05:622a:2616:b0:494:a23a:cadf with SMTP id d75a77b69052e-49f47b05cfdmr219085081cf.32.1748363940558;
        Tue, 27 May 2025 09:39:00 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-494ae528713sm168824091cf.71.2025.05.27.09.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 09:39:00 -0700 (PDT)
Message-ID: <6835eaa4.c80a0220.2baf57.d14b@mx.google.com>
X-Google-Original-Message-ID: <aDXqosNN0g0EtHzf@winterfell.>
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 870801200043;
	Tue, 27 May 2025 12:38:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 27 May 2025 12:38:59 -0400
X-ME-Sender: <xms:o-o1aPeyYsc3-i7arpsKxc_4kTqrYD_hv9IMbIBvplBTeJ97DmgScQ>
    <xme:o-o1aFM5egdliNM-d929Mc3IAMuXhkg0iHiYEKhpu8nEF1x1FH5hRIXkFFq8Z6gSK
    SQTMZgQDuUTrQ6uuQ>
X-ME-Received: <xmr:o-o1aIhSb8g2a6EsncHRtkJFsrt8vOvWd4bCKE5qF6VlfCBSXCwkiBhg8cdrFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdekkeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquh
    hnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhephedugfduffff
    teeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhp
    rghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsg
    hoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggp
    rhgtphhtthhopedukedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghqvgesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohephihurhihrdhnohhrohhvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepkhgvvghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
    hnuhigsehrrghsmhhushhvihhllhgvmhhovghsrdgukhdprhgtphhtthhopehvihhrvghs
    hhdrkhhumhgrrheslhhinhgrrhhordhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjh
    horhhnfegpghhhsehprhhothhonhhmrghilhdrtghomh
X-ME-Proxy: <xmx:o-o1aA_Az6WUnTs_97ubNWmht2V2Q1d_1iISWP0vZoapCUjEg1CQ6g>
    <xmx:o-o1aLsEGoxTKiZCoNOHbr6TQO9Xe1qEzsTFWxPPuxP53TcD1igifA>
    <xmx:o-o1aPGhng6OQrXJs9GlKmqmp8p2hDuWirTezTrluNgiuWiD-xe-FQ>
    <xmx:o-o1aCML03kDGqUF_y1oWRiUh3DjiQARTw8QgSWjsHcvzVFTLAvhqA>
    <xmx:o-o1aMP80SHazLzuACLC7ErsGCiVjxlcY0fptLKwUvHODX3nhwd7bmN4>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 12:38:58 -0400 (EDT)
Date: Tue, 27 May 2025 09:38:58 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Burak Emir <bqe@google.com>
Cc: Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v9 2/5] rust: add bindings for bitops.h
References: <20250526150141.3407433-1-bqe@google.com>
 <20250526150141.3407433-3-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526150141.3407433-3-bqe@google.com>

On Mon, May 26, 2025 at 03:01:31PM +0000, Burak Emir wrote:
> Makes atomic set_bit and clear_bit inline functions as well as the
> non-atomic variants __set_bit and __clear_bit available to Rust.
> Adds a new MAINTAINERS section BITOPS API BINDINGS [RUST].
> 
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Burak Emir <bqe@google.com>
> Acked-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
> ---
>  MAINTAINERS            |  5 +++++
>  rust/helpers/bitops.c  | 23 +++++++++++++++++++++++
>  rust/helpers/helpers.c |  1 +
>  3 files changed, 29 insertions(+)
>  create mode 100644 rust/helpers/bitops.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 86cae0ca5287..04d6727e944c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4141,6 +4141,11 @@ F:	include/linux/bitops.h
>  F:	lib/test_bitops.c
>  F:	tools/*/bitops*
>  
> +BITOPS API BINDINGS [RUST]
> +M:	Yury Norov <yury.norov@gmail.com>
> +S:	Maintained
> +F:	rust/helpers/bitops.c
> +
>  BLINKM RGB LED DRIVER
>  M:	Jan-Simon Moeller <jansimon.moeller@gmx.de>
>  S:	Maintained
> diff --git a/rust/helpers/bitops.c b/rust/helpers/bitops.c
> new file mode 100644
> index 000000000000..1fe9e3b23a39
> --- /dev/null
> +++ b/rust/helpers/bitops.c
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bitops.h>
> +
> +void rust_helper___set_bit(unsigned int nr, unsigned long *addr)

Why "unsigned int" instead of "unsigned long"? The C API uses
"unsigned long" and in the Rust API, you uses "usize" for `nbits` and
`index`s, therefore using "unsigned int" only introduces unnecessary "as
u32" casting IMO, am I missing something here?

Regards,
Boqun

> +{
> +	__set_bit(nr, addr);
> +}
> +
> +void rust_helper___clear_bit(unsigned int nr, unsigned long *addr)
> +{
> +	__clear_bit(nr, addr);
> +}
> +
> +void rust_helper_set_bit(unsigned int nr, volatile unsigned long *addr)
> +{
> +	set_bit(nr, addr);
> +}
> +
> +void rust_helper_clear_bit(unsigned int nr, volatile unsigned long *addr)
> +{
> +	clear_bit(nr, addr);
> +}
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 92721d165e35..4de8ac390241 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include "bitmap.c"
> +#include "bitops.c"
>  #include "blk.c"
>  #include "bug.c"
>  #include "build_assert.c"
> -- 
> 2.49.0.1151.ga128411c76-goog
> 
