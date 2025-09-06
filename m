Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F202F1F5F6;
	Sat,  6 Sep 2025 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757168852; cv=none; b=Dlza9vO26Pj7dih8KlolvFUf/S3N5AeH76oZRG+crPFUicvDMNKZ9bHY24k/LWlUf3dTB+vCSQLsXy9TTZAPOFM6NsccBvofPqFdHR42pKFINlE3bAMBJUKh4yC3SJJNff/4OmWhWSnZD8SsauxAvBryDSQR/TJAEtWD9PSdFLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757168852; c=relaxed/simple;
	bh=uLFV/MlpNQBdyT07MRh3qADLmF7gcgTzvaZH9DgBaEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqzoivrSNX33B/jWjhJWqDbm15sqdrmTjTdb2gciLuwVkDToEYpY/bRpIfkYHjbPcB0ApewQbofnGl6WUAtlpYYYXZvRZK0vvL/vcT8YXqbUxStLOhfvDLzeABwiWdT7L6RekaSH4ecv3Xgl9jYY7dqR/qKiAdsHHLq+g02zjyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6y309nx; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6y309nx"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-723bc91d7a6so26687787b3.3;
        Sat, 06 Sep 2025 07:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757168850; x=1757773650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FJO9S7x3nRRnjHDwb9V3pJU7i7F2/XAB3JBEito+s1c=;
        b=h6y309nx7Z3iqK/xhcX+hvmryH/kw5rodCQ07zMUDZBBOFJyI8rsC0FYr1XCXIucmJ
         7ATf7D1fONCHSn5Z30QqT7tuN+5ScseDVEPEL9eNbEUMyPnZ7CwxyQeCSfBctkXxNPEK
         NctytL3HAAOXKr8sAsutOh9hkGOyUAvP6KzyCY8oqzn12/kcHiPl/denPdXr79PVAjxq
         HqxsbCwlT0yxT8X3g5x5qw9t6TWgqUigVpUnkEFhhO9NQbJWHzIjL8izFQq8AUy3xSdM
         WjjaQ7JWZXK7uVywV/4bG58EA9XYGMLFAYCuRS8Y8faRGRPBvKwxXx2BCzuiomgiVKRu
         TnMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757168850; x=1757773650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJO9S7x3nRRnjHDwb9V3pJU7i7F2/XAB3JBEito+s1c=;
        b=kCuXDBiMSsduhBzMSfTtRjQeluldd3a3Qt27OQ6RxO5oP4BGx9my30XeC2WaXPM0EK
         oWL8zI2jbzTEmJqLobSzLSsXGwDOHejfl22LEat2jAdmrlVMeUlvyYC6iE5nIZsDOdGn
         s9CUAWlR+DuO67AMCX0eRfyHo8A2uGo7n55pPfuvC8RnWyKEtJADtk8IEKyPY6S/Pp3W
         LTUw/gJH2DeZndoPQT/XX3dZ4htmZkTfxCoBZ3WT2lWfPCXtA/Z9xzkBK2ZgmtLnW8/F
         KDHWQHy8z+JoVRD4cFhgYfgIL27VeqvqBin1nDzQXogsx7Zfr1coy5kovuxp4YyX2PY9
         xaWA==
X-Forwarded-Encrypted: i=1; AJvYcCWF5mKBUFKlPGbbfnexZzT3vi77dgeHxHXNlieqK84eI1iPuIDtxffcC538yXTtPpoWMiz7pLQ8ecNj7j5b@vger.kernel.org, AJvYcCXAuYxvdXPPRLlXA+X+ZBolCkW5QHj60jAcYZneH2rdWFAJkXNNm/jP+h8r7m/hngv8AojBCqXq1zFlEjuRCQk=@vger.kernel.org, AJvYcCXf7gDBHUSys72LwS/0SL7NsbAJh+mo1u2ywEkq6v5LsR3CG7MqdO9k71Qdn6kpK9ViRSBBENhIEXO57jpRWYU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1y5yFJaox3er3F6e6kjuXheN+cI37SzWIUk5ySSjOfrSdu7wB
	M8VcBh6OD90TkRYG6lY39hpXexetJs31YdV0dz9v2leNRpWX06xMhrO0GiXjgg==
X-Gm-Gg: ASbGnctHahzHLbdvQS7nKnHMh1faHRaUZxqLyjHnrfUast7Q8h7W9VxKTBmZ3jKQOm9
	VRIDb0a2A7TCFeA790lxUuC4uhu/m2UNTJgyXZwjwUO9MN3Uhsmo9muhP2hfGv3GGDDdQCveKl6
	LcN8I9SYEl76jT8cpTfxTT4Z77xif5kkVRI26d9AJq6YFxgXZJms6bx0ki+Pr9+bQz3FNf8sHAo
	k2mPmD1QRLsYxGeWOlb2aHzyH/B5RKj6mN5/41jmvWYrDtmMWYRsRxotzPWcTFYKkxr6/mpcJsO
	FiJvoKS8Sc0whhdD6NUVJs+gPPsahq+PV/W0ygaS/3T7p8aoiMMfrcVWB64/6Kymv0u0snERu1C
	J3uWOXkDhj0QBo7MDifTQu9BJzxtERMcreVbsDJQBIKF3jYJjad6PFk1Eiw==
X-Google-Smtp-Source: AGHT+IFo/wdRnLRWSsHuDNT81jeYpBcsp0gDGos0qkmPdS51KfdLC3byHzsGcGowzpzY+8XxHQpscA==
X-Received: by 2002:a05:690c:7002:b0:721:21f6:3e0d with SMTP id 00721157ae682-727f505616fmr20670537b3.38.1757168849822;
        Sat, 06 Sep 2025 07:27:29 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-5ff8784525dsm3348113d50.3.2025.09.06.07.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 07:27:29 -0700 (PDT)
Date: Sat, 6 Sep 2025 10:27:28 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
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
Message-ID: <aLxE0AvP63nXxciG@yury>
References: <20250904165015.3791895-1-bqe@google.com>
 <aLnURXW_ZiX2iJd_@yury>
 <CANiq72==48=69hYiDo1321pCzgn_n1_jg=ez5UYXX91c+g5JVQ@mail.gmail.com>
 <aLv8buzrro0E5CCQ@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLv8buzrro0E5CCQ@stanley.mountain>

On Sat, Sep 06, 2025 at 12:18:38PM +0300, Dan Carpenter wrote:
> Nope.  Try again.
> 
> diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> index 6e0824579781..2f00e91e9c35 100644
> --- a/rust/kernel/bitmap.rs
> +++ b/rust/kernel/bitmap.rs
> @@ -551,18 +551,21 @@ fn bitmap_set_clear_find() -> Result<(), AllocError> {
>          Ok(())
>      }
>  
> -    #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
>      #[test]
>      fn owned_bitmap_out_of_bounds() -> Result<(), AllocError> {
> -        let mut b = BitmapVec::new(128, GFP_KERNEL)?;
> +        #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
> +        {
> +            let mut b = BitmapVec::new(128, GFP_KERNEL)?;
> +
> +            b.set_bit(2048);
> +            b.set_bit_atomic(2048);
> +            b.clear_bit(2048);
> +            b.clear_bit_atomic(2048);
> +            assert_eq!(None, b.next_bit(2048));
> +            assert_eq!(None, b.next_zero_bit(2048));
> +            assert_eq!(None, b.last_bit());
> +        }
>  
> -        b.set_bit(2048);
> -        b.set_bit_atomic(2048);
> -        b.clear_bit(2048);
> -        b.clear_bit_atomic(2048);
> -        assert_eq!(None, b.next_bit(2048));
> -        assert_eq!(None, b.next_zero_bit(2048));
> -        assert_eq!(None, b.last_bit());
>          Ok(())
>      }

Alright, the testing is definitely failed. I'll drop the series and
let Burak to send v16 with all fixes merged.

Thanks,
Yury
