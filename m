Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81904287510
	for <linux-hardening@vger.kernel.org>; Fri,  5 Jun 2026 14:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670417; cv=none; b=LgOlQSlAaFPkBpSOR5ws2zldrPbjOgPI2pKHB8oYcfnMbu1aMrworvvT0fkv08MbG7dGNAz9U97xNgBvYKGaLqD177qXoMNhGdDwC0khoJlesqDTl554QfCjo/ln0coqj7K/4HfMgQtAwZq9CXjCBVQnGFXQr/MIMz2FjH9pHnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670417; c=relaxed/simple;
	bh=uTFaLbD94g6l9PwItMr3jHF0S+U5kEzaUis22iok9Uo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ff4+ma9HEwSq/WvS30ApNga0V9Ba1RMSHuiyFMh2VdnUar4icNHCxCqggMbiDhuSIIiqpKTDAcvbbIg2Km5KYtyPnucKzBr3L+n8SXitf56HrUyhoguhwgSxwQKSxCP6LZE8pdSVsWbJ+n9E3IQAIXO8zBupUsQ+IsbvHKLS2e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JN3Xt2SO; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JN3Xt2SO"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45eeea039ebso1079771f8f.1
        for <linux-hardening@vger.kernel.org>; Fri, 05 Jun 2026 07:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780670414; x=1781275214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DdmpuPgPA38VeTeuKDOnpEQv9HAVop+/PGKrT2luQtY=;
        b=JN3Xt2SO9jCUtIjXlJW8DinsQlv1HcNo64WgtU3+Q/k7NsjlQ5lRUKkAS0+7+AlBQL
         b9WG7OKFBMV22WyKXDBYiYsjwzWM92JJCXcYtZQ8q5G+o7IayCqKn1h6GkEpGxMVA84R
         CTv1j7Jy7brRFKx/06CyQcFbxCTtN9nPoAvwApUS5CmhOc3WBH9zL3SV2Br4cFmHCiFS
         b9H+yyCbTpHSRTQhWKlB85jC0AKPCxRnqoTGjg0KP5UfIkCO1zK42YzSnSnv5NFgmRE3
         UQXypTqlOawtMv8GTOzu7sN1w1uiCRKgwnkgnmDYXwzwf/ZGTfHpRL/+PM+P8X3CgzKN
         LdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780670414; x=1781275214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DdmpuPgPA38VeTeuKDOnpEQv9HAVop+/PGKrT2luQtY=;
        b=IReSDrKIA3KZufW1GqA7nosFSI3SYHwfr1NnK7QsXZJYoSsqkrKLztVvMDACP6X+kV
         piaNo8SrWLYsFD3SXQZ67EP9khnTZIPnPMOaCI2PAa2OW8boJp37++tX05RvwBzQAtiX
         7a3lJQKpgD+Y/vlFy9reakr2x4uyIDogGqBNma3sh+1jPHZ/3v7TRflRM2Nt4KL46cKj
         jx6c3DQTNLqyQvMAfjyjH6HrkMST1xyeu33soFB0HRpVU6P8KNeFe/VCd0shksNCf8Ok
         Gx6Dvvv46+ATT/RqYhCw0BFhWd5uDiVs7Gt4F2rERZk5L4pqt1VAnK8Qbi0I2HmBetO8
         S5fQ==
X-Forwarded-Encrypted: i=1; AFNElJ8c/r3xPjkkhS7Ywu+yDTc3AT7dAgqJXpyPpmE176hNi2BNALpc/jiWctsVe57BDrHQIzzoLgxPQU1E2tJMXKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz6eBt+JDo7cqOZUHMZLgTtyToNZKRm8R9Fwu/BWGJ1xc+jzML
	24uzQZzBJ9E9ruxY63SPedFSM0L3oEvrXw/yP5MEENs7O6sL1MuJ4miP1q9eFr6g
X-Gm-Gg: Acq92OFpT1B9PkBtwAWA/G/q7vv7dA6BckdwazIKrXpr9TeWNRhzi16ZmyEpKXKh81m
	ZYsgeto6aUTMhm9Tvc42RbG334Lu6tMaHgvFmfzMxf9TcgOjXlFzxnpwe3k18SvaWECzZ41IAqK
	9GsC/YUzI5nUooyvlOGkvjxNplf/QGTLdmrSeGRALUYolkUoDu0JGg0pmffb93TAeDH9ioA931O
	rERr0gZOS6G/I7QzGrWhLQQ6kTlSyBwzBKYb+85vnS9TR1jFUwtk8vEiOFAfY7ZixdbkXFWzGfL
	jRR8VaafYY8SQ6A88ZaWqcRSOJlIf2u6OUyFUlIBXjmB+NTlAycXDQV412OBlnwkCR4TWlBbCCO
	MGxxKefqVjwPD2Dh9NM7vFfQEg5ePsyerLHQ+cwKwx3w2n3HlqdbAJ44nxQaXkqzsVgGAG5F7vb
	qkXuE+Ge5I+O5E6GR8g2VEFsqUKAy7p1Rnc5Bdd/oS0836Glf+cqHPxwsMHm9Ah2A7EYYTopdU9
	gbfB+AGEI/6RThQKJUt2cgbziq2fGqTN1/W0u45Oe7qh5yXQA==
X-Received: by 2002:a5d:5e08:0:b0:45a:dd7a:e33c with SMTP id ffacd0b85a97d-4603062afc1mr7290618f8f.33.1780670413795;
        Fri, 05 Jun 2026 07:40:13 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344541sm24350549f8f.22.2026.06.05.07.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 07:40:13 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Fri, 5 Jun 2026 15:40:08 +0100
To: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>, rodrigo.alencar@analog.com, 
	Michael Auchter <michael.auchter@ni.com>, linux@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH 10/12] iio: dac: ad5686: add triggered buffer support
Message-ID: <httw7hnumjs5cmtpjntci24ufmjts7rhqyjawnxhh5gd74sg3d@wpg5ecnyms53>
References: <20260602-ad5686-new-features-v1-0-691e01883d27@analog.com>
 <20260602-ad5686-new-features-v1-10-691e01883d27@analog.com>
 <20260603134151.7cf1654b@jic23-huawei>
 <i3wvatdosla3cszhhtizgoetcbknl56be3mpipzdxqx2jzvch2@l4hzeer5zoa7>
 <20260605150951.1c793b76@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605150951.1c793b76@jic23-huawei>

On 26/06/05 03:09PM, Jonathan Cameron wrote:
> On Fri, 5 Jun 2026 12:34:31 +0100
> Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:
> 
> > On 26/06/03 01:41PM, Jonathan Cameron wrote:
> > > On Tue, 02 Jun 2026 17:33:57 +0100
> > > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> > >   
> > > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > > 
> > > > Implement trigger handler by leveraging the LDAC gpio to update all DAC
> > > > channels at once when it is available. Also, the multiple channel writes
> > > > can be flushed at once with the sync() operation.  
> > 
> > ...
> > 
> > > > +static irqreturn_t ad5686_trigger_handler(int irq, void *p)
> > > > +{
> > > > +	struct iio_poll_func *pf = p;
> > > > +	struct iio_dev *indio_dev = pf->indio_dev;
> > > > +	struct iio_buffer *buffer = indio_dev->buffer;
> > > > +	struct ad5686_state *st = iio_priv(indio_dev);
> > > > +	u16 val[AD5686_MAX_CHANNELS] = { };
> > > > +	int ret, ch, i = 0;
> > > > +	bool async_update;
> > > > +	u8 cmd;
> > > > +
> > > > +	ret = iio_pop_from_buffer(buffer, val);
> > > > +	if (ret)
> > > > +		goto out;
> > > > +
> > > > +	mutex_lock(&st->lock);
> > > > +
> > > > +	async_update = st->ldac_gpio && bitmap_weight(indio_dev->active_scan_mask,
> > > > +						      iio_get_masklength(indio_dev)) > 1;
> > > > +	if (async_update) {
> > > > +		/* use ldac to update all channels simultaneously */
> > > > +		cmd = AD5686_CMD_WRITE_INPUT_N;
> > > > +		gpiod_set_value_cansleep(st->ldac_gpio, 0);
> > > > +	} else {
> > > > +		cmd = AD5686_CMD_WRITE_INPUT_N_UPDATE_N;
> > > > +	}
> > > > +
> > > > +	iio_for_each_active_channel(indio_dev, ch) {
> > > > +		ret = st->ops->write(st, cmd, indio_dev->channels[ch].address, val[i++]);
> > > > +		if (ret)
> > > > +			goto cleanup;
> > > > +	}
> > > > +
> > > > +	if (st->ops->sync)
> > > > +		ret = st->ops->sync(st); /* flush all pending transfers */
> > > > +
> > > > +cleanup:  
> > 
> > It turns out that this label is not really needed. When sync() op is available
> > it must be called regardless of write failure, so the bus data can reset its
> > state. Then moving "cleanup" up would just make it useless.
> > 
> > > > +	if (async_update)  
> > > 
> > > Error paths are always fun.  Do we care about setting ldac_gpio to 1 if
> > > we failed to write the channel values?  That will set any that did successfully
> > > update, but not all of them.  Note I'm not sure on the right answer for this.
> > > There may not be one!  
> > 
> > I would not see a problem with that, as there is no much we can do with errors
> > in a interrupt handler.
> > 
> > >   
> > > > +		gpiod_set_value_cansleep(st->ldac_gpio, 1);
> > > > +
> > > > +	mutex_unlock(&st->lock);
> > > > +out:
> > > > +	iio_trigger_notify_done(indio_dev->trig);  
> > > We get this pattern so often (though not always).  Feels like maybe
> > > we should put some effort into a generic opt in solution for this.
> > > 
> > > A job for another day but options that come to mind.
> > > 1) (hideous) a flag
> > > 2) Maybe an alternative callback. thread_always_complete or
> > >    something like that.  Pain to wire through all the calls though
> > >    and injecting the necessary wrapper isn't great either.
> > >    Implementation wise would be a case of popping in a wrapper function
> > >    in iio_trigger_attach_poll() call to request_threaded_irq().
> > > 3) Maybe a helper macro?  Bit ugly as we'd need one to generate
> > >    the wrapper function and another to use the same name for
> > >    the registration function.
> > > 
> > > Hmm. Those are all ugly (maybe 2 is ok ish).  Suggestions welcome!  
> > 
> > using a cleanup.h? with something like:
> > 
> > 	static inline void iio_trigger_always_done(struct iio_poll_func **ppf)
> > 	{
> > 		iio_trigger_notify_done((*ppf)->indio_dev->trig);
> > 	}
> > 
> > 	static irqreturn_t ad5686_trigger_handler(int irq, void *p)
> > 	{
> > 		struct iio_poll_func *pf __cleanup(iio_trigger_always_done) = p;
> 
> That's not a nice pattern given the lack of any local constructing. The ownership
> transfer isn't obvious as both p and pf are really same type (it's slightly
> hidden by the void * nature of p) - ideally we'd want p to be unusable after
> that transfer.  Could do something hideous like 
> 		struct iio_poll_func *pf __cleanup(iio_trigger_always_done) =
> 			__get_and_null(p, NULL);
> where p is set NULL so it becomes dead but that is ugly and not what that
> is for so I doubt it would be popular and so we'd end up with yet another
> weird macro.  There is some precedence with take_fd() but the use of that
> is complex and I think it is only used to grab ownership from a local CLASS()
> defined cleanup.
> 
> So it would work, but I've actively argued against this style elsewhere
> in the kernel so don't really want it in IIO either!
> 
> Key disadvantage is that it is yet another weird bit of cleanup.h stuff for
> people to learn and we have enough of those already.
> 
> So indeed an option but I'm not really liking it.

That makes sense, I understand the concern. I didn't take __cleanup()
as ownership transfer. I thought it was just to register actions to variables
when they go out of scope or something. In that case the pointer itself is
being "cleaned up" (with **ppf in the cleanup action) not the memory that it
points to.

-- 
Kind regards,

Rodrigo Alencar
