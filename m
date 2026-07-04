Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1259A3438B5
	for <linux-hardening@vger.kernel.org>; Sat,  4 Jul 2026 16:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783183841; cv=none; b=lNDB1YHpJVy4G8mT9jFgx5fZLDkHJGkWhw/6iRNXNlLwVjBJnc7bcBvzH/NeylXCzex9A8D2pnZaqg455+WSvgVT/X3eoU1zNzlXobjdklOUdtfagxOPVeFVRzccdtpv5FSlSMQJAlGigS3x4aXarMpn4e8TJYoPrZR45qOht28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783183841; c=relaxed/simple;
	bh=I4w7J78soOjJ0QUV6I0ifDS+Q+5IOOM3fxCKJ+hVduw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cOvxekFoFQ3wWgb+yjPEYWlKRO0tsyQ/l59MlfPRpmlUYB8qkVsXUaUg2/x9sm7bUFxu6oJY+XpT/RkEMWYsTT6mJbW4TAcAOxGyXLPu0D7/ZPDi99VYIoejF9HYIjz3uqrlljjPEHuOItKfTu8eEsNlaWLHVwDWGbjLQvbSLu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=KGIVjtDh; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="KGIVjtDh"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e9fa42f08cso1026074a34.1
        for <linux-hardening@vger.kernel.org>; Sat, 04 Jul 2026 09:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783183837; x=1783788637; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r/gEBWdH2YbusOaxF2AVLiisIf8zHaMmjVT4xSj8PXs=;
        b=KGIVjtDhSG+kReS0uIixBDUPdCC0wM05UXt5tWRk0oHxz1iqW7xAnZDjkVlLpzaQy6
         rTurFDpmEfqO8QfjPIWOJgRRqzLm8D4JlPvSBYhw+vhCwKP83RrBphshgMv9C7mEPCvh
         48qUsxEbi63Nr6sBUPx6rHf5nQjf4MtLmWjDZ9kpUqc456fsiom4RbjTRyyH1P70NsYP
         grsOPaqf54MsYZZ8MN/PBKFl8E43QEdy8hNH/QV+SFPkM64i0h636DYr2hfd+i7KtwTj
         bVvpqqdONNZkOK1wqYNi4s4JUY/55RNmFcWG8sFT0Tv9ktTjO4FuG5mXdZOLNvXb2YL5
         ceNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783183837; x=1783788637;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r/gEBWdH2YbusOaxF2AVLiisIf8zHaMmjVT4xSj8PXs=;
        b=oe/M/55Q4om/Yip4QfPqEVPy3vQCMVAVDRDsl92eesYhqIarxB7YeJZiw7Ato1bdxB
         7+Oo/FRxrw+0SZpxXvvOtLHPlsM1oAgh3jeKGMvL66XBfVoemuYUz5lhKWcXh2zFMcyZ
         g8Yc8H9GWtBARAqAoFySZB2fsn6jznDrQdsj14eYAyS+BVheGyvon7eMw1BWoPJUbTOo
         j5hLwXCrw0Hwr0FKmFwP5zCbG2OknHgdNwhvocomUP8iCnyRL9bE/J8+FfqGk/+gIkvL
         uOI9yofuCxIHDtAs7VAQi+vnE3vYjuIFwNW3s3i8/fRoVTudkF5z7cWVZISaa0Ve6OGH
         PL9w==
X-Forwarded-Encrypted: i=1; AFNElJ/tuEzaNEnl9J9wqEsygmlXgB8Ep23Jt7FUCyJeQXE9OpUxEP7wvQfPtQvimkyZQ6R951pFI1Yu6ZymSu5ltHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw54HlwrR/WTdPyTcuvIO+ySZbH/HL4QzFI1rUaGkB+Z2kR2Wuc
	jpMJ1evKpXEfo4hKryTWRn38MM771mLdgUdMyzE05MaiEvUerXGKHJEDjuvkyVsAJto=
X-Gm-Gg: AfdE7cme+h0Wf8jpTvlYcZElNqHOPLrsQrzapgva7w0tBJ9O3k6gAtl7ilPcIRdSkD/
	4CKYfvCCKz17p2fc4BbD+j74d1y5TPzdSoAhgjDo9Gzr2xXjHcC96KNsTLBxEWc3AQ+v/yp3ov/
	G36QVD0ccA4k90s5vQsN90x0NH+ZYKkmWhM2lQ7473r3Is4LT2anNTynMH+VBsZU5w1irVci0FI
	LTdQEcYxk611xGUikM6cpFCu0ca8ENTAb7V5dzy1c6fErdKk7BkhM2TSd/MbF4fXIB91kW/Gzff
	9i5AZO3wzmm7WfYzY0Asoy3hDAvsNSa81kKKm5U1TaEcTNkKlW8bbAv+lgVv3/sa1P2QAfDtQ62
	K4s5RfeFs6+LigHbMcS0FNV4g7TwAm5haEDTfeE38YS84j+yYgiU+YAuH0o/kjrVgkZmFxQ245G
	yi4m04g3FCU+jvbwNU1gUKOqvRB/MZbPZINJg59OHq00ukAVqIh6+JkojX0TP7CKg=
X-Received: by 2002:a05:6830:381a:b0:7df:5fc:3fd8 with SMTP id 46e09a7af769-7eb7fd2c5d2mr2822485a34.1.1783183836823;
        Sat, 04 Jul 2026 09:50:36 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:4944:e714:93fc:9815? ([2600:8803:e7e4:500:4944:e714:93fc:9815])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb542936e6sm7552846a34.5.2026.07.04.09.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jul 2026 09:50:36 -0700 (PDT)
Message-ID: <1493eed5-5bb8-4a2c-8f2d-8b4bc5dde157@baylibre.com>
Date: Sat, 4 Jul 2026 11:50:35 -0500
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/16] iio: frequency: ad9910: add RAM mode support
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>, rodrigo.alencar@analog.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-hardening@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20260618-ad9910-iio-driver-v6-0-79125ffbe430@analog.com>
 <20260618-ad9910-iio-driver-v6-12-79125ffbe430@analog.com>
 <20260703040544.08a8ea5e@jic23-huawei> <ake_YWfvVC9RQ3wu@nsa>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <ake_YWfvVC9RQ3wu@nsa>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/3/26 9:09 AM, Nuno Sá wrote:
> On Fri, Jul 03, 2026 at 04:05:44AM +0100, Jonathan Cameron wrote:
>> On Thu, 18 Jun 2026 14:27:28 +0100
>> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
>>
>>> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
>>>
>>> Add RAM control channel, which includes:
>>> - RAM data loading via firmware upload interface;
>>> - Per-profile configuration and DDS core parameter destination as firmware
>>>   metadata;
>>> - Profile switching relying on profile channels;
>>> - Sampling frequency control of the active profile;
>>> - ram-enable-aware read/write paths that redirect single tone
>>>   frequency/phase/amplitude access through reg_profile cache when RAM is
>>>   active;
>>>
>>> When RAM is enabled, the DDS profile parameters (frequency, phase,
>>> amplitude) for the single tone mode are sourced from a shadow register
>>> cache (reg_profile[]) since the profile registers are repurposed for RAM
>>> control.
>>>
>>> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
>>
>>> diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
>>> index 3fe97aa887c3..c4e179dda715 100644
>>> --- a/drivers/iio/frequency/ad9910.c
>>> +++ b/drivers/iio/frequency/ad9910.c
>>
>>> +static enum fw_upload_err ad9910_ram_fwu_write(struct fw_upload *fw_upload,
>>> +					       const u8 *data, u32 offset,
>>> +					       u32 size, u32 *written)
>>> +{
>>> +	const struct ad9910_ram_fw *fw_data = (const struct ad9910_ram_fw *)data;
>>> +	struct ad9910_state *st = fw_upload->dd_handle;
>>> +	int ret, ret2, idx, wcount;
>>> +	u64 tmp64, backup;
>>> +
>>> +	if (offset != 0)
>>> +		return FW_UPLOAD_ERR_INVALID_SIZE;
>>> +
>>> +	guard(mutex)(&st->lock);
>>> +
>>> +	if (st->ram_fwu_cancel)
>>> +		return FW_UPLOAD_ERR_CANCELED;
>>> +
>>> +	if (AD9910_RAM_ENABLED(st))
>>> +		return FW_UPLOAD_ERR_HW_ERROR;
>>> +
>>> +	for (idx = 0; idx < AD9910_NUM_PROFILES; idx++)
>>> +		st->reg_profile[idx] = get_unaligned_be64(&fw_data->profiles[idx]) |
>>> +				       AD9910_PROFILE_RAM_OPEN_MSK;
>>> +
>>> +	ret = ad9910_reg32_update(st, AD9910_REG_CFR1,
>>> +				  AD9910_CFR1_RAM_PLAYBACK_DEST_MSK |
>>> +				  AD9910_CFR1_INT_PROFILE_CTL_MSK,
>>> +				  get_unaligned_be32(&fw_data->cfr1), true);
>>> +	if (ret)
>>> +		return FW_UPLOAD_ERR_RW_ERROR;
>>> +
>>> +	wcount = get_unaligned_be16(&fw_data->wcount);
>>> +	if (!wcount) {
>>> +		*written = size;
>>> +		return FW_UPLOAD_ERR_NONE; /* nothing else to write */
>>> +	}
>>> +
>>> +	ret = ad9910_profile_set(st, st->profile);
>>> +	if (ret)
>>> +		return FW_UPLOAD_ERR_HW_ERROR;
>>> +
>>> +	/* backup profile register and update it with required address range */
>>> +	backup = st->reg[AD9910_REG_PROFILE(st->profile)].val64;
>>> +	tmp64 = AD9910_PROFILE_RAM_STEP_RATE_MSK |
>>> +		FIELD_PREP(AD9910_PROFILE_RAM_START_ADDR_MSK, 0) |
>>> +		FIELD_PREP(AD9910_PROFILE_RAM_END_ADDR_MSK, wcount - 1);
>>> +	ret = ad9910_reg64_write(st, AD9910_REG_PROFILE(st->profile), tmp64, true);
>>> +	if (ret)
>>> +		return FW_UPLOAD_ERR_RW_ERROR;
>>> +
>>> +	memcpy(&st->tx_buf[1], fw_data->words, wcount * AD9910_RAM_WORD_SIZE);
>>> +
>>> +	/* write ram data and restore profile register */
>>> +	ret = ad9910_spi_write(st, AD9910_REG_RAM,
>>> +			       wcount * AD9910_RAM_WORD_SIZE, false);
>>> +	ret2 = ad9910_reg64_write(st, AD9910_REG_PROFILE(st->profile), backup, true);
>>> +	if (ret || ret2)
>>> +		return FW_UPLOAD_ERR_RW_ERROR;
>>> +
>>> +	*written = size;
>>
>> I'd like a blank line here. Mostly to make that 'good' return more obvious.
>>
>>> +	return FW_UPLOAD_ERR_NONE;
>>> +}
>>
>>>  
>>> +static inline void ad9910_debugfs_init(struct ad9910_state *st,
>>> +				       struct iio_dev *indio_dev)
>>> +{
>>> +	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
>>> +	char buf[64];
>>> +
>>> +	/*
>>> +	 * symlinks are created here so iio userspace tools can refer to them
>>> +	 * as debug attributes.
>>
>> Maybe worth a reference to appropriate ABI doc here (even if it is introduced
>> in a later patch)
> 
> I'm not so sure about these links. I mean, I definitely agree we should
> make it easy for userspace tools like libiio to be able to handle
> these kind of attributes but using debugfs is questionable to me. Pretty
> much because this is not a debug thing. It is a real setting for the
> driver so ideally we would be able to control it (using the existent
> tools) without enforcing one to mount debugfs (I know that most of the
> times it's always mounted but still feels wrong to tie "real
> functionality" to debugfs). 
> 
> Having said the above, some suggestions:
> 
> 1. Make the iio_dev the parent so that the attr name is just "ram" and
> it will be a subdir /sys/bus/iio/iio:deviceN/ram/.
> 2. Propose a new helper for the firmware_loader code so we can get
> struct device from struct fw_upload then we can easily create a sysfs
> symlink.
> 3. Name the attr as dev_name(iio_dev):attr so that it becomes
> iio:deviceN:attr_name.
> 
> Now that I think about it, 2. does not make much sense when compared to
> 1. And If I'm not missing anything both 1. and 3. can be sanely parsable
> from userspace (being 3. maybe a bit more reliable). And yes, both require
> user space tools (in this case libiio) to support a new type of
> attribute (firmware) but that is another problem.

I would say that udev should be used to find the firmware device from
userspace rather than creating symlinks. And you probably don't even
need udev if you already have the `iio-device:<ID>` value. The path
is always going to be `/sys/class/firmware/iio-device:<ID>:ram/`. It
seems like the same amount of work for usespace to computer the path
either way, so might as well keep it simple and leave out the symlink
stuff.

> 
> - Nuno Sá
>>
>>> +	 */
>>> +	snprintf(buf, sizeof(buf), "/sys/class/firmware/%s/loading", st->ram_fwu_name);
>>> +	debugfs_create_symlink("ram_loading", d, buf);
>>> +
>>> +	snprintf(buf, sizeof(buf), "/sys/class/firmware/%s/data", st->ram_fwu_name);
>>> +	debugfs_create_symlink("ram_data", d, buf);
>>> +}
>>> +
>>>  static int ad9910_probe(struct spi_device *spi)
>>>  {
>>>  	static const char * const supplies[] = {
>>> @@ -1561,7 +1876,25 @@ static int ad9910_probe(struct spi_device *spi)
>> ...
>>
>>> +	ad9910_debugfs_init(st, indio_dev);
>>
>> Blank line preferred before a simple return like this one.
>>
>>> +	return 0;
>>>  }
>>>  
>>>  static const struct spi_device_id ad9910_id[] = {
>>>
>>

