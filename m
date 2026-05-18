Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37EF48125E
	for <linux-hardening@vger.kernel.org>; Mon, 18 May 2026 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779112247; cv=none; b=D/ag8N0dpGflWotKVrhSTppKKjc4ahnc3Agzl4TK52b65Fsag/aFZ9sjrfOZRDisST4KtkMHtmPLdn79Y/VR6+M933tq70BIki9ufs8b+cqACImVGqBgxv05LjxZhpUvBML/EcodR1GqZHmFi8GoiZezQO1NuNMU+D7Tam9FleM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779112247; c=relaxed/simple;
	bh=HRuFSBfnRcAX1Ik+wr5YWCfxLO3z+wetsNZ7npXKxLM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvPF3mDEoktrCCjZnOIaZ13utJPiJtGf0tUUz2FnWJIoVo4bQbCSKFFsq2uQ2gjq/hKvj4ljFyGPzlOsnK+n1S0OvtxClz8pPA1zvkkSmLuVUsgm+fjHNz7PyrJ27NHymbTqW6Yil3Q6vozJzgONW3LfkCQpWZqz1eOU1C3t2Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFwQkIRV; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFwQkIRV"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43fe62837baso1253480f8f.3
        for <linux-hardening@vger.kernel.org>; Mon, 18 May 2026 06:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779112243; x=1779717043; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bOGygrHdqOVWXAOvGkDRTZ2rxuT23fhhj2Bb5CGxVXQ=;
        b=MFwQkIRVFs1L3E53/SbMCH3sOMOZOZOkeAoBGFOErhTW8PYjS9u/rXKRbvdYPctSVy
         agHN8dBvR9tr3SUV+NHVQsytocivf9/+ttfPGtqRTpbnX2x12vXL4uEFCDbeV4Seojog
         nPUkgXIB2Lj2YpNuo8KEMp90H2jEfUiptqieprDZKHJdecu6P5iONWU1JFvMc1qxCJwu
         tOkPlALa5HVS1yY44S33qnyYBrOlgHxajEha0bvyVwB8LCBkWUyFjKznbevCzXV7G1wB
         ChzqkeWlxv3TS44ufX9EFF5i9zFOuQVPa8DPaEVt3VIN6iIYxhn+vU9aFo0+Liizxt++
         CQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779112243; x=1779717043;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bOGygrHdqOVWXAOvGkDRTZ2rxuT23fhhj2Bb5CGxVXQ=;
        b=hLbEZc/au0tJIaXi2UpHgfazs9jI+SKG6JU3DsEE20Etk8hsuu0CZwDnntul0W6vvl
         jEm0j9tkKl8rbyzyai0wzKZjWXRLPC1VQEeKbKcUAo+wGkIZ+uP/B1O0DgtBUP1bOB/e
         cwf9ViGveorMH2GfZOI8rxK6QjBqrQXNiNBTZVNu/qgrtbnXPLtVCY/Xz8nJgd3L444f
         O2TcRmUpO2hcD+r+KiEV6silFyxVgGfRO31amyQSJBr3WgOgWoy0PJhHInLZv3fV8NSK
         zQJmNfyM8ZmGWGIobjQxaSwC5Ub+jxg4Q66PRqb6ENVeb18hQFP0H2IK3Z00IpliHGok
         5nsA==
X-Forwarded-Encrypted: i=1; AFNElJ/GMzbu5iIeDbLI8UHfY9xgup4I3YF0LDrupipS1dkocBkznC8t6hi8SGIT6xWqCKMDs87TRv8IybOzxfxLUZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqhm2yCSC+4rvM7BM3lDyKggR42iw1RjRVgAAxwH+O2qBtNOP3
	I7FVLi0ObQGb7VlQ+cEy73V0W5sGjvNI+D/JlHm+aFc53a3ggbz1SSFC
X-Gm-Gg: Acq92OFCqyXlOcbpEMcWYu6owKuxCYuoN5OD1/YQVbo2jm5SHwyhIvfm8KRiwU8RswC
	3tKpM6EhZRBoUwz1BY69rQbXdA5W8kwFsGtJtrJI+tp03liwRqGyXuW0SY7w7K5brMcPj820Nxx
	FvlqKyJdy39EeJHXuluPDQYrRxAUozJ+j5ZiHW8yknYwPgQQFRWKX+JyJPhrZguIY8TGmvBATH9
	ZXJGKCo2IWJJ3j6ZnXQNDaAPttrxFOwf0WLua3nM7HfBRoaL3ofA+g2sHpabzAjtQ5qhYryjw+g
	N1Qa/9bxLrSFaU20wQXUlFdb5+e6zxc9EmJn6keVVmLpM6T/aYUbtDBiy7jAHdxIKZ3934NqTou
	25LYGDFxJfyI0iqTGZRdmCVPUNcrEjibey59znHKTNIRzftual2y14RkSv6uT7S3T5118BwrdB6
	qcaNkkMD0hCyNvXDiAj/tLNskDyqLtlPtSePoAdX7rfYPhJvdiLF0KnTSnxD5iWAnUZ1zAC25bR
	LjlSGq9lACBD5rFl4EFWp3oczeIeyRHGaYips4iF4vEbfMEeyDj4UXkcfpK
X-Received: by 2002:a05:600c:470e:b0:48e:8741:fd3d with SMTP id 5b1f17b1804b1-48fe60ea21dmr213355945e9.14.1779112242814;
        Mon, 18 May 2026 06:50:42 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768bcesm39767810f8f.4.2026.05.18.06.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 06:50:42 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Mon, 18 May 2026 14:50:37 +0100
To: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v5 09/13] iio: frequency: ad9910: add RAM mode support
Message-ID: <dedkptdfy4bbhr66nirp52ldzmkje4rnjqgxre7gvnlrpwrvce@zymm36oaulv6>
References: <20260517-ad9910-iio-driver-v5-0-31599c88314a@analog.com>
 <20260517-ad9910-iio-driver-v5-9-31599c88314a@analog.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260517-ad9910-iio-driver-v5-9-31599c88314a@analog.com>

On 26/05/17 07:19PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> - [High] Incomplete hardware rollback during a profile swap failure leaves AD9910 shadow registers corrupted.
> - [High] Missing software cache and hardware rollback when CFR1 register update fails.
> - [High] Unprotected software profile cache corruption on firmware upload failure.
> - [High] Firmware upload `.write` callback fails on chunked payloads and performs out-of-bounds memory reads.
> - [Medium] The RAM firmware upload sysfs node and debugfs symlinks are registered with a `(null)` name.
> --
> 
> commit 3876f09fc86743085e5099fea5762c34dc150ecf
> Author: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> iio: frequency: ad9910: add RAM mode support
> 
> Add RAM control channel, which includes RAM data loading via firmware
> upload interface, per-profile configuration, profile switching,
> sampling frequency control, and ram-enable-aware read/write paths.
> 
> > diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
> > index 4ad80475139d7..86ed350011cff 100644
> > --- a/drivers/iio/frequency/ad9910.c
> > +++ b/drivers/iio/frequency/ad9910.c
> 
> [ ... ]
> 
> > @@ -1202,6 +1306,41 @@ static int ad9910_write_raw(struct iio_dev *indio_dev,
> >  			return ad9910_reg32_update(st, AD9910_REG_CFR2,
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
> > +				 */
> > +				while (i--) {
> > +					tmp64 = st->reg[AD9910_REG_PROFILE(i)].val64;
> > +					st->reg[AD9910_REG_PROFILE(i)].val64 = st->reg_profile[i];
> > +					st->reg_profile[i] = tmp64;
> > +				}
> > +				return ret;
> 
> If a write fails mid-loop, this rollback block restores the software cache
> but doesn't issue SPI writes to revert the hardware shadow registers.
> Could the next successful SPI write with an IO_UPDATE pulse inadvertently
> latch these corrupted, partially-swapped profiles into the active hardware
> state?

The approach reverts the changes on cached values, so we do not have RAM and single
tone profile values mixed in software. The hardware might be in an invalid state,
but an error is reported to the user.
 
> > +			}
> > +
> > +			tmp32 = FIELD_PREP(AD9910_CFR1_RAM_ENABLE_MSK, !!val);
> > +			return ad9910_reg32_update(st, AD9910_REG_CFR1,
> > +						   AD9910_CFR1_RAM_ENABLE_MSK,
> > +						   tmp32, true);
> 
> If ad9910_reg32_update() fails here, the function returns immediately without
> reverting the swapped profiles. Should there be a rollback of the swapped
> profiles in this error path to prevent the device from operating with corrupted
> synthesizer parameters?

Yes, I'd this part can be improved. Writing to CFR1 can be moved up (before the cache
restore).

> 
> >  		default:
> >  			return -EINVAL;
> >  		}
> 
> [ ... ]
> 
> > @@ -1475,6 +1657,126 @@ static int ad9910_read_label(struct iio_dev *indio_dev,
> > +static enum fw_upload_err ad9910_ram_fwu_write(struct fw_upload *fw_upload,
> > +					       const u8 *data, u32 offset,
> > +					       u32 size, u32 *written)
> > +{
> > +	const struct ad9910_ram_fw *fw_data = (const struct ad9910_ram_fw *)data;
> > +	struct ad9910_state *st = fw_upload->dd_handle;
> > +	int ret, ret2, idx, wcount;
> > +	u64 tmp64, backup;
> > +
> > +	if (offset != 0)
> > +		return FW_UPLOAD_ERR_INVALID_SIZE;
> 
> The sysfs firmware upload framework chunks data into blocks bounded by
> PAGE_SIZE (typically 4096 bytes). Since the maximum AD9910 firmware size
> can be 4176 bytes, this driver will reject any chunks after the first.
> Can this be adjusted to support firmware files larger than PAGE_SIZE?

That does not seem to be the case:
https://elixir.bootlin.com/linux/v7.1-rc3/source/drivers/base/firmware_loader/sysfs_upload.c#L184

Sysfs binary attribute writes from userspace are limited to PAGE_SIZE per
write() syscall (enforced in fs/sysfs/file.c). But the firmware loader
framework accumulates these into an internal buffer (fw->data).

The driver's write callback is called from fw_upload_main() in sysfs_upload.c.
So, the key question is whether that function passes fw->size - offset
(the full remaining size) or min(fw->size - offset, PAGE_SIZE) (PAGE_SIZE-bounded chunks)
to the driver callback.

The referenced code shows that the write callback is not called every
PAGE_SIZE chunks, but the callback implementation that defines the how
much it can handle at each call.

Also, I have already tested this code with a FW file bigger than 4k.

> > +
> > +	guard(mutex)(&st->lock);
> > +
> > +	if (st->ram_fwu_cancel)
> > +		return FW_UPLOAD_ERR_CANCELED;
> > +
> > +	if (AD9910_RAM_ENABLED(st))
> > +		return FW_UPLOAD_ERR_HW_ERROR;
> > +
> > +	for (idx = 0; idx < AD9910_NUM_PROFILES; idx++)
> > +		st->reg_profile[idx] = get_unaligned_be64(&fw_data->profiles[idx]) |
> > +				       AD9910_PROFILE_RAM_OPEN_MSK;
> 
> Here the software cache st->reg_profile[] is overwritten before the SPI
> hardware operations. If any subsequent hardware writes fail, the function
> aborts and the cache is left with partially uploaded profiles.
> Could the original cache be backed up and restored on failure?

I'd say that is not an issue. When RAM is disabled (requirement to enter this function),
this cache is exclusive to be managed by the RAM mode. This is meant to be
written here.

> 
> > +
> > +	ret = ad9910_reg32_update(st, AD9910_REG_CFR1,
> > +				  AD9910_CFR1_RAM_PLAYBACK_DEST_MSK |
> > +				  AD9910_CFR1_INT_PROFILE_CTL_MSK,
> > +				  get_unaligned_be32(&fw_data->cfr1), true);
> > +	if (ret)
> > +		return FW_UPLOAD_ERR_RW_ERROR;
> > +
> > +	wcount = get_unaligned_be16(&fw_data->wcount);
> > +	if (!wcount) {
> > +		*written = size;
> > +		return FW_UPLOAD_ERR_NONE; /* nothing else to write */
> > +	}
> > +
> > +	ret = ad9910_profile_set(st, st->profile);
> > +	if (ret)
> > +		return FW_UPLOAD_ERR_HW_ERROR;
> > +
> > +	/* backup profile register and update it with required address range */
> > +	backup = st->reg[AD9910_REG_PROFILE(st->profile)].val64;
> > +	tmp64 = AD9910_PROFILE_RAM_STEP_RATE_MSK |
> > +		FIELD_PREP(AD9910_PROFILE_RAM_START_ADDR_MSK, 0) |
> > +		FIELD_PREP(AD9910_PROFILE_RAM_END_ADDR_MSK, wcount - 1);
> > +	ret = ad9910_reg64_write(st, AD9910_REG_PROFILE(st->profile), tmp64, true);
> > +	if (ret)
> > +		return FW_UPLOAD_ERR_RW_ERROR;
> > +
> > +	memcpy(&st->tx_buf[1], fw_data->words, wcount * AD9910_RAM_WORD_SIZE);
> 
> If the firmware is larger than PAGE_SIZE, size will be 4096 on the first
> call, but wcount could request more bytes than are present in the chunk.
> Does this memcpy() risk reading out-of-bounds memory from the data buffer?

this is dicussed above, from drivers/base/firmware_loader/sysfs_upload.c it
does not seem to be true that the write happens in chunks of PAGE_SIZE.

> [ ... ]
> 
> > @@ -1688,7 +2014,25 @@ static int ad9910_probe(struct spi_device *spi)
> >  	if (ret)
> >  		return dev_err_probe(dev, ret, "device setup failed\n");
> >  
> > -	return devm_iio_device_register(dev, indio_dev);
> > +	snprintf(st->ram_fwu_name, sizeof(st->ram_fwu_name), "%s:ram",
> > +		 dev_name(&indio_dev->dev));
> 
> The IIO core does not assign the device name to indio_dev->dev until
> devm_iio_device_register() is called. Will dev_name() return "(null)" here,
> resulting in sysfs nodes named "/sys/class/firmware/(null):ram"?
> This might also cause probe failures due to sysfs name collisions if multiple
> AD9910 devices are present on the system.

I suppose that is incorrect.

	dev_set_name(&indio_dev->dev, "iio:device%d", iio_dev_opaque->id)

happens during iio_device_alloc().

> 
> > +	st->ram_fwu = firmware_upload_register(THIS_MODULE, dev, st->ram_fwu_name,
> > +					       &ad9910_ram_fwu_ops, st);
> > +	if (IS_ERR(st->ram_fwu))
> > +		return dev_err_probe(dev, PTR_ERR(st->ram_fwu),
> > +				     "failed to register ram upload ops\n");
> > +
> > +	ret = devm_add_action_or_reset(dev, ad9910_ram_fwu_unregister, st->ram_fwu);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret,
> > +				     "failed to add ram upload unregister action\n");
> > +
> > +	ret = devm_iio_device_register(dev, indio_dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ad9910_debugfs_init(st, indio_dev);
> > +	return 0;
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260517-ad9910-iio-driver-v5-0-31599c88314a@analog.com?part=9

-- 
Kind regards,

Rodrigo Alencar
