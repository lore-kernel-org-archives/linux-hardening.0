Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CFB54780
	for <linux-hardening@vger.kernel.org>; Sat, 11 May 2024 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715444398; cv=none; b=RphVhyMtBG9E8O3LZR/hMAd0CCp5If4P9gb3BASCRpSxnor5cDyQ8eraav+K8JkCbsh3fG6m4W+cZZwDqPRBZ2li5VZbadwhkWhiUGiwbaK7wF/hhbb2RtK3WOfrXPV97a5r4T0d52InjqbJHOGecv4qPXgaJjATNnFLIp8yXxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715444398; c=relaxed/simple;
	bh=RuuS8zpxoRmHVqAdrZe0CD6SBD46zm4h+foC06fQHu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1akH+h0yR8wKYle95VDqio4qmm22xEpo45J7EcNi3U2BwqLqxgQDTRaB2IbrJCqO8BOrzgRY48LvX82ZYmeEViVYOQU9psbnO+5XDEShOIPdnc9jZZ9UwhZV6uAozMZU2dwfgXIEC/DT6CtBGxbv/6pWchuMj6r+HVIAdNH9fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mG7LGQl4; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mG7LGQl4"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59a17fcc6bso707705866b.1
        for <linux-hardening@vger.kernel.org>; Sat, 11 May 2024 09:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715444395; x=1716049195; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vbUMTEX6m3rt+3OY+OFWA/VbtbWKAOJ+KgCixGrtPtw=;
        b=mG7LGQl4E9yX51sYmRp55iyXP9G8ju3oi+5RYq2Y+upiOX3asHlZ0+WzugJ1MAvAkN
         ccE7wcbxbzDYJ7zJM0h32dyK7EWPWUQ7JxMuNyrJd8zYvNZ/go7mbTrSaif0ZWWOo/Tt
         800hWf3hIor4A3GIdZlIYmH2XAp8uBc2oViwyJzk/kTeFL8mP/1rqWD2dUsISRRazQG9
         j6zIvuVtdn9rknlFS+bF3TAHOIHy9min4CclM6tVmnDRMbAnFo1afP9sAH4VHJnWiFbG
         8jVVeLKAzeNFRW7kRXIUT4xc/aApU9BkCK3FyOWq6g82LTdGfjSzMn/AJ3jQF+jdEu0w
         Idiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715444395; x=1716049195;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vbUMTEX6m3rt+3OY+OFWA/VbtbWKAOJ+KgCixGrtPtw=;
        b=CWWUQnJQ40sQyluYmjH6YKtPmm3RS/jNjxcgK+aZ7VuTvd9g9xzEtpnNqHV8CZQZoQ
         /8sMq3DSFvWKdVAmfYCG5RuD7USrjuhL101eO8SBacanS9yExNtUqwLg/kQiJX6zL1nH
         7Mf3ZLTivaApRZ9yrF0grybq0h6QHxqkCAh/YGkiJd1MSeUgX881KAjPQ69PiPo9YD/l
         tHgxn9rUJMW81/PJwmzqtz3qBF0GJ5UvW9GyAzS7Z4IoHK5ZoGLguvDnSunJV4I1TotV
         uccQWZmhbQJfG2Jw0FSjsaFS/5ExFsm6p6yvH0/XMCIgYsY4S9KQvSaeizCyOkMjtgjJ
         agGw==
X-Forwarded-Encrypted: i=1; AJvYcCXK264HM5cVSjisbdgIQo9RweWhW7gM9QVH4m+9HEyGVI+jsjTIhPEp/dQWNiZcc4JUCpTFsQ1YYzK4sD+mxecGpSdQiwv+FIG7he4vZIs8
X-Gm-Message-State: AOJu0YzemDmPspc0AuMQ8rBb9Imdk0zlFPRQyg1EUHeSNJlQwET6QEkR
	HSLVQJRZ6mMMvX0m48UIRBaZBwMcEViORk1Ct/vmabLj6KOlcucE4djLlv350K8=
X-Google-Smtp-Source: AGHT+IGxMl5HSfr0i2j6HMDDHTyIAdFvrzQjk8AYeajhDnujdnlmNHPXsgc2fOM/6TTiXKM9gq/v/w==
X-Received: by 2002:a17:906:3542:b0:a58:5ee1:db43 with SMTP id a640c23a62f3a-a5a2d57a3b1mr348282766b.23.1715444395024;
        Sat, 11 May 2024 09:19:55 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b17844sm344129566b.190.2024.05.11.09.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 09:19:54 -0700 (PDT)
Date: Sat, 11 May 2024 19:19:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Justin Stitt <justinstitt@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
Message-ID: <039d54d6-8aa2-4e5b-829b-69002cff35d3@moroto.mountain>
References: <202404291502.612E0A10@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202404291502.612E0A10@keescook>

I'm pretty sure we've tried using a sanitizer before and it had too many
false positives.  So your solution is to annotate all the false
positives?

There are two main issue which make integer overflows complicated from
a static analysis perspective.  1)  Places where it's intentional or
we don't care.  2)  Places where the integer overflow is harmless for
one reason or another.  Btw, integer overflows are a lot more common on
32 bit CPUs because obviously it's easier to overflow 4 billion than
whatever number U64_MAX is.

Here are is a sample of ten integer overflows that the user can trigger.
Maybe pick a couple and walk us through how they would be annotated?

drivers/usb/dwc3/gadget.c:3064 dwc3_gadget_vbus_draw() warn: potential integer overflow from user '1000 * mA'
  3052  static int dwc3_gadget_vbus_draw(struct usb_gadget *g, unsigned int mA)
  3053  {
  3054          struct dwc3             *dwc = gadget_to_dwc(g);
  3055          union power_supply_propval      val = {0};
  3056          int                             ret;
  3057  
  3058          if (dwc->usb2_phy)
  3059                  return usb_phy_set_power(dwc->usb2_phy, mA);
  3060  
  3061          if (!dwc->usb_psy)
  3062                  return -EOPNOTSUPP;
  3063  
  3064          val.intval = 1000 * mA;
                             ^^^^^^^^^^
mA comes from the user and we only know that it's a multiple of 2.
So here we would annotate that val.intval can store integer overflows?
Or we'd annotate mA?

  3065          ret = power_supply_set_property(dwc->usb_psy, POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT, &val);
  3066  
  3067          return ret;
  3068  }


drivers/usb/class/usbtmc.c:852 usbtmc_generic_read() warn: potential integer overflow from user 'max_transfer_size + 1'
   842                   * wMaxPacketSize – 1) to avoid sending a zero-length
   843                   * packet
   844                   */
   845                  remaining = transfer_size;
   846                  if ((max_transfer_size % data->wMaxPacketSize) == 0)
   847                          max_transfer_size += (data->wMaxPacketSize - 1);
   848          } else {
   849                  /* round down to bufsize to avoid truncated data left */
   850                  if (max_transfer_size > bufsize) {
   851                          max_transfer_size =
   852                                  roundup(max_transfer_size + 1 - bufsize,
                                                ^^^^^^^^^^^^^^^^^^^^^
This can overflow.  We should make it a rule that all size variables
have to be unsigned long.  That would have made this safe on 64 bit
systems.

   853                                          bufsize);
   854                  }
   855                  remaining = max_transfer_size;

drivers/usb/misc/usbtest.c:1994 iso_alloc_urb() warn: potential integer overflow from user 'bytes + maxp'
  1974  static struct urb *iso_alloc_urb(
  1975          struct usb_device       *udev,
  1976          int                     pipe,
  1977          struct usb_endpoint_descriptor  *desc,
  1978          long                    bytes,
  1979          unsigned offset
  1980  )
  1981  {
  1982          struct urb              *urb;
  1983          unsigned                i, maxp, packets;
  1984  
  1985          if (bytes < 0 || !desc)
  1986                  return NULL;
  1987  
  1988          maxp = usb_endpoint_maxp(desc);
  1989          if (udev->speed >= USB_SPEED_SUPER)
  1990                  maxp *= ss_isoc_get_packet_num(udev, pipe);
  1991          else
  1992                  maxp *= usb_endpoint_maxp_mult(desc);
  1993  
  1994          packets = DIV_ROUND_UP(bytes, maxp);
                                       ^^^^^
The issue here is on a 32 bit system when bytes is INT_MAX.

  1995  
  1996          urb = usb_alloc_urb(packets, GFP_KERNEL);
  1997          if (!urb)
  1998                  return urb;


drivers/usb/storage/uas.c:324 uas_stat_cmplt() warn: potential integer overflow from user 'idx + 1'
   322          idx = be16_to_cpup(&iu->tag) - 1;

The "- 1" makes this UINT_MAX

   323          if (idx >= MAX_CMNDS || !devinfo->cmnd[idx]) {
   324                  dev_err(&urb->dev->dev,
   325                          "stat urb: no pending cmd for uas-tag %d\n", idx + 1);
                                                                             ^^^^^^^
Harmless integer overflow in printk.

   326                  goto out;
   327          }


drivers/mtd/parsers/tplink_safeloader.c:101 mtd_parser_tplink_safeloader_parse() warn: potential integer overflow from user 'bytes + 1'
    97          for (idx = 0, offset = TPLINK_SAFELOADER_DATA_OFFSET;
    98               idx < TPLINK_SAFELOADER_MAX_PARTS &&
    99               sscanf(buf + offset, "partition %64s base 0x%llx size 0x%llx%zn\n",
   100                      name, &parts[idx].offset, &parts[idx].size, &bytes) == 3;

I think this buffer comes from the partition table?

   101               idx++, offset += bytes + 1) {
                                      ^^^^^^^^^

   102                  parts[idx].name = kstrdup(name, GFP_KERNEL);
   103                  if (!parts[idx].name) {
   104                          err = -ENOMEM;


drivers/char/ppdev.c:344 pp_set_timeout() warn: potential integer overflow from user 'tv_sec * 100'
   343  static int pp_set_timeout(struct pardevice *pdev, long tv_sec, int tv_usec)
   344  {
   345          long to_jiffies;
   346  
   347          if ((tv_sec < 0) || (tv_usec < 0))
   348                  return -EINVAL;
   349  
   350          to_jiffies = usecs_to_jiffies(tv_usec);
                                              ^^^^^^^

   351          to_jiffies += tv_sec * HZ;
                              ^^^^^^^^^^^
Both of these can overflow

   352          if (to_jiffies <= 0)
                    ^^^^^^^^^^^^^^^
But they're checked here.

   353                  return -EINVAL;
   354  
   355          pdev->timeout = to_jiffies;
   356          return 0;
   357  }

drivers/char/ipmi/ipmi_plat_data.c:70 ipmi_platform_add() warn: potential integer overflow from user 'r[0]->start + p->regsize'
    69          r[0].start = p->addr;
    70          r[0].end = r[0].start + p->regsize - 1;
                           ^^^^^^^^^^^^^^^^^^^^^^^
I think this is root only so it's safe?  Or it could be a false
positive.

    71          r[0].name = "IPMI Address 1";
    72          r[0].flags = flags;


drivers/i2c/i2c-dev.c:485 i2cdev_ioctl() warn: potential integer overflow from user (local copy) 'arg * 10'
   478          case I2C_TIMEOUT:
   479                  if (arg > INT_MAX)
   480                          return -EINVAL;
   481  
   482                  /* For historical reasons, user-space sets the timeout
   483                   * value in units of 10 ms.
   484                   */
   485                  client->adapter->timeout = msecs_to_jiffies(arg * 10);
                                                                    ^^^^^^^^^
This can overflow and then the msecs_to_jiffies() conversion also has
an integer overflow in it.

   486                  break;


drivers/i2c/busses/i2c-bcm2835.c:93 clk_bcm2835_i2c_calc_divider() warn: potential integer overflow from user 'parent_rate + rate'
    90  static int clk_bcm2835_i2c_calc_divider(unsigned long rate,
    91                                  unsigned long parent_rate)
    92  {
    93          u32 divider = DIV_ROUND_UP(parent_rate, rate);
    94  
    95          /*
    96           * Per the datasheet, the register is always interpreted as an even
    97           * number, by rounding down. In other words, the LSB is ignored. So,
    98           * if the LSB is set, increment the divider to avoid any issue.
    99           */
   100          if (divider & 1)
   101                  divider++;
   102          if ((divider < BCM2835_I2C_CDIV_MIN) ||
   103              (divider > BCM2835_I2C_CDIV_MAX))
   104                  return -EINVAL;

Again, math first then check the result later.  Integer overflow is
basically harmless.

   105  
   106          return divider;
   107  }


drivers/hwmon/nct6775-core.c:2265 store_temp_offset() warn: potential integer overflow from user '__x + (__d / 2)'
  2251  static ssize_t
  2252  store_temp_offset(struct device *dev, struct device_attribute *attr,
  2253                    const char *buf, size_t count)
  2254  {
  2255          struct nct6775_data *data = dev_get_drvdata(dev);
  2256          struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
  2257          int nr = sattr->index;
  2258          long val;
  2259          int err;
  2260  
  2261          err = kstrtol(buf, 10, &val);
  2262          if (err < 0)
  2263                  return err;
  2264  
  2265          val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), -128, 127);
                                                  ^^^^^^^^^^
Overflow and then clamp.

  2266  
  2267          mutex_lock(&data->update_lock);

regards,
dan carpenter
