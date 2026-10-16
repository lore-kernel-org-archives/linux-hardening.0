Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D174CF476
	for <linux-hardening@vger.kernel.org>; Fri, 16 Oct 2026 19:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792178231; cv=none; b=Q6Hmjbbw93rjTpBYDEr7vwG9CH217jDzhDJ7VP4DQI3aMAY3akiLvWKuDCdLJ9O2irYpLSeh1kAfBEUXADJCKRlqwt8LSwfQumIj36pF9R6/vN5yiiqPCyAb2OhXbRfMGb0oBD/rpvyNmUXAi9nWUdTVV0DYal24M5xOe4Wdwo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792178231; c=relaxed/simple;
	bh=ET917KfXAU2oCz7RCW/M4EQhs4HJ/7oNAHdBONRKMH4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=srDXkzyfPPVKDADTByVSU2A0Nv8Z8Yi+XNQf+3kF5By4Fz96/OFD+5UO2OlmuBRrhUabU07KOFNqG0SMiaPfn0tpSlBvyQj++wPc689l2Nb52J73ue/6/LbDgj39e6BOzjAUPIC66QwwE3QnCVlpgko5qPWsb4tiS51AbOlAtPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzhQW2cp; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzhQW2cp"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-35f036b17easo598135eec.1
        for <linux-hardening@vger.kernel.org>; Fri, 16 Oct 2026 12:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792178227; x=1792783027; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SoDZzK0EmbEwkXW0QdmZPMKiCBUtVL90PEYb/mW71hI=;
        b=LzhQW2cpvdegUxJygLy1kaNexOT1uwZxZA9knjPBsbfPBaVZzt5ITQpGKIzOxV9/Ul
         RvqFou1/dSzhe3r9ZLKzIerpI5YS7qdlVmzxV0CdoDep70Obp3wgWf5FZKe/iMDXH2fU
         3N/HDuT2xDxCVM5m8I4jsknjR7vkm9PXeOVh779tuG73ul7M+bTW8rB2jL4+t/ldg81B
         haMn/fnYlifIf9OwDhGCnwcZsCeJ/lscJMqsxMQEmt/UGVDc0zXLyjk+yxfEfASuHoRA
         uS1Tnmhc3hdFWPs0H9lpWDoke8ijeN82LBTzPTPqdL0ErP2zYo1b97cnfbIHJItTdpCU
         8qhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792178227; x=1792783027;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SoDZzK0EmbEwkXW0QdmZPMKiCBUtVL90PEYb/mW71hI=;
        b=K/Bl7R/QiZzXSDL7HslsCtkJzrtfAzpdWjkf3biBg+sGCXgMFXvPPOxTaJynCHz7gq
         zKATKN6N+t6koqL8SMArIM1zB2FcNLvFstVbZwkorxPhcMTJmf8aoGo0X0bHUqK8J/eG
         A/t9Dekt3RSDGIQbRnV+/t0kkFj3HOKFqZ5PeNu1zOMwT6KHYaHDXDCa+Ez+nZs43O/J
         FP2pqZeQiKiK00du/RWZPK2UJcHbtBbdYu7vv+9dYgECTib9lqaJCpxthIFrXYxqgAgq
         cJA+nRRtY/oebXigDOl7b39nknn6hFuU9PHEAO25eUCZHUBcD11fAHIH+gbIUj3dD2I1
         OpjQ==
X-Forwarded-Encrypted: i=1; AKwUvBwgL8zY77Ss2qdfVqujDVABXEhISz13YStaj/O1z380Eme9qtsXbjTUVy6Aj9A6TrpnCJjMw8KeJoEklmgy8D4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJEvFkMmpsLUHKFR7Br7Mi4ybPOiG/5tvgcQdxurkTvyJsoKDeN
	8W7zYZf9+YgKc+B0jNMpMB+tHYr1sall3ixy/V1/2RhDkaL2Rydqe+1U
X-Gm-Gg: AYBFou35d7ov1W+AF4BeOdRoCW0C9ANeDAtKJ9Bof84melGSBDIiJjQ4Qag+euyEdp6
	zWqLrAKvR4NrKHzWG3R2CgZ39ek7Cyl41j/xA8DdMXLdKqUDGQChg18jscWPIQrdbELyfJ6tv7x
	6eX4IkudfxpumfGJO2bs21bgTnhcwNBb2Oqu5lOSFSCTQKQpwKJgFKfpYvqXSxdE06EVztpqkKs
	AvQLe0BJz+nTySjhhU95BpAwGkxE1CYgOxxBjSQ+ahwJybOgTilAFYs1y5TPVq3CklGocP+W/xj
	mucEFQa19Z//WZID0UYV8aFpSF5H6kQdI24ah45wieLIa0WL1nReNAeEW+1E64OZpJGvVx96sC2
	eH+rWV99gOYCMSsnsXAdCJZCFFCiEFEc4RdFTlpXDxwLPUcc/VAMpJO/CrjxqTarh5bVVzjpgMn
	sVgPvOP6xPKxZBbM6G1/1ch0Bl6b1jSBJOlPPsb5FvskDOEsre07xnGGxHS8dXwd3TQbVV0l0bE
	fzshqaJn8VlvcOyU8btrJrsGvj3f/Z14D8FJD+1
X-Received: by 2002:a05:7301:1828:b0:355:cd68:6f03 with SMTP id 5a478bee46e88-361a283f7demr874960eec.33.1792178227023;
        Fri, 16 Oct 2026 12:17:07 -0700 (PDT)
Received: from localhost ([2a00:79e0:2ebe:8:34f0:f27d:9a5d:56e0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608258aa66sm10395097eec.20.2026.10.16.12.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 12:17:06 -0700 (PDT)
Date: Fri, 16 Oct 2026 12:17:05 -0700
Message-ID: <30bc6e07072076b0591fd416f50f4fc3@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Shihuang Liu <shlomojune6@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Ville Syrjala <syrjala@sci.fi>,
	Henk Vergonet <Henk.Vergonet@gmail.com>,
	Henrik Rydberg <rydberg@bitmath.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] Input: joystick - replace strlcat() with strscpy()
In-Reply-To: <20261016170411.51025-2-shlomojune6@gmail.com>
References: <20261016170411.51025-1-shlomojune6@gmail.com> <20261016170411.51025-2-shlomojune6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Shihuang,

On Sat, Oct 17, 2026 at 01:04:07AM +0800, Shihuang Liu wrote:
> The pxrc and xpad drivers build the physical path by appending a
> constant "/input0" suffix with strlcat() after usb_make_path().
>
> In preparation for removing the deprecated strlcat() API[1],
> replace it with strnlen() followed by strscpy() into the remainder
> of the buffer, as commit 34b228b739f5 ("HID: usbhid: replace
> strlcat with better alternatives") did for the usbhid drivers.
...
>  	usb_make_path(udev, pxrc->phys, sizeof(pxrc->phys));
> -	strlcat(pxrc->phys, "/input0", sizeof(pxrc->phys));
> +	len = strnlen(pxrc->phys, sizeof(pxrc->phys));
> +	strscpy(pxrc->phys + len, "/input0", sizeof(pxrc->phys) - len);

I really dislike this conversion pattern, and I do not want to see it
open-coded across 18 drivers in this series.

usb_make_path() is just a trivial wrapper around snprintf() that already
returns the length of the formatted string. Calling usb_make_path(),
ignoring its return value, rescanning the buffer with strnlen(), and
then open-coding pointer and size arithmetic for strscpy() (along with
an extra local variable in every probe function) makes the code much
uglier and harder to read than what we had before.

All of these USB input drivers already include <linux/usb/input.h>, and
drivers across other subsystems (drivers/hid/usbhid/, drivers/media/rc/,
drivers/media/usb/, sound/usb/caiaq/, drivers/usb/storage/onetouch.c)
all use the exact same usb_make_path() + suffix pattern ("/input0",
"/input%d", "/ir0", "/button", etc.).

If we want to get rid of strlcat() here, please introduce a generic
helper in include/linux/usb.h (or a USB input helper in
include/linux/usb/input.h) that formats the USB path together with the
subpath in a single pass, for example:

__printf(4, 5)
int usb_make_subpath(struct usb_device *dev, char *buf, size_t size,
		     const char *fmt, ...);

(or a simple const char *suffix variant if formatting is not needed).
Then each driver can do:

	usb_make_subpath(udev, pxrc->phys, sizeof(pxrc->phys), "input0");

and even drivers/hid/usbhid/hid-core.c can simply do:

	usb_make_subpath(dev, hid->phys, sizeof(hid->phys),
			 "input%d", intf->altsetting[0].desc.bInterfaceNumber);

instead of repeating this strnlen() + strscpy() boilerplate everywhere.

Thanks.

-- 
Dmitry
