Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A1A7C082
	for <linux-hardening@vger.kernel.org>; Mon, 13 May 2024 19:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629420; cv=none; b=CZ/ChcPZ7aiQb4WUrNudqWapIkBJrD/ciZRJGmSzxRRyvlF4cmROAOz/xwilTCJUr2losCp/zsw+iT3pqjcUBWGjPiLDPHVIMk9O3KOGdFLvqkhxnKQ1T5y6JogUQNeKZxQGWGMXg+77NYt4Fiy60e+e6Sz32nOA+YU3VF/VjSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629420; c=relaxed/simple;
	bh=K61Eeb63d0yaw8+TKUN2pTbZRolvq3Pgv6Gq358MquE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHKV+I6vtSMZ7ofc0XM0xqC7VU+7hm3SZ9hsfLkYd27M54vyyplBKm/gP6lE6lLbqXFOgrnsBExaes+g1V5kdaP2bC7pJWo5p4THxPj8qmA/cf1putsQQeH1jYqoxL+I9R1K2PZTJ25tun1I2yABtAniV+3EPgJ3kFS8VHeBVvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EhvTntpc; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EhvTntpc"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ecc23e6c9dso30866515ad.2
        for <linux-hardening@vger.kernel.org>; Mon, 13 May 2024 12:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715629418; x=1716234218; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3Yo50qdnkANEGN5IkXj0mAYeaPHuiq9Yw00mAPWh7RA=;
        b=EhvTntpc8Ah4Bt51v/KBV1lA4mdKO70C2jP8ytfK8j20CUWb/GLZBjjpW/I1nmXI7Y
         9+Z3iZQ6qrBNpb7VXFZSELeZBdhzrxMlvSLpscEIAtQrQifDaJJKNQ69Tb8lSTmR27ag
         eAD9edGAhu5wFYc1nkOAcWMumuDjBs4Aqmc4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715629418; x=1716234218;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Yo50qdnkANEGN5IkXj0mAYeaPHuiq9Yw00mAPWh7RA=;
        b=EmFAscS+pe4Igg1clWwxU821yd6Sx/yz+qJDi1LQkcT+1xm+Jzc6BwoOq7d+LqGjQT
         rlP83pgcPkKwSfxmN/VWouxnxEfBzcD0zN5BsaTYm9JMOKHJd9AE34Dxagyu8nOOxMQD
         OwudVYHSFF7EyReB4I/iTkCD798xJVAS12KzG22n730Qk0lz8+OmR1EvxntZw/DxXh/r
         So7+dW9ptWN7sd3Qzi81dsg9CBSKjnpWSHdqOSs8wTXPsFa4jcHI79tZpMpAuymUeDqo
         yP7ipJxdNSyvO2+BZW4z9QSkJqFmEyQiP2JGaulQB0J7Wy+T+hOmmtSW4DNvTKbRrrmb
         Ra1w==
X-Forwarded-Encrypted: i=1; AJvYcCVEpB4DJecPj7uD0gLiddVo9f/8WWtzeydLd07xtcEjnpuCQ73ypDBCk7lo9vXq1CtdxGYnUfd+sOns8Nr1UV03buWiBQTCjrPrt1kiA4Ol
X-Gm-Message-State: AOJu0Yy6rauS0FJSqQD4vdnKHa9gZ6qDlblR/9kc1mhLT7QfqlolBD27
	DOoVCzBC4ekbyZyWTdwVzjJ+4MqXp3jiWYrFM/Vzg9O6z97PtSPngEfAt7R27Q==
X-Google-Smtp-Source: AGHT+IHXRBXfaq+moLO5icTiqOzUIngitS3nNlXAT5sPau7Atj50bQ8EqwnilNsJWDU0XbUScvM9xQ==
X-Received: by 2002:a17:902:ec89:b0:1eb:58d2:8739 with SMTP id d9443c01a7336-1ef43d0a009mr131792085ad.3.1715629418503;
        Mon, 13 May 2024 12:43:38 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d177asm82902335ad.23.2024.05.13.12.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 12:43:38 -0700 (PDT)
Date: Mon, 13 May 2024 12:43:37 -0700
From: Kees Cook <keescook@chromium.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Justin Stitt <justinstitt@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
Message-ID: <202405131203.F7B97F5E38@keescook>
References: <202404291502.612E0A10@keescook>
 <039d54d6-8aa2-4e5b-829b-69002cff35d3@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <039d54d6-8aa2-4e5b-829b-69002cff35d3@moroto.mountain>

On Sat, May 11, 2024 at 07:19:49PM +0300, Dan Carpenter wrote:
> I'm pretty sure we've tried using a sanitizer before and it had too many
> false positives.  So your solution is to annotate all the false
> positives?

That was the plan, yes. Based on current feedback, we'll be taking an
even more incremental approach, though.

> There are two main issue which make integer overflows complicated from
> a static analysis perspective.  1)  Places where it's intentional or
> we don't care.  2)  Places where the integer overflow is harmless for
> one reason or another.  Btw, integer overflows are a lot more common on
> 32 bit CPUs because obviously it's easier to overflow 4 billion than
> whatever number U64_MAX is.

Agreed on all counts. :)

> Here are is a sample of ten integer overflows that the user can trigger.
> Maybe pick a couple and walk us through how they would be annotated?

Sure, I will answer this from the perspective of the original proposal
(enabling signed-integer-overflow, unsigned-integer-overflow,
signed-integer-implicit-truncation, and
unsigned-integer-implicit-truncation).

> 
> drivers/usb/dwc3/gadget.c:3064 dwc3_gadget_vbus_draw() warn: potential integer overflow from user '1000 * mA'
>   3052  static int dwc3_gadget_vbus_draw(struct usb_gadget *g, unsigned int mA)
>   3053  {
>   3054          struct dwc3             *dwc = gadget_to_dwc(g);
>   3055          union power_supply_propval      val = {0};
>   3056          int                             ret;
>   3057  
>   3058          if (dwc->usb2_phy)
>   3059                  return usb_phy_set_power(dwc->usb2_phy, mA);
>   3060  
>   3061          if (!dwc->usb_psy)
>   3062                  return -EOPNOTSUPP;
>   3063  
>   3064          val.intval = 1000 * mA;
>                              ^^^^^^^^^^
> mA comes from the user and we only know that it's a multiple of 2.
> So here we would annotate that val.intval can store integer overflows?
> Or we'd annotate mA?

Do we _want_ it to overflow? This seems like a case where we don't? I
would expect this to need:

		int intval;

		if (check_mul_overflow(1000, mA, &intval))
			return -EINVAL;

		val.intval = intval;

> 
>   3065          ret = power_supply_set_property(dwc->usb_psy, POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT, &val);
>   3066  
>   3067          return ret;
>   3068  }
> 
> 
> drivers/usb/class/usbtmc.c:852 usbtmc_generic_read() warn: potential integer overflow from user 'max_transfer_size + 1'
>    842                   * wMaxPacketSize – 1) to avoid sending a zero-length
>    843                   * packet
>    844                   */
>    845                  remaining = transfer_size;
>    846                  if ((max_transfer_size % data->wMaxPacketSize) == 0)
>    847                          max_transfer_size += (data->wMaxPacketSize - 1);
>    848          } else {
>    849                  /* round down to bufsize to avoid truncated data left */
>    850                  if (max_transfer_size > bufsize) {
>    851                          max_transfer_size =
>    852                                  roundup(max_transfer_size + 1 - bufsize,
>                                                 ^^^^^^^^^^^^^^^^^^^^^
> This can overflow.  We should make it a rule that all size variables
> have to be unsigned long.  That would have made this safe on 64 bit
> systems.
> 
>    853                                          bufsize);
>    854                  }
>    855                  remaining = max_transfer_size;

Again, do we _want_ this to overflow? It looks like not. I'm not sure
what this code is trying to do, though. The comment doesn't seem to
match the code. Why isn't this just roundup(max_transfer_size, bufsize) ?

> drivers/usb/misc/usbtest.c:1994 iso_alloc_urb() warn: potential integer overflow from user 'bytes + maxp'
>   1974  static struct urb *iso_alloc_urb(
>   1975          struct usb_device       *udev,
>   1976          int                     pipe,
>   1977          struct usb_endpoint_descriptor  *desc,
>   1978          long                    bytes,
>   1979          unsigned offset
>   1980  )
>   1981  {
>   1982          struct urb              *urb;
>   1983          unsigned                i, maxp, packets;
>   1984  
>   1985          if (bytes < 0 || !desc)
>   1986                  return NULL;
>   1987  
>   1988          maxp = usb_endpoint_maxp(desc);
>   1989          if (udev->speed >= USB_SPEED_SUPER)
>   1990                  maxp *= ss_isoc_get_packet_num(udev, pipe);
>   1991          else
>   1992                  maxp *= usb_endpoint_maxp_mult(desc);
>   1993  
>   1994          packets = DIV_ROUND_UP(bytes, maxp);
>                                        ^^^^^
> The issue here is on a 32 bit system when bytes is INT_MAX.

All of these examples seem to be cases that should be mitigated. The
earlier check should be expanded:

		if (bytes < 0 || bytes >= INT_MAX || !desc)

> 
>   1995  
>   1996          urb = usb_alloc_urb(packets, GFP_KERNEL);
>   1997          if (!urb)
>   1998                  return urb;
> 
> 
> drivers/usb/storage/uas.c:324 uas_stat_cmplt() warn: potential integer overflow from user 'idx + 1'
>    322          idx = be16_to_cpup(&iu->tag) - 1;
> 
> The "- 1" makes this UINT_MAX
> 
>    323          if (idx >= MAX_CMNDS || !devinfo->cmnd[idx]) {
>    324                  dev_err(&urb->dev->dev,
>    325                          "stat urb: no pending cmd for uas-tag %d\n", idx + 1);
>                                                                              ^^^^^^^
> Harmless integer overflow in printk.
> 
>    326                  goto out;
>    327          }

Again, this doesn't look like we want it overflowing. "idx" isn't
reported correctly. It can just use "idx": that's what's being examined
in the "if" statement.

> drivers/mtd/parsers/tplink_safeloader.c:101 mtd_parser_tplink_safeloader_parse() warn: potential integer overflow from user 'bytes + 1'
>     97          for (idx = 0, offset = TPLINK_SAFELOADER_DATA_OFFSET;
>     98               idx < TPLINK_SAFELOADER_MAX_PARTS &&
>     99               sscanf(buf + offset, "partition %64s base 0x%llx size 0x%llx%zn\n",
>    100                      name, &parts[idx].offset, &parts[idx].size, &bytes) == 3;
> 
> I think this buffer comes from the partition table?
> 
>    101               idx++, offset += bytes + 1) {
>                                       ^^^^^^^^^
> 
>    102                  parts[idx].name = kstrdup(name, GFP_KERNEL);
>    103                  if (!parts[idx].name) {
>    104                          err = -ENOMEM;

Again, we don't want it wrapping. The whole loop needs to be expanded to
be readable, and bounds checking needs to be performed.

> 
> 
> drivers/char/ppdev.c:344 pp_set_timeout() warn: potential integer overflow from user 'tv_sec * 100'
>    343  static int pp_set_timeout(struct pardevice *pdev, long tv_sec, int tv_usec)
>    344  {
>    345          long to_jiffies;
>    346  
>    347          if ((tv_sec < 0) || (tv_usec < 0))
>    348                  return -EINVAL;
>    349  
>    350          to_jiffies = usecs_to_jiffies(tv_usec);
>                                               ^^^^^^^
> 
>    351          to_jiffies += tv_sec * HZ;
>                               ^^^^^^^^^^^
> Both of these can overflow
> 
>    352          if (to_jiffies <= 0)
>                     ^^^^^^^^^^^^^^^
> But they're checked here.
> 
>    353                  return -EINVAL;
>    354  
>    355          pdev->timeout = to_jiffies;
>    356          return 0;
>    357  }

This doesn't look like a wrapping-desired case either, but just for fun,
let's assume we want it. (And why are any of these signed?) Annotation
is added to the variables:

static int pp_set_timeout(struct pardevice *pdev, long __wraps tv_sec, int __wraps tv_usec)
{
	long __wraps to_jiffies;



> 
> drivers/char/ipmi/ipmi_plat_data.c:70 ipmi_platform_add() warn: potential integer overflow from user 'r[0]->start + p->regsize'
>     69          r[0].start = p->addr;
>     70          r[0].end = r[0].start + p->regsize - 1;
>                            ^^^^^^^^^^^^^^^^^^^^^^^
> I think this is root only so it's safe?  Or it could be a false
> positive.
> 
>     71          r[0].name = "IPMI Address 1";
>     72          r[0].flags = flags;

We don't want this to wrap, yes? I don't know what is expected when regsize == 0,
but ignoring that, I'd expect:

	if (check_add_overflow(r[0].start, p->regsize - 1, &r[0].end))
		error...


> 
> 
> drivers/i2c/i2c-dev.c:485 i2cdev_ioctl() warn: potential integer overflow from user (local copy) 'arg * 10'
>    478          case I2C_TIMEOUT:
>    479                  if (arg > INT_MAX)
>    480                          return -EINVAL;
>    481  
>    482                  /* For historical reasons, user-space sets the timeout
>    483                   * value in units of 10 ms.
>    484                   */
>    485                  client->adapter->timeout = msecs_to_jiffies(arg * 10);
>                                                                     ^^^^^^^^^
> This can overflow and then the msecs_to_jiffies() conversion also has
> an integer overflow in it.

If we want these wrapping:

		unsigned long __wraps timeout = arg * 10;
		client->adapter->timeout = msecs_to_jiffies(timeout);

and:

static inline unsigned long _msecs_to_jiffies(const unsigned int __wraps m)


> 
>    486                  break;
> 
> 
> drivers/i2c/busses/i2c-bcm2835.c:93 clk_bcm2835_i2c_calc_divider() warn: potential integer overflow from user 'parent_rate + rate'
>     90  static int clk_bcm2835_i2c_calc_divider(unsigned long rate,
>     91                                  unsigned long parent_rate)
>     92  {
>     93          u32 divider = DIV_ROUND_UP(parent_rate, rate);
>     94  
>     95          /*
>     96           * Per the datasheet, the register is always interpreted as an even
>     97           * number, by rounding down. In other words, the LSB is ignored. So,
>     98           * if the LSB is set, increment the divider to avoid any issue.
>     99           */
>    100          if (divider & 1)
>    101                  divider++;
>    102          if ((divider < BCM2835_I2C_CDIV_MIN) ||
>    103              (divider > BCM2835_I2C_CDIV_MAX))
>    104                  return -EINVAL;
> 
> Again, math first then check the result later.  Integer overflow is
> basically harmless.

Either fix the check or:

	u32 __wraps divider = ...

> 
>    105  
>    106          return divider;
>    107  }
> 
> 
> drivers/hwmon/nct6775-core.c:2265 store_temp_offset() warn: potential integer overflow from user '__x + (__d / 2)'
>   2251  static ssize_t
>   2252  store_temp_offset(struct device *dev, struct device_attribute *attr,
>   2253                    const char *buf, size_t count)
>   2254  {
>   2255          struct nct6775_data *data = dev_get_drvdata(dev);
>   2256          struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
>   2257          int nr = sattr->index;
>   2258          long val;
>   2259          int err;
>   2260  
>   2261          err = kstrtol(buf, 10, &val);
>   2262          if (err < 0)
>   2263                  return err;
>   2264  
>   2265          val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), -128, 127);
>                                                   ^^^^^^^^^^
> Overflow and then clamp.

Looks like DIV_ROUND_CLOSEST() needs to be made sane and use more modern
helpers (it appears to be doing open-coded is_signed(), wants
check_*_overflow(), etc).

> 
>   2266  
>   2267          mutex_lock(&data->update_lock);
> 
> regards,
> dan carpenter

-Kees

-- 
Kees Cook
