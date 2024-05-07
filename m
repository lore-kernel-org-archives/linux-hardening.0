Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD4356B6F
	for <linux-hardening@vger.kernel.org>; Tue,  7 May 2024 20:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715115223; cv=none; b=n6rr6nRxgJdqvwYOmCe08JM89K7wN3ooUfCL/6wgiuzJ/KLNzOpJF0YkAdPb6xix3mUAKbuky46E02uv13w0fNmlr/vn5CbQtngK6UPj6BBFCQL4PSuXhk/Kp2I81GXvwM3ALLSRpcc94AM3dAiWiU6QKM/nqp4PggU3Wwz9Z4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715115223; c=relaxed/simple;
	bh=7M+NtxKZnPDppdk30q3K/jPePHvgBrshS2sV34FSFas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mm5btR0WYUc0wA09N2ts/1ucZG6GAvpxWHRFiPNzMBxCT6Vq/LQpnRJm+Y1K4btsnVXZufi7g7iN8yx6YDIdsZTs5DCpjImh0lqMT39qGjPwh+NPeh1/rNmfsimTyrpzfGXlCQtX+93d7fFcKc3w/mnta09jpHAxNTRjVykHt+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk; spf=pass smtp.mailfrom=philpotter.co.uk; dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b=azZOnxEX; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b="azZOnxEX"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-34e040ed031so2580615f8f.0
        for <linux-hardening@vger.kernel.org>; Tue, 07 May 2024 13:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20230601.gappssmtp.com; s=20230601; t=1715115220; x=1715720020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hFVFsbOtBEE+BmWcqY4bLdtjzye15d8lPmfNqQm2W7E=;
        b=azZOnxEXgKyFh6XChqzJnZeEO3m0oulwTF4s+PcxbURLJBqlFW2BUokOwUo8Ha0opW
         FTzXH1FS/OnPWx9eo7QowtrJaoyS058NVAsEaqcWZpbP1jq/26sEXU3+9lgvIH7ilx65
         whdfLL31LPm6+jnqEDpXy8LZRcIYfHVMEr78JKFbLIHwHCxF1QVnmsfm7SUTdpxKSGwA
         gDDcCC6Q0GIBWlzjKM06XCcHaj3OjXiEdEg+4veapYHOfDOCBr+geAbGFylenGIYRQAh
         LLZ4D6O0icTb63DVb0vsZvgL4gFXGwAGL/TihS1FkCeSTngSqbAdwleC6aOoh2NBxzRr
         tj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715115220; x=1715720020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFVFsbOtBEE+BmWcqY4bLdtjzye15d8lPmfNqQm2W7E=;
        b=mSD2rU6lSe9+WKq+wYtni2DOQS/LX2lkCoyIdNklMWhlAXZcTnNNyvLb4UVWfre5fM
         lcK9QGedlMQLmno+qjdy3nLSJ10xvvMK4FGhIxWZ3PqIIkW7s71ObF2jeXMFQ9wq1VBY
         1GNT2DG7i6oHijX8Kfk+ZkGYRIXM/YkW7RRhXx+ivlQdXg3YN6JZip7Zk+tBBevW6UKU
         mKYrTKRKrHpR6haRIQ+U4yNQIx+93d/Bl0IXywThPwX8mUqs1JYjG73UQceg0QgNIoz5
         r3rJJ3nNdIfpc4c1Hei2g9Sd2EL1A1t8JHlTpRKAMNEqCeKCiiaXYZy0/SbvehC+tNil
         OgEg==
X-Forwarded-Encrypted: i=1; AJvYcCUVW/S5wNB3ohyF6s0Gg2Mv37tKN7ECjQTjIDW91SXmX6B847Yivj330UpQxLRmykjS3lS1szY9tDJ1/maXfDAeZELaFjTLtBrgdTN+K318
X-Gm-Message-State: AOJu0YxK8ZQRNl1P69BbK1D9DwVPgIdgFouNBIJqKPLd+U/YRWZswuZH
	ZlRCONa5bjE8KHxitY8VIexd3Yp1GG1Evq4NfFCh03CnWrUP/QHALCDKod5gWCk=
X-Google-Smtp-Source: AGHT+IGvKgByFba511+kQjW5eQZwi1LEu6PO71nv4QsVrnVhDPPAGCjI1x7cguks0dBbCf7Cf+etgQ==
X-Received: by 2002:a5d:58f2:0:b0:349:8a7e:e0af with SMTP id ffacd0b85a97d-34fcaddda53mr545108f8f.11.1715115219785;
        Tue, 07 May 2024 13:53:39 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id ay35-20020a05600c1e2300b00419f419236fsm20909420wmb.41.2024.05.07.13.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 13:53:39 -0700 (PDT)
Date: Tue, 7 May 2024 21:53:37 +0100
From: Phillip Potter <phil@philpotter.co.uk>
To: Justin Stitt <justinstitt@google.com>
Cc: Phillip Potter <phil@philpotter.co.uk>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH] cdrom: rearrange last_media_change check to avoid
 unintentional overflow
Message-ID: <ZjqU0fbzHrlnad8D@equinox>
References: <20240507-b4-sio-ata1-v1-1-810ffac6080a@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507-b4-sio-ata1-v1-1-810ffac6080a@google.com>

On Tue, May 07, 2024 at 04:54:04AM +0000, Justin Stitt wrote:
> When running syzkaller with the newly reintroduced signed integer wrap
> sanitizer we encounter this splat:
> 
> [  366.015950] UBSAN: signed-integer-overflow in ../drivers/cdrom/cdrom.c:2361:33
> [  366.021089] -9223372036854775808 - 346321 cannot be represented in type '__s64' (aka 'long long')
> [  366.025894] program syz-executor.4 is using a deprecated SCSI ioctl, please convert it to SG_IO
> [  366.027502] CPU: 5 PID: 28472 Comm: syz-executor.7 Not tainted 6.8.0-rc2-00035-gb3ef86b5a957 #1
> [  366.027512] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [  366.027518] Call Trace:
> [  366.027523]  <TASK>
> [  366.027533]  dump_stack_lvl+0x93/0xd0
> [  366.027899]  handle_overflow+0x171/0x1b0
> [  366.038787] ata1.00: invalid multi_count 32 ignored
> [  366.043924]  cdrom_ioctl+0x2c3f/0x2d10
> [  366.063932]  ? __pm_runtime_resume+0xe6/0x130
> [  366.071923]  sr_block_ioctl+0x15d/0x1d0
> [  366.074624]  ? __pfx_sr_block_ioctl+0x10/0x10
> [  366.077642]  blkdev_ioctl+0x419/0x500
> [  366.080231]  ? __pfx_blkdev_ioctl+0x10/0x10
> ...
> 
> Historically, the signed integer overflow sanitizer did not work in the
> kernel due to its interaction with `-fwrapv` but this has since been
> changed [1] in the newest version of Clang. It was re-enabled in the
> kernel with Commit 557f8c582a9ba8ab ("ubsan: Reintroduce signed overflow
> sanitizer").
> 
> Let's rearrange the check to not perform any arithmetic, thus not
> tripping the sanitizer.
> ...

Hi Justin,

Thanks for the patch, looks good to me and seems like a sensible change.
Reviewed and build/runtime tested, I will send on for inclusion.

Reviewed-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
