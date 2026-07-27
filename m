Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2DF3EB0EF
	for <linux-hardening@vger.kernel.org>; Mon, 27 Jul 2026 09:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785144535; cv=none; b=a8ZjMATWP0Vn9QW3KIfRjmh8FOS1xUgnjSh8bUVLqgEnvhnIh1k0OA5n4rwoz1auW4mgAY1VXc/NC0cb4lbBt/8m8C/3kB98OXplWpKrY/8l8/KyQYJJmJdZfQVTEz82mOu3+kZOkgQTccLg/SivT94DM3Q28XThcyDoLsqDxZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785144535; c=relaxed/simple;
	bh=nQlx2kWnHJd3XJ5B5weviO3lv8P9gLWs39NgJOYDu0s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i27rtTXQbh0K/7nsSs4FdfAikPW/GQ0sfatbNB2+lFrIA5XrYZr/LSRKllDlqbrvzkAz3/XI3dqCERCzTivM3fQ7Pl8FRQdYasMdGLAUcrFazFQytbvUL2GrHHXsc2zb+ZJ+aAU4TtKxPTPvRsNbwWtlNAB+jpvkUFL/49312cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pJmZjSsb; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJmZjSsb"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6983f20a8bfso3865160a12.1
        for <linux-hardening@vger.kernel.org>; Mon, 27 Jul 2026 02:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785144532; x=1785749332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=INc0UxFlZdOC07viPjgsMk1340wWs0bSyky3tI3iXLg=;
        b=pJmZjSsbXuFe6ZgStpU3UH76pfLUdBC1BnYqqZtZbhRuGv99RxCCnyfEvd232cGC0R
         cjfgqSHp+KEROsvrZK1XmYTqZoTCEEvNiKb5U2lRJf8iA0aDEyD3Whg5EvDPpd7q3jT5
         1mMgH31oJrnhhyehgboY9IdeS/MxCMnAGF0+JDQFPWcu5BGGDMka27Bum78HjtSar+Fn
         kCU3RM98Ry9+7a6Za780sByXcZD9/fTya4YeWmuXmvHsWQbzXztuHIjnYfbvnhi2Bktf
         2fYM3Z3z+F0bH6bFnnS6zaAWHLfQ/tPmywoRfsqYR7FFTVBdDOQw47wYiqGDsTBKSY9R
         VXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785144532; x=1785749332;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=INc0UxFlZdOC07viPjgsMk1340wWs0bSyky3tI3iXLg=;
        b=oRpSNVZuyLkIzHXcFZ4FFrNSFb/mzggxwokw5RQ7SjtJ7vwk/gNkcxW+tAHEQy5ktW
         2dT9thQoDXmLUI9d0raL5vnERTEDXnFfAhNKMZ4XlwNaGKkv/ZBvJtvX9iQdzaR3oE2t
         IhDtIuMjGHWXZupH0QCri8D8Dbq/DEDlUuAoUawDgTE0BJKfBaRoBlypy8J00vHdsr+M
         sN8uvSkNIUkOv2miEK7VGquoBh4TLI6Yf/+GTeYsDkg5PKkrfC6JFCKYpiTLjvfnRyns
         UoDoXLPw4v3Lk4VCANW4icKz4VWSdlvpzf8DzaFBwBDykLG9J9uNj4t3AQQlYgutAVaJ
         julA==
X-Forwarded-Encrypted: i=1; AHgh+RrGUB8/AQQdWKKX81Ef1g6VcAFPA8OGzSK0dn7gIigKE160+ZdjfEvMYky+DbUOsg6soOCweUDBCcCQj5UfZUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGENjo3UvcYbBa3BP5SYQNVee/GuB3xeY9M/ENx40gYN13uRZn
	f9kATW6WS2STEOgwHcqW3m81zgie9q+/uEM1BT91Ib/scsRvzrUSEt1J
X-Gm-Gg: AR+sD12PVzdAwEPxR3AmNVKanwtnU3xBRsrS4PtfJaihvlrm3jKhJbJaJaSCYQlgXY3
	LMjrDkR7rLeZ+yCIF8lU/CdtAVVnZpBs4OSeM2suLxvyC77QKJdYgu8wj4bM6tbB60IGZ8o/y9z
	V5HQCmmnekPmFO3zHNZV6+v3OOYWgfrxUa1pfGKtpU87MP+vpcYy0lYDVN0yxUkBGPIdhT6WOAB
	9EaJIEtMoCkL5lXeMJKpcJISMf6e5zBsKwlXIv8KQukK9kCnSwd8l8/yCm009icOGP9CBW32jZA
	4TzO3VX79GZ8EiVMGqv4WcR9oawdpOuPCqNrRWPVaDzGMVEReC5srTJ5d4V+VdzE09elv1vCTgF
	+whnINvFd6oa6IUm3Mp/F/KxIRoY6OQu6PkYF5XkOaT1j14DWnmU4xPOPhsVloT6na8yOttRs7u
	zQQni4EQhzeDmSw34M/Td+KYtZohDKB7vwBKKl0+zRkjDD941kFHLcagqItMjfZSsIIPTA8Viqj
	AemWw==
X-Received: by 2002:a17:906:6a2a:b0:c12:74b8:9d3 with SMTP id a640c23a62f3a-c1f1eabf2f1mr307455866b.3.1785144531681;
        Mon, 27 Jul 2026 02:28:51 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32ebbaf5sm607779366b.44.2026.07.27.02.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 02:28:50 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Mon, 27 Jul 2026 10:28:44 +0100
To: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v9 13/17] iio: frequency: ad9910: add RAM mode support
Message-ID: <fv4zpxtmvobho3xna2pvmgdnpnwleil33bp2z6w3grzonxf6fq@yukanjhc5fsz>
References: <20260722-ad9910-iio-driver-v9-0-459d1df5ac56@analog.com>
 <20260722-ad9910-iio-driver-v9-13-459d1df5ac56@analog.com>
 <20260725234637.4ee42657@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260725234637.4ee42657@jic23-huawei>

On 25/07/26 23:46, Jonathan Cameron wrote:
> On Wed, 22 Jul 2026 16:50:22 +0100
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Add RAM control channel, which includes:
> > - RAM data loading via firmware upload interface;
> > - Per-profile configuration and DDS core parameter destination as firmware
> >   metadata;
> > - Profile switching relying on profile channels;
> > - Sampling frequency control of the active profile;
> > - ram-enable-aware read/write paths that redirect single tone
> >   frequency/phase/amplitude access through reg_profile cache when RAM is
> >   active;
> > 
> > When RAM is enabled, the DDS profile parameters (frequency, phase,
> > amplitude) for the single tone mode are sourced from a shadow register
> > cache (reg_profile[]) since the profile registers are repurposed for RAM
> > control.
> > 
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> As mentioned in reply to an earlier patch, I haven't looked in detail
> at the firmware cancel path stuff sashiko is unhappy with.  Whilst
> it looks like the sort of esoteric path where maybe it is fine to fail
> good to take one more look.

Yeah.. it is considering a cancel request right after the fw-update starts,
with the fw-update failing for an invalid format before the check of the
cancellation flag. With this, a second attempt on fw-update would fail again
because the flag would not have been cleared.

Unusual, but I can have that handled.

> One other thing Sashiko commented on inline. I think that is either right
> or a bit more detail is needed in the comment.
> 
> Thanks,
> 
> Jonathan
> 
> 
> > diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
> > index 6c794e1b4b1c..844cc0cc8f3e 100644
> > --- a/drivers/iio/frequency/ad9910.c
> > +++ b/drivers/iio/frequency/ad9910.c
> ...
> 
> > @@ -1119,7 +1220,7 @@ static int ad9910_write_raw(struct iio_dev *indio_dev,
> >  	struct ad9910_state *st = iio_priv(indio_dev);
> >  	u64 tmp64;
> >  	u32 tmp32;
> > -	int ret;
> > +	int ret, i;
> >  
> >  	guard(mutex)(&st->lock);
> >  
> > @@ -1156,6 +1257,41 @@ static int ad9910_write_raw(struct iio_dev *indio_dev,
> >  						   AD9910_CFR2_DRG_DEST_MSK |
> >  						   AD9910_CFR2_DRG_ENABLE_MSK,
> >  						   tmp32, true);
> > +		case AD9910_CHANNEL_RAM:
> > +			if (AD9910_RAM_ENABLED(st) == !!val)
> > +				return 0;
> > +
> > +			/* swap profile configs */
> > +			for (i = 0; i < AD9910_NUM_PROFILES; i++) {
> > +				tmp64 = st->reg[AD9910_REG_PROFILE(i)].val64;
> > +				ret = ad9910_reg64_write(st,
> > +							 AD9910_REG_PROFILE(i),
> > +							 st->reg_profile[i],
> > +							 false);
> > +				if (ret)
> > +					break;
> > +				st->reg_profile[i] = tmp64;
> > +			}
> > +
> > +			if (ret) {
> > +				/*
> > +				 * After the write failure, profiles 0..i-1 were
> > +				 * already swapped in SW, but Hw registers are
> > +				 * still pending an IO update, so swap them back
> > +				 * in SW to keep the state consistent.
> 
> Sashiko's follow up question about whether a subsequent use of IO update might
> end up with these stale values seems like a reasonable one. Perhaps a little
> more detail on why that doesn't matter is needed here?

Here, I focus on protecting the cached states (reverting the successful writes)
rather than reverting stuff in HW after a SPI failure. The spi failure is delivered
to userspace, so user should be aware that something is off.

What would happen if reverting HW states fails for nother SPI failure... I don't
want to go into that...

If SPI starts to work again, other write attempts should be able to sync cached
configs with HW.
 
> > +				 */
> > +				while (i--) {
> > +					tmp64 = st->reg[AD9910_REG_PROFILE(i)].val64;
> > +					st->reg[AD9910_REG_PROFILE(i)].val64 = st->reg_profile[i];
> > +					st->reg_profile[i] = tmp64;
> > +				}
> > +				return ret;
> > +			}
> > +
> > +			tmp32 = FIELD_PREP(AD9910_CFR1_RAM_ENABLE_MSK, !!val);
> > +			return ad9910_reg32_update(st, AD9910_REG_CFR1,
> > +						   AD9910_CFR1_RAM_ENABLE_MSK,
> > +						   tmp32, true);
> >  		default:
> >  			return -EINVAL;
> >  		}
> 

-- 
Kind regards,

Rodrigo Alencar
